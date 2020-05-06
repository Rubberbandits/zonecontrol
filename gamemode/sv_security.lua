kingston = kingston or {}
kingston.security = kingston.security or {}
kingston.security.api_key = "869469DBF9BC38D6BCF1A0E96C582258"

function GM:SteamIDIsBanned( sid )
	
	if( !GAMEMODE.BanTable ) then GAMEMODE.BanTable = { } end
	
	for k, v in pairs( self.BanTable ) do
		
		if( v.SteamID == sid ) then
			
			if( tonumber( v.Length ) == 0 ) then
				
				return 0, v.Reason, true;
				
			else
				
				local t = util.TimeSinceDate( v.Date );
				
				if( t < tonumber( v.Length ) ) then
					
					return v.Length - t, v.Reason, false;
					
				else
					
					table.remove( self.BanTable, k );
					self:RemoveBan( sid, "time's up" );
					
				end
				
			end
			
		end
		
	end
	
end

function GM:CheckPassword( steamid, networkid, svpass, pass, name )
	
	if( self.NoMySQL ) then
		
		if( steamid != STEAMID_DISSEMINATE ) then
			
			return false, "The server's MySQL is down for some reason - we're working on it! Check back later.";
			
		end
		
	end
	
	local t, r, p = self:SteamIDIsBanned( util.SteamIDFrom64( steamid ) );
	
	if( t ) then
		
		if( p ) then
			
			self:LogSecurity( util.SteamIDFrom64( steamid ), networkid, name, "Permabanned." );
			
			local reason = ".";
			
			if( r and string.len( r ) > 0 ) then
				
				reason = " (" .. r .. ").";
				
			end
			
			return false, "You're permabanned" .. reason .. " Apply for an unban at " .. self.WebsiteURL .. ".";
			
		else
			
			self:LogSecurity( util.SteamIDFrom64( steamid ), networkid, name, "Banned for " .. t .. " more minutes." );
			
			local reason = ".";
			
			if( r and string.len( r ) > 0 ) then
				
				reason = " (" .. r .. ").";
				
			end
			
			return false, "You're banned for " .. t .. " more minutes" .. reason .. " Apply for an unban at " .. self.WebsiteURL .. ".";
			
		end
		
	end
	
	if( self.PrivateMode ) then
		
		if( !table.HasValue( self.PrivateSteamIDs, util.SteamIDFrom64( steamid ) ) ) then
			
			self:LogSecurity( util.SteamIDFrom64( steamid ), networkid, name, "Blocked during private mode." );
			return false, self.TestingClosedMessage;
			
		end
		
	end
	
	if( svpass != "" ) then
		
		if( pass != svpass ) then
			
			self:LogSecurity( util.SteamIDFrom64( steamid ), networkid, name, "Failed password check: Their password, \"" .. pass .. "\", did not match server password, \"" .. svpass .. "\"." );
			return false;
			
		end
		
	end
	
	return true;
	
end

function nQuizBan( ply, mode )
	
	local mode = net.ReadBit();
	
	if( !GAMEMODE.BanTable ) then GAMEMODE.BanTable = { } end
	
	if( mode == 0 ) then
		
		table.insert( GAMEMODE.BanTable, { SteamID = ply:SteamID(), Length = 360, Reason = "Failed quiz.", Date = os.date( "!%m/%d/%y %H:%M:%S" ) } );
		GAMEMODE:AddBan( ply:SteamID(), 360, "Failed quiz.", os.date( "!%m/%d/%y %H:%M:%S" ) );
		
		ply:Kick( "Failed quiz" );
		
		netstream.Start( nil, "nAQuizBan", ply:Nick(), false );
		
	else
		
		table.insert( GAMEMODE.BanTable, { SteamID = ply:SteamID(), Length = 0, Reason = "Failed quiz.", Date = os.date( "!%m/%d/%y %H:%M:%S" ) } );
		GAMEMODE:AddBan( ply:SteamID(), 0, "Failed quiz.", os.date( "!%m/%d/%y %H:%M:%S" ) );
		
		ply:Kick( "Failed quiz" );

		netstream.Start( nil, "nAQuizBan", ply:Nick(), true );
		
	end
	
end
netstream.Hook( "nQuizBan", nQuizBan );

function kingston.security.check_family_share(ply)
	http.Fetch(
		Format("http://api.steampowered.com/IPlayerService/IsPlayingSharedGame/v0001/?key=%s&format=json&steamid=%s&appid_playing=4000",
			kingston.security.api_key,
			ply:SteamID64()
		),

		function(body)
			local body = util.JSONToTable(body)

			if not body or not body.response or not body.response.lender_steamid then
				error(string.format("FamilySharing: Invalid Steam API response for %s | %s\n", ply:Nick(), ply:SteamID()))
			end

			local lender = body.response.lender_steamid
			if lender ~= "0" then
				http.Fetch(
					Format("https://api.steampowered.com/ISteamUser/GetPlayerSummaries/v2/?key=%s&format=json&steamids=%s",
						kingston.security.api_key,
						lender
					),
					
					function(body)
						local body = util.JSONToTable(body)
						local lender_info = body.response.players[1]

						if not body or not body.response or not lender_info.personaname then
							error(string.format("FamilySharing: Invalid Steam API response for %s | %s\n", ply:Nick(), ply:SteamID()))
						end

						local lender_name = lender_info.personaname
						if lender_name ~= "0" then
							kingston.security.handle_shared(ply, lender_name, lender_info.steamid)
						end
					end,

					function(code)
						error(string.format("FamilySharing: Failed API call for %s | %s (Error: %s)\n", ply:Nick(), ply:SteamID(), code))
					end
				)
			end
		end,

		function(code)
			error(string.format("FamilySharing: Failed API call for %s | %s (Error: %s)\n", ply:Nick(), ply:SteamID(), code))
		end
	)
end

function kingston.security.handle_shared(ply, lender_name, lender_steamid)
	local lender_proper_steamid = util.SteamIDFrom64(lender_steamid)

	kingston.log.write(
		"security", 
		"Player %s (%s) is borrowing Garry's Mod from %s (%s)%s!", 
		ply:Nick(), 
		ply:SteamID(), 
		lender_name, 
		lender_proper_steamid, 
		(", this player is banned" and GAMEMODE:SteamIDIsBanned(lender_proper_steamid)) or ""
	)

	GAMEMODE:Notify(
		player.GetAdmins(), 
		nil, 
		COLOR_ERROR, 
		"Player %s (%s) is borrowing Garry's Mod from %s (%s)%s!", 
		ply:Nick(), 
		ply:SteamID(), 
		lender_name, 
		lender_proper_steamid, 
		(", this player is banned" and GAMEMODE:SteamIDIsBanned(lender_proper_steamid)) or ""
	)
end

local function check_family_share(ply)
	kingston.security.check_family_share(ply)
end
hook.Add("PlayerAuthed", "STALKER.check_family_share", check_family_share)

function kingston.security.check_ip(ply)
	mysqloo.Query(
		Format("SELECT * FROM cc_players WHERE IPAddress = '%s' AND SteamID != '%s';", ply:IPAddress(), ply:SteamID()),
		function(data, q)
			if #data > 0 then
				local str = ""
				for k,v in next, data do
					str = str..v.LastName..", "
				end
				
				kingston.log.write(
					"security", 
					"Player %s (%s) has same IP as other players! (%s)",
					ply:Nick(),
					ply:SteamID(),
					str
				)
				
				GAMEMODE:Notify(
					player.GetAdmins(),
					nil,
					COLOR_ERROR,
					"Player %s (%s) has same IP as other players! (%s)",
					ply:Nick(),
					ply:SteamID(),
					str
				)
			end
		end
	)
end

local function check_ip(ply)
	kingston.security.check_ip(ply)
end
hook.Add("PlayerAuthed", "STALKER.check_ip", check_ip)

local ignore_types = {
	["[ic]"] = true,
	["[yell]"] = true,
	["[whisper]"] = true,
	["[it]"] = true,
	["[lit]"] = true,
	["[me]"] = true,
	["[lme]"] = true,
	["[looc]"] = true,
	["[admin]"] = true,
	["[radio]"] = true,
}

for trait,info in next, kingston.chat.Languages do
	local id = info[2]:sub(2, #info[2])
	
	ignore_types["["..id.."]"] = true
	ignore_types["["..id.."Y]"] = true
	ignore_types["["..id.."W]"] = true
end

local function BroadcastWatchedLogs(category, text)
	for k,v in next, player.GetAll() do
		if v:Watched() and text:find(v:Nick()) then
			local should_broadcast = true
			for m,n in next, ignore_types do
				if text:find(m, 1, true) then
					should_broadcast = false
				end
			end
			
			if should_broadcast then
				netstream.Start(player.GetAdmins(), "ConsoleNotify", "WATCHED: "..text)
			end
		end
	end
end
hook.Add("LogWritten", "STALKER.BroadcastWatchedLogs", BroadcastWatchedLogs)