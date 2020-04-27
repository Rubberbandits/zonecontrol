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
hook.Add("SetupDataDirectories", SetupLogDirectories)