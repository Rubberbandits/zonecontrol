kingston = kingston or {}
kingston.log = kingston.log or {}

kingston.log.db_struct = {
	{ "Date", "VARCHAR(20)" },
	{ "Category", "VARCHAR(128)" },
	{ "Log", "VARCHAR(8192)" },
}
kingston.log.console_log = true
kingston.log.should_log = {
	sql = true,
	bugs = true,
	admin = true,
	console = true,
	security = true,
}

kingston.log.query_str = [[
	INSERT INTO cc_logs (Date, Category, Log) VALUES (UNIX_TIMESTAMP(), ?, ?);
]]
kingston.log.search_str = [[SELECT * FROM cc_logs WHERE Date >= UNIX_TIMESTAMP('%s') AND Date <= (UNIX_TIMESTAMP('%s') + 86400) AND Category = '%s' AND Log LIKE '%%%s%%' LIMIT %d, %d;]]

local function init_log_db_tbl(db)
	mysqloo.Query("CREATE TABLE IF NOT EXISTS cc_logs ( id INT NOT NULL auto_increment, PRIMARY KEY ( id ) );")
	GAMEMODE:InitSQLTable(kingston.log.db_struct, "cc_logs")
	
	kingston.log.query = db:prepare(kingston.log.query_str)
end
hook.Add("InitSQLTables", "STALKER.InitLogDBTable", init_log_db_tbl)

function kingston.log.db_write(category, text, ...)
	local str = Format(text, ...)

	kingston.log.query:clearParameters()
		kingston.log.query:setString(1, category)
		kingston.log.query:setString(2, str)
	kingston.log.query:start()
	
	if kingston.log.console_log or kingston.log.should_log[category] then
		MsgC(COLOR_LOG, str.."\n")
	end
end

-- gotta use lambda funcs cus async

function kingston.log.search(date_str, category, content, limit, offset, cb)
	local function onSuccess(data, q)
		cb(q, data)
	end

	mysqloo.Query(Format(kingston.log.search_str, mysqloo.Escape(date_str), mysqloo.Escape(date_str), mysqloo.Escape(category), mysqloo.Escape(content), offset, limit), onSuccess, onError)
end

/* aliases for logging systems */

function GM:SetupDataDirectories()
	
end

function GM:LogFile(category, text)
	kingston.log.write(category, text)
end

function GM:LogSQL(text)
	if string.len(text) > 120 then
		text = string.sub(text, 1, 120) .. " (...)"
	end

	self:LogFile("sql", text)
end

function GM:LogBug(text)
	self:LogFile("bugs", text)
end

function GM:LogConsole(text)
	self:LogFile("console", text)
end

function GM:LogAdmin(text, ply)
	local ins = ply:SteamID() .. "\t" .. text
	self:LogFile("admin", ins)
end

function GM:LogSecurity(steamid, networkid, name, text)
	local ins = steamid .. "\t" .. networkid .. "\t" .. name .. "\t" .. text
	self:LogFile("security", ins)
end

function GM:LogChat(text, ply)
	local ins = ply:SteamID() .. "\t" .. text
	self:LogFile("chat", ins)
end

function GM:LogSandbox(text, ply)
	local ins = ply:SteamID() .. "\t" .. text
	self:LogFile("sandbox", ins)
end

function GM:LogItems(text, ply)
	local ins = ply:SteamID() .. "\t" .. text
	self:LogFile("items", ins)
end

/* networking */

local function RequestLogSearch(ply, date_str, category, content, position)
	if !ply:IsAdmin() then return end

	kingston.log.search(date_str, category, content, 50, position, function(q, data)
		netstream.Start(ply, "RequestLogSearch", data)
	end)
end
netstream.Hook("RequestLogSearch", RequestLogSearch)