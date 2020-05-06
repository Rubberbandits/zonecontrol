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