local function zcGetGroups(len)
	local uniqueID = net.ReadString()
	local priority = net.ReadUInt(8)
	local isAdmin = net.ReadBool()
	local isSuperAdmin = net.ReadBool()

	local permissions = {}
	local permissionCount = net.ReadUInt(8)
	for i = 1, permissionCount do
		permissions[net.ReadString()] = true
	end

	local data = {
		uniqueID = uniqueID,
		priority = priority,
		isAdmin = isAdmin,
		isSuperAdmin = isSuperAdmin,
		permissions = permissions
	}

	kingston.admin.createGroup(uniqueID, data)
end
net.Receive("zcGetGroups", zcGetGroups)

local GROUP_ADDPERM 	= 0
local GROUP_TAKEPERM 	= 1
local GROUP_PRIORITY 	= 2
local GROUP_UNIQUEID	= 3
local GROUP_SETADMIN	= 4
local GROUP_SETSA		= 5

local GROUP_ACTION = {
	[GROUP_ADDPERM] = function(group)
		group:givePermission(net.ReadString())
	end,
	[GROUP_TAKEPERM] = function(group)
		group:takePermission(net.ReadString())
	end,
	[GROUP_PRIORITY] = function(group)
		group.priority = net.ReadUInt(8)
	end,
	[GROUP_UNIQUEID] = function(group)
		// deep copy or new object?
	end,
	[GROUP_SETADMIN] = function(group)
		group.isAdmin = net.ReadBool()
	end,
	[GROUP_SETSA] = function(group)
		group.isSuperAdmin = net.ReadBool()
	end
}

local function zcUpdateGroup(len)
	local uniqueID = net.ReadString()
	local group = kingston.admin.groups[uniqueID]

	if !group then return end

	local action = net.ReadUInt(8)
	local actionFunction = GROUP_ACTION[action]
	actionFunction(group)
end
net.Receive("zcUpdateGroup", zcUpdateGroup)

local function zcDeleteGroup(len)
	local uniqueID = net.ReadString()
	local group = kingston.admin.groups[uniqueID]

	if !group then return end

	group:delete()
end
net.Receive("zcDeleteGroup", zcDeleteGroup)

local function zcRequestUsergroups()
	net.Start("zcGetGroups")
	net.SendToServer()
end
hook.Add("InitPostEntity", "STALKER.RequestUsergroups", zcRequestUsergroups)
