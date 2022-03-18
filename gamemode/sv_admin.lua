kingston = kingston or {}
kingston.admin = kingston.admin or {}

kingston.admin.commands = kingston.admin.commands or {}
kingston.admin.groups = kingston.admin.groups or {}

local GROUP_ADDPERM 	= 0
local GROUP_TAKEPERM 	= 1
local GROUP_PRIORITY 	= 2
local GROUP_UNIQUEID	= 3
local GROUP_SETADMIN	= 4
local GROUP_SETSA		= 5

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
	function kingston.admin.queries.load:onSuccess(results)
		for _,data in pairs(results) do
			local newGroup = {}
			setmetatable(newGroup, kingston.meta.group)

			newGroup:init(data.uniqueID, data)

			kingston.admin.groups[data.uniqueID] = newGroup
		end
	end

	kingston.admin.queries.load:start()
end

// Networking
util.AddNetworkString("zcRunCommand")
util.AddNetworkString("zcUpdateGroup")
util.AddNetworkString("zcGetGroups")
util.AddNetworkString("zcDeleteGroup")

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

local function zcGetGroups(len, ply)
	--if ply.GroupsNetworked then return end

	for _, group in pairs(kingston.admin.groups) do
		net.Start("zcGetGroups")
			net.WriteString(group.uniqueID)
			net.WriteUInt(group.priority, 8)
			net.WriteBool(group.isAdmin)
			net.WriteBool(group.isSuperAdmin)

			net.WriteUInt(table.Count(group.permissions), 8)
			for cmd, _ in pairs(group.permissions) do
				net.WriteString(cmd)
			end
		net.Send(ply)
	end

	ply.GroupsNetworked = true
end
net.Receive("zcGetGroups", zcGetGroups)

// Database

kingston.admin.groups_db_struct = {
	{ "permissions", "JSON"},
	{ "priority", "INT(3)" },
	{ "isAdmin", "BOOL" },
	{ "isSuperAdmin", "BOOL" }
}

kingston.admin.queries = kingston.admin.queries or {}

local function init_log_admin_tbl(db)
	mysqloo.Query("CREATE TABLE IF NOT EXISTS cc_usergroups (`uniqueID` VARCHAR(128), PRIMARY KEY (`uniqueID`));")
	GAMEMODE:InitSQLTable(kingston.admin.groups_db_struct, "cc_usergroups")
	
	// Load all groups
	kingston.admin.queries.load = db:prepare([[SELECT `uniqueID`, `permissions`, `priority`, `isAdmin`, `isSuperAdmin` FROM `cc_usergroups`;]]);
	// Create group
	kingston.admin.queries.create = db:prepare([[INSERT INTO `cc_usergroups` (`uniqueID`, `permissions`, `priority`, `isAdmin`, `isSuperAdmin`) VALUES (?, JSON_OBJECT(), ?, ?, ?);]]);
	// Modify group
	-- kingston.admin.queries.modifyPriority = db:prepare();
	-- kingston.admin.queries.modifyUniqueID = db:prepare();
	-- kingston.admin.queries.modifyAdmin = db:prepare();
	-- kingston.admin.queries.modifySuperAdmin = db:prepare();
	// Delete group
	kingston.admin.queries.delete = db:prepare([[DELETE FROM `cc_usergroups` WHERE `uniqueID` = ?;]]);
	// Add permission
	kingston.admin.queries.addperm = db:prepare([[UPDATE `cc_usergroups` SET `permissions` = JSON_SET(`permissions`, ?, true) WHERE `uniqueID` = ?]]);
	// Take permission
	kingston.admin.queries.takeperm = db:prepare([[UPDATE `cc_usergroups` SET `permissions` = JSON_REMOVE(`permissions`, ?) WHERE `uniqueID` = ?]]);

	kingston.admin.load()
end
hook.Add("InitSQLTables", "STALKER.InitAdminDBTable", init_log_admin_tbl)