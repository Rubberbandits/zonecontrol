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
}

kingston.pda.chat_insert_str = [[
	INSERT INTO cc_pda_chat (Date, Sender, Receiver, SenderName, ReceiverName, Message) VALUES (?, ?, ?, ?, ?, ?);
]]
kingston.pda.journal_insert_str = [[
	INSERT INTO cc_pda_journal (Date, Owner, Title, Message) VALUES (?, ?, ?, ?);
]]
kingston.pda.search_chat_str = [[SELECT * FROM cc_pda_chat WHERE Date LIKE '%%%s%%' AND (Sender = %d OR Receiver = %d);]]
kingston.pda.search_journal_str = [[SELECT * FROM cc_pda_journal WHERE Owner = %d;]]

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

	mysqloo.Query(Format(kingston.pda.search_chat_str, mysqloo.Escape(date), id, id), onSuccess)
end

function kingston.pda.grab_journal(id, cb)
	local function onSuccess(data, q)
		cb(q, data)
	end
	mysqloo.Query(Format(kingston.pda.search_journal_str, id), onSuccess)
end

function kingston.pda.find_contacts()

end

function kingston.pda.write_chat(sender_id, receiver_id, message)
	local sender_pda = GAMEMODE.g_ItemTable[sender_id]
	local receiver_pda = GAMEMODE.g_ItemTable[receiver_id]
	if !sender_pda or !receiver_pda then return end

	kingston.pda.chat_insert:clearParameters()
		kingston.pda.chat_insert:setString(1, os.date("!%x %X"))
		kingston.pda.chat_insert:setNumber(2, sender_id)
		kingston.pda.chat_insert:setNumber(3, receiver_id)
		kingston.pda.chat_insert:setString(4, sender_pda:GetVar("Name", "UNKNOWN"))
		kingston.pda.chat_insert:setString(5, receiver_pda:GetVar("Name", "UNKNOWN"))
		kingston.pda.chat_insert:setString(6, message)
	kingston.pda.chat_insert:start()
end

function kingston.pda.write_journal(pda, title, message)
	local item = GAMEMODE.g_ItemTable[pda]
	if !item then return end

	kingston.pda.journal_insert.onError = function(q, err)
		print(err)
	end

	kingston.pda.journal_insert:clearParameters()
		kingston.pda.journal_insert:setString(1, os.date("!%x %X"))
		kingston.pda.journal_insert:setNumber(2, pda)
		kingston.pda.journal_insert:setString(3, title)
		kingston.pda.journal_insert:setString(4, message)
	kingston.pda.journal_insert:start()
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

local function PDAWriteJournal(ply, id, title, message)
	local item = ply.Inventory[id]
	if item and item:GetClass() == "pda" and item:GetVar("Power", false) then
		kingston.pda.write_journal(id, title, message)
	end
end
netstream.Hook("PDAWriteJournal", PDAWriteJournal)