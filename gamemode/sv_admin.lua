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
	
end

function concommand.AddAdmin( cmd, func, sa, playertarget )
	
	local function c( ply, _, args )
		
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

local function Restart( ply, args )
	
	GAMEMODE:Notify(nil, "CombineControl.ChatHuge", COLOR_ERROR, "%s is restarting the server in five seconds.", ply:Nick())
	
	GAMEMODE:LogAdmin( "[R] " .. ply:Nick() .. " restarted the server.", ply );
	
	timer.Simple( 5, function() game.ConsoleCommand( "changelevel " .. game.GetMap() .. "\n" ); end );
	
end
concommand.AddAdmin( "rpa_restart", Restart );

local function StopSound( ply, args )
	
	netstream.Start( nil, "nAStopSound" );
	
	GAMEMODE:LogAdmin( "[S] " .. ply:Nick() .. " stopped all sounds.", ply );
	
end
concommand.AddAdmin( "rpa_stopsound", StopSound );

local function DisableAI( ply, args )
	
	if( !args[1] ) then
		
		ply:Notify(nil, COLOR_ERROR, "Error: no value specified.")
		return;
		
	end
	
	local n = tonumber( args[1] );
	
	if( n != 0 and n != 1 ) then
		
		ply:Notify(nil, COLOR_ERROR, "Error: invalid value specified.")
		return;
		
	end
	
	RunConsoleCommand( "ai_disabled", args[1] );
	
end
concommand.AddAdmin( "rpa_aidisabled", DisableAI );

local function ChangeLevel( ply, args )
	
	if( !args[1] ) then
		
		ply:Notify(nil, COLOR_ERROR, "Error: no value specified.")
		return;
		
	end
	
	if( table.HasValue( GAMEMODE:GetMaps(), args[1] ) ) then

		GAMEMODE:Notify(nil, "CombineControl.ChatHuge", COLOR_ERROR, "%s is changing the map to %s in five seconds.", ply:Nick(), map)
		
		GAMEMODE:LogAdmin( "[R] " .. ply:Nick() .. " changed the map to " .. args[1] .. ".", ply );
		
		timer.Simple( 5, function() game.ConsoleCommand( "changelevel " .. args[1] .. "\n" ); end );
		
	else

		netstream.Start( ply, "nAInvalidMap", GAMEMODE:GetMaps() );
		
	end
	
end
concommand.AddAdmin( "rpa_changelevel", ChangeLevel );

local function NameWarn( ply, args )
	
	if( #args == 0 ) then
		
		ply:Notify(nil, COLOR_ERROR, "Error: no target specified.")
		return;
		
	end
	
	local targ = GAMEMODE:FindPlayer( args[1], ply );
	
	if( targ and targ:IsValid() ) then
		
		netstream.Start( targ, "nWarnName" );
		
	else
		
		ply:Notify(nil, COLOR_ERROR, "Error: target not found.")
		
	end
	
end
concommand.AddAdmin( "rpa_namewarn", NameWarn );

local function Kill( ply, args )
	
	if( #args == 0 ) then
		
		ply:Notify(nil, COLOR_ERROR, "Error: no target specified.")
		return;
		
	end
	
	local targ = GAMEMODE:FindPlayer( args[1], ply );
	
	if( targ and targ:IsValid() ) then
		
		local nick = targ:RPName();
		
		targ:Kill();
		
		GAMEMODE:LogAdmin( "[D] " .. ply:Nick() .. " killed player " .. nick .. ".", ply );
		targ:Notify(nil, COLOR_NOTIF, "%s killed you.", ply:Nick())
		
	else
		
		ply:Notify(nil, COLOR_ERROR, "Error: target not found.")
		
	end
	
end
concommand.AddAdmin( "rpa_kill", Kill );

local function Explode( ply, args )
	
	if( #args == 0 ) then
		
		ply:Notify(nil, COLOR_ERROR, "Error: no target specified.")
		return;
		
	end
	
	local targ = GAMEMODE:FindPlayer( args[1], ply );
	
	if( targ and targ:IsValid() ) then
		
		local nick = targ:RPName();
		local explo = ents.Create( "env_explosion" );
		explo:SetOwner( ply );
		explo:SetPos( targ:GetPos() );
		explo:SetKeyValue( "iMagnitude", 1000 );
		explo:SetKeyValue( "iRadiusOverride", 32 );
		explo:Spawn();
		explo:Activate();
		explo:Fire( "Explode" );
		
		targ:SetVelocity( Vector( math.random( -200, 200 ), math.random( -200, 200 ), math.random( 300, 600 ) ) );
		
		GAMEMODE:LogAdmin( "[D] " .. ply:Nick() .. " exploded player " .. nick .. ".", ply );

		targ:Notify(nil, COLOR_NOTIF, "%s exploded you.", ply:Nick())
		
	else
		
		ply:Notify(nil, COLOR_ERROR, "Error: target not found.")
		
	end
	
end
concommand.AddAdmin( "rpa_explode", Explode );

local function Slap( ply, args )
	
	if( #args == 0 ) then
		
		ply:Notify(nil, COLOR_ERROR, "Error: no target specified.")
		return;
		
	end
	
	local targ = GAMEMODE:FindPlayer( args[1], ply );
	
	if( targ and targ:IsValid() ) then
		
		local nick = targ:RPName();
		
		targ:SetVelocity( Vector( math.random( -400, 400 ), math.random( -400, 400 ), math.random( 400, 600 ) ) );
		
		GAMEMODE:LogAdmin( "[P] " .. ply:Nick() .. " slapped player " .. nick .. ".", ply );

		targ:Notify(nil, COLOR_NOTIF, "%s slapped you.", ply:Nick())
		
	else
		
		ply:Notify(nil, COLOR_ERROR, "Error: target not found.")
		
	end
	
end
concommand.AddAdmin( "rpa_slap", Slap );

local function KO( ply, args )
	
	if( #args == 0 ) then
		
		ply:Notify(nil, COLOR_ERROR, "Error: no target specified.")
		return;
		
	end
	
	local targ = GAMEMODE:FindPlayer( args[1], ply );
	
	if( targ and targ:IsValid() ) then
		
		local nick = targ:RPName();
		
		targ:SetConsciousness( 0 );
		targ:PassOut();
		
		GAMEMODE:LogAdmin( "[U] " .. ply:Nick() .. " KO'd player " .. nick .. ".", ply );
		
		targ:Notify(nil, COLOR_NOTIF, "%s knocked you out.", ply:Nick())
		
	else
		
		ply:Notify(nil, COLOR_ERROR, "Error: target not found.")
		
	end
	
end
concommand.AddAdmin( "rpa_ko", KO );

local function Wake( ply, args )
	
	if( #args == 0 ) then
		
		ply:Notify(nil, COLOR_ERROR, "Error: no target specified.")
		return;
		
	end
	
	local targ = GAMEMODE:FindPlayer( args[1], ply );
	
	if( targ and targ:IsValid() ) then
		
		local nick = targ:RPName();
		
		targ:SetConsciousness( 100 );
		targ:WakeUp();
		
		GAMEMODE:LogAdmin( "[U] " .. ply:Nick() .. " woke player " .. nick .. ".", ply );
		
		targ:Notify(nil, COLOR_NOTIF, "%s woke you up.", ply:Nick())
		
	else
		
		ply:Notify(nil, COLOR_ERROR, "Error: target not found.")
		
	end
	
end
concommand.AddAdmin( "rpa_wake", Wake );

local function Kick( ply, args )
	
	if( #args == 0 ) then
		
		ply:Notify(nil, COLOR_ERROR, "Error: no target specified.")
		return;
		
	end
	
	local targ = GAMEMODE:FindPlayer( args[1], ply );
	
	local reason = "Kicked by " .. ply:Nick();
	
	if( args[2] ) then
		
		reason = "Kicked by " .. ply:Nick() .. " (" .. args[2] .. ")";
		
	end
	
	if( targ and targ:IsValid() ) then
		
		local nick = targ:RPName() or targ:Nick();
		
		targ:Kick( reason );

		GAMEMODE:LogAdmin( "[K] " .. ply:Nick() .. " kicked player " .. nick .. " (" .. (args[2] or "No reason specified.") .. ").", ply );
		
		GAMEMODE:Notify(nil, nil, COLOR_NOTIF, "%s was kicked by %s. (%s)", nick, ply:Nick(), args[2] or "No reason specified.")
		
	else
		
		ply:Notify(nil, COLOR_ERROR, "Error: target not found.")
		
	end
	
end
concommand.AddAdmin( "rpa_kick", Kick );

local function Ban( ply, args )

	if( !IsValid( ply ) ) then
	
		if( #args == 0 ) then
			
			Msg( "nANoTargetSpecified\n" );
			return;
			
		end
		
		if( #args == 1 ) then
			
			Msg( "nANoDurationSpecified\n" );
			return;
			
		end
		
		if( tonumber( args[2] ) < 0 ) then
			
			Msg( "nANegativeDuration\n" );
			return;
			
		end
	
	else
	
		if( #args == 0 ) then
			
			ply:Notify(nil, COLOR_ERROR, "Error: no target specified.")
			return;
			
		end
		
		if( #args == 1 ) then
			
			ply:Notify(nil, COLOR_ERROR, "Error: no duration specified.")
			return;
			
		end
		
		if( tonumber( args[2] ) < 0 ) then
			
			ply:Notify(nil, COLOR_ERROR, "Error: Invalid duration.")
			return;
			
		end
		
	end
	
	local targ = GAMEMODE:FindPlayer( args[1], ply );
	local reason;
	
	if( !IsValid( ply ) ) then
	
		reason = "Banned for " .. args[2] .. " minutes by console.";
		
		if( args[3] ) then
		
			reason = "Banned for " .. args[2] .. " minutes by console. (" .. args[3] .. ")";
			
			if( args[2] == "0" ) then
				
				reason = "Permabanned by console. (" .. args[3] .. ")";
				
			end
			
		end
		
	else
	
		reason = "Banned for " .. args[2] .. " minutes by " .. ply:Nick();
		
		if( args[3] ) then
			
			reason = "Banned for " .. args[2] .. " minutes by " .. ply:Nick() .. " (" .. args[3] .. ")";
			
			if( args[2] == "0" ) then
				
				reason = "Permabanned by " .. ply:Nick() .. " (" .. args[3] .. ")";
				
			end
			
		end
		
	end
	
	local reasonin = args[3] or "No reason specified.";
	
	if( !IsValid( ply ) ) then
	
		if( targ and targ:IsValid() ) then
			
			local nick = targ:RPName();
			
			if( !targ:IsBot() ) then
				
				if( !GAMEMODE.BanTable ) then GAMEMODE.BanTable = { } end
				
				table.insert( GAMEMODE.BanTable, { SteamID = targ:SteamID(), Length = tonumber( args[2] ), Reason = reasonin, Date = os.date( "!%m/%d/%y %H:%M:%S" ) } );
				GAMEMODE:AddBan( targ:SteamID(), args[2], reasonin, os.date( "!%m/%d/%y %H:%M:%S" ) );
				
			end
			
			targ:Kick( reason );
			
			GAMEMODE:LogConsole( "[B] Console banned player " .. nick .. " for " .. args[2] .. " minutes (" .. reasonin .. ").", true );
			GAMEMODE:Notify(nil, nil, COLOR_NOTIF, "%s was banned by Console for %s minutes. (%s)", nick, args[2], args[3] or "No reason specified.")
			
		elseif( string.find( args[1], "STEAM_" ) ) then
			
			if( !GAMEMODE.BanTable ) then GAMEMODE.BanTable = { } end
			
			table.insert( GAMEMODE.BanTable, { SteamID = args[1], Length = tonumber( args[2] ), Reason = reasonin, Date = os.date( "!%m/%d/%y %H:%M:%S" ) } );
			GAMEMODE:AddBan( args[1], args[2], reasonin, os.date( "!%m/%d/%y %H:%M:%S" ) );
			
			GAMEMODE:LogConsole( "[B] Console banned SteamID " .. args[1] .. " for " .. args[2] .. " minutes (" .. reasonin .. ").", true );
			GAMEMODE:Notify(nil, nil, COLOR_NOTIF, "%s was banned by Console for %s minutes. (%s)", args[1], args[2], args[3] or "No reason specified.")
			
		else
			
			Msg( "No Target Found\n" );
			
		end
		
		return;
	
	end
	
	if( targ and targ:IsValid() ) then
		
		local nick = targ:RPName();
		
		if( !targ:IsBot() ) then
			
			if( !GAMEMODE.BanTable ) then GAMEMODE.BanTable = { } end
			
			table.insert( GAMEMODE.BanTable, { SteamID = targ:SteamID(), Length = tonumber( args[2] ), Reason = reasonin, Date = os.date( "!%m/%d/%y %H:%M:%S" ) } );
			GAMEMODE:AddBan( targ:SteamID(), args[2], reasonin, os.date( "!%m/%d/%y %H:%M:%S" ) );
			
		end
		
		targ:Kick( reason );
		
		GAMEMODE:LogAdmin( "[B] " .. ply:Nick() .. " banned player " .. nick .. " for " .. args[2] .. " minutes (" .. reasonin .. ").", ply );
		
		GAMEMODE:Notify(nil, nil, COLOR_NOTIF, "%s was banned by %s for %s minutes. (%s)", nick, ply:Nick(), args[2], args[3] or "No reason specified.")
		
	elseif( string.find( args[1], "STEAM_" ) ) then
		
		if( !GAMEMODE.BanTable ) then GAMEMODE.BanTable = { } end
		
		table.insert( GAMEMODE.BanTable, { SteamID = args[1], Length = tonumber( args[2] ), Reason = reasonin, Date = os.date( "!%m/%d/%y %H:%M:%S" ) } );
		GAMEMODE:AddBan( args[1], args[2], reasonin, os.date( "!%m/%d/%y %H:%M:%S" ) );
		
		GAMEMODE:LogAdmin( "[B] " .. ply:Nick() .. " banned SteamID " .. args[1] .. " for " .. args[2] .. " minutes (" .. reasonin .. ").", ply );
		
		GAMEMODE:Notify(nil, nil, COLOR_NOTIF, "%s was banned by %s for %s minutes. (%s)", args[1], ply:Nick(), args[2], args[3] or "No reason specified.")
		
	else
		
		ply:Notify(nil, COLOR_ERROR, "Error: target not found.")
		
	end
	
end
concommand.AddAdmin( "rpa_ban", Ban );

local function ChangeBanLength( ply, args )
	
	if( #args == 0 ) then
		
		ply:Notify(nil, COLOR_ERROR, "Error: No SteamID specified.")
		return;
		
	end
	
	if( #args == 1 ) then
		
		ply:Notify(nil, COLOR_ERROR, "Error: No duration specified.")
		return;
		
	end
	
	local len = tonumber( args[2] );
	
	if( !len ) then
		
		ply:Notify(nil, COLOR_ERROR, "Error: invalid value specified.")
		return;
		
	end
	
	if( len < 0 ) then

		ply:Notify(nil, COLOR_ERROR, "Error: Invalid duration.")
		return;
		
	end
	
	if( string.find( args[1], "STEAM_" ) ) then
		
		local k = GAMEMODE:LookupBan( args[1] );
		
		if( !k ) then
			
			ply:Notify(nil, COLOR_ERROR, "Error: No ban found for SteamID given.")
			
		else
			
			local record = GAMEMODE.BanTable[k];
			
			table.remove( GAMEMODE.BanTable, k );
			GAMEMODE:RemoveBan( args[1], "admin change ban length" );
			
			table.insert( GAMEMODE.BanTable, { SteamID = record.SteamID, Length = len, Reason = record.Reason, Date = record.Date } );
			GAMEMODE:AddBan( record.SteamID, len, record.Reason, record.Date );
			
			GAMEMODE:LogAdmin( "[B] " .. ply:Nick() .. " changed SteamID " .. args[1] .. "'s ban length to " .. ".", ply );
			
			netstream.Start( ply, "nBansList", GAMEMODE.BanTable );
			
		end
		
	else

		ply:Notify(nil, COLOR_ERROR, "Error: invalid value specified.")
		
	end
	
end
concommand.AddAdmin( "rpa_changebanlength", ChangeBanLength );

local function Unban( ply, args )
	
	if( #args == 0 ) then
		
		ply:Notify(nil, COLOR_ERROR, "Error: No SteamID specified.")
		return;
		
	end
	
	if( string.find( args[1], "STEAM_" ) ) then
		
		local k = GAMEMODE:LookupBan( args[1] );
		
		if( !k ) then
			
			ply:Notify(nil, COLOR_ERROR, "Error: No ban found for SteamID given.")
			
		else
			
			table.remove( GAMEMODE.BanTable, k );
			GAMEMODE:RemoveBan( args[1], "admin unban" );
			
			GAMEMODE:LogAdmin( "[B] " .. ply:Nick() .. " unbanned SteamID " .. args[1] .. ".", ply );
			
			GAMEMODE:Notify(nil, nil, COLOR_NOTIF, "%s unbanned SteamID %s.", ply:Nick(), args[1])
			
			local tab = { };
			
			for _, v in pairs( player.GetAll() ) do
				
				if( v:IsAdmin() ) then
					
					table.insert( tab, v );
					
				end
				
			end
			
			if( !GAMEMODE.BanTable ) then GAMEMODE.BanTable = { } end
			
			netstream.Start( ply, "nBansList", GAMEMODE.BanTable );
			
		end
		
	else
		
		ply:Notify(nil, COLOR_ERROR, "Error: Invalid SteamID specified.")
		
	end
	
end
concommand.AddAdmin( "rpa_unban", Unban );

local GoodTraceVectors = {
	Vector( 40, 0, 0 ),
	Vector( -40, 0, 0 ),
	Vector( 0, 40, 0 ),
	Vector( 0, -40, 0 ),
	Vector( 0, 0, 40 )
};

local function FindGoodTeleportPos( ply )
	
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

local function GiveMoney( ply, args )
	
	if( #args == 0 ) then
		
		ply:Notify(nil, COLOR_ERROR, "Error: no target specified.")
		return;
		
	end
	
	local targ = GAMEMODE:FindPlayer( args[1], ply );
	local amt = 0;
	
	if( args[2] ) then
		
		amt = tonumber( args[2] );
		
	end
	
	if( targ and targ:IsValid() ) then
		
		targ:AddMoney( amt );
		targ:UpdateCharacterField( "Money", tostring( targ:Money() ) );
		targ:Notify(nil, COLOR_NOTIF, "%s gave you %d rubles.", ply:Nick(), amt)
		
		GAMEMODE:LogAdmin( "[M] " .. ply:Nick() .. " gave " .. targ:RPName() .. " " .. tostring( amt ) .. " rubles.", ply );
		
	else
		
		ply:Notify(nil, COLOR_ERROR, "Error: target not found.")
		
	end
	
end
concommand.AddAdmin( "rpa_givemoney", GiveMoney );

local function Goto( ply, args )
	
	if( #args == 0 ) then
		
		ply:Notify(nil, COLOR_ERROR, "Error: no target specified.")
		return;
		
	end
	
	local targ = GAMEMODE:FindPlayer( args[1], ply );
	
	if( targ and targ:IsValid() ) then
		
		local p = FindGoodTeleportPos( targ );
		ply:SetPos( p );
		
	else
		
		ply:Notify(nil, COLOR_ERROR, "Error: target not found.")
		
	end
	
end
concommand.AddAdmin( "rpa_goto", Goto );
concommand.AddGamemaster( "rpg_goto", Goto );

local function Bring( ply, args )
	
	if( #args == 0 ) then
		
		ply:Notify(nil, COLOR_ERROR, "Error: no target specified.")
		return;
		
	end
	
	local targ = GAMEMODE:FindPlayer( args[1], ply );
	
	if( targ and targ:IsValid() ) then
		
		local p = FindGoodTeleportPos( ply );
		targ:SetPos( p );
		
	else
		
		ply:Notify(nil, COLOR_ERROR, "Error: target not found.")
		
	end
	
end
concommand.AddAdmin( "rpa_bring", Bring );
concommand.AddGamemaster( "rpg_bring", Bring );

local function Send( ply, args )

	if( #args == 0 ) then
	
		ply:Notify(nil, COLOR_ERROR, "Error: no target specified.")
		return;
		
	end
	
	if( #args == 1 ) then
	
		ply:Notify(nil, COLOR_ERROR, "Error: no value specified.")
		return;
		
	end
	
	local targ = GAMEMODE:FindPlayer( args[1], ply );
	local destination = GAMEMODE:FindPlayer( args[2], ply );
	
	if( targ and targ:IsValid() ) then
	
		if( destination and destination:IsValid() ) then
		
			local p = FindGoodTeleportPos( destination );
			targ:SetPos( p );
		
		else
		
			ply:Notify(nil, COLOR_ERROR, "Error: second target not found.")
		
		end
	
	else
	
		ply:Notify(nil, COLOR_ERROR, "Error: target not found.")
	
	end

end
concommand.AddAdmin( "rpa_send", Send )
concommand.AddGamemaster( "rpg_send", Send );

local function Seeall( ply, args )
	
	netstream.Start( ply, "nASeeAll" );
	ply.UsingSeeAll = !ply.UsingSeeAll
	
end
concommand.AddAdmin( "rpa_seeall", Seeall );
concommand.AddGamemaster( "rpg_seeall", Seeall );

local function UsingSeeAll( ply, args )
	local tbl = {}
	for k,v in next, player.GetAll() do
		if v.UsingSeeAll then
			tbl[k] = v
		end
	end
	
	netstream.Start(ply, "nPrintUsingSeeAll", tbl)
end
concommand.AddAdmin( "rpa_usingseeall", UsingSeeAll );

local function SeeAllProps( ply, args )
	
	netstream.Start( ply, "nASeeAllProps" );
	
end
concommand.AddAdmin( "rpa_seeallprops", SeeAllProps );
concommand.AddGamemaster( "rpg_seeallprops", SeeAllProps );

GM.WhitelistModels = {
	"models/player/combine_soldier.mdl",
	"models/player/combine_super_soldier.mdl"
};

local function SetCharModel( ply, args )
	
	if( #args == 0 ) then
		
		ply:Notify(nil, COLOR_ERROR, "Error: no target specified.")
		return;
		
	end
	
	local targ = GAMEMODE:FindPlayer( args[1], ply );
	local model = args[2] or GAMEMODE.CitizenModels[1];
	
	model = string.gsub( string.lower( model ), "\\", "/" );
	
	if( GAMEMODE.TranslateNPCModelTable[model] ) then
		
		model = GAMEMODE.TranslateNPCModelTable[model];
		
	end
	
	if( targ and targ:IsValid() ) then
		
		if( targ.CharModel == targ:GetModel() ) then
			
			targ:SetModelCC( model );
			
		end
		
		if( !table.HasValue( GAMEMODE.CitizenModels, model ) ) then
			
			targ:SetBody("")
			
		end
		
		targ.CharModel = model;
		targ:UpdateCharacterField( "Model", model );
		
		GAMEMODE:LogAdmin( "[M] " .. ply:Nick() .. " changed player " .. targ:RPName() .. "'s model to \"" .. model .. "\".", ply );
		
		local rf = { ply, targ };
		GAMEMODE:Notify(rf, nil, COLOR_NOTIF, "%s set %s's model to %s.", ply:Nick(), targ:Nick(), model)
		
	else
		
		ply:Notify(nil, COLOR_ERROR, "Error: target not found.")
		
	end
	
end
concommand.AddAdmin( "rpa_setcharmodel", SetCharModel );

local function SetModelSelf( ply, args )
	
	if( #args == 0 ) then
		
		ply:Notify(nil, COLOR_ERROR, "Error: no model specified.")
		return;
		
	end
	local model = args[1] or GAMEMODE.CitizenModels[1];
	
	model = string.gsub( string.lower( model ), "\\", "/" );
	
	if( GAMEMODE.TranslateNPCModelTable[model] ) then
		
		model = GAMEMODE.TranslateNPCModelTable[model];
		
	end
	
	if( ply and ply:IsValid() ) then
		
		if( ply.CharModel == ply:GetModel() ) then
			
			ply:SetModelCC( model );
			
		end
		
		if( !table.HasValue( GAMEMODE.CitizenModels, model ) ) then
			
			ply:SetBody("")
			
		end
		
		ply.CharModel = model;
		ply:UpdateCharacterField( "Model", model );
		
		GAMEMODE:LogAdmin( "[GM] " .. ply:Nick() .. " changed their model to \"" .. model .. "\".", ply );
		
		ply:Notify(nil, COLOR_NOTIF, "You've set your own model to %s.", model)
		
	end
	
end
concommand.AddGamemaster( "rpg_setmodelself", SetModelSelf );

local function SetName( ply, args )
	
	if( #args == 0 ) then
		
		ply:Notify(nil, COLOR_ERROR, "Error: no target specified.")
		return;
		
	end
	
	if( #args == 1 ) then
		
		ply:Notify(nil, COLOR_ERROR, "Error: no value specified.")
		return;
		
	end
	
	local targ = GAMEMODE:FindPlayer( args[1], ply );
	local name = "";
	
	for i = 2, #args do
		
		name = name .. args[i] .. " ";
		
	end
	
	name = string.Trim( name );
	
	if( targ and targ:IsValid() ) then
		
		if( string.len( string.Trim( name ) ) <= GAMEMODE.MaxNameLength and string.len( string.Trim( name ) ) >= GAMEMODE.MinNameLength ) then
			
			if( !string.find( name, "#", nil, true ) and !string.find( name, "~", nil, true ) and !string.find( name, "%", nil, true ) ) then
				
				local old = targ:RPName();
				
				targ:SetRPName( string.Trim( name ) );
				targ:UpdateCharacterField( "RPName", name );
				
				GAMEMODE:LogAdmin( "[N] " .. ply:Nick() .. " changed player " .. old .. "'s name to \"" .. name .. "\".", ply );
				
				local rf = { ply, targ };

				GAMEMODE:Notify(rf, nil, COLOR_NOTIF, "%s changed %s's roleplay name from %s to %s", ply:Nick(), targ:Nick(), old, name)
				
			end
			
		end
		
	else
		
		ply:Notify(nil, COLOR_ERROR, "Error: target not found.")
		
	end
	
end
concommand.AddAdmin( "rpa_setname", SetName );

local function SetTied( ply, args )
	
	if( #args == 0 ) then
		
		ply:Notify(nil, COLOR_ERROR, "Error: no target specified.")
		return;
		
	end
	
	if( #args == 1 ) then
		
		ply:Notify(nil, COLOR_ERROR, "Error: no value specified.")
		return;
		
	end
	
	local targ = GAMEMODE:FindPlayer( args[1], ply );
	local val = tonumber( args[2] );
	
	if( !val or ( val != 0 and val != 1 ) ) then
		
		ply:Notify(nil, COLOR_ERROR, "Error: invalid value specified.")
		
	end
	
	if( targ and targ:IsValid() ) then
		
		targ:SetTiedUp( val == 1 );
		GAMEMODE:LogAdmin( "[F] " .. ply:Nick() .. " tied player " .. targ:RPName() .. ".", ply );
		
	else
		
		ply:Notify(nil, COLOR_ERROR, "Error: target not found.")
		
	end
	
end
concommand.AddAdmin( "rpa_settied", SetTied );

local function AddBadge( ply, args )
	
	if( #args == 0 ) then
		
		ply:Notify(nil, COLOR_ERROR, "Error: no target specified.")
		return;
		
	end
	
	if( #args == 1 ) then
		
		ply:Notify(nil, COLOR_ERROR, "Error: no value specified.")
		return;
		
	end
	
	local targ = GAMEMODE:FindPlayer( args[1], ply );
	local val = tonumber( args[2] );
	
	if( !val or targ:HasBadge( val ) ) then
		
		ply:Notify(nil, COLOR_ERROR, "Error: invalid value specified.")
		
	end
	
	if( targ and targ:IsValid() ) then
		
		targ:SetScoreboardBadges( targ:ScoreboardBadges() + val );
		targ:UpdatePlayerField( "ScoreboardBadges", targ:ScoreboardBadges() );
		
	else
		
		ply:Notify(nil, COLOR_ERROR, "Error: target not found.")
		
	end
	
end
concommand.AddAdmin( "rpa_addbadge", AddBadge, true );

local function RemoveBadge( ply, args )
	
	if( #args == 0 ) then
		
		ply:Notify(nil, COLOR_ERROR, "Error: no target specified.")
		return;
		
	end
	
	if( #args == 1 ) then
		
		ply:Notify(nil, COLOR_ERROR, "Error: no value specified.")
		return;
		
	end
	
	local targ = GAMEMODE:FindPlayer( args[1], ply );
	local val = tonumber( args[2] );
	
	if( !val or !targ:HasBadge( val ) ) then
		
		ply:Notify(nil, COLOR_ERROR, "Error: invalid value specified.")
		
	end
	
	if( targ and targ:IsValid() ) then
		
		targ:SetScoreboardBadges( targ:ScoreboardBadges() - val );
		targ:UpdatePlayerField( "ScoreboardBadges", targ:ScoreboardBadges() );
		
	else
		
		ply:Notify(nil, COLOR_ERROR, "Error: target not found.")
		
	end
	
end
concommand.AddAdmin( "rpa_removebadge", RemoveBadge, true );

local function SetCharFlag( ply, args )
	
	if( #args == 0 ) then
		
		ply:Notify(nil, COLOR_ERROR, "Error: no target specified.")
		return;
		
	end
	
	local targ = GAMEMODE:FindPlayer( args[1], ply );
	local flags = args[2] or "";
	
	if( targ and targ:IsValid() ) then
		
		local old_flags = targ:CharFlags()
		targ:SetCharFlags( flags );
		
		for i=1, #flags do
			local flag = flags[i]
			if !old_flags:find(flag) then
				local new_flag = GAMEMODE.CharFlags[flag]
				if new_flag and new_flag.OnGiven then
					new_flag.OnGiven( targ );
				end
			end
		end
		
		GAMEMODE:LogAdmin( "[F] " .. ply:Nick() .. " changed player " .. targ:RPName() .. "'s character flag to \"" .. flags .. "\".", ply );
		
		local rf = { ply, targ };
		
		if( flags == "" ) then
			
			GAMEMODE:Notify(rf, nil, COLOR_NOTIF, "%s removed all of %s's flags.", ply:Nick(), targ:Nick())
			
		else
			
			GAMEMODE:Notify(rf, nil, COLOR_NOTIF, "%s set %s's flags to \"%s\"", ply:Nick(), targ:Nick(), flags)
			
		end
		
		targ:UpdateCharacterField( "CharFlags", flags );
		
	else
		
		ply:Notify(nil, COLOR_ERROR, "Error: target not found.")
		
	end
	
end
concommand.AddAdmin( "rpa_setcharflag", SetCharFlag );

local function FlagsRoster( ply, args )
	
	local function qS( ret )
		
		netstream.Start( ply, "nAFlagsRoster", ret );
		
		GAMEMODE:LogSQL( "Player " .. ply:Nick() .. " retrieved flags roster." );
		
	end
	
	local function qF( err )
		
	end
	
	mysqloo.Query( "SELECT RPName, CharFlags FROM cc_chars WHERE CharFlags != ''", qS, qF );
	
end
concommand.AddAdmin( "rpa_flagsroster", FlagsRoster );

local function SetToolTrust( ply, args )
	
	if( #args == 0 ) then
		
		ply:Notify(nil, COLOR_ERROR, "Error: no target specified.")
		return;
		
	end
	
	local targ = GAMEMODE:FindPlayer( args[1], ply );
	local trust = tonumber( args[2] ) or 0;
	
	if( trust != 0 and trust != 1 and trust != 2 ) then
		
		ply:Notify(nil, COLOR_ERROR, "Error: invalid value specified.")
		return;
		
	end
	
	if( targ and targ:IsValid() ) then
		
		targ:SetToolTrust( trust );
		
		GAMEMODE:LogAdmin( "[S] " .. ply:Nick() .. " changed player " .. targ:RPName() .. "'s tooltrust to \"" .. tostring( trust ) .. "\".", ply );
		
		local rf = { ply, targ };
		
		if( trust == 0 ) then

			GAMEMODE:Notify(rf, nil, COLOR_NOTIF, "%s removed %s's tooltrust.", ply:Nick(), targ:Nick())
			
		else

			GAMEMODE:Notify(rf, nil, COLOR_NOTIF, "%s set %s's tooltrust to level %d.", ply:Nick(), targ:Nick(), trust)
			
		end
		
		targ:UpdatePlayerField( "ToolTrust", trust );
		
		if( targ:ToolTrust() == 0 ) then
			
			targ:StripWeapon( "gmod_tool" );
			
		else
			
			targ:Give( "gmod_tool" );
			
		end
		
	else
		
		ply:Notify(nil, COLOR_ERROR, "Error: target not found.")
		
	end
	
end
concommand.AddAdmin( "rpa_settooltrust", SetToolTrust );

local function SetPhysTrust( ply, args )
	
	if( #args == 0 ) then
		
		ply:Notify(nil, COLOR_ERROR, "Error: no target specified.")
		return;
		
	end
	
	local targ = GAMEMODE:FindPlayer( args[1], ply );
	local trust = tonumber( args[2] ) or 1;
	
	if( trust != 0 and trust != 1 ) then
		
		ply:Notify(nil, COLOR_ERROR, "Error: invalid value specified.")
		return;
		
	end
	
	if( targ and targ:IsValid() ) then
		
		if( targ:IsAdmin() ) then
			
			ply:Notify(nil, COLOR_ERROR, "Error: this target is an admin.")
			return;
			
		end
		
		targ:SetPhysTrust( trust );
		
		GAMEMODE:LogAdmin( "[S] " .. ply:Nick() .. " changed player " .. targ:RPName() .. "'s phystrust to \"" .. tostring( trust ) .. "\".", ply );
		
		local rf = { ply, targ };
		
		if( trust == 0 ) then
			
			GAMEMODE:Notify(rf, nil, COLOR_NOTIF, "%s has removed %s's phystrust.", ply:Nick(), targ:Nick())
			
		else
			
			GAMEMODE:Notify(rf, nil, COLOR_NOTIF, "%s has given %s phystrust.", ply:Nick(), targ:Nick())
			
		end
		
		targ:UpdatePlayerField( "PhysTrust", trust );
		
		if( targ:PhysTrust() == 0 ) then
			
			targ:StripWeapon( "weapon_physgun" );
			
		else
			
			targ:Give( "weapon_physgun" );
			
		end
		
	else
		
		ply:Notify(nil, COLOR_ERROR, "Error: target not found.")
		
	end
	
end
concommand.AddAdmin( "rpa_setphystrust", SetPhysTrust );

local function SetPropTrust( ply, args )
	
	if( #args == 0 ) then
		
		ply:Notify(nil, COLOR_ERROR, "Error: no target specified.")
		return;
		
	end
	
	local targ = GAMEMODE:FindPlayer( args[1], ply );
	local trust = tonumber( args[2] ) or 1;
	
	if( trust != 0 and trust != 1 ) then
		
		ply:Notify(nil, COLOR_ERROR, "Error: invalid value specified.")
		return;
		
	end
	
	if( targ and targ:IsValid() ) then
		
		if( targ:IsAdmin() ) then
			
			ply:Notify(nil, COLOR_ERROR, "Error: this target is an admin.")
			return;
			
		end
		
		targ:SetPropTrust( trust );
		
		GAMEMODE:LogAdmin( "[S] " .. ply:Nick() .. " changed player " .. targ:RPName() .. "'s proptrust to \"" .. tostring( trust ) .. "\".", ply );
		
		local rf = { ply, targ };
		
		if( trust == 0 ) then
			
			GAMEMODE:Notify(rf, nil, COLOR_NOTIF, "%s has removed %s's proptrust.", ply:Nick(), targ:Nick())
			
		else
		
			GAMEMODE:Notify(rf, nil, COLOR_NOTIF, "%s has given %s proptrust.", ply:Nick(), targ:Nick())
			
		end
		
		targ:UpdatePlayerField( "PropTrust", trust );
		
	else
		
		ply:Notify(nil, COLOR_ERROR, "Error: target not found.")
		
	end
	
end
concommand.AddAdmin( "rpa_setproptrust", SetPropTrust );

local function EditInventory( ply, args )
	
	if( #args == 0 ) then
		
		ply:Notify(nil, COLOR_ERROR, "Error: no target specified.")
		return;
		
	end
	
	local targ = GAMEMODE:FindPlayer( args[1], ply );
	
	if( targ and targ:IsValid() ) then
		
		GAMEMODE:LogAdmin( "[I] " .. ply:Nick() .. " opened character " .. targ:RPName() .. "'s inventory.", ply );
		
		local inv = {}
		for k,v in next, targ.Inventory do
			inv[k] = {
				ItemClass = v:GetClass(),
				Vars = v:GetVars()
			}
		end
		netstream.Start( ply, "nAEditInventory", targ, inv );
		
	else
		
		ply:Notify(nil, COLOR_ERROR, "Error: target not found.")
		
	end
	
end
concommand.AddAdmin( "rpa_editinventory", EditInventory );

function nARemoveItem( ply, targ, k )
	
	if( !ply:IsAdmin() ) then
		
		return;
		
	end
	
	local item = targ.Inventory[k]
	
	if item then
		GAMEMODE:LogAdmin( "[I] " .. ply:Nick() .. " took character " .. targ:RPName() .. "'s item \"" .. targ.Inventory[k]:GetName() .. "\".", ply );
		GAMEMODE:LogItems( "[R] " .. targ:VisibleRPName() .. "'s item " .. targ.Inventory[k]:GetName() .. " was taken by " .. ply:Nick() .. ".", ply );
		
		targ:Notify(nil, COLOR_NOTIF, "%s has taken your %s (%s)!", ply:Nick(), item:GetName(), item:GetClass())
		
		if item:GetVar("Equipped", false) then
			item:CallFunction("Unequip", true)
		end
		
		netstream.Start(targ, "RemoveItem", k)
		
		item.owner = ply;
		item:SetCharID( ply:CharID() )
		item:UpdateSave();
		item:TransmitToOwner();
		targ.Inventory[k] = nil
		ply.Inventory[k] = item
		
		hook.Run("ItemDropped", targ, item)
		hook.Run("ItemPickedUp", ply, item)
		
		local inv = {}
		for k,v in next, targ.Inventory do
			inv[k] = {
				ItemClass = v:GetClass(),
				Vars = v:GetVars(),
			}
		end
		netstream.Start( ply, "nAUpdateInventory", targ, inv );
	end
	
end
netstream.Hook( "nARemoveItem", nARemoveItem );

local function PlayMusic( ply, args )
	
	if( #args == 0 ) then
		
		ply:Notify(nil, COLOR_ERROR, "Error: invalid value specified.")
		return;
		
	end
	
	local arg = string.lower( args[1] );
	local song = nil;
	
	if( arg == "idle" or arg == "song_idle" or tonumber( arg ) == 0 ) then
		
		song = SONG_IDLE;
		arg = "idle";
		
	elseif( arg == "alert" or arg == "song_alert" or tonumber( arg ) == 1 ) then
		
		song = SONG_ALERT;
		arg = "alert";
		
	elseif( arg == "action" or arg == "song_action" or tonumber( arg ) == 2 ) then
		
		song = SONG_ACTION;
		arg = "action";
		
	elseif( arg == "stinger" or arg == "song_stinger" or tonumber( arg ) == 3 ) then
		
		song = SONG_STINGER;
		arg = "stinger";
		
	else
		
		song = arg;
		
	end
	
	if( song ) then
		
		local ssong = song;
		
		if( type( song ) == "number" ) then
			
			ssong = table.Random( GAMEMODE:GetSongList( song ) );
			GAMEMODE:LogAdmin( "[M] " .. ply:Nick() .. " played " .. arg .. " music (" .. ssong .. ").", ply );
			
		else
			
			GAMEMODE:LogAdmin( "[M] " .. ply:Nick() .. " played music (" .. ssong .. ").", ply );
			
		end
		
		netstream.Start( nil, "nAPlayMusic", ssong );
		
	else
		
		ply:Notify(nil, COLOR_ERROR, "Error: invalid value specified.")
		
	end
	
end
concommand.AddAdmin( "rpa_playmusic", PlayMusic );

local function PlayMusicTarget( ply, args )
	
	if( #args < 2 ) then
		
		ply:Notify(nil, COLOR_ERROR, "Error: invalid value specified.")
		return;
		
	end
	
	local arg = string.lower( args[1] );
	local song = nil;
	
	if( arg == "idle" or arg == "song_idle" or tonumber( arg ) == 0 ) then
		
		song = SONG_IDLE;
		arg = "idle";
		
	elseif( arg == "alert" or arg == "song_alert" or tonumber( arg ) == 1 ) then
		
		song = SONG_ALERT;
		arg = "alert";
		
	elseif( arg == "action" or arg == "song_action" or tonumber( arg ) == 2 ) then
		
		song = SONG_ACTION;
		arg = "action";
		
	elseif( arg == "stinger" or arg == "song_stinger" or tonumber( arg ) == 3 ) then
		
		song = SONG_STINGER;
		arg = "stinger";
		
	else
		
		song = arg;
		
	end
	
	if( song ) then
		
		local ssong = song;
		
		if( type( song ) == "number" ) then
			
			ssong = table.Random( GAMEMODE:GetSongList( song ) );
			GAMEMODE:LogAdmin( "[M] " .. ply:Nick() .. " played " .. arg .. " targeted music (" .. ssong .. ").", ply );
			
		else
			
			GAMEMODE:LogAdmin( "[M] " .. ply:Nick() .. " played targeted music (" .. ssong .. ").", ply );
			
		end
		
		local plys = { };
		
		for i = 2, #args do
			
			local targ = GAMEMODE:FindPlayer( args[i], ply );
			
			if( targ and targ:IsValid() ) then
				
				table.insert( plys, targ );
				
			else

				ply:Notify(nil, COLOR_ERROR, "Error: No target found (\"&s\"). Skipping.", args[i])
				
			end
			
		end

		netstream.Start( plys, "nAPlayMusic", ssong );
		
	else
		
		ply:Notify(nil, COLOR_ERROR, "Error: invalid value specified.")
		
	end
	
end
concommand.AddAdmin( "rpa_playmusictarget", PlayMusicTarget );

local function StopMusic( ply, args )
	
	GAMEMODE:LogAdmin( "[M] " .. ply:Nick() .. " stopped any playing music.", ply );
	netstream.Start( nil, "nAStopMusic" );
	
end
concommand.AddAdmin( "rpa_stopmusic", StopMusic );

local function CreateItem( ply, args )
	
	local item = args[1] or "";
	
	if( item == "" ) then

		netstream.Start( ply, "nAListItems", "" );
		return;
		
	end
	
	if( GAMEMODE:GetItemByID( item ) ) then
		
		GAMEMODE:CreateItem( ply, item );
		
		GAMEMODE:LogAdmin( "[I] " .. ply:Nick() .. " spawned item \"" .. item .. "\" (" .. GAMEMODE:GetItemByID( item ).Name .. ").", ply );
		
	else

		netstream.Start( ply, "nAListItems", item );
		
	end
	
end
concommand.AddAdmin( "rpa_createitem", CreateItem );

local function CreateArtifact( ply, args )
	
	local item = args[1] or "";
	
	if( item == "" ) then
		
		netstream.Start( ply, "nAListArtifacts", "" );
		return;
		
	end
	
	if( GAMEMODE:GetItemByID( item ) ) then
	
		if( !GAMEMODE:GetItemByID( item ).Artifact ) then return end
		
		GAMEMODE:CreateArtifact( ply, item );
		
		GAMEMODE:LogAdmin( "[I] " .. ply:Nick() .. " spawned item \"" .. item .. "\" (" .. GAMEMODE:GetItemByID( item ).Name .. ").", ply );
		
	else
		
		netstream.Start( ply, "nAListArtifacts", item );
		
	end
	
end
concommand.AddAdmin( "rpa_createartifact", CreateArtifact );

local function CreateExplosion( ply, args )
	
	local trace = { };
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 32768;
	trace.filter = ply;
	local tr = util.TraceLine( trace );
	
	local explo = ents.Create( "env_explosion" );
	explo:SetOwner( ply );
	explo:SetPos( tr.HitPos );
	explo:SetKeyValue( "iMagnitude", 1 );
	explo:SetKeyValue( "iRadiusOverride", 1 );
	explo:Spawn();
	explo:Activate();
	explo:Fire( "Explode" );
	
end
concommand.AddAdmin( "rpa_createexplosion", CreateExplosion );

local function CreateFire( ply, args )
	
	local num = tonumber( args[1] );
	
	if( !num ) then
		
		ply:Notify(nil, COLOR_ERROR, "Error: no value specified.")
		return;
		
	end
	
	if( num < 1 ) then
		
		ply:Notify(nil, COLOR_ERROR, "Error: invalid value specified.")
		return;
		
	end
	
	if( num > 60 * 60 * 24 ) then
		
		ply:Notify(nil, COLOR_ERROR, "Error: invalid value specified.")
		return;
		
	end
	
	local trace = { };
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 32768;
	trace.filter = ply;
	local tr = util.TraceLine( trace );
	
	local fire = ents.Create( "env_fire" );
	fire:SetPos( tr.HitPos );
	fire:SetKeyValue( "spawnflags", "1" );
	fire:SetKeyValue( "attack", "4" );
	fire:SetKeyValue( "firesize", "128" );
	fire:Spawn();
	fire:Activate();
	fire:Fire( "Enable", "" );
	fire:Fire( "StartFire", "" );
	
	SafeRemoveEntityDelayed( fire, num );
	
end
concommand.AddAdmin( "rpa_createfire", CreateFire );

local function ToggleSaved( ply, args )
	
	local trace = { };
	trace.start = ply:GetShootPos();
	trace.endpos = trace.start + ply:GetAimVector() * 32768;
	trace.filter = ply;
	local tr = util.TraceLine( trace );
	
	if( tr.Entity and tr.Entity:IsValid() and tr.Entity:GetClass() == "prop_physics" ) then
		
		tr.Entity:SetPropSaved( !tr.Entity:PropSaved() );
		
		if( tr.Entity:GetPhysicsObject() and tr.Entity:GetPhysicsObject():IsValid() ) then
			
			tr.Entity:GetPhysicsObject():EnableMotion( false );
			
		end
		
		GAMEMODE:SaveSavedProps();
		
	end
	
end
concommand.AddAdmin( "rpa_togglesaved", ToggleSaved );
concommand.AddGamemaster( "rpg_togglesaved", ToggleSaved );

local function UnownDoor( ply, args )
	
	local trace = { };
	trace.start = ply:GetShootPos();
	trace.endpos = trace.start + ply:GetAimVector() * 32768;
	trace.filter = ply;
	local tr = util.TraceLine( trace );
	
	if( tr.Entity and tr.Entity:IsValid() and tr.Entity:IsDoor() ) then
		
		tr.Entity:ResetDoor();
		
	end
	
end
concommand.AddAdmin( "rpa_unowndoor", UnownDoor );

local function HideAdmin( ply, args )
	
	if( args[1] and tonumber( args[1] ) and ( tonumber( args[1] ) == 0 or tonumber( args[1] ) == 1 ) ) then
		
		ply:SetHideAdmin( tonumber( args[1] ) == 1 );
		
	else
		
		ply:SetHideAdmin( !ply:HideAdmin() );
		
	end
	
end
concommand.AddAdmin( "rpa_hideadmin", HideAdmin );

local function Hidden( ply, args )
	
	if( args[1] and tonumber( args[1] ) and ( tonumber( args[1] ) == 0 or tonumber( args[1] ) == 1 ) ) then
		
		ply:SetHidden( tonumber( args[1] ) == 1 );
		
	else
		
		ply:SetHidden( !ply:Hidden() );
		
	end
	
end
concommand.AddAdmin( "rpa_hidden", Hidden );
concommand.AddGamemaster( "rpg_hidden", Hidden );
local function SetLicenses( ply, args )

	if( #args == 0 ) then
		
		ply:Notify(nil, COLOR_ERROR, "Error: no target specified.")
		return;
		
	end
	
	local targ = GAMEMODE:FindPlayer( args[1], ply );
	local t = args[2] and tonumber( args[2] ) or 0;
	
	if( targ and targ:IsValid() ) then
	
		targ:SetBusinessLicenses( t );
		targ:UpdateCharacterField( "BusinessLicenses", targ:BusinessLicenses() );
		
		GAMEMODE:LogAdmin( "[F] " .. ply:Nick() .. " changed player " .. targ:RPName() .. "'s licenses to \"" .. t .. "\".", ply );
		
		netstream.Start( targ, "nPopulateBusiness" );
		
	else
		
		ply:Notify(nil, COLOR_ERROR, "Error: target not found.")
		
	end

end
concommand.AddAdmin( "rpa_setlicenses", SetLicenses );

local function TakeFromStockpile( ply, args )

	if( #args == 0 ) then
		
		ply:Notify(nil, COLOR_ERROR, "Error: no target specified.")
		return;
		
	end
	
	local id = args[1] and tonumber(args[1]);
	local item_id = args[2] and tonumber( args[2] );
	local stockpile = GAMEMODE.LoadedStockpiles[id]
	
	if stockpile then
		if !stockpile.Inventory[item_id] then
			ply:Notify(nil, Color(200,0,0), "Error: Invalid item specified.")
			return
		end
		
		local function onSuccess( ret )
		
			for k,v in next, ret do
			
				if !GAMEMODE:GetItemByID(v.ItemClass) then continue end
			
				local object = item( ply, v.ItemClass, v.id, util.JSONToTable(v.Vars) );
				object:TransmitToOwner();
				object:UpdateSave();
				stockpile.Inventory[item] = nil
				
				GAMEMODE:LogAdmin( Format("[F] %s removed %s from stash \"%s\".", ply:Nick(), object:GetName(), stockpile.Name), ply );
			
			end
		end
		mysqloo.Query(Format("SELECT * FROM cc_items WHERE id = '%s'", mysqloo.Escape(args[2])), onSuccess)
		
	else
		
		ply:Notify(nil, Color(200,0,0), "Error: No stockpile found")
		
	end

end
concommand.AddAdmin( "rpa_takefromstockpile", TakeFromStockpile );

local function GiveAccessToStockpile( ply, args )

	if( #args == 0 ) then
		
		ply:Notify(nil, COLOR_ERROR, "Error: no target specified.")
		return;
		
	end
	
	local targ = GAMEMODE:FindPlayer( args[1], ply );
	local t = args[2] and tonumber( args[2] ) or 0;
	local szJSON;
	
	if( targ and targ:IsValid() ) then
		
		local stockpile = GAMEMODE.LoadedStockpiles[t]
		
		if( stockpile ) then

			if( !table.HasValue( stockpile.Accessors, math.floor( targ:CharID() ) ) ) then

				stockpile.Accessors[#stockpile.Accessors + 1] = targ:CharID();
				szJSON = util.TableToJSON( stockpile.Accessors );
				
				local function onSuccess()
				
					GAMEMODE:LogAdmin( "[F] " .. ply:Nick() .. " gave access to " .. targ:RPName() .. " for stockpile \"" .. t .. "\".", ply );
				
				end
				mysqloo.Query( Format( "UPDATE cc_stockpiles SET Accessors = '%s' WHERE id = '%s'", szJSON, t ), onSuccess );
			
			end
			
		else
		
			ply:Notify(nil, COLOR_ERROR, "Error: stockpile not found.")
			
		end
		
	else
		
		ply:Notify(nil, COLOR_ERROR, "Error: target not found.")
		
	end

end
concommand.AddAdmin( "rpa_giveaccesstostockpile", GiveAccessToStockpile );

local function TakeAccessToStockpile( ply, args )

	if( #args == 0 ) then
		
		ply:Notify(nil, COLOR_ERROR, "Error: no target specified.")
		return;
		
	end
	
	local targ = GAMEMODE:FindPlayer( args[1], ply );
	local t = args[2] and tonumber( args[2] ) or 0;
	local szJSON;
	
	if( targ and targ:IsValid() ) then
	
		local stockpile = GAMEMODE.LoadedStockpiles[t]
	
		if( stockpile ) then

			if( table.HasValue( stockpile.Accessors, math.floor( targ:CharID() ) ) ) then

				for k,v in next, stockpile.Accessors do
				
					if( v == math.floor( targ:CharID() ) ) then
					
						table.remove( stockpile.Accessors, k );
						break;
						
					end
					
				end
				szJSON = util.TableToJSON( stockpile.Accessors );
				
				local function onSuccess()
				
					GAMEMODE:LogAdmin( "[F] " .. ply:Nick() .. " took access from " .. targ:RPName() .. " for stockpile \"" .. t .. "\".", ply );
				
				end
				mysqloo.Query( Format( "UPDATE cc_stockpiles SET Accessors = '%s' WHERE id = '%s'", szJSON, t ), onSuccess );
			
			end
			
		else
		
			ply:Notify(nil, COLOR_ERROR, "Error: stockpile not found.")
			
		end
		
	else
		
		ply:Notify(nil, COLOR_ERROR, "Error: target not found.")
		
	end
	
end
concommand.AddAdmin( "rpa_takeaccesstostockpile", TakeAccessToStockpile );

local function SetEntityDesc( ply, cmd, args, szArgs )
	local targ = ply:GetEyeTraceNoCursor().Entity
	local szDesc = szArgs
	
	if !ply:IsAdmin() then
		if #szDesc > 512 then return end
		if targ.PropSteamID and targ:PropSteamID() != ply:SteamID() then return end
	end

	if targ and IsValid(targ) and targ:GetClass() == "prop_physics" or targ:GetClass() == "prop_ragdoll" then
		if targ.PropDesc then
			targ:SetPropDesc(szDesc)
		end
	end
end
concommand.Add( "rp_propdesc", SetEntityDesc );

local function BlowoutTriggerInstant( ply, args )

	if GAMEMODE:BlowoutEnabled() < 1 then
		ply:Notify(nil, Color(255,32,32), "Blowouts are disabled, use rpa_blowout_enabled 1.")
		return
	end
	
	if kingston.blowout.get_var("Bool", "active_blowout") then 
		ply:Notify(nil, Color(255,32,32), "A blowout is already in progress!")
		return
	end
	
	ply:Notify(nil, Color(32,255,32), "Instant blowout sequence starting.")
	kingston.blowout.initiate(true)
	
	GAMEMODE:LogAdmin( Format("[F] %s started an instant blowout sequence.", ply:Nick()), ply );
	
end
concommand.AddAdmin( "rpa_triggerblowoutinstant", BlowoutTriggerInstant );

local function BlowoutTriggerDelayed( ply, args )

	if GAMEMODE:BlowoutEnabled() < 1 then
		ply:Notify(nil, Color(255,32,32), "Blowouts are disabled, use rpa_blowout_enabled 1.")
		return
	end
	
	if kingston.blowout.get_var("Bool", "active_blowout") then 
		ply:Notify(nil, Color(255,32,32), "A blowout is already in progress!")
		return
	end

	ply:Notify(nil, Color(32,255,32), "Delayed blowout sequence starting.")
	kingston.blowout.initiate()
	
	GAMEMODE:LogAdmin( Format("[F] %s started a delayed blowout sequence.", ply:Nick()), ply );
	
end
concommand.AddAdmin( "rpa_triggerblowout", BlowoutTriggerDelayed );

local function BlowoutCancel( ply, args )

	if GAMEMODE:BlowoutEnabled() < 1 then
		ply:Notify(nil, Color(255,32,32), "Blowouts are disabled, use rpa_blowout_enabled 1.")
		return
	end
	
	if !kingston.blowout.get_var("Bool", "active_blowout") then 
		ply:Notify(nil, Color(255,32,32), "There is no blowout in progress!")
		return
	end

	ply:Notify(nil, Color(32,255,32), "Blowout cancelled.")
	kingston.blowout.cancel()
	
	GAMEMODE:LogAdmin( Format("[F] %s cancelled the ongoing blowout.", ply:Nick()), ply );
	
end
concommand.AddAdmin( "rpa_cancelblowout", BlowoutCancel );

local function PanicCleanup( ply )

	for k,v in next, ents.FindByClass( "prop_physics" ) do
	
		if( IsValid( v ) and IsValid( v:GetPhysicsObject() ) ) then
		
			if( v:GetPhysicsObject():IsMotionEnabled() ) then
			
				v:Remove();
			
			end
		
		end
	
	end
	
end	
concommand.AddAdmin( "rpa_panic", PanicCleanup );

local function SetDamageMultiplier( ply, args )
	local mult = args[1] and tonumber(args[1])
	if !mult then
		ply:Notify(nil, Color(200,0,0), "Error: Invalid multiplier specified.")
		return
	end

	local cvar = GetConVar("sv_tfa_damage_multiplier")
	if cvar then
		cvar:SetFloat(mult)
		
		ply:Notify(nil, Color(0,200,0), "Global damage multipler set to %s", args[1])
		GAMEMODE:LogAdmin( Format("[F] %s set the global damage multiplier to %s.", ply:Nick(), args[1]), ply );
	else
		ply:Notify(nil, Color(200,0,0), "Error: Somehow the TFA damage multipler CVar is missing!")
	end
end	
concommand.AddAdmin( "rpa_setdmgmult", SetDamageMultiplier, true );

local function GiveStockpile( ply, args )

	if( #args == 0 ) then
		
		ply:Notify(nil, COLOR_ERROR, "Error: no target specified.")
		return;
		
	end
	
	local targ = GAMEMODE:FindPlayer( args[1], ply );
	
	if( targ and targ:IsValid() ) then
	
		targ.StartStockpileCreation = true;
		netstream.Start( targ, "nRequestStockpileName" );
		
	else
		
		ply:Notify(nil, COLOR_ERROR, "Error: target not found.")
		
	end
	
end
concommand.AddAdmin( "rpa_givestockpile", GiveStockpile );

local function SetRank(ply, args)
	if #args == 0 then
		ply:Notify(nil, COLOR_ERROR, "Error: no target specified.")
		return
	end
	
	local targ = GAMEMODE:FindPlayer(args[1], ply)
	local rank = args[2] or "user"
	
	if targ and targ:IsValid() then
		targ:SetUserGroup(rank)
		targ:UpdatePlayerField("Rank", rank)
		
		GAMEMODE:Notify({ply, targ}, nil, COLOR_NOTIF, "%s set %s's rank to %s.", ply:Nick(), targ:Nick(), rank)
	else
		ply:Notify(nil, COLOR_ERROR, "Error: target not found.")
	end
end
concommand.AddAdmin("rpa_setrank", SetRank, true)

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

local function SetWatched( ply, args )

	if( #args == 0 ) then
		
		ply:Notify(nil, COLOR_ERROR, "Error: no target specified.")
		return;
		
	end
	
	local targ = GAMEMODE:FindPlayer( args[1], ply );
	
	if( targ and targ:IsValid() ) then
	
		targ:SetWatched(!targ:Watched())
		targ:UpdatePlayerField( "Watched", targ:Watched() and "1" or "0" )
		ply:Notify(nil, COLOR_NOTIF, targ:Watched() and "%s is now being watched." or "%s is no longer being watched.", targ:Nick())
		
	else
		
		ply:Notify(nil, COLOR_ERROR, "Error: target not found.")
		
	end
	
end
concommand.AddAdmin( "rpa_togglewatched", SetWatched );