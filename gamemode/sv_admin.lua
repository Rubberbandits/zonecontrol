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
util.AddNetworkString("zcUpdateGroup")
util.AddNetworkString("zcGetGroups")
util.AddNetworkString("zcDeleteGroup")

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
	{ "isSuperAdmin", "BOOL" },
	{ "charFlag", "VARCHAR(1)"}
}

kingston.admin.queries = kingston.admin.queries or {}

local function init_log_admin_tbl(db)
	mysqloo.Query("CREATE TABLE IF NOT EXISTS cc_usergroups (`uniqueID` VARCHAR(128), PRIMARY KEY (`uniqueID`));")
	GAMEMODE:InitSQLTable(kingston.admin.groups_db_struct, "cc_usergroups")
	
	// Load all groups
	kingston.admin.queries.load = db:prepare([[SELECT `uniqueID`, `permissions`, `priority`, `isAdmin`, `isSuperAdmin` FROM `cc_usergroups`;]]);
	// Create group
	kingston.admin.queries.create = db:prepare([[INSERT INTO `cc_usergroups` (`uniqueID`, `permissions`, `priority`, `isAdmin`, `isSuperAdmin`, `charFlag`) VALUES (?, JSON_OBJECT(), ?, ?, ?, ?);]]);
	// Modify group
	kingston.admin.queries.modifyPriority = db:prepare([[UPDATE `cc_usergroups` SET `priority` = ? WHERE `uniqueID` = ?;]]);
	-- kingston.admin.queries.modifyUniqueID = db:prepare();
	kingston.admin.queries.modifyAdmin = db:prepare([[UPDATE `cc_usergroups` SET `isAdmin` = ? WHERE `uniqueID` = ?;]]);
	kingston.admin.queries.modifySuperAdmin = db:prepare([[UPDATE `cc_usergroups` SET `isSuperAdmin` = ? WHERE `uniqueID` = ?;]]);
	// Delete group
	kingston.admin.queries.delete = db:prepare([[DELETE FROM `cc_usergroups` WHERE `uniqueID` = ?;]]);
	// Add permission
	kingston.admin.queries.addperm = db:prepare([[UPDATE `cc_usergroups` SET `permissions` = JSON_SET(`permissions`, ?, true) WHERE `uniqueID` = ?]]);
	// Take permission
	kingston.admin.queries.takeperm = db:prepare([[UPDATE `cc_usergroups` SET `permissions` = JSON_REMOVE(`permissions`, ?) WHERE `uniqueID` = ?]]);

	kingston.admin.load()
end
hook.Add("InitSQLTables", "STALKER.InitAdminDBTable", init_log_admin_tbl)

function concommand.AddAdminVariable( cmd, var, default, friendlyvar, sa )
	
	local function c( ply, _, args )
		
		if( !ply:IsAdmin() ) then
			
			ply:Notify( nil, COLOR_ERROR, "You need to be an admin to do this.")
			return;
			
		end
		
		if( sa and !ply:IsSuperAdmin() ) then

			ply:Notify( nil, COLOR_ERROR, "You need to be a superadmin to do this.")
			return;
			
		end
		
		if( !args[1] ) then
			
			ply:Notify(nil, COLOR_ERROR, "Error: no value specified.")
			return;
			
		end
		
		GAMEMODE["Set" .. var]( GAMEMODE, tonumber( args[1] ) );
		
		GAMEMODE:LogAdmin( "[V] " .. ply:Nick() .. " set variable \"" .. var .. "\" to \"" .. tonumber( args[1] ) .. "\".", ply );
		GAMEMODE:Notify(nil, nil, Color(255,255,255,255), "%s set %s to %s.", ply:Nick(), friendlyvar, tostring(args[1]))
		
	end
	concommand.Add( cmd, c );
	
end

concommand.AddAdminVariable( "rpa_oocdelay", "OOCDelay", 0, "OOC delay" );
concommand.AddAdminVariable( "rpa_flashlights", "Flashlight", 0, "flashlight" );
concommand.AddAdminVariable( "rpa_blowout_enabled", "BlowoutEnabled", 1, "Blowout enabled" );
concommand.AddAdminVariable( "rpa_blowout_auto_schedule", "BlowoutAutoShedule", 1, "Blowout auto-schedule" );
concommand.AddAdminVariable( "rpa_blowout_interval", "BlowoutInterval", 7200, "Blowout interval" );
concommand.AddAdminVariable( "rpa_announcing_duration", "BlowoutAnnounceDuration", 300, "Blowout announce duration" );

local function RCONCommandSupport()
	Entity(0).Notify = function(ent, font, color, text, ...)
		MsgC(color, Format(text, ...).."\n")
	end
	Entity(0).Nick = function(self)
		return "Console"
	end
	Entity(0).SteamID = function(self)
		return "STEAM_0:0:CONSOLE"
	end
	Entity(0).GetUserGroup = function(self)
		return "rcon"
	end
end
hook.Add("InitPostEntity", "RCONCommandSupport", RCONCommandSupport)

local GoodTraceVectors = {
	Vector( 40, 0, 0 ),
	Vector( -40, 0, 0 ),
	Vector( 0, 40, 0 ),
	Vector( 0, -40, 0 ),
	Vector( 0, 0, 40 )
};

function FindGoodTeleportPos( ply )

	local trace = { };
	trace.start = ply:GetShootPos();
	trace.endpos = trace.start + ply:GetAimVector() * 50;
	trace.mins = Vector( -16, -16, 0 );
	trace.maxs = Vector( 16, 16, 72 );
	trace.filter = ply;
	local tr = util.TraceHull( trace );

	if( !tr.Hit ) then

		return tr.HitPos;

	end

	local pos = ply:GetPos();

	for _, v in pairs( GoodTraceVectors ) do

		local trace = { };
		trace.start = ply:GetPos();
		trace.endpos = trace.start + v;
		trace.mins = Vector( -16, -16, 0 );
		trace.maxs = Vector( 16, 16, 72 );
		trace.filter = ply;
		local tr = util.TraceHull( trace );

		if( tr.Fraction == 1.0 ) then

			pos = ply:GetPos() + v;
			break;

		end

	end

	return pos;

end

local function SetEntityDesc( ply, cmd, args, szArgs )
	local targ = ply:GetEyeTraceNoCursor().Entity
	local szDesc = szArgs

	if !ply:IsAdmin() then
		if #szDesc > 512 then return end
		if targ.PropSteamID and targ:PropSteamID() != ply:SteamID() then return end
	end

	if targ and IsValid(targ) and targ:GetClass() == "prop_physics" or targ:GetClass() == "prop_ragdoll" then
		if targ.PropDesc and SERVER then
			targ:SetPropDesc(szDesc)
		end
	end
end
concommand.Add( "rp_propdesc", SetEntityDesc, "Sets a prop's description", FCVAR_USERINFO ); 

netstream.Hook("nGetBansList", function(ply)
	if not ply:IsAdmin() then return end

	netstream.Start(ply, "nBansList", GAMEMODE.BanTable)
end)