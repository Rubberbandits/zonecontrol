kingston = kingston or {}
kingston.pda = kingston.pda or {}
kingston.pda.authenticated = kingston.pda.authenticated or {}

kingston.pda.chat_db_struct = {
	{ "Date", "VARCHAR(20)" },
	{ "Sender", "INT" },
	{ "Receiver", "INT" },
	{ "SenderName", "VARCHAR(256)" },
	{ "ReceiverName", "VARCHAR(256)" },
	{ "Message", "VARCHAR(8192)" },
}

kingston.pda.journal_db_struct = {
	{ "Date", "VARCHAR(20)" },
	{ "Owner", "INT" },
	{ "Title", "VARCHAR(256)" },
	{ "Message", "VARCHAR(8192)" },
	{ "DeletionDate", "BIGINT UNSIGNED" },
}

kingston.pda.chat_insert_str = [[
	INSERT INTO cc_pda_chat (Date, Sender, Receiver, SenderName, ReceiverName, Message) VALUES (UNIX_TIMESTAMP(), ?, ?, ?, ?, ?);
]]
kingston.pda.journal_insert_str = [[
	INSERT INTO cc_pda_journal (Date, Owner, Title, Message) VALUES (UNIX_TIMESTAMP(), ?, ?, ?);
]]
kingston.pda.search_chat_str = [[SELECT * FROM cc_pda_chat WHERE Date >= UNIX_TIMESTAMP('%s') AND Date <= (UNIX_TIMESTAMP('%s') + 86400) AND (Sender = %d OR Receiver = %d);]]
kingston.pda.search_journal_str = [[SELECT * FROM cc_pda_journal WHERE Owner = %d AND DeletionDate IS NULL;]]

kingston.pda.delete_journal_str = [[UPDATE cc_pda_journal SET DeletionDate = UNIX_TIMESTAMP() WHERE id = ?;]]
kingston.pda.recover_journals_str = [[UPDATE cc_pda_journal SET DeletionDate = NULL WHERE Owner = ?;]]

local function init_log_pda_tbl(db)
	mysqloo.Query("CREATE TABLE IF NOT EXISTS cc_pda_chat ( id INT NOT NULL auto_increment, PRIMARY KEY ( id ) );")
	mysqloo.Query("CREATE TABLE IF NOT EXISTS cc_pda_journal ( id INT NOT NULL auto_increment, PRIMARY KEY ( id ) );")
	GAMEMODE:InitSQLTable(kingston.pda.chat_db_struct, "cc_pda_chat")
	GAMEMODE:InitSQLTable(kingston.pda.journal_db_struct, "cc_pda_journal")
	
	kingston.pda.chat_insert = db:prepare(kingston.pda.chat_insert_str)
	
	kingston.pda.journal_insert = db:prepare(kingston.pda.journal_insert_str)
	kingston.pda.journal_delete = db:prepare(kingston.pda.delete_journal_str)
	kingston.pda.journal_recover = db:prepare(kingston.pda.recover_journals_str)
end
hook.Add("InitSQLTables", "STALKER.InitPDADBTable", init_log_pda_tbl)

function kingston.pda.grab_chat(id, date, cb)
	local function onSuccess(data, q)
		cb(q, data)
	end

	mysqloo.Query(Format(kingston.pda.search_chat_str, mysqloo.Escape(date), mysqloo.Escape(date), id, id), onSuccess)
end

function kingston.pda.grab_journal(id, cb)
	local function onSuccess(data, q)
		cb(q, data)
	end
	mysqloo.Query(Format(kingston.pda.search_journal_str, id), onSuccess)
end

function kingston.pda.find_contacts()
	local rf = {}
	for k,v in next, GAMEMODE.g_ItemTable do
		if v:GetClass() == "pda" then
			if !v:GetVar("Power", false) then continue end
			
			rf[#rf + 1] = {name = v:GetVar("PDAName", "UNKNOWN_USER"), rank = v:GetPDARank()}
		end
	end
	
	return rf
end

function kingston.pda.write_chat(sender_id, receiver_id, message)
	local sender_pda = GAMEMODE.g_ItemTable[sender_id]
	local receiver_pda = GAMEMODE.g_ItemTable[receiver_id]
	if !sender_pda or !receiver_pda then return end

	kingston.pda.chat_insert:clearParameters()
		kingston.pda.chat_insert:setNumber(1, sender_id)
		kingston.pda.chat_insert:setNumber(2, receiver_id)
		kingston.pda.chat_insert:setString(3, sender_pda:GetVar("PDAName", "UNKNOWN_USER"))
		kingston.pda.chat_insert:setString(4, receiver_pda:GetVar("PDAName", "UNKNOWN_USER"))
		kingston.pda.chat_insert:setString(5, message)
	kingston.pda.chat_insert:start()
end

function kingston.pda.write_journal(pda, title, message, update)
	local item = GAMEMODE.g_ItemTable[pda]
	if !item then return end

	kingston.pda.journal_insert.onSuccess = function(q, data)
		if update then
			kingston.pda.grab_journal(pda, function(q, data)
				netstream.Start(item:Owner(), "PDAGrabJournal", data)
			end)
		end
	end
	
	kingston.pda.journal_insert.onError = function(q, err)
		print(err)
	end

	kingston.pda.journal_insert:clearParameters()
		kingston.pda.journal_insert:setNumber(1, pda)
		kingston.pda.journal_insert:setString(2, title)
		kingston.pda.journal_insert:setString(3, message)
	kingston.pda.journal_insert:start()
end

function kingston.pda.delete_journal(id, cb)
	kingston.pda.journal_delete.onSuccess = function(q, data)
		if cb then
			cb()
		end
	end

	kingston.pda.journal_delete:clearParameters()
		kingston.pda.journal_delete:setNumber(1, id)
	kingston.pda.journal_delete:start()
end

function kingston.pda.recover_journals(pda)
	kingston.pda.journal_recover:clearParameters()
		kingston.pda.journal_recover:setNumber(1, pda)
	kingston.pda.journal_recover:start()
end

function kingston.pda.player_authenticated(ply, pda)
	local item = ply.Inventory[pda]
	if !item then return false end
	if !item:GetVar("HasPassword", false) then return true end
	if !kingston.pda.authenticated[pda] then return false end
	
	return kingston.pda.authenticated[pda][ply:CharID()] or false
end

/* Networking */

local function PDAGrabChat(ply, id, date)
	local item = ply.Inventory[id]
	if item and item:GetClass() == "pda" and item:GetVar("Power", false) and kingston.pda.player_authenticated(ply, id) then
		kingston.pda.grab_chat(id, date, function(q, data)
			netstream.Start(ply, "PDAGrabChat", data)
		end)
	end
end
netstream.Hook("PDAGrabChat", PDAGrabChat)

local function PDAGrabJournal(ply, id)
	local item = ply.Inventory[id]
	if item and item:GetClass() == "pda" and item:GetVar("Power", false) and kingston.pda.player_authenticated(ply, id) then
		kingston.pda.grab_journal(id, function(q, data)
			netstream.Start(ply, "PDAGrabJournal", data)
		end)
	end
end
netstream.Hook("PDAGrabJournal", PDAGrabJournal)

local function PDAGrabContacts(ply)
	netstream.Start(ply, "PDAGrabContacts", kingston.pda.find_contacts())
end
netstream.Hook("PDAGrabContacts", PDAGrabContacts)

local function PDAWriteJournal(ply, id, title, message, update)
	if #title > 128 then return end
	if #message > 2048 then return end
	
	local item = ply.Inventory[id]
	if item and item:GetClass() == "pda" and item:GetVar("Power", false) and kingston.pda.player_authenticated(ply, id) then
		kingston.pda.write_journal(id, title, message, update)
	end
end
netstream.Hook("PDAWriteJournal", PDAWriteJournal)

local function PDADeleteJournal(ply, pda, id)
	local item = ply.Inventory[pda]
	if !item then return end
	if !kingston.pda.player_authenticated(ply, pda) then return end

	kingston.pda.delete_journal(id, function()
		kingston.pda.grab_journal(pda, function(q, data)
			netstream.Start(ply, "PDAGrabJournal", data)
		end)
	end)
end
netstream.Hook("PDADeleteJournal", PDADeleteJournal)

local function PDARecoverJournals(ply, pda)
	local item = ply.Inventory[pda]
	if !item then return end
	if !ply:IsPDATech() or !ply:HasItem("pda_recover") then return end
	if item:GetVar("Encrypted", false) then return end
	if ply.StartPDARecover + 119 > CurTime() then return end
	
	local items = ply:HasItem("pda_recover")
	if istable(items) and !items.IsItem then
		items = items[1]
	end
	
	if math.random(1,3) > 1 then
		items:RemoveItem(true)
	end
	
	kingston.pda.recover_journals(pda)
	ply.StartPDARecover = nil
end
netstream.Hook("PDARecoverJournals", PDARecoverJournals)

local function PDAEncrypt(ply, pda)
	local item = ply.Inventory[pda]
	if !item then return end
	if item:GetVar("Encrypted", false) then return end
	if item:GetVar("HasPassword", false) then return end
	if !ply:IsPDATech() or !ply:HasItem("pda_encryption") then return end
	if ply.StartPDAEncrypt + 19 > CurTime() then return end
	
	local items = ply:HasItem("pda_encryption")
	if istable(items) and !items.IsItem then
		items = items[1]
	end
	items:RemoveItem(true)
	
	item:SetVar("Encrypted", true, false, true)
	ply.StartPDAEncrypt = nil
end
netstream.Hook("PDAEncrypt", PDAEncrypt)

local function PDADecrypt(ply, pda)
	local item = ply.Inventory[pda]
	if !item then return end
	if !item:GetVar("Encrypted", false) then return end
	if !ply:IsPDATech() or !ply:HasItem("pda_decryption") then return end
	if ply.StartPDADecrypt + 199 > CurTime() then return end
	
	local items = ply:HasItem("pda_decryption")
	if istable(items) and !items.IsItem then
		items = items[1]
	end
	items:RemoveItem(true)
	
	item:SetVar("Encrypted", false, false, true)
	item:SetVar("HasPassword", false, false, true)
	item:SetVar("PrivateVars", {Password = ""})
	ply.StartPDADecrypt = nil
end
netstream.Hook("PDADecrypt", PDADecrypt)

local function PDASetPassword(ply, pda, password)
	local item = ply.Inventory[pda]
	
	if !item then return end
	if !item:GetVar("Encrypted", false) then return end
	if item:GetVar("HasPassword", false) then return end
	
	local private_vars = item:GetVar("PrivateVars", {}) 
	private_vars.Password = password
	
	item:SetVar("PrivateVars", private_vars)
	item:SetVar("HasPassword", true, false, true)
end
netstream.Hook("PDASetPassword", PDASetPassword)

local function AuthenticatePDA(ply, pda, password)
	local item = ply.Inventory[pda]
	if !item then return end
	if !item:GetVar("HasPassword", false) then return end
	if item:GetVar("PrivateVars", {}).Password != password then return end
	
	if !kingston.pda.authenticated[pda] then
		kingston.pda.authenticated[pda] = {}
	end

	kingston.pda.authenticated[pda][ply:CharID()] = true
	netstream.Start(ply, "AuthenticatePDA", pda)
end
netstream.Hook("AuthenticatePDA", AuthenticatePDA)

local RandomPDANames = {
	"vitalikvisitor",
	"vladvacuum",
	"kostikkamikaze",
	"anton_ace",
	"stepasnuggler",
	"yurasyogi",
	"shurikspade",
	"vityukha_vandal",
	"leva-lord",
	"edikears",
	"KolyaKnot",
	"Vetal--Visitor",
	"matveimachine",
	"vladviking",
	"temka-Typist",
	"timka-tail",
	"BodyaBusDriver",
	"Borkabeaver",
	"anatolyalligator",
	"vasyavisigoth",
	"yurasyankee",
	"zheka-Zinger",
	"VankaTycoon",
	"Fedka Highlander",
	"Mitka Axe",
	"Mark Debater",
	"Pavlukha Shortstop",
	"Gena Courier",
	"Sanya Boulder",
	"Vitalik Shifter",
	"Grisha Zinger",
	"Sevka Atrocious",
	"maxtrump",
	"Zhenka Defunct",
	"Dmitro Rook",
	"Borya Madera",
	"Vovka Nocturnal",
	"Vovka Megabyte",
	"Lekha Lethal",
	"Tokha Skew",
	"Vladimir Hungry",
	"George Pigmy",
	"Vulture Burbridge",
	"Red",
	"NormanFourEyes",
	"TheSlug",
	"Maltese",
	"Filya Butt",
	"direstraitsofficial",
	"rambo",
	"Legwarmer",
	"strelokfan1999",
	"aznsk8r1337",
	"Iron Ivan",
	"Fedya_Rice",
	"kendricknovielloreal",
	"Litso",
	"Grisha Heartthrob",
	"FULL_EMPTY",
	"BOOTY ASS",
	"Artyom Dyatlov",
	"marauderofficial",
	"Naum Shubin",
	"not_a_barman_alt",
}

local RandomItemOpinions = {
	"I can't believe the Zone has done this to me.",
	"I can finally retire!",
	"Is this even worth anything?",
	"Anyone looking to buy it?",
	"Wow, what junk.",
	"It's my lucky day!",
	"Does anyone have any idea what this is?",
	"First offer goes.",
	"NO LOWBALL OFFERS, I KNOW WHAT I HAVE.",
	"I hate these things.",
	"Does anyone know any traders that'll take it?",
	"He won't be needing this anymore.",
}

local RandomTalking = {
	"The Zone really is an evil bastard.",
	"Why does it smell like someone died over here? Oh, there he is.",
	"I really hate swamp water.",
	"uh oh, my dosimeter isn't reading anymore...",
	"uhh guys, I dropped my geiger counter.",
	"Why does my mouth taste like metal?",
	"Hahah, I just watched a rookie shit his pants!",
	"That boar and flesh really are going at it, it's like a nature documentary.",
	"You people are all freaks, go to hell!",
	"Just saw a fat bandit pass by Lonertown. His poor mother!",
	"Is it supposed to make that sound?",
	"Anyone else hear that?",
	"I'm watching you!",
	"Oblivion awaits...",
	"How the hell do you get laid in this place?",
	"Let sleeping dogs lie.",
	"Is there a trader around?",
	"Is there a technician around?",
	"That's life.",
	"Anyone got an MP7 mag?",
	"My suit broke. God damn it...",
	"What the fuck...",
	"Why does my PDA keep saying my reputation has worsened?",
	"I wiped this zone and why did I just come here? Money. Yes, we have fattened with our blood and sweat the cocksuckers in the government, that earn while doing fucking shit, and we are here, obliged to crawl for pathetic crumbs.",
	"feelin pretty shit. Who cares, Ima have myself a beer, HEHE.",
	"I feel like sleeping",
	"My dosimeter's reading 3.6 roentgens. Is that good or bad?",
	"wtf even is tourists delight",
	"I AM COMPLETELY DERANGED!!!!",
	"The longer I'm here, the more I want to leave, and the less I think I actually can.",
	"KXFNGDKFGJSLHJRASOPCOFDF",
	"Who's better, Freedom or Duty?",
	"These emissions are killing me slowly. One more, and I think my bones will disintegrate.",
	"The Zone is a witch, and anomalies are her magic spells. Does that make us the potion or the broom?",
	"It's gonna be a long day, isn't it?",
	"Hello, world!",
	"i am so sick and tired. I just want out of here",
	"What does radiation taste like? Because I think I'm tasting radiation right now.",
	"I haven't smiled once since I got here.",
	"DOWNLOAD THIS LINK TO RECEIVE FREE RUBLES!!!: realstalkercash.snet.vbs",
}

local RandomPlayerRelatedStrings = {
	"I heard that somebody put a bounty on %s's head.",
	"%s seems kind of jittery lately. Did anyone post money on their head?",
	"Hey, %s! Duck.",
	"Pssst, %s. Don't look behind you.",
	"%s, watch out!",
	"%s, your reputation seems well enough.",
	"%s, are you new here?",
	"Hey %s, what happened to that Russian Playboy I loaned you?",
	"%s",
	"Watch out, %s. You will become a zombie and the last thing you will see is my shotgun barrel.",
	"Hey, %s. Want to be friends?",
	"What the fuck did you just fucking say about me, %s?",
	"I think I just saw %s. Are the stories true?",
	"anyone seen %s today?",
	"THiS is a MESSAGE fOr %s. WACH OUT !!!! U R NEXT >:(",
	"Finally, some peace and quiet. %s can't ever shut the fuck up.",
	"it's time yall. going to collect that bounty on %s",
	"%s haunts my dreams.",
	"Haven't seen %s in a while. Hope they aren't dead.",
}

local RandomNPCRelatedStrings = {
	"Anyone seen a %s around here? Thought I heard one a minute ago.",
	"Just took down a %s. What a bastard.",
	"Stay alert. I hear a %s.",
	"Seems like every day I wake up and find a %s in my tent.",
	"Damn %s! It left a mess all over the place.",
	"Check it out, that %s is  getting closer.",
	"Is that... a %s over there?...",
	"i had a dream about a %s last nite",
	"does %s taste good or nah",
	"Eek! %s!",
	"Theres a mass outbreak of %s in the Garbage . Tread carefully stalkers",
}

local RandomItemRelatedStrings = {
	"%s. That's all he had on him.",
	"I don't think I'm going to make it, man. I forgot to pack %s.",
	"Barman has some very shitty deals. I think he ripped me off on a %s.",
	"Anybody seen my %s? I think I left it around here somewhere.",
	"Heard from my buddy that %s is the hot new item to have.",
	"Who was selling that %s? I've got the cash.",
	"Price check on %s?",
	"Anybody else get the message saying you won a %s in a raffle?",
	"I'm trying to repair my ZAZ, and the manual says I need a %s. Anyone got one for sale?",
	"I needed this %s. Thanks for saving me from spending money, my dead friend.",
	"That bastard was carrying %s, I will keep it.",
	"Would you look at this! He had %s. It's mine now.",
	"Sidorovich will want his hands on this %s!",
	"day 532 of looking for a %s ........",
	"How much is a %s",
	"Do traders sell %s or do i have to pull it outta some stinkin corpse ?",
	"I;m thinking about thos %s",
}

local RandomTraderRelatedStrings = {
	"%s just keeps on raising their prices. If it keeps on, I'll go to sleep starving.",
	"%s has some great deals.",
	"Finally, some decent prices. %s has the hookup.",
	"%s is on their bullshit again. Buyer beware!",
	"Someone tell %s to wake the fuck up, I need to buy something.",
	"the market sucks cock rn, at least %s has good prices",
	"This is the last time I buy from %s. What a rip off.",
	"I wonder how %s gets their supplies....... hm.......",
	"This magazine I just bought from %s is sticky.",
}

local DisallowItems = {
	suit_exo = true,
	suit_ssp = true,
	suit_sspm = true,
	suit_heavyseva = true,
	ammo_50ae = true,
	ammo_50bmg = true,
	ammo_127x108 = true,
	ammo_gauss = true,
	electrobattery = true,
	faberge = true,
	flamebattery = true,
	gasrag = true,
	mutant_bloodsucker = true,
	nightstar = true,
	pellicle = true,
	sarcophagus = true,
	soul = true,
	sword = true,
	reprise = true,
	weapon_srp_m60 = true,
	weapon_srp_c96 = true,
	weapon_cc_gauss = true,
	weapon_srp_vhs = true,
	weapon_srp_rfb = true,
	weapon_srp_kimber = true,
	weapon_srp_ksg = true,
	weapon_srp_svu = true,
	weapon_srp_spectre = true,
	generic_item = true,
	psiband_monolith = true,
	generic_artifact1 = true,
	generic_artifact2 = true,
	generic_artifact3 = true,
	bdu_suit_berill_free0 = true,
	bdu_suit_berill_lone0 = true,
	bdu_suit_berill_lone1 = true,
	bdu_suit_berill_nomask_free0 = true,
	bdu_suit_berill_nomask_lone0 = true,
	bdu_suit_berill_nomask_lone1 = true,
	bdu_suit_berill_nomask_spet0 = true,
	bdu_suit_berill_nomask_ukm0 = true,
	bdu_suit_berill_spet0 = true,
	bdu_suit_berill_ukm0 = true,
	bdu_suit_combatsunrise_duty1 = true,
	bdu_suit_combatsunrise_final2 = true,
	bdu_suit_combatsunrise_free2 = true,
	bdu_suit_combatsunrise_lone10 = true,
	bdu_suit_combatsunrise_lone11 = true,
	bdu_suit_combatsunrise_lone12 = true,
	bdu_suit_combatsunrise_lone13 = true,
	bdu_suit_combatsunrise_lone14 = true,
	bdu_suit_combatsunrise_lone15 = true,
	bdu_suit_combatsunrise_lone16 = true,
	bdu_suit_combatsunrise_lone17 = true,
	bdu_suit_combatsunrise_lone18 = true,
	bdu_suit_combatsunrise_lone19 = true,
	bdu_suit_combatsunrise_lone20 = true,
	bdu_suit_combatsunrise_lone21 = true,
	bdu_suit_combatsunrise_lone26 = true,
	bdu_suit_combatsunrise_lone28 = true,
	bdu_suit_combatsunrise_lone29 = true,
	bdu_suit_combatsunrise_lone3 = true,
	bdu_suit_combatsunrise_lone30 = true,
	bdu_suit_combatsunrise_lone31 = true,
	bdu_suit_combatsunrise_lone5 = true,
	bdu_suit_combatsunrise_lone7 = true,
	bdu_suit_combatsunrise_lone8 = true,
	bdu_suit_combatsunrise_merc0 = true,
	bdu_suit_combatsunrise_merc1 = true,
	bdu_suit_combatsunrise_merc2 = true,
	bdu_suit_combatsunrise_merc3 = true,
	bdu_suit_cs1_lone0 = true,
	bdu_suit_exo_bandit1 = true,
	bdu_suit_exo_duty1 = true,
	bdu_suit_exo_duty2 = true,
	bdu_suit_exo_final1 = true,
	bdu_suit_exo_free1 = true,
	bdu_suit_exo_free2 = true,
	bdu_suit_exo_free3 = true,
	bdu_suit_exo_lone0 = true,
	bdu_suit_exo_lone1 = true,
	bdu_suit_exo_lone2 = true,
	bdu_suit_exo_lone3 = true,
	bdu_suit_exo_merc1 = true,
	bdu_suit_exo_merc2 = true,
	bdu_suit_exo_mono1 = true,
	bdu_suit_exo_mono2 = true,
	bdu_suit_heavyseva_duty2 = true,
	bdu_suit_heavyseva_lone0 = true,
	bdu_suit_heavyseva_lone1 = true,
	bdu_suit_heavyseva_lone2 = true,
	bdu_suit_heavyseva_merc1 = true,
	bdu_suit_heavyseva_merc2 = true,
	bdu_suit_heavyseva_mono3 = true,
	bdu_suit_io7_bandit1 = true,
	bdu_suit_io7_bandit2 = true,
	bdu_suit_io7_lone0 = true,
	bdu_suit_io7_lone1 = true,
	bdu_suit_io7_lone2 = true,
	bdu_suit_io7_lone3 = true,
	bdu_suit_io7_merc0 = true,
	bdu_suit_io7_merc1 = true,
	bdu_suit_io7_merc2 = true,
	bdu_suit_io7_merc3 = true,
	bdu_suit_io7_merc4 = true,
	bdu_suit_io7_merc5 = true,
	bdu_suit_io7_merc6 = true,
	bdu_suit_io7_merc7 = true,
	bdu_suit_io7_merc8 = true,
	bdu_suit_psz_duty1 = true,
	bdu_suit_psz_free2 = true,
	bdu_suit_psz_isg1 = true,
	bdu_suit_psz_lone0 = true,
	bdu_suit_psz_lone22 = true,
	bdu_suit_psz_lone23 = true,
	bdu_suit_psz_lone24 = true,
	bdu_suit_psz_lone25 = true,
	bdu_suit_psz_lone27 = true,
	bdu_suit_psz_lone28 = true,
	bdu_suit_psz_lone31 = true,
	bdu_suit_psz_lone32 = true,
	bdu_suit_psz_lone6 = true,
	bdu_suit_psz_merc0 = true,
	bdu_suit_psz_merc1 = true,
	bdu_suit_psz_mono2 = true,
	bdu_suit_psz_mono3 = true,
	bdu_suit_psz_mono4 = true,
	bdu_suit_radsuit_bandit1 = true,
	bdu_suit_radsuit_duty1 = true,
	bdu_suit_radsuit_duty2 = true,
	bdu_suit_radsuit_final1 = true,
	bdu_suit_radsuit_free1 = true,
	bdu_suit_radsuit_free2 = true,
	bdu_suit_radsuit_free3 = true,
	bdu_suit_radsuit_lone0 = true,
	bdu_suit_radsuit_lone1 = true,
	bdu_suit_radsuit_lone2 = true,
	bdu_suit_radsuit_lone3 = true,
	bdu_suit_radsuit_merc1 = true,
	bdu_suit_radsuit_merc2 = true,
	bdu_suit_radsuit_mono1 = true,
	bdu_suit_radsuit_mono2 = true,
	bdu_suit_seva_duty1 = true,
	bdu_suit_seva_duty2 = true,
	bdu_suit_seva_final1 = true,
	bdu_suit_seva_free1 = true,
	bdu_suit_seva_free2 = true,
	bdu_suit_seva_isg1 = true,
	bdu_suit_seva_lone0 = true,
	bdu_suit_seva_lone1 = true,
	bdu_suit_seva_lone2 = true,
	bdu_suit_seva_lone3 = true,
	bdu_suit_seva_merc1 = true,
	bdu_suit_seva_merc2 = true,
	bdu_suit_seva_mono1 = true,
	bdu_suit_seva_mono2 = true,
	bdu_suit_seva_mono3 = true,
	bdu_suit_skat_bulat_duty1 = true,
	bdu_suit_skat_bulat_duty2 = true,
	bdu_suit_skat_bulat_lone0 = true,
	bdu_suit_skat_bulat_lone1 = true,
	bdu_suit_skat_bulat_merc1 = true,
	bdu_suit_skat_bulat_ukm = true,
	bdu_suit_skat_bulat_winter1 = true,
	bdu_suit_skat_duty1 = true,
	bdu_suit_skat_duty2 = true,
	bdu_suit_skat_lone0 = true,
	bdu_suit_skat_lone1 = true,
	bdu_suit_skat_merc1 = true,
	bdu_suit_skat_ukm1 = true,
	bdu_suit_skat_winter1 = true,
	bdu_suit_ssp_eco0 = true,
	bdu_suit_ssp_eco1 = true,
	bdu_suit_sunrise_final1 = true,
	bdu_suit_sunrise_final2 = true,
	bdu_suit_sunrise_free1 = true,
	bdu_suit_sunrise_isg1 = true,
	bdu_suit_sunrise_lone0 = true,
	bdu_suit_sunrise_lone1 = true,
	bdu_suit_sunrise_lone10 = true,
	bdu_suit_sunrise_lone11 = true,
	bdu_suit_sunrise_lone12 = true,
	bdu_suit_sunrise_lone13 = true,
	bdu_suit_sunrise_lone14 = true,
	bdu_suit_sunrise_lone15 = true,
	bdu_suit_sunrise_lone16 = true,
	bdu_suit_sunrise_lone17 = true,
	bdu_suit_sunrise_lone18 = true,
	bdu_suit_sunrise_lone19 = true,
	bdu_suit_sunrise_lone2 = true,
	bdu_suit_sunrise_lone20 = true,
	bdu_suit_sunrise_lone21 = true,
	bdu_suit_sunrise_lone26 = true,
	bdu_suit_sunrise_lone28 = true,
	bdu_suit_sunrise_lone29 = true,
	bdu_suit_sunrise_lone3 = true,
	bdu_suit_sunrise_lone30 = true,
	bdu_suit_sunrise_lone31 = true,
	bdu_suit_sunrise_lone32 = true,
	bdu_suit_sunrise_lone33 = true,
	bdu_suit_sunrise_lone34 = true,
	bdu_suit_sunrise_lone35 = true,
	bdu_suit_sunrise_lone36 = true,
	bdu_suit_sunrise_lone37 = true,
	bdu_suit_sunrise_lone4 = true,
	bdu_suit_sunrise_lone5 = true,
	bdu_suit_sunrise_lone7 = true,
	bdu_suit_sunrise_lone8 = true,
	bdu_suit_sunrise_lone9 = true,
	bdu_suit_sunrise_merc2 = true,
	bdu_suit_sunrise_merc3 = true,
	bdu_suit_sunrise_mono1 = true,
	bdu_suit_trench_bandit0 = true,
	bdu_suit_trench_bandit1 = true,
	bdu_suit_trench_bandit2 = true,
	bdu_suit_trench_bandit3 = true,
	bdu_suit_trench_sunrisemask_bandit0_lone0 = true,
	bdu_suit_trench_sunrisemask_bandit0_lone13 = true,
	bdu_suit_trench_sunrisemask_bandit0_lone17 = true,
	bdu_suit_trench_sunrisemask_bandit0_lone22 = true,
	bdu_suit_trench_sunrisemask_bandit0_lone23 = true,
	bdu_suit_trench_sunrisemask_bandit0_lone25 = true,
	bdu_suit_trench_sunrisemask_bandit0_lone27 = true,
	bdu_suit_trench_sunrisemask_bandit0_lone29 = true,
	bdu_suit_trench_sunrisemask_bandit1_lone0 = true,
	bdu_suit_trench_sunrisemask_bandit1_lone13 = true,
	bdu_suit_trench_sunrisemask_bandit1_lone17 = true,
	bdu_suit_trench_sunrisemask_bandit1_lone22 = true,
	bdu_suit_trench_sunrisemask_bandit1_lone23 = true,
	bdu_suit_trench_sunrisemask_bandit1_lone25 = true,
	bdu_suit_trench_sunrisemask_bandit1_lone27 = true,
	bdu_suit_trench_sunrisemask_bandit1_lone29 = true,
	bdu_suit_trench_sunrisemask_bandit2_lone0 = true,
	bdu_suit_trench_sunrisemask_bandit2_lone13 = true,
	bdu_suit_trench_sunrisemask_bandit2_lone17 = true,
	bdu_suit_trench_sunrisemask_bandit2_lone22 = true,
	bdu_suit_trench_sunrisemask_bandit2_lone23 = true,
	bdu_suit_trench_sunrisemask_bandit2_lone25 = true,
	bdu_suit_trench_sunrisemask_bandit2_lone27 = true,
	bdu_suit_trench_sunrisemask_bandit2_lone29 = true,
	bdu_suit_trench_sunrisemask_bandit3_lone0 = true,
	bdu_suit_trench_sunrisemask_bandit3_lone13 = true,
	bdu_suit_trench_sunrisemask_bandit3_lone17 = true,
	bdu_suit_trench_sunrisemask_bandit3_lone22 = true,
	bdu_suit_trench_sunrisemask_bandit3_lone23 = true,
	bdu_suit_trench_sunrisemask_bandit3_lone25 = true,
	bdu_suit_trench_sunrisemask_bandit3_lone27 = true,
	bdu_suit_trench_sunrisemask_bandit3_lone29 = true,
	bdu_suit_trenchio7_bandit1_bandit0 = true,
	bdu_suit_trenchio7_bandit1_bandit1 = true,
	bdu_suit_trenchio7_bandit2_bandit0 = true,
	bdu_suit_trenchio7_bandit2_bandit1 = true,
	bdu_suit_trenchio7_lone0_bandit0 = true,
	bdu_suit_trenchio7_lone0_bandit1 = true,
	bdu_suit_trenchio7_lone1_bandit0 = true,
	bdu_suit_trenchio7_lone1_bandit1 = true,
	bdu_suit_trenchio7_lone2_bandit0 = true,
	bdu_suit_trenchio7_lone2_bandit1 = true,
	bdu_suit_trenchio7_lone3_bandit0 = true,
	bdu_suit_trenchio7_lone3_bandit1 = true,
	bdu_suit_trenchio7_merc0_bandit0 = true,
	bdu_suit_trenchio7_merc0_bandit1 = true,
	bdu_suit_trenchio7_merc1_bandit0 = true,
	bdu_suit_trenchio7_merc1_bandit1 = true,
	bdu_suit_trenchio7_merc2_bandit0 = true,
	bdu_suit_trenchio7_merc2_bandit1 = true,
	bdu_suit_trenchio7_merc3_bandit0 = true,
	bdu_suit_trenchio7_merc3_bandit1 = true,
	bdu_suit_trenchio7_merc4_bandit0 = true,
	bdu_suit_trenchio7_merc4_bandit1 = true,
	bdu_suit_trenchio7_merc5_bandit0 = true,
	bdu_suit_trenchio7_merc5_bandit1 = true,
	bdu_suit_trenchio7_merc6_bandit0 = true,
	bdu_suit_trenchio7_merc6_bandit1 = true,
	bdu_suit_trenchio7_merc7_bandit0 = true,
	bdu_suit_trenchio7_merc7_bandit1 = true,
	bdu_suit_trenchio7_merc8_bandit0 = true,
	bdu_suit_trenchio7_merc8_bandit1 = true,
	bdu_suit_trenchsunrise_final1_bandit0 = true,
	bdu_suit_trenchsunrise_final2_bandit0 = true,
	bdu_suit_trenchsunrise_lone0_bandit0 = true,
	bdu_suit_trenchsunrise_lone0_bandit3 = true,
	bdu_suit_trenchsunrise_lone10_bandit0 = true,
	bdu_suit_trenchsunrise_lone10_bandit1 = true,
	bdu_suit_trenchsunrise_lone10_bandit3 = true,
	bdu_suit_trenchsunrise_lone11_bandit0 = true,
	bdu_suit_trenchsunrise_lone11_bandit1 = true,
	bdu_suit_trenchsunrise_lone12_bandit0 = true,
	bdu_suit_trenchsunrise_lone12_bandit1 = true,
	bdu_suit_trenchsunrise_lone13_bandit1 = true,
	bdu_suit_trenchsunrise_lone14_bandit0 = true,
	bdu_suit_trenchsunrise_lone14_bandit1 = true,
	bdu_suit_trenchsunrise_lone15_bandit0 = true,
	bdu_suit_trenchsunrise_lone15_bandit1 = true,
	bdu_suit_trenchsunrise_lone16_bandit0 = true,
	bdu_suit_trenchsunrise_lone17_bandit0 = true,
	bdu_suit_trenchsunrise_lone17_bandit1 = true,
	bdu_suit_trenchsunrise_lone18_bandit0 = true,
	bdu_suit_trenchsunrise_lone18_bandit1 = true,
	bdu_suit_trenchsunrise_lone19_bandit0 = true,
	bdu_suit_trenchsunrise_lone19_bandit1 = true,
	bdu_suit_trenchsunrise_lone2_bandit0 = true,
	bdu_suit_trenchsunrise_lone2_bandit1 = true,
	bdu_suit_trenchsunrise_lone2_bandit3 = true,
	bdu_suit_trenchsunrise_lone20_bandit0 = true,
	bdu_suit_trenchsunrise_lone20_bandit1 = true,
	bdu_suit_trenchsunrise_lone21_bandit0 = true,
	bdu_suit_trenchsunrise_lone21_bandit1 = true,
	bdu_suit_trenchsunrise_lone26_bandit0 = true,
	bdu_suit_trenchsunrise_lone29_bandit0 = true,
	bdu_suit_trenchsunrise_lone3_bandit1 = true,
	bdu_suit_trenchsunrise_lone30_bandit0 = true,
	bdu_suit_trenchsunrise_lone4_bandit0 = true,
	bdu_suit_trenchsunrise_lone4_bandit3 = true,
	bdu_suit_trenchsunrise_lone5_bandit1 = true,
	bdu_suit_trenchsunrise_lone5_bandit3 = true,
	bdu_suit_trenchsunrise_lone7_bandit0 = true,
	bdu_suit_trenchsunrise_lone7_bandit1 = true,
	bdu_suit_trenchsunrise_lone7_bandit3 = true,
	bdu_suit_trenchsunrise_lone8_bandit1 = true,
	bdu_suit_trenchsunrise_mono1_bandit0 = true,
}

local RandomPDAMessageFuncs = {
	[1] = function()
		local randomItem = table.Random(GAMEMODE.Items)

		if DisallowItems[randomItem.Class] then return end

		local randomOpinion = table.Random(RandomItemOpinions)

		return Format("I found a %s. %s", randomItem.Name, randomOpinion)
	end,
	[2] = function()
		return table.Random(RandomTalking)
	end,
	[3] = function()
		local randomPlayer = table.Random(player.GetAllLoaded())
		if !IsValid(randomPlayer) then return end

		local playerName = !randomPlayer:Hidden() and randomPlayer:HasCharFlag("X") and randomPlayer:RPName() or false
		if !playerName then return end
		
		local randomItem = table.Random(GAMEMODE.Items)

		if DisallowItems[randomItem.Class] then return end

		return Format("%s just ripped me off on %s. I paid twice the value!", playerName, randomItem.Name)
	end,
	[4] = function()
		local randomItem = table.Random(GAMEMODE.Items)
		if DisallowItems[randomItem.Class] then return end

		return Format(table.Random(RandomItemRelatedStrings), randomItem.Name)
	end,
	[5] = function()
		local randomPlayer = table.Random(player.GetAllLoaded())
		if !IsValid(randomPlayer) then return end

		local playerName = !randomPlayer:Hidden() and randomPlayer:RPName() or false

		if !playerName then return end

		return Format(table.Random(RandomPlayerRelatedStrings), playerName)
	end,
	[6] = function()
		local randomPlayer = table.Random(player.GetAllLoaded())
		if !IsValid(randomPlayer) then return end

		local playerName = !randomPlayer:Hidden() and randomPlayer:HasCharFlag("X") and randomPlayer:RPName() or false

		if !playerName then return end

		return Format(table.Random(RandomTraderRelatedStrings), playerName)
	end,
	[7] = function()
		local allNPCs = {}
		for _,ent in ipairs(ents.GetAll()) do
			if ent:IsNextBot() or ent:IsNPC() then
				table.insert(allNPCs, ent)
			end
		end

		local randomNPC = table.Random(allNPCs)

		if !randomNPC then return end

		local npcData = scripted_ents.GetStored(randomNPC:GetClass())
		
		if !npcData then return end
		if !npcData.t then return end
		if !npcData.t.PrintName then return end

		return Format(table.Random(RandomNPCRelatedStrings), npcData.t.PrintName)
	end,
}

concommand.Add("randompda", function(ply, cmd, args)
	if IsValid(ply) then return end

	print(table.Random(RandomPDAMessageFuncs)())
end)

local function RandomPDAMessages()
	if !kingston.blowout.can_use_pda() then return end

	if !GAMEMODE.NextRandomPDA then
		GAMEMODE.NextRandomPDA = CurTime() + math.random(300, 600)
	end

	if GAMEMODE.NextRandomPDA <= CurTime() then
		local icon = {2,5}
		local username = table.Random(RandomPDANames)
		local randomMessage = table.Random(RandomPDAMessageFuncs)
		local message = randomMessage()

		if !message then 
			return
		end

		for _,ply in ipairs(player.GetAll()) do
			local pda = ply:HasItem("pda")

			if !pda then continue end

			local poweredOn 
			if !pda.IsItem and istable(pda) then
				for _,item in ipairs(pda) do
					if item:GetVar("Power", false) then
						poweredOn = true
					end
				end
			else
				poweredOn = pda:GetVar("Power", false)
			end

			if !poweredOn then continue end

			if ply:HasItem("pda") then
				ply:PDANotify(username.." -> all", message, icon[1], icon[2])
			end
		end

		if GAMEMODE.PDADiscordHook then
			// fire and forget
			http.Post(GAMEMODE.ProxySite, {
				url = GAMEMODE.PDADiscordHook,
				data = util.TableToJSON({
					username = username.." -> all",
					content = message,
					avatar_url = "https://cdn.discordapp.com/attachments/367478333425844224/956297681658052608/latest.png",
					allowed_mentions = {parse = {}}
				})
			})
		end

		GAMEMODE.NextRandomPDA = CurTime() + math.random(180, 300)
	end
end
hook.Add("Think", "STALKER.RandomPDAMessages", RandomPDAMessages)