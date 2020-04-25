kingston = kingston or {}
kingston.log = kingston.log or {}

kingston.log.to_db = true -- filesystem or DB

function kingston.log.write(category, text, ...)
	if kingston.log.to_db and SERVER then
		kingston.log.db_write(category, text, ...)
	else
		kingston.log.fs_write(category, text, ...)
	end
end

function kingston.log.fs_write(category, text, ...)

end

local function SetupLogDirectories()
	file.CreateDir("zonecontrol/logs")
end
hook.Add("SetupDataDirectories", SetupLogDirectories)