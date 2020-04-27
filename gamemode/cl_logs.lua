kingston = kingston or {}
kingston.log = kingston.log or {}

-- no console print for client
kingston.log.console_log = false

/* networking */

local function RequestLogSearch(tbl)
	GAMEMODE:PopulateAdminLogs(tbl)
end
netstream.Hook("RequestLogSearch", RequestLogSearch)