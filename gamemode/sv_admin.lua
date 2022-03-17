kingston = kingston or {}
kingston.admin = kingston.admin or {}

kingston.admin.commands = kingston.admin.commands or {}
kingston.admin.groups = kingston.admin.groups or {}

local ARGTYPE_TARGET 	= 0
local ARGTYPE_STRING 	= 1
local ARGTYPE_BOOL 		= 2
local ARGTYPE_NUMBER 	= 3

local ArgTypeMap = {
	ARGTYPE_TARGET = {
		READ = function()
			return net.ReadEntity()
		end
	},
	ARGTYPE_STRING = {
		READ = function()
			return net.ReadString()
		end
	},
	ARGTYPE_BOOL = {
		READ = function()
			return new.ReadBool()
		end
	},
	ARGTYPE_NUMBER = {
		READ = function()
			return net.ReadInt(32)
		end
	}
}

function kingston.admin.load()

end

// Networking
util.AddNetworkString("zcRunCommand")
util.AddNetworkString("zcUpdateGroup")
util.AddNetworkString("zcGetGroups")

local function zcRunCommand(len, ply)
	local cmd = net.ReadString()

	local commandData = kingston.admin.commands[cmd]
	if !commandData then
		Error("[Admin] Invalid command was sent to zcRunCommand!")
		return
	end

	local passedArguments = {};
	for _,argType in pairs(commandData.arguments) do
		table.insert(passedArguments, ArgTypeMap[argType].READ())
	end

	kingston.admin.runCommand(ply, cmd, passedArguments)
end

net.Receive("zcRunCommand", zcRunCommand)

// Database

kingston.admin.groups_db_struct = {
	{ "UniqueID", "VARCHAR(128)" },
	{ "Permissions", "JSON"},
	{ "Priority", "INT(3)" },
	{ "IsAdmin", "BOOL" },
	{ "IsSuperAdmin", "BOOL" }
}

local function init_log_admin_tbl(db)
	mysqloo.Query("CREATE TABLE IF NOT EXISTS cc_groups (`UniqueID` VARCHAR(128), PRIMARY KEY (`UniqueID`));")
	GAMEMODE:InitSQLTable(kingston.admin.groups_db_struct, "cc_groups")
	
	// Prepare queries
	// Create group
	// Modify group functions
	// Delete group
	// Add permissions to group
	// Take permissions from group
	// Load all groups
end
hook.Add("InitSQLTables", "STALKER.InitAdminDBTable", init_log_admin_tbl)