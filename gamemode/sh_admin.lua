kingston = kingston or {}
kingston.admin = kingston.admin or {}

kingston.admin.groups = kingston.admin.groups or {}
kingston.admin.commands = kingston.admin.commands or {}

ARGTYPE_NONE	= bit.lshift(1, 0)
ARGTYPE_TARGET 	= bit.lshift(1, 1)
ARGTYPE_STRING 	= bit.lshift(1, 2)
ARGTYPE_BOOL 	= bit.lshift(1, 3)
ARGTYPE_NUMBER 	= bit.lshift(1, 4)
ARGTYPE_STEAMID	= bit.lshift(1, 5)
ARGTYPE_ARRAY	= bit.lshift(1, 6)

local ExpectedArguments = {
	[ARGTYPE_NONE] = {
		name = "none",
		process = function() return NULL end
	},
	[ARGTYPE_TARGET] = {
		name = "target",
		process = function(arg, ply, cmd)
			local target = GAMEMODE:FindPlayer(arg)
			if !target then
				return false, "Target not found"
			end
		
			local canTarget = hook.Run("CanTargetPlayer", ply, target, cmd)
			
			if !canTarget then
				return false, "Cannot target this player!"
			end

			return target
		end
	},
	[ARGTYPE_STRING] = {
		name = "string",
		process = function(arg)
			if !arg then
				return false, "invalid string"
			end

			return arg
		end,
	},
	[ARGTYPE_BOOL] = {
		name = "boolean",
		process = function(arg)
			return tobool(arg)
		end,
	},
	[ARGTYPE_NUMBER] = {
		name = "number",
		process = function(arg)
			if !arg then
				return false, "invalid number"
			end

			return tonumber(arg)
		end,
	},
	[ARGTYPE_STEAMID] = {
		name = "steamID",
		process = function(arg)
			local isSteamID = string.find(arg, "STEAM_")
			if !isSteamID then
				return false, "invalid steamID"
			end

			return arg
		end,
	}
}

ExpectedArguments[ARGTYPE_ARRAY] = {
	name = "comma-separated list",
	process = function(arg, ply, cmd, expectedType)
		if !arg or #arg == 0 then
			return false, "invalid list"
		end

		local data = {}
		local array = string.Split(arg, ",")

		local listType = ExpectedArguments[bit.bxor(expectedType, ARGTYPE_ARRAY)]
		for _,entry in pairs(array) do
			table.insert(data, listType.process(entry, ply, cmd, expectedType))
		end

		return data
	end
}

// Player metaobject detours
local PLAYER = FindMetaTable("Player")
function PLAYER:GetUserGroup()
	local groupID = hook.Run("PlayerGetUserGroup", self)
	if groupID then
		return groupID
	end

	return self:GetNWString("UserGroup", "user")
end

function PLAYER:HasPermission(cmd, args)
	local canRun, message = hook.Run("HasPermission", self, cmd, args)
	if !canRun then
		return false, message
	end

	return true
end

function PLAYER:IsSuperAdmin()
	local group = kingston.admin.groups[self:GetUserGroup()]
	if !group then return false end

	return group.isSuperAdmin and !self:HasCharFlag("Q")
end

function PLAYER:IsAdmin()
	if self:IsSuperAdmin() then return true end

	local group = kingston.admin.groups[self:GetUserGroup()]
	if !group then return false end

	return group.isAdmin and !self:HasCharFlag("Q")
end

function PLAYER:IsEventCoordinator()
	
	return self:GetUserGroup() == "gamemaster" and !self:HasCharFlag("Q")
	
end

// Hooks
function GM:HasPermission(ply, cmd, args)
	if ply:GetUserGroup() == "rcon" then return true end

	local plyGroup = kingston.admin.groups[ply:GetUserGroup()]
	if !plyGroup then 
		return false, Format("Player doesn't have any permissions!") 
	end

	local commandData = kingston.admin.commands[cmd]
	if commandData then
		local canRun, err = commandData.canRun && commandData.canRun(ply, unpack(args)) || true
		if !canRun then
			return false, Format("Player cannot use this command! Reason: %s", err)
		end
	end

	// if has target arguments, check if we can target

	local canRun, err = plyGroup:canRun(ply, cmd, args and unpack(args))
	if !canRun then
		return false, Format("This group cannot use this command! Reason: %s", err)
	end

	return true
end

function GM:CanTargetPlayer(ply, target, cmd)
	if ply:GetUserGroup() == "rcon" then return true end

	local plyGroup = kingston.admin.groups[ply:GetUserGroup()]
	if !plyGroup then return false end

	local commandData = kingston.admin.commands[cmd]

	if commandData.ignoreRank then
		return true
	end

	return ply != target and plyGroup:canTarget(target:GetUserGroup()) or true
end

local function GetArgumentTypeNames(expectedArgs)
	local names = {}
	local validArgumentTypes = {}

	for i,expectedTypes in pairs(expectedArgs) do
		table.insert(validArgumentTypes, {})

		for argType,_ in pairs(ExpectedArguments) do
			if bit.band(expectedTypes, argType) != 0 then
				table.insert(validArgumentTypes[i], argType)
			end
		end
	end

	for i,types in pairs(validArgumentTypes) do
		local argNames = {}
		for _,argType in pairs(types) do
			table.insert(argNames, ExpectedArguments[argType].name)
		end

		table.insert(names, table.concat(argNames, " or "))
	end

	return names
end

function GM:CheckArgumentTypes(ply, cmd, args, processed)
	local commandData = kingston.admin.commands[cmd]

	local validArgumentTypes = {};
	for i,expectedTypes in pairs(commandData.arguments) do
		table.insert(validArgumentTypes, {})

		for argType,_ in pairs(ExpectedArguments) do
			if bit.band(expectedTypes, argType) != 0 then
				table.insert(validArgumentTypes[i], argType)
			end
		end
	end

	if #args == 0 && #commandData.arguments > 0 && !table.HasValue(validArgumentTypes[1], ARGTYPE_NONE) then
		return false, Format("no arguments provided. Expected: %s", table.concat(GetArgumentTypeNames(commandData.arguments), ", "))
	end

	for i,types in pairs(validArgumentTypes) do
		local err = "unknown"
		for _,argType in pairs(types) do
			local arg = args[i]
			local result, errString = ExpectedArguments[argType].process(arg, ply, cmd, commandData.arguments[i])

			if errString then
				err = errString
				continue
			end

			// if the final argument is a string, and there are more arguments past that, concat
			if #args > #commandData.arguments and i == #commandData.arguments and argType == ARGTYPE_STRING then
				result = table.concat(args, " ", i)
			end

			processed[i] = result;

			if result != NULL then
				break
			end
		end

		if processed[i] == nil then
			return false, err
		end
	end

	if #processed != #commandData.arguments then
		return false, Format("incorrect number of arguments! Expected: %s", table.concat(GetArgumentTypeNames(commandData.arguments), ", "))
	end
end

function GM:PlayerNoClip( ply )
	if ply:PassedOut() then return false end
	if ply:Bottify() then return false end
	
	local canRun, err = ply:HasPermission("noclip")
	if !canRun then
		if CLIENT and IsFirstTimePredicted() then
			LocalPlayer():Notify(nil, COLOR_ERROR, err)
		end
		
		return false
	end
	
	if( SERVER ) then
		
		if( ply:IsEFlagSet( EFL_NOCLIP_ACTIVE ) ) then
			
			ply:GodDisable();
			ply:SetNoTarget( false );
			ply:SetNoDraw( false );
			ply:SetNotSolid( false );
			
			if( ply:GetActiveWeapon() != NULL ) then
				
				ply:GetActiveWeapon():SetNoDraw( false );
				ply:GetActiveWeapon():SetColor( Color( 255, 255, 255, 255 ) );
				
			end
			
			if( ply.NoclipPos ) then
				
				ply:SetPos( ply.NoclipPos );
				ply.NoclipPos = nil;
				
			end
			
		else
			
			ply:GodEnable();
			ply:SetNoTarget( true );
			ply:SetNoDraw( true );
			ply:SetNotSolid( true );
			
			if( ply:GetActiveWeapon() != NULL ) then
				
				ply:GetActiveWeapon():SetNoDraw( true );
				ply:GetActiveWeapon():SetColor( Color( 255, 255, 255, 0 ) );
				
			end
				
			ply.NoclipPos = ply:GetPos();

		end
		
	end
	
	return true;
	
end

// Group object
// Structure:
// permissions - mapping, defines what commands a group can run
// isAdmin - bool, if this group returns true when calling IsAdmin()
// isSuperAdmin - bool, if this group returns true when calling IsSuperAdmin()
// priority - integer, level of seniority when comparing to other groups
local GROUP = {}

local GROUP_ADDPERM 	= 0
local GROUP_TAKEPERM 	= 1
local GROUP_PRIORITY 	= 2
local GROUP_UNIQUEID	= 3
local GROUP_SETADMIN	= 4
local GROUP_SETSA		= 5

function GROUP:init(uniqueID, data)
	table.Merge(self, data)

	self.isAdmin = tobool(self.isAdmin)
	self.isSuperAdmin = tobool(self.isSuperAdmin)

	self.permissions = isstring(data.permissions) && util.JSONToTable(data.permissions) || data.permissions
	self.uniqueID = uniqueID
end

function GROUP:set(key, value)

end

function GROUP:givePermission(cmd)
	self.permissions[cmd] = true

	if SERVER then
		kingston.admin.queries.addperm:clearParameters()
			kingston.admin.queries.addperm:setString(1, Format("$.%s", cmd))
			kingston.admin.queries.addperm:setString(2, self.uniqueID)
		kingston.admin.queries.addperm:start()

		// network
		net.Start("zcUpdateGroup")
			net.WriteString(self.uniqueID)
			net.WriteUInt(GROUP_ADDPERM, 8)
			net.WriteString(cmd)
		net.Broadcast()
	end
end

function GROUP:takePermission(cmd)
	self.permissions[cmd] = nil
	
	if SERVER then
		kingston.admin.queries.takeperm:clearParameters()
			kingston.admin.queries.takeperm:setString(1, Format("$.%s", cmd))
			kingston.admin.queries.takeperm:setString(2, self.uniqueID)
		kingston.admin.queries.takeperm:start()

		// network
		net.Start("zcUpdateGroup")
			net.WriteString(self.uniqueID)
			net.WriteUInt(GROUP_TAKEPERM, 8)
			net.WriteString(cmd)
		net.Broadcast()
	end
end

function GROUP:canTarget(target)
	local targetGroup = kingston.admin.groups[target]

	return self.priority > targetGroup.priority
end

function GROUP:canRun(ply, cmd, args)
	return self.permissions[cmd], "missing permission."
end 

function GROUP:delete()
	if SERVER then
		kingston.admin.queries.delete:clearParameters()
			kingston.admin.queries.delete:setString(1, self.uniqueID)
		kingston.admin.queries.delete:start()

		// network
		net.Start("zcDeleteGroup")
			net.WriteString(self.uniqueID)
		net.Broadcast()
	end

	kingston.admin.groups[self.uniqueID] = nil
	setmetatable(self, nil)
end

GROUP.__index = GROUP

kingston.meta = kingston.meta or {}
kingston.meta.group = GROUP

// Functions
function kingston.admin.getGroup(uniqueID)
	return kingston.admin.groups[uniqueID]
end

function kingston.admin.createGroup(uniqueID, data)
	local newGroup = {}
	setmetatable(newGroup, kingston.meta.group)

	newGroup:init(uniqueID, data)

	kingston.admin.groups[uniqueID] = newGroup

	if !newGroup.permissions then
		newGroup.permissions = {}
	end

	if SERVER then
		kingston.admin.queries.create:clearParameters()
			kingston.admin.queries.create:setString(1, uniqueID)
			kingston.admin.queries.create:setNumber(2, data.priority)
			kingston.admin.queries.create:setNumber(3, data.isAdmin == true and 1 or 0)
			kingston.admin.queries.create:setNumber(4, data.isSuperAdmin == true and 1 or 0)
			kingston.admin.queries.create:setString(5, data.charFlag)
		kingston.admin.queries.create:start()

		net.Start("zcGetGroups")
			net.WriteString(newGroup.uniqueID)
			net.WriteUInt(newGroup.priority, 8)
			net.WriteBool(newGroup.isAdmin)
			net.WriteBool(newGroup.isSuperAdmin)

			net.WriteUInt(table.Count(newGroup.permissions), 8)
			for cmd, _ in pairs(newGroup.permissions) do
				net.WriteString(cmd)
			end
		net.Broadcast()
	end

	return newGroup
end

function kingston.admin.registerCommand(cmd, data)
	if !cmd then
		Error("[Admin] Invalid command name passed to registerCommand")
		return
	end

	if !data.onRun then
		Error("[Admin] Invalid onRun passed to registerCommand")
		return
	end

	if SERVER then
		concommand.Add(Format("rpa_%s", cmd), function(ply, _, args) 
			if !IsValid(ply) then
				ply = Entity(0)
			end

			kingston.admin.runCommand(ply, cmd, args)
		end)
	end

	kingston.command.register(cmd, {
		syntax = data.syntax,
		description = data.description,
		can_run = function(ply) return ply:HasPermission(cmd) end,
		log = function() end,
		on_run = function(ply, args)
			if !SERVER then return end

			kingston.admin.runCommand(ply, cmd, args)
		end,
	});

	// Command data structure:
	// onRun - shared, returns bool, messageString
	// canRun - shared, returns bool, errorString
	// arguments - shared, array
	// syntax - shared, string, help string printed when no arguments are passed to a command

	kingston.admin.commands[cmd] = data
end

function kingston.admin.runCommand(ply, cmd, args)
	local commandData = kingston.admin.commands[cmd]
	if !commandData then
		Error("[Admin] Tried to call invalid command!")
		return
	end

	if #args == 0 then

	end

	local processed = {}
	local success, err = hook.Run("CheckArgumentTypes", ply, cmd, args, processed)
	if success == false then
		ply:Notify(nil, COLOR_ERROR, "Argument parsing error: %s", err)
		return
	end

	local canRun, message = hook.Run("HasPermission", ply, cmd, processed)
	if !canRun then
		ply:Notify(nil, COLOR_ERROR, message)
		return
	end

	local success, message = commandData.onRun(ply, unpack(processed))
	if success == false then
		ply:Notify(nil, COLOR_ERROR, message)
		return
	end

	hook.Run("PlayerCommandRan", ply, cmd, args)
end

function GM:PlayerCommandRan(ply, cmd, args)
	kingston.log.write("command", "[%s][ran command: %s] %s", ply and ply:Nick() or "rcon", cmd, #args > 0 and table.concat(args, " ") or "no args")
end

// Load all commands
local cmd_files = file.Find( GM.FolderName.."/gamemode/commands/*.lua", "LUA", "namedesc" );
if #cmd_files > 0 then
	for _, v in ipairs(cmd_files) do
		if SERVER then
			AddCSLuaFile("commands/"..v)
		end

		include("commands/"..v)
	end
end