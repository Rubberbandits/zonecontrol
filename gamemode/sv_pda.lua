kingston = kingston or {}
kingston.pda = kingston.pda or {}

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
kingston.pda.search_journal_str = [[SELECT * FROM cc_pda_journal WHERE Owner = %d AND DeletionDate IS NOT NULL;]]

local function init_log_pda_tbl(db)
	mysqloo.Query("CREATE TABLE IF NOT EXISTS cc_pda_chat ( id INT NOT NULL auto_increment, PRIMARY KEY ( id ) );")
	mysqloo.Query("CREATE TABLE IF NOT EXISTS cc_pda_journal ( id INT NOT NULL auto_increment, PRIMARY KEY ( id ) );")
	GAMEMODE:InitSQLTable(kingston.pda.chat_db_struct, "cc_pda_chat")
	GAMEMODE:InitSQLTable(kingston.pda.journal_db_struct, "cc_pda_journal")
	
	kingston.pda.chat_insert = db:prepare(kingston.pda.chat_insert_str)
	kingston.pda.journal_insert = db:prepare(kingston.pda.journal_insert_str)
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

function kingston.pda.delete_journal(pda, id)
	
end

/* Networking */

local function PDAGrabChat(ply, id, date)
	local item = ply.Inventory[id]
	if item and item:GetClass() == "pda" and item:GetVar("Power", false) then
		kingston.pda.grab_chat(id, date, function(q, data)
			netstream.Start(ply, "PDAGrabChat", data)
		end)
	end
end
netstream.Hook("PDAGrabChat", PDAGrabChat)

local function PDAGrabJournal(ply, id)
	local item = ply.Inventory[id]
	if item and item:GetClass() == "pda" and item:GetVar("Power", false) then
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
	if item and item:GetClass() == "pda" and item:GetVar("Power", false) then
		kingston.pda.write_journal(id, title, message, update)
	end
end
netstream.Hook("PDAWriteJournal", PDAWriteJournal)