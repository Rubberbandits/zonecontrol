kingston = kingston or {}
kingston.admin = kingston.admin or {}

kingston.admin.groups = kingston.admin.groups or {}
kingston.admin.commands = kingston.admin.commands or {}

local ARGTYPE_TARGET 	= 0
local ARGTYPE_STRING 	= 1
local ARGTYPE_BOOL 		= 2
local ARGTYPE_NUMBER 	= 3

local ArgumentProcessor = {
	[ARGTYPE_TARGET] = function(arg)
		return GAMEMODE:FindPlayer(arg) || false
	end,
	[ARGTYPE_STRING] = function(arg)
		return arg
	end,
	[ARGTYPE_BOOL] = function(arg)
		return tobool(arg)
	end,
	[ARGTYPE_NUMBER] = function(arg)
		return tonumber(arg)
	end
}

local ArgToName = {
	[ARGTYPE_TARGET] = "target",
	[ARGTYPE_STRING] = "string",
	[ARGTYPE_BOOL] = "boolean",
	[ARGTYPE_NUMBER] = "number"
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
	return hook.Run("HasPermission", self, cmd, args)
end

function PLAYER:IsSuperAdmin()
	if self:IsUserGroup("superadmin") and !self:HasCharFlag("Q") then return true end

	return false
end

function PLAYER:IsAdmin()
	if self:IsSuperAdmin() then return true end
	if self:IsUserGroup("admin") and !self:HasCharFlag("Q") then return true end

	return false
end

function PLAYER:IsEventCoordinator()
	
	return (self:GetUserGroup() == "gamemaster" or self:HasCharFlag( "G" )) and !self:HasCharFlag("Q")
	
end

// Hooks
function GM:HasPermission(ply, cmd, args)
	local plyGroup = kingston.admin.groups[ply:GetUserGroup()]
	local commandData = kingston.admin.commands[cmd]
	if !commandData then
		return false, Format("Invalid command")
	end

	local canRun, err = commandData.canRun && commandData.canRun(ply, unpack(args)) || true
	if !canRun then
		return false, Format("Player cannot use this command! Reason: %s", err)
	end

	// if has target arguments, check if we can target

	local canRun, err = plyGroup:canRun(ply, cmd, unpack(args))
	if !canRun then
		return false, Format("This group cannot use this command! Reason: %s", err)
	end

	return true
end

function GM:CanTargetPlayer(ply, target)
	local plyGroup = kingston.admin.groups[ply:GetUserGroup()]

	return ply != target and plyGroup:canTarget(target:GetUserGroup()) or true
end

local function GetArgumentTypeNames(expectedArgs)
	local names = {}
	for _,argType in pairs(expectedArgs) do
		table.insert(names, ArgToName[argType])
	end

	return names
end

function GM:CheckArgumentTypes(ply, cmd, args, processed)
	local commandData = kingston.admin.commands[cmd]

	for i,arg in pairs(args) do
		local argType = commandData.arguments[i]
		local result = ArgumentProcessor[argType](arg)

		if argType == ARGTYPE_TARGET then
			if !result then
				return false, "Target not found"
			end
		
			local canTarget = hook.Run("CanTargetPlayer", ply, result)
			
			if !canTarget then
				return false, "Cannot target this player!"
			end
		end

		processed[i] = result;
	end

	if #processed != #commandData.arguments then
		return false, Format("incorrect number of arguments! Expected: %s", table.concat(GetArgumentTypeNames(commandData.arguments), ","))
	end
end

local GROUP_ADDPERM 	= 0
local GROUP_TAKEPERM 	= 1
local GROUP_PRIORITY 	= 2
local GROUP_UNIQUEID	= 3
local GROUP_SETADMIN	= 4
local GROUP_SETSA		= 5

// Group object
// Structure:
// permissions - mapping, defines what commands a group can run
// isAdmin - bool, if this group returns true when calling IsAdmin()
// isSuperAdmin - bool, if this group returns true when calling IsSuperAdmin()
// priority - integer, level of seniority when comparing to other groups
local GROUP = {}

function GROUP:init(uniqueID, data)
	table.Merge(self, data)

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

function GROUP:canRun(cmd, args)
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

	if SERVER then
		kingston.admin.queries.create:clearParameters()
			kingston.admin.queries.create:setString(1, uniqueID)
			kingston.admin.queries.create:setNumber(2, data.priority)
			kingston.admin.queries.create:setNumber(3, data.isAdmin)
			kingston.admin.queries.create:setNumber(4, data.isSuperAdmin)
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
		net.Send(ply)
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

	concommand.Add(Format("rpa_%s", cmd), function(ply, _, args) 
		kingston.admin.runCommand(ply, cmd, args)
	end)

	kingston.command.register(cmd, {
		syntax = data.syntax,
		description = data.description,
		can_run = function() return true end,
		on_run = function(ply, args)
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
		print("argument parse error")
		ply:Notify(nil, COLOR_ERROR, "Argument parsing error: %s", err)
		return
	end

	local canRun, message = hook.Run("HasPermission", ply, cmd, processed)
	if !canRun then

		ply:Notify(nil, COLOR_ERROR, message)
		return
	end

	local success, message = commandData.onRun(ply, unpack(processed))
	if !success then
		ply:Notify(nil, COLOR_ERROR, message)
		return
	end

	hook.Run("PlayerCommandRan", ply, cmd, args)
end

function GM:PlayerNoClip( ply )
	
	if( ply:PassedOut() ) then return false; end
	if( ply:Bottify() ) then return false; end
	
	if( !ply:HasPermission("noclip") ) then
		
		if( CLIENT and IsFirstTimePredicted() ) then
			
			LocalPlayer():Notify(nil, Color( 200, 0, 0, 255 ), "You need to be an admin to do this.")
			
		end
		
		return false;
		
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
			
			if( ply:IsEventCoordinator() ) then
				
				ply.NoclipPos = ply:GetPos();
				
			end
			
		end
		
	end
	
	return true;
	
end

local cmd_files = file.Find( GM.FolderName.."/gamemode/admincmds/*.lua", "LUA", "namedesc" );
if #cmd_files > 0 then
	for _, v in ipairs(cmd_files) do
		include("admincmds/"..v)
	end
end

local cmd_files = file.Find( GM.FolderName.."/gamemode/gmcmds/*.lua", "LUA", "namedesc" );
if #cmd_files > 0 then
	for _, v in ipairs(cmd_files) do
		include("gmcmds/"..v)
	end
end