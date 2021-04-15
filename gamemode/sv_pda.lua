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
			
			rf[#rf + 1] = {name = v:GetVar("Name", "UNKNOWN_USER")}
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
		kingston.pda.chat_insert:setString(3, sender_pda:GetVar("Name", "UNKNOWN_USER"))
		kingston.pda.chat_insert:setString(4, receiver_pda:GetVar("Name", "UNKNOWN_USER"))
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
	if !ply:HasCharFlag("T") or !ply:HasItem("pda_recover") then return end
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
	if !ply:HasCharFlag("T") or !ply:HasItem("pda_encryption") then return end
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
	if !ply:HasCharFlag("T") or !ply:HasItem("pda_decryption") then return end
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
	"Uh oh, my dosimeter isn't reading anymore...",
	"Uhh, guys, I dropped my Geiger Counter.",
	"Why does my mouth taste like metal?",
	"Hahah, I just watched a rookie shit his pants!",
	"The boar and flesh really are going at it, it's like a nature documentary.",
	"You people are all freaks, go to hell!",
	"Just saw a fat bandit pass by Loner town. His poor mother!",
}

local RandomPlayerRelatedStrings = {
	"I think I passed %s earlier. Isn't there a bounty on their head?",
	"%s seems kind of jittery lately. Anyone posted money on their head?",
	"Hey, %s! Duck.",
	"Pssst, %s. Don't look behind you.",
	"%s, watch out!",
	"%s, your reputation seems well enough.",
	"%s, are you new here?",
}

local RandomNPCRelatedStrings = {
	"Anyone seen a %s around here? Thought I heard one a minute ago.",
}

local RandomItemRelatedStrings = {
	"%s. That's all he had on him.",
	"I don't think I'm going to make it, man. I forgot to pack %s.",
}

local DisallowItems = {
	suit_exo = true,
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
		local randomPlayer = table.Random(player.GetAll())
		local playerName = randomPlayer:CharID() > 0 and randomPlayer:RPName() or false
		local randomItem = table.Random(GAMEMODE.Items)

		if DisallowItems[randomItem.Class] then return end

		if !playerName then
			playerName = table.Random(RandomPDANames)
		end

		return Format("%s just ripped me off on %s. I paid twice the price!", playerName, randomItem.Name)
	end,
	[4] = function()
		local randomItem = table.Random(GAMEMODE.Items)
		if DisallowItems[randomItem.Class] then return end

		return Format(table.Random(RandomItemRelatedStrings), randomItem.Name)
	end,
	[5] = function()
		local randomPlayer = table.Random(player.GetAll())
		local playerName = randomPlayer:CharID() > 0 and randomPlayer:RPName() or false

		if !playerName then return end

		return Format(table.Random(RandomPlayerRelatedStrings), playerName)
	end,
	[6] = function()
		local randomPlayer = table.Random(player.GetAll())
		local playerName = randomPlayer:CharID() > 0 and randomPlayer:HasCharFlag("X") and randomPlayer:RPName() or false

		if !playerName then return end

		return Format("%s just keeps on raising their prices. If it keeps on, I'll go to sleep starving.", playerName)
	end,
	[7] = function()
		local allNPCs = {}
		for _,ent in ipairs(ents.GetAll()) do
			if ent:IsNextBot() or ent:IsNPC() then
				table.insert(allNPCs, ent)
			end
		end

		local randomNPC = table.Random(allNPCs)

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
	if !GAMEMODE.NextRandomPDA then
		GAMEMODE.NextRandomPDA = CurTime() + math.random(180, 300)
	end

	if GAMEMODE.NextRandomPDA <= CurTime() then
		local icon = {2,5}
		local username = table.Random(RandomPDANames)
		local randomMessage = table.Random(RandomPDAMessageFuncs)
		local string = randomMessage()

		if !string then 
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
				ply:PDANotify(username.." -> all", string, icon[1], icon[2])
			end
		end

		GAMEMODE.NextRandomPDA = CurTime() + math.random(180, 300)
	end
end
hook.Add("Think", "STALKER.RandomPDAMessages", RandomPDAMessages)