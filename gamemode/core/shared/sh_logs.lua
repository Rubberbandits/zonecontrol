kingston = kingston or {}
kingston.log = kingston.log or {}

kingston.log.to_db = true -- filesystem or DB
kingston.log.dir = "zonecontrol/logs"

function kingston.log.write(category, text, ...)
	if kingston.log.to_db and SERVER then
		kingston.log.db_write(category, text, ...)
	else
		kingston.log.fs_write(category, text, ...)
	end
	
	hook.Run("LogWritten", category, Format(text, ...))
end

function kingston.log.fs_write(category, text, ...)
	if !file.IsDir(kingston.log.dir.."/"..os.date("!%y-%m-%d"), "DATA") then
		file.CreateDir(kingston.log.dir.."/"..os.date("!%y-%m-%d"))
	end
	
	file.Append(kingston.log.dir.."/"..os.date("!%y-%m-%d").."/"..category..".txt", os.date("!%X").."\t"..Format(text, ...).."\n")
end

local function SetupLogDirectories()
	file.CreateDir(kingston.log.dir)
end
hook.Add("SetupDataDirectories", "SetupLogDirectories", SetupLogDirectories)

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
