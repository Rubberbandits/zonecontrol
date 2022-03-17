kingston = kingston or {}
kingston.admin = kingston.admin or {}

kingston.admin.groups = kingston.admin.groups or {}
kingston.admin.commands = kingston.admin.commands or {}

local ARGTYPE_TARGET 	= 0
local ARGTYPE_STRING 	= 1
local ARGTYPE_BOOL 		= 2
local ARGTYPE_NUMBER 	= 3

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
	return hook.Run("HasPermission", ply, cmd, args)
end

// Hooks
function GM:HasPermission(ply, cmd, args)
	local plyGroup = kingston.admin.groups[ply:GetUserGroup()]
	local commandData = kingston.admin.commands[cmd]

	local canRun, err = commandData.canRun && commandData.canRun(ply, args) || true
	if !canRun then
		return false, Format("Player cannot use this command! Reason: %s", err)
	end

	// if has target arguments, check if we can target

	local canRun, err = plyGroup:canRun(ply, cmd, args)
	if !canRun then
		return false, Format("This group cannot use this command! Reason: %s", err)
	end

	return true
end

function GM:CanTargetPlayer(ply, target)
	local plyGroup = kingston.admin.groups[ply:GetUserGroup()]

	return plyGroup:canTarget(target:GetUserGroup())
end

function GM:CheckArgumentTypes(cmd, args)

end

// Group object
// Structure:
// permissions - mapping, defines what commands a group can run
// isAdmin - bool, if this group returns true when calling IsAdmin()
// isSuperAdmin - bool, if this group returns true when calling IsSuperAdmin()
// priority - integer, level of seniority when comparing to other groups
local GROUP = {}

function GROUP:init(data)
	table.Merge(self, data)
end

function GROUP:set(key, value)

end

function GROUP:givePermission(cmd)
	self.permissions[cmd] = true

	if SERVER then
		//save and broadcast
	end
end

function GROUP:takePermission(cmd)
	self.permissions[cmd] = nil
	
	if SERVER then
		//save and broadcast
	end
end

function GROUP:canTarget(target)
	local targetGroup = kingston.admin.groups[target]

	return self.priority > targetGroup.priority
end

function GROUP:canRun(cmd, args)
	return self.permissions[cmd]
end

function GROUP:delete()
	if SERVER then
		// delete from database
	end

	kingston.admin.groups[self.cmd] = nil
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

	kingston.admin.groups[uniqueID] = data

	if SERVER then
		// save group to db/fs
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

	// Command data structure:
	// onRun - shared
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

	local canRun, message = hook.Run("HasPermission", ply, cmd, args)
	if !canRun then
		ply:Notify(nil, COLOR_ERR, message)
		return
	end

	local expectedArguments = commandData.arguments
	// args processing and type checking

	local err, message = commandData.onRun(ply, args)
	if err then
		ply:Notify(nil, COLOR_ERR, message)
		return
	end

	hook.Run("PlayerCommandRan", ply, cmd, args)
end

function GM:PlayerNoClip( ply )
	
	if( ply:PassedOut() ) then return false; end
	if( ply:Bottify() ) then return false; end
	
	if( !ply:HasPermission("rpa_noclip") ) then
		
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