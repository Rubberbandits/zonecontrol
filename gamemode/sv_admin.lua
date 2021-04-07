kingston = kingston or {}
kingston.AdminCommands = kingston.AdminCommands or {}
kingston.GamemasterCommands = kingston.GamemasterCommands or {}

function nGetBansList( ply )
	
	if( !ply:IsAdmin() ) then return end
	
	if( !GAMEMODE.BanTable ) then GAMEMODE.BanTable = { } end
	
	netstream.Start( ply, "nBansList", GAMEMODE.BanTable );
	
end
netstream.Hook( "nGetBansList", nGetBansList );

function GM:AdminThink( ply )
	
	if( DEBUG_PAUSEAPPS ) then return end
	
end

function concommand.AddGamemaster( cmd, func, sa, playertarget )
	
	local function c( ply, _, args )
		
		if( !ply:IsEventCoordinator() ) then
			
			ply:Notify( nil, COLOR_ERROR, "You need to be a gamemaster to do this.")
			
			return;
			
		end
		
		func( ply, args );
		
	end
	concommand.Add( cmd, c );

	kingston.GamemasterCommands[cmd] = {}
	
end

function concommand.AddAdmin( cmd, func, sa, playertarget )
	
	local function c( ply, _, args )

		if !ply:IsValid() then
			ply = Entity(0)
		end
		
		if( ply:EntIndex() != 0 and !ply:IsAdmin() ) then
			
			ply:Notify( nil, COLOR_ERROR, "You need to be an admin to do this.")
			
			return;
			
		end
		
		if( ply:EntIndex() != 0 and sa and !ply:IsSuperAdmin() ) then

			ply:Notify( nil, COLOR_ERROR, "You need to be a superadmin to do this.")
			
			return;
			
		end
		
		func( ply, args );
		
	end
	concommand.Add( cmd, c );
	
	kingston.AdminCommands[cmd] = {}

end

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

local function set_rank(ply, _, args)
	if ply:IsValid() then
		return
	end
	
	local targ = GAMEMODE:FindPlayer(args[1])
	local rank = args[2] or "user"
	if targ and targ:IsValid() then
		targ:SetUserGroup(rank)
		targ:UpdatePlayerField("Rank", rank)
		
		MsgC(COLOR_NOTIF, Format("%s's rank has been set to %s.\n", targ:Nick(), rank))
		targ:Notify(nil, COLOR_NOTIF, "Console set your rank to %s.", rank)
	elseif( string.find( args[1], "STEAM_" ) ) then
		GAMEMODE:UpdatePlayerFieldOffline(args[1], "Rank", rank)
	else
		MsgC(COLOR_ERR, "Error: no target found.\n")
	end
end
concommand.Add( "rpa_serversetrank", set_rank );

/*
	Console command running support
*/

hook.Add("InitPostEntity", "RCONCommandSupport", function()
	Entity(0).Notify = function(ent, font, color, text, ...)
		MsgC(color, Format(text, ...).."\n")
	end
	Entity(0).Nick = function(self)
		return "Console"
	end
	Entity(0).SteamID = function(self)
		return "STEAM_0:0:CONSOLE"
	end
end)