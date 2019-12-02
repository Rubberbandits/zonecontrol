local meta = FindMetaTable( "Player" );
CC = { }; -- Table of chat command functions.

if( SERVER ) then
	
	function nSay( ply, text )
		
		ply:SetTyping( 0 );
		
		if( !ply.LastChat ) then ply.LastChat = 0 end
		if( CurTime() - ply.LastChat < 0.05 ) then return end
		ply.LastChat = CurTime();
		
		if( string.len( text ) > 2000 ) then
			
			return;
			
		end
		
		GAMEMODE:OnChat( ply, text );
		
	end
	netstream.Hook( "nSay", nSay );
	
	function nChangeRadio( ply, val )

		if( !ply:HasItem( "radio" ) ) then return end
		
		if( val >= 0 ) then
			
			if( val <= 999 ) then
			
				ply:SetRadioFreq( math.Round( val, 2 ) );
				
			end
			
		end
		
	end
	netstream.Hook( "nChangeRadio", nChangeRadio );
	
else
	
	function nConSay( str )

		GAMEMODE:AddChat({ CB_ALL, CB_OOC }, "CombineControl.ChatNormal", Color( 255, 0, 0, 255 ) "Console: " .. str);
		
	end
	netstream.Hook( "nConSay", nConSay );
	
	function nConASay( str )

		GAMEMODE:AddChat({ CB_ALL, CB_OOC }, "CombineControl.ChatNormal", Color( 255, 0, 0, 255 ) "[ADMIN] Console: " .. str);
		
	end
	netstream.Hook( "nConASay", nConASay );
	
	function nChatLocal( ply, str )
		
		GAMEMODE:ChatLocal( ply, str );
		
	end
	netstream.Hook( "nChatLocal", nChatLocal );
	
	function nChatYell( ply, str )
		
		CC.Yell( ply, str );
		
	end
	netstream.Hook( "nChatYell", nChatYell );
	
	function nChatWhisper( ply, str )
		
		CC.Whisper( ply, str );
		
	end
	netstream.Hook( "nChatWhisper", nChatWhisper );
	
	function nChatMe( ply, str )
		
		CC.Me( ply, str, true );
		
	end
	netstream.Hook( "nChatMe", nChatMe );
	
	function nChatLMe( ply, str )
		
		CC.LMe( ply, str, true );
		
	end
	netstream.Hook( "nChatLMe", nChatLMe );
	
	function nChatIt( ply, str )

		CC.It( ply, str );
		
	end
	netstream.Hook( "nChatIt", nChatIt );
	
	function nChatLIt( ply, str )

		CC.LIt( ply, str );
		
	end
	netstream.Hook( "nChatLIt", nChatLIt );
	
	function nChatAn( ply, str )

		CC.An( ply, str );
		
	end
	netstream.Hook( "nChatAn", nChatAn );
	
	function nChatOOC( ply, str )

		CC.OOC( ply, str, true );
		
	end
	netstream.Hook( "nChatOOC", nChatOOC );
	
	function nChatPDA( name, tname, str, mode )
		
		GAMEMODE:AddPDANotification(name.." -> "..tname, str, 6, 3, false)

	end
	netstream.Hook( "nChatPDA", nChatPDA );
	
	function nChatLOOC( ply, str )

		CC.LOOC( ply, str );
		
	end
	netstream.Hook( "nChatLOOC", nChatLOOC );
	
	function nChatAdmin( ply, str )

		CC.Admin( ply, str );
		
	end
	netstream.Hook( "nChatAdmin", nChatAdmin );
	
	function nChatPM( name, tname, str, mode )

		local text = "[PM to " .. tname .. "] " .. name .. ":" .. str;
		
		if( !mode ) then
			
			text = "[PM to " .. tname .. "]: " .. str;
			
		else
			
			text = "[PM from " .. name .. "]: " .. str;
			
		end
		
		GAMEMODE:AddChat( { CB_ALL, CB_OOC }, "CombineControl.ChatNormal", Color( 255, 183, 58, 255 ), text );
		
	end
	netstream.Hook( "nChatPM", nChatPM );
	
	function nChatRadio( ply, str )

		CC.Radio( ply, str );
		
	end
	netstream.Hook( "nChatRadio", nChatRadio );
	
	function nChatBigRadio( ply, str )

		if( !ply.VisibleRPName ) then return end
		
		local name = ply:VisibleRPName();
		
		GAMEMODE:AddChat( { CB_ALL, CB_IC }, "CombineControl.ChatRadio", Color( 128, 128, 128, 255 ), "[Stationary Radio] " .. name .. ":" .. str );
		
	end
	netstream.Hook( "nChatBigRadio", nChatBigRadio );
	
	function nChatRadioSurround( ply, str )
		
		CC.Radio( ply, str, true );
		
	end
	netstream.Hook( "nChatRadioSurround", nChatRadioSurround );
	
	function nChatDispatch( ply, str )

		CC.Dispatch( ply, str );
		
	end
	netstream.Hook( "nChatDispatch", nChatDispatch );
	
	function nChatCRDevice( ply, str )

		CC.CR( ply, str );
		
	end
	netstream.Hook( "nChatCRDevice", nChatCRDevice );
	
	function nChatCRDeviceSurround( ply, str )

		CC.CR( ply, str, true );
		
	end
	netstream.Hook( "nChatCRDeviceSurround", nChatCRDeviceSurround );
	
	function nChatBroadcast( ply, str )

		CC.Broadcast( ply, str );
		
	end
	netstream.Hook( "nChatBroadcast", nChatBroadcast );
	
	function nChatEvent( ply, str )

		CC.Event( ply, str );
		
	end
	netstream.Hook( "nChatEvent", nChatEvent );
	
	function nChatLEvent( ply, str )

		CC.LocalEvent( ply, str );
		
	end
	netstream.Hook( "nChatLEvent", nChatLEvent );
	
	function nChatAdvertise( ply, str )

		CC.Advertise( ply, str, true );
		
	end
	netstream.Hook( "nChatAdvertise", nChatAdvertise );
	
	function nRoll( ply, val )
		
		CC.Roll( ply, nil, val );
		
	end
	netstream.Hook( "nRoll", nRoll );
	
end

GM.ChatCommands = { };

function GM:AddChatCommand( text, color, func )
	
	table.insert( self.ChatCommands, { text, color, func } );
	
end

function GM:StringHasCommand( str )
	
	local tab = self.ChatCommands;
	
	table.sort( tab, function( a, b )
		
		return string.len( a[1] ) > string.len( b[1] );
		
	end );
	
	for _, v in pairs( self.ChatCommands ) do
		
		if( str ) then
			
			if( string.find( string.lower( str ), string.lower( v[1] ), nil, true ) == 1 ) then
				
				return v;
				
			end
			
		end
		
	end
	
	return false;
	
end

function meta:GetRF( maxd, muffled, inclself )
	
	local rf = { };
	
	for _, v in pairs( player.GetAll() ) do
		
		if( v != self or inclself ) then
			
			local dist = maxd;
			
			if( maxd != muffled and !self:CanHear( v ) ) then
				
				dist = muffled;
				
			end
			
			if( v:GetPos():Distance( self:GetPos() ) < dist ) then
				
				table.insert( rf, v );
				
			end
			
		end
		
	end
	
	return rf;
	
end

function GM:OnChat( ply, text )
	
	local cc = self:StringHasCommand( text );
	
	if( cc ) then
		
		local f = string.sub( text, string.len( cc[1] ) + 1 );
		local ret = cc[3]( ply, f );
		
		if( ret ) then
			
			GAMEMODE.NextChatText = text;
			
		end
		
	else
		
		self:ChatLocal( ply, text );
		
	end
	
end

function GM:ChatLocal( ply, arg )
	
	if( string.len( arg ) == 0 ) then return end
	
	if( !ply:Alive() ) then
		
		if( CLIENT ) then
			
			self:AddChat( { CB_ALL, CB_IC }, "CombineControl.ChatNormal", Color( 200, 0, 0, 255 ), "You're dead. You can't talk." );
			
		end
		
		return;
		
	end
	
	if( ply:PassedOut() ) then
		
		if( CLIENT ) then
			
			GAMEMODE:AddChat( { CB_ALL, CB_IC }, "CombineControl.ChatNormal", Color( 200, 0, 0, 255 ), "You're unconscious. You can't talk." );
			
		end
		
		return;
		
	end
	
	if( SERVER ) then
		
		local rf = ply:GetRF( 400, 150 );
		
		netstream.Start( rf, "nChatLocal", ply, arg );
		
		local name = ply:VisibleRPName();
		
		GAMEMODE:LogChat( "[ ] " .. name .. ": " .. arg, ply );
		
	else
		
		if( !ply.VisibleRPName ) then return end
		
		local name = ply:VisibleRPName();
		self:AddChat( { CB_ALL, CB_IC }, "CombineControl.ChatNormal", Color( 114, 160, 193, 255 ), name .. ": " .. arg );
		
	end
	
end

function CC.Yell( ply, arg )
	
	if( string.len( arg ) == 0 ) then return end
	
	if( !ply:Alive() ) then
		
		if( CLIENT ) then
			
			GAMEMODE:AddChat( { CB_ALL, CB_IC }, "CombineControl.ChatNormal", Color( 200, 0, 0, 255 ), "You're dead. You can't talk." );
			
		end
		
		return;
		
	end
	
	if( ply:PassedOut() ) then
		
		if( CLIENT ) then
			
			GAMEMODE:AddChat( { CB_ALL, CB_IC }, "CombineControl.ChatNormal", Color( 200, 0, 0, 255 ), "You're unconscious. You can't talk." );
			
		end
		
		return;
		
	end
	
	if( SERVER ) then
		
		local rf = ply:GetRF( 1000, 800 );
		netstream.Start( rf, "nChatYell", ply, arg );
		
		local name = ply:VisibleRPName();
		GAMEMODE:LogChat( "[Y] " .. name .. ": " .. arg, ply );
		
	else
		
		if( !ply.VisibleRPName ) then return end
		
		local name = ply:VisibleRPName();
		GAMEMODE:AddChat( { CB_ALL, CB_IC }, "CombineControl.ChatBig", Color( 200, 0, 0, 255 ), "[YELL] " .. name .. ":" .. arg );
		
	end
	
end
GM:AddChatCommand( "/y", Color( 200, 0, 0, 255 ), CC.Yell );

function CC.Whisper( ply, arg )
	
	if( string.len( arg ) == 0 ) then return end
	
	if( !ply:Alive() ) then
		
		if( CLIENT ) then
			
			GAMEMODE:AddChat( { CB_ALL, CB_IC }, "CombineControl.ChatNormal", Color( 200, 0, 0, 255 ), "You're dead. You can't talk." );
			
		end
		
		return;
		
	end
	
	if( ply:PassedOut() ) then
		
		if( CLIENT ) then
			
			GAMEMODE:AddChat( { CB_ALL, CB_IC }, "CombineControl.ChatNormal", Color( 200, 0, 0, 255 ), "You're unconscious. You can't talk." );
			
		end
		
		return;
		
	end
	
	if( SERVER ) then
		
		local rf = ply:GetRF( 50, 0 );
		netstream.Start( rf, "nChatWhisper", ply, arg );

		local name = ply:VisibleRPName();
		GAMEMODE:LogChat( "[W] " .. name .. ": " .. arg, ply );
		
	else
		
		if( !ply.VisibleRPName ) then return end
		
		local name = ply:VisibleRPName();
		GAMEMODE:AddChat( { CB_ALL, CB_IC }, "CombineControl.ChatSmall", Color( 200, 200, 200, 255 ), "[WHISPER] " .. name .. ":" .. arg );
		
	end
	
end
GM:AddChatCommand( "/w", Color( 200, 200, 200, 255 ), CC.Whisper );

function CC.Me( ply, arg, others )
	
	if( string.len( arg ) == 0 ) then return end
	
	if( SERVER ) then
		
		local rf = ply:GetRF( 400, 150 );
		netstream.Start( rf, "nChatMe", ply, arg );
		
		local name = ply:VisibleRPName();
		GAMEMODE:LogChat( "[M] " .. name .. " " .. arg, ply );
		
	else
		
		if( !ply.VisibleRPName ) then return end
		
		local name = ply:VisibleRPName();
		GAMEMODE:AddChat( { CB_ALL, CB_IC }, "CombineControl.ChatNormal", Color( 114, 160, 193, 255 ), "** " .. name .. arg );
		
	end
	
end
GM:AddChatCommand( "/me", Color( 114, 160, 193, 255 ), CC.Me );
GM:AddChatCommand( "/e", Color( 114, 160, 193, 255 ), CC.Me );

function CC.LMe( ply, arg, others )
	
	if( string.len( arg ) == 0 ) then return end
	
	if( SERVER ) then
		
		local rf = ply:GetRF( 1000, 300 );
		netstream.Start( rf, "nChatLMe", ply, arg );
		
		local name = ply:VisibleRPName();
		GAMEMODE:LogChat( "[LM] " .. name .. " " .. arg, ply );
		
	else
		
		if( !ply.VisibleRPName ) then return end
		
		local name = ply:VisibleRPName();
		GAMEMODE:AddChat( { CB_ALL, CB_IC }, "CombineControl.ChatNormal", Color( 114, 160, 193, 255 ), "** " .. name .. arg );
		
	end
	
end
GM:AddChatCommand( "/lme", Color( 114, 160, 193, 255 ), CC.LMe );

function CC.It( ply, arg )
	
	if( string.len( arg ) == 0 ) then return end
	
	if( SERVER ) then
		
		local rf = ply:GetRF( 400, 150 );
		netstream.Start( rf, "nChatIt", ply, arg );

		local name = ply:VisibleRPName();
		GAMEMODE:LogChat( "[I] (" .. name .. ") " .. arg, ply );
		
	else
		
		if( !ply.VisibleRPName ) then return end
		
		local name = ply:VisibleRPName();
		GAMEMODE:AddChat( { CB_ALL, CB_IC }, "CombineControl.ChatNormal", Color( 114, 160, 193, 255 ), "** " .. arg );
		
	end
	
end
GM:AddChatCommand( "/it", Color( 114, 160, 193, 255 ), CC.It );

function CC.LIt( ply, arg )
	
	if( string.len( arg ) == 0 ) then return end
	
	if( SERVER ) then
		
		local rf = ply:GetRF( 1000, 300 );
		netstream.Start( rf, "nChatLIt", ply, arg );
		
		local name = ply:VisibleRPName();
		GAMEMODE:LogChat( "[I] (" .. name .. ") " .. arg, ply );
		
	else
		
		if( !ply.VisibleRPName ) then return end
		
		local name = ply:VisibleRPName();
		GAMEMODE:AddChat( { CB_ALL, CB_IC }, "CombineControl.ChatNormal", Color( 114, 160, 193, 255 ), "** " .. arg );
		
	end
	
end
GM:AddChatCommand( "/lit", Color( 114, 160, 193, 255 ), CC.LIt );

function CC.OOC( ply, arg, other )
	
	if( string.len( arg ) == 0 ) then return end
	
	if( !other and ply.LastOOC and CurTime() < ply.LastOOC + GAMEMODE:OOCDelay() ) then
		
		if( !ply:IsAdmin() ) then
			
			if( CLIENT ) then
				
				GAMEMODE:AddChat( { CB_ALL, CB_OOC }, "CombineControl.ChatNormal", Color( 200, 200, 200, 255 ), "Wait " .. tostring( math.Round( ply.LastOOC + GAMEMODE:OOCDelay() - CurTime() ) ) .. " seconds to talk in OOC." );
				
			end
			
			return true;
			
		end
		
	end
	
	ply.LastOOC = CurTime();
	
	if( SERVER ) then
		
		local rf = { };
		
		for _, v in pairs( player.GetAll() ) do
			
			if( v != ply ) then
				
				table.insert( rf, v );
				
			end
			
		end
		
		netstream.Start( rf, "nChatOOC", ply, arg );
		
		local name = ply:VisibleRPName();
		GAMEMODE:LogChat( "[O] " .. name .. ": " .. arg, ply );
		
		MsgC( Color( 50, 150, 255, 255 ), "[OOC] " .. name .. ":" .. arg .. "\n" );
		
	else
		
		if( !ply.VisibleRPName ) then return end
		
		GAMEMODE:AddChat( { CB_ALL, CB_OOC }, "CombineControl.ChatNormal", Color( 200, 50, 50, 255 ), "[OOC] ", team.GetColor(ply:Team()), ply, Color( 255, 255, 255, 255 ), ":" .. arg );
		
	end
	
end
GM:AddChatCommand( "//", Color( 50, 150, 255, 255 ), CC.OOC );

function CC.PDA( ply, arg )

	local arg = string.Trim( arg )
	if( string.len( arg ) == 0 ) then return end
	if( #string.sub( arg, string.len( string.Explode( " ", arg )[1] ) + 2 ) == 0 ) then return end
	if kingston.blowout.get_var("Bool", "connection_lost", false) then return end
	
	if( SERVER ) then

		-- LMAO this shit is a huge yikes sorry jake...
		local item = ply:HasItem("pda")
		
		if !item then return end
		if !item:GetVar("Primary", false) then
			for k,v in next, ply.Inventory do
				if v:GetClass() == "pda" then
					if v:GetVar("Primary", false) and v:GetVar("Power",false) then
						item = v
						break
					end
				end
			end
		end
		if !item:GetVar("Power",false) then return end
		
		local name = item:GetVar("Name", "")
		if #name == 0 then
			name = ply:RPName()
		end
		
		local targ = string.Explode( " ", arg )[1];
		if targ == "all" then
			local rf = { };
			for _, v in pairs( player.GetAll() ) do
				if( v:HasItem( "pda" ) ) then
					for m,n in next, v.Inventory do
						if n:GetClass() == "pda" and n:GetVar("Power",false) then
							table.insert( rf, v );
							continue
						end
					end
				end
				
			end
			
			local name = item:GetVar("Name", "")
			if #name == 0 then
				name = ply:RPName()
			end
			
			netstream.Start( rf, "nAddPDANotif", name.." -> all", string.sub( arg, string.len( targ ) + 2 ), 2, 5 );

			GAMEMODE:LogChat( "[GP] " .. name .. " ("..ply:RPName().."): " .. string.sub( arg, string.len( targ ) + 2 ), ply );
			
			MsgC( Color( 255, 150, 0, 255 ), "[GPDA] " .. name .. " ("..ply:GetName().."):" .. string.sub( arg, string.len( targ ) + 2 ) .. "\n" );
		else
			local tply = GAMEMODE:FindPlayer( targ, ply, true );
			
			if !tply then 
				ply:PDANotify("STALKER.net", "Recipient could not be found, or is offline. Try again later.", 3, 12)
				return 
			end
			
			local targ_item = tply:HasItem("pda")
			
			if !targ_item then return end
			for k,v in next, tply.Inventory do
				if v:GetClass() == "pda" then
					if string.find( string.lower( v:GetVar("Name","") ), string.lower(targ), nil, true ) and v:GetVar("Power",false) then
						targ_item = v
						break
					end
				end
			end
			
			local targ_name = targ_item:GetVar("Name", "")
			if #targ_name == 0 then
				targ_name = tply:RPName()
			end
			
			if( tply ) then

				netstream.Start( tply, "nChatPDA", name, targ_name, string.sub( arg, string.len( targ ) + 2 ), true );
				
			else
				
				return;
				
			end

			netstream.Start( ply, "nChatPDA", name, targ_name, string.sub( arg, string.len( targ ) + 2 ), false );
			GAMEMODE:LogChat( "[P] (" .. name .. ") [PDA Message to " .. targ_name .. "]: " .. arg, ply );
		end
	end
end
GM:AddChatCommand( "/pda", Color( 100, 255, 100, 255 ), CC.PDA );

function CC.LOOC( ply, arg )
	
	if( string.len( arg ) == 0 ) then return end
	
	if( SERVER ) then
		
		local rf = ply:GetRF( 400, 150 );
		netstream.Start( rf, "nChatLOOC", ply, arg );
		
		local name = ply:VisibleRPName();
		GAMEMODE:LogChat( "[L] " .. name .. ": " .. arg, ply );
		
	else
		
		if( !ply.VisibleRPName ) then return end
		
		local name = ply:VisibleRPName();
		GAMEMODE:AddChat( { CB_ALL, CB_OOC }, "CombineControl.ChatNormal", Color( 50, 200, 255, 255 ), "[LOOC] " .. name .. ":" .. arg );
		
	end
	
end
GM:AddChatCommand( ".//", Color( 50, 200, 255, 255 ), CC.LOOC );
GM:AddChatCommand( "[[", Color( 50, 200, 255, 255 ), CC.LOOC );

function CC.Admin( ply, arg )
	
	if( string.len( arg ) == 0 ) then return end
	
	if( SERVER ) then
		
		local rf = { };
		
		for _, v in pairs( player.GetAll() ) do
			
			if( v != ply and ( v:IsAdmin() or v:IsEventCoordinator() ) ) then
				
				table.insert( rf, v );
				
			end
			
		end

		netstream.Start( rf, "nChatAdmin", ply, arg );
		
		local name = ply:VisibleRPName();
		GAMEMODE:LogChat( "[A] " .. name .. ": " .. arg, ply );
		
		MsgC( Color( 198, 51, 51, 255 ), "[ADMIN] " .. name .. ":" .. arg .. "\n" );
		
	else
		
		if( !ply.VisibleRPName ) then return end
		
		local name = ply:VisibleRPName();
		if ply:IsAdmin() or ply:IsEventCoordinator() then
			GAMEMODE:AddChat( { CB_ALL, CB_OOC }, "CombineControl.ChatNormal", Color( 198, 51, 51, 255 ), "[ADMIN] " .. name .. ":" .. arg );
		else
			GAMEMODE:AddChat( { CB_ALL, CB_OOC }, "CombineControl.ChatNormal", Color( 198, 51, 51, 255 ), "[ADMIN - Request] " .. name .. ":" .. arg );
		end
		
	end
	
end
GM:AddChatCommand( "/a", Color( 198, 51, 51, 255 ), CC.Admin );

function CC.PM( ply, arg )

	local arg = string.Trim( arg )
	if( string.len( arg ) == 0 ) then return end
	
	if( SERVER ) then
		
		local targ = string.Explode( " ", arg )[1];
		local tply = GAMEMODE:FindPlayer( targ, ply );
		
		if( tply ) then
			
			netstream.Start( tply, "nChatPM", ply:VisibleRPName(), tply:VisibleRPName(), string.sub( arg, string.len( targ ) + 2 ), true );
			
		else
			
			return;
			
		end
		
		netstream.Start( ply, "nChatPM", ply:VisibleRPName(), tply:VisibleRPName(), string.sub( arg, string.len( targ ) + 2 ), false );
		
		local name = ply:VisibleRPName();
		local tname = tply:VisibleRPName();
		GAMEMODE:LogChat( "[P] (" .. name .. ") [PM to " .. tname .. "]: " .. arg, ply );
		
	end
	
end
GM:AddChatCommand( "/pm", Color( 255, 183, 58, 255 ), CC.PM );

function CC.CanRadio( ply )
	
	local tr = GAMEMODE:GetHandTrace( ply, 128 );
	
	if( tr.Entity and tr.Entity:IsValid() and tr.Entity:GetClass() == "cc_radio" ) then
		
		return true, tr.Entity:GetChannel(), tr.Entity;
		
	end
	
	if( ply:HasItem( "radio" ) ) then
		
		return true, ply:RadioFreq();
		
	end
	
	return false;
	
end

function CC.Radio( ply, arg, norad )
	
	if( string.len( arg ) == 0 ) then return end
	
	local can, channel, ent = CC.CanRadio( ply );
	
	if( CLIENT and ply == LocalPlayer() and !can ) then
		
		GAMEMODE:AddChat( { CB_ALL, CB_IC }, "CombineControl.ChatNormal", Color( 200, 0, 0, 255 ), "You need a radio for this." );
		return;
		
	end
	
	if( !ply:Alive() ) then
		
		if( CLIENT ) then
			
			GAMEMODE:AddChat( { CB_ALL, CB_IC }, "CombineControl.ChatNormal", Color( 200, 0, 0, 255 ), "You're dead. You can't talk." );
			
		end
		
		return;
		
	end
	
	if( ply:PassedOut() ) then
		
		if( CLIENT ) then
			
			GAMEMODE:AddChat( { CB_ALL, CB_IC }, "CombineControl.ChatNormal", Color( 200, 0, 0, 255 ), "You're unconscious. You can't talk." );
			
		end
		
		return;
		
	end
	
	if( SERVER ) then
		
		if( !can ) then
			
			return;
			
		end
		
		if( !ent ) then
			
			local rf = ply:GetRF( 400, 150 );
			netstream.Start( rf, "nChatRadioSurround", ply, arg );
			
			local rf = { };
			
			for _, v in pairs( player.GetAll() ) do
				
				if( channel == v:RadioFreq() and ply != v and v:HasItem( "radio" ) ) then
					
					table.insert( rf, v );
					
				end
				
			end
			
			netstream.Start( rf, "nChatRadio", ply, arg );
			
			local rf = { };
			
			for _, v in pairs( ents.FindByClass( "cc_radio" ) ) do
				
				if( channel == v:GetChannel() ) then
					
					for _, n in pairs( player.GetAll() ) do
						
						local dist = 400;
						
						if( !n:CanHear( v ) ) then
							
							dist = 150;
							
						end
						
						if( n:GetPos():Distance( v:GetPos() ) < dist ) then
							
							table.insert( rf, n );
							
						end
						
					end
					
				end
				
			end
			
			netstream.Start( rf, "nChatBigRadio", ply, arg );
			
		else
			
			local rf = { };
			
			for _, v in pairs( player.GetAll() ) do
				
				if( channel == v:RadioFreq() and ply != v and v:HasItem( "radio" ) ) then
					
					table.insert( rf, v );
					
				end
				
			end

			netstream.Start( rf, "nChatRadio", ply, arg );
			
			local rf = { };
			
			for _, v in pairs( ents.FindByClass( "cc_radio" ) ) do
				
				if( channel == v:GetChannel() ) then
					
					for _, n in pairs( player.GetAll() ) do
						
						local dist = 400;
						
						if( !n:CanHear( v ) ) then
							
							dist = 150;
							
						end
						
						if( n:GetPos():Distance( v:GetPos() ) < dist ) then
							
							table.insert( rf, n );
							
						end
						
					end
					
				end
				
			end

			netstream.Start( rf, "nChatBigRadio", ply, arg );
			
		end
		
		local name = ply:VisibleRPName();
		GAMEMODE:LogChat( "[R] (" .. tostring( channel ) .. ") " .. name .. ": " .. arg, ply );
		
	else
		
		if( !ply.VisibleRPName ) then return end
		
		local name = ply:VisibleRPName();
		
		if( norad ) then
		
			if( !ent ) then

				GAMEMODE:AddChat( { CB_ALL, CB_IC }, "CombineControl.ChatNormal", Color( 200, 200, 200, 255 ), name .. ":" .. arg );
				
			end
			
		else
			
			if( ( ply == LocalPlayer() and !ent ) or ply != LocalPlayer() ) then
				
				GAMEMODE:AddChat( { CB_ALL, CB_IC, CB_RADIO }, "CombineControl.ChatRadio", Color( 160, 160, 160, 255 ), "[Radio] " .. name .. ":" .. arg );
				
			end
			
		end
		
	end
	
end
GM:AddChatCommand( "/r", Color( 160, 160, 160, 255 ), CC.Radio );
GM:AddChatCommand( "/radio", Color( 160, 160, 160, 255 ), CC.Radio );

function CC.Event( ply, arg )
	
	if( string.len( arg ) == 0 ) then return end
	
	if( !ply:IsAdmin() and !ply:IsEventCoordinator() ) then
		
		if( CLIENT ) then
			
			GAMEMODE:AddChat( { CB_ALL, CB_IC }, "CombineControl.ChatNormal", Color( 200, 0, 0, 255 ), "You need to be an admin to do this." );
			
		end
		
		return;
		
	end
	
	if( SERVER ) then
		
		local rf = ply:GetRF( math.huge, math.huge );
		
		netstream.Start( rf, "nChatEvent", ply, arg );
		
		local name = ply:VisibleRPName();
		GAMEMODE:LogChat( "[E] (" .. name .. ") " .. arg, ply );
		
		MsgC( Color( 200, 100, 50, 255 ), "(" .. name .. ") " .. arg .. "\n" );
		
	else
		
		if( !ply.VisibleRPName ) then return end
		
		local name = ply:VisibleRPName();
		GAMEMODE:AddChat( { CB_ALL, CB_IC }, "CombineControl.ChatHuge", Color( 114, 160, 193, 255 ), "[EVENT] " .. arg );
		
	end
	
end
GM:AddChatCommand( "/ev", Color( 114, 160, 193, 255 ), CC.Event );

function CC.LocalEvent( ply, arg )
	
	if( string.len( arg ) == 0 ) then return end
	
	if( !ply:IsAdmin() and !ply:IsEventCoordinator() ) then
		
		if( CLIENT ) then
			
			GAMEMODE:AddChat( { CB_ALL, CB_IC }, "CombineControl.ChatNormal", Color( 200, 0, 0, 255 ), "You need to be an admin to do this." );
			
		end
		
		return;
		
	end
	
	if( SERVER ) then
		
		local rf = ply:GetRF( 3000, 3000 );
		netstream.Start( rf, "nChatLEvent", ply, arg );
		
		local name = ply:VisibleRPName();
		GAMEMODE:LogChat( "[LEV] (" .. name .. ") " .. arg, ply );
		
		MsgC( Color( 200, 100, 50, 255 ), "(" .. name .. ") " .. arg .. "\n" );
		
	else
		
		if( !ply.VisibleRPName ) then return end
		
		local name = ply:VisibleRPName();
		GAMEMODE:AddChat( { CB_ALL, CB_IC }, "CombineControl.ChatHuge", Color( 114, 160, 193, 255 ), "[L-EVENT] " .. arg );
		
	end
	
end
GM:AddChatCommand( "/lev", Color( 114, 160, 193, 255 ), CC.LocalEvent );

function CC.Help( ply, arg )
	
	if( CLIENT ) then
		
		GAMEMODE:CreateHelpMenu();
		
	end
	
end
GM:AddChatCommand( "/help", Color( 200, 200, 200, 255 ), CC.Help );

function CC.Roll( ply, arg, val )
	
	if( val ) then
		
		if( !ply.VisibleRPName ) then return end
		
		local name = ply:VisibleRPName();
		GAMEMODE:AddChat( { CB_ALL, CB_OOC }, "CombineControl.ChatNormal", Color( 200, 200, 200, 255 ), name .. " rolled " .. val .. "/100." );
		
	else
		
		if( SERVER ) then
			
			local roll = math.random( 0, 100 );
			
			local rf = ply:GetRF( 400, 150, true );
			netstream.Start( rf, "nRoll", ply, roll );
			
			local name = ply:VisibleRPName();
			GAMEMODE:LogChat( "[R] " .. name .. " rolled " .. roll .. "/100.", ply );
			
		end
		
	end
	
end
GM:AddChatCommand( "/roll", Color( 200, 200, 200, 255 ), CC.Roll );

CC.Languages = { };
CC.Languages[TRAIT_ENGLISH] = { "English", "/eng" };
CC.Languages[TRAIT_CHINESE] = { "Chinese", "/chi" };
CC.Languages[TRAIT_JAPANESE] = { "Japanese", "/jap" };
CC.Languages[TRAIT_SPANISH] = { "Spanish", "/spa" };
CC.Languages[TRAIT_FRENCH] = { "French", "/fre" };
CC.Languages[TRAIT_GERMAN] = { "German", "/ger" };
CC.Languages[TRAIT_ITALIAN] = { "Italian", "/ita" };
CC.Languages[TRAIT_POLISH] = { "Polish", "/pol" };

for k, v in pairs( CC.Languages ) do
	
	CC[v[1]] = function( ply, arg )
		
		if( string.len( arg ) == 0 ) then return end
		
		if( CLIENT and ply == LocalPlayer() and bit.band( ply:Trait(), k ) != k ) then
			
			GAMEMODE:AddChat( { CB_ALL, CB_IC }, "CombineControl.ChatNormal", Color( 200, 0, 0, 255 ), "You can't speak " .. v[1] .. "!" );
			return;
			
		end
		
		if( !ply:Alive() ) then
			
			if( CLIENT ) then
				
				GAMEMODE:AddChat(  { CB_ALL, CB_IC }, "CombineControl.ChatNormal", Color( 200, 0, 0, 255 ), "You're dead. You can't talk." );
				
			end
			
			return;
			
		end
		
		if( ply:PassedOut() ) then
			
			if( CLIENT ) then
				
				GAMEMODE:AddChat( { CB_ALL, CB_IC }, "CombineControl.ChatNormal", Color( 200, 0, 0, 255 ), "You're unconscious. You can't talk." );
				
			end
			
			return;
			
		end
		
		if( SERVER ) then
			
			if( !ply:HasTrait( k ) ) then
				
				return;
				
			end
			
			local rf = ply:GetRF( 400, 150 );
			netstream.Start( rf, "nChat"..v[1], ply, arg );
			
			local name = ply:VisibleRPName();
			GAMEMODE:LogChat( "[F] " .. name .. ": " .. arg, ply );
			
		else
			
			if( !ply.VisibleRPName ) then return end
			
			local name = ply:VisibleRPName();
			
			if( !LocalPlayer():HasTrait( k ) ) then
				
				GAMEMODE:AddChat( { CB_ALL, CB_IC }, "CombineControl.ChatNormalItalic", Color( 255, 167, 73, 255 ), name .. " speaks " .. v[1] .. "." );
				
			else
				
				GAMEMODE:AddChat( { CB_ALL, CB_IC }, "CombineControl.ChatNormal", Color( 255, 167, 73, 255 ), "[" .. v[1] .. "] " .. name .. ":" .. arg );
				
			end
			
		end
		
	end
	GM:AddChatCommand( v[2], Color( 255, 167, 73, 255 ), CC[v[1]] );
	
	if( CLIENT ) then
		
		_G["nChat" .. v[1]] = function( ply, str )
			
			CC[v[1]]( ply, str );
			
		end
		netstream.Hook( "nChat" .. v[1], _G["nChat" .. v[1]] );
		
	end
	
	CC[v[1] .. "Y"] = function( ply, arg )
		
		if( string.len( arg ) == 0 ) then return end
		
		if( CLIENT and ply == LocalPlayer() and bit.band( ply:Trait(), k ) != k ) then
			
			GAMEMODE:AddChat( { CB_ALL, CB_IC }, "CombineControl.ChatNormal", Color( 200, 0, 0, 255 ), "You can't speak " .. v[1] .. "!" );
			return;
			
		end
		
		if( !ply:Alive() ) then
			
			if( CLIENT ) then
				
				GAMEMODE:AddChat( { CB_ALL, CB_IC }, "CombineControl.ChatNormal", Color( 200, 0, 0, 255 ), "You're dead. You can't talk." );
				
			end
			
			return;
			
		end
		
		if( ply:PassedOut() ) then
			
			if( CLIENT ) then
				
				GAMEMODE:AddChat( { CB_ALL, CB_IC }, "CombineControl.ChatNormal", Color( 200, 0, 0, 255 ), "You're unconscious. You can't talk." );
				
			end
			
			return;
			
		end
		
		if( SERVER ) then
			
			if( !ply:HasTrait( k ) ) then
				
				return;
				
			end
			
			local rf = ply:GetRF( 1000, 800 );
			netstream.Start( rf, "nChatY"..v[1], ply, arg );
			
			local name = ply:VisibleRPName();
			GAMEMODE:LogChat( "[G] " .. name .. ": " .. arg, ply );
			
		else
			
			if( !ply.VisibleRPName ) then return end
			
			local name = ply:VisibleRPName();
			
			if( !LocalPlayer():HasTrait( k ) ) then
				
				GAMEMODE:AddChat( { CB_ALL, CB_IC }, "CombineControl.ChatBigItalic", Color( 255, 167, 73, 255 ), name .. " yells something in " .. v[1] .. "." );
				
			else
				
				GAMEMODE:AddChat( { CB_ALL, CB_IC }, "CombineControl.ChatBig", Color( 255, 167, 73, 255 ), "[" .. v[1] .. ", Yell] " .. name .. ":" .. arg );
				
			end
			
		end
		
	end
	GM:AddChatCommand( v[2] .. "y", Color( 255, 167, 73, 255 ), CC[v[1] .. "Y"] );
	
	if( CLIENT ) then
		
		_G["nChatY" .. v[1]] = function( ply, str )
			
			CC[v[1] .. "Y"]( ply, str );
			
		end
		netstream.Hook( "nChatY" .. v[1], _G["nChatY" .. v[1]] );

	end
	
	CC[v[1] .. "W"] = function( ply, arg )
		
		if( string.len( arg ) == 0 ) then return end
		
		if( CLIENT and ply == LocalPlayer() and bit.band( ply:Trait(), k ) != k ) then
			
			GAMEMODE:AddChat( { CB_ALL, CB_IC }, "CombineControl.ChatNormal", Color( 200, 0, 0, 255 ), "You can't speak " .. v[1] .. "!" );
			return;
			
		end
		
		if( !ply:Alive() ) then
			
			if( CLIENT ) then
				
				GAMEMODE:AddChat( { CB_ALL, CB_IC }, "CombineControl.ChatNormal", Color( 200, 0, 0, 255 ), "You're dead. You can't talk." );
				
			end
			
			return;
			
		end
		
		if( ply:PassedOut() ) then
			
			if( CLIENT ) then
				
				GAMEMODE:AddChat( { CB_ALL, CB_IC }, "CombineControl.ChatNormal", Color( 200, 0, 0, 255 ), "You're unconscious. You can't talk." );
				
			end
			
			return;
			
		end
		
		if( SERVER ) then
			
			if( !ply:HasTrait( k ) ) then
				
				return;
				
			end
			
			local rf = ply:GetRF( 150, 0 );
			netstream.Start( rf, "nChatW"..v[1], ply, arg );
			
			local name = ply:VisibleRPName();
			GAMEMODE:LogChat( "[H] " .. name .. ": " .. arg, ply );
			
		else
			
			if( !ply.VisibleRPName ) then return end
			
			local name = ply:VisibleRPName();
			
			if( !LocalPlayer():HasTrait( k ) ) then
				
				GAMEMODE:AddChat( { CB_ALL, CB_IC }, "CombineControl.ChatSmallItalic", Color( 255, 167, 73, 255 ), name .. " whispers something in " .. v[1] .. "." );
				
			else
				
				GAMEMODE:AddChat( { CB_ALL, CB_IC }, "CombineControl.ChatSmall", Color( 255, 167, 73, 255 ), "[" .. v[1] .. ", Whisper] " .. name .. ":" .. arg );
				
			end
			
		end
		
	end
	GM:AddChatCommand( v[2] .. "w", Color( 255, 167, 73, 255 ), CC[v[1] .. "W"] );
	
	if( CLIENT ) then
		
		_G["nChatW" .. v[1]] = function( ply, str )
			
			CC[v[1] .. "W"]( ply, str );
			
		end
		netstream.Hook( "nChatW" .. v[1], _G["nChatW" .. v[1]] );

	end
	
	CC[v[1] .. "R"] = function( ply, arg, norad )
		
		if( string.len( arg ) == 0 ) then return end
		
		local can, channel, ent = CC.CanRadio( ply );
		
		if( CLIENT and ply == LocalPlayer() and bit.band( ply:Trait(), k ) != k ) then
			
			GAMEMODE:AddChat( { CB_ALL, CB_IC }, "CombineControl.ChatNormal", Color( 200, 0, 0, 255 ), "You can't speak " .. v[1] .. "!" );
			return;
			
		end
		
		if( CLIENT and ply == LocalPlayer() and !can ) then
			
			GAMEMODE:AddChat( { CB_ALL, CB_IC }, "CombineControl.ChatNormal", Color( 200, 0, 0, 255 ), "You need a radio for this." );
			return;
			
		end
		
		if( !ply:Alive() ) then
			
			if( CLIENT ) then
				
				GAMEMODE:AddChat( { CB_ALL, CB_IC }, "CombineControl.ChatNormal", Color( 200, 0, 0, 255 ), "You're dead. You can't talk." );
				
			end
			
			return;
			
		end
		
		if( ply:PassedOut() ) then
			
			if( CLIENT ) then
				
				GAMEMODE:AddChat( { CB_ALL, CB_IC }, "CombineControl.ChatNormal", Color( 200, 0, 0, 255 ), "You're unconscious. You can't talk." );
				
			end
			
			return;
			
		end
		
		if( SERVER ) then
		
			if( !can ) then
				
				return;
				
			end
			
			if( !ply:HasTrait( k ) ) then
				
				return;
				
			end
			
			if( !ent ) then
				
				local rf = ply:GetRF( 400, 150 );
				netstream.Start( rf, "nChatRSurround"..v[1], ply, arg );
				
				local rf = { };
				
				for _, v in pairs( player.GetAll() ) do
					
					if( channel == v:RadioFreq() and ply != v and v:HasItem( "radio" ) ) then
						
						table.insert( rf, v );
						
					end
					
				end
				
				netstream.Start( rf, "nChatR"..v[1], ply, arg );
				
				local rf = { };
				
				for _, v in pairs( ents.FindByClass( "cc_radio" ) ) do
					
					if( channel == v:GetChannel() ) then
						
						for _, n in pairs( player.GetAll() ) do
							
							local dist = 400;
							
							if( !n:CanHear( v ) ) then
								
								dist = 150;
								
							end
							
							if( n:GetPos():Distance( v:GetPos() ) < dist ) then
								
								table.insert( rf, n );
								
							end
							
						end
						
					end
					
				end
				
				netstream.Start( rf, "nChatR"..v[1], ply, arg );
				
			else
				
				local rf = { };
				
				for _, v in pairs( player.GetAll() ) do
					
					if( channel == v:RadioFreq() and ply != v and v:HasItem( "radio" ) ) then
						
						table.insert( rf, v );
						
					end
					
				end

				netstream.Start( rf, "nChatR"..v[1], ply, arg );
				
				local rf = { };
				
				for _, v in pairs( ents.FindByClass( "cc_radio" ) ) do
					
					if( channel == v:GetChannel() ) then
						
						for _, n in pairs( player.GetAll() ) do
							
							local dist = 400;
							
							if( !n:CanHear( v ) ) then
								
								dist = 150;
								
							end
							
							if( n:GetPos():Distance( v:GetPos() ) < dist ) then
								
								table.insert( rf, n );
								
							end
							
						end
						
					end
					
				end

				netstream.Start( rf, "nChatR"..v[1], ply, arg );
				
			end
			
			local name = ply:VisibleRPName();
			GAMEMODE:LogChat( "[R] (" .. tostring( channel ) .. ") " .. name .. ": " .. arg, ply );
			
		else
			
			if( !ply.VisibleRPName ) then return end
			
			local name = ply:VisibleRPName();
			
			if( norad ) then
			
				if( !ent ) then

					if( !LocalPlayer():HasTrait( k ) ) then
						
						GAMEMODE:AddChat( { CB_ALL, CB_IC }, "CombineControl.ChatNormalItalic", Color( 255, 167, 73, 255 ), name .. " says something in " .. v[1] .. "." );
						
					else
						
						GAMEMODE:AddChat( { CB_ALL, CB_IC }, "CombineControl.ChatNormal", Color( 255, 167, 73, 255 ), "[" .. v[1] .. "] " .. name .. ":" .. arg );
						
					end
					
				end
				
			else
				
				if( ( ply == LocalPlayer() and !ent ) or ply != LocalPlayer() ) then
			
					if( !LocalPlayer():HasTrait( k ) ) then
						
						GAMEMODE:AddChat( { CB_ALL, CB_IC, CB_RADIO }, "CombineControl.ChatRadio", Color( 160, 160, 160, 255 ), "[Radio] " .. name .. " says something in "..v[1].."." );
						
					else
						
						GAMEMODE:AddChat( { CB_ALL, CB_IC, CB_RADIO }, "CombineControl.ChatRadio", Color( 255, 167, 73, 255 ), "[Radio - " .. v[1] .. "] " .. name .. ":" .. arg );
						
					end
					
				end
				
			end
			
		end
		
	end
	GM:AddChatCommand( v[2] .. "r", Color( 160, 160, 160, 255 ), CC[v[1] .. "R"] );
	
	if( CLIENT ) then
		
		_G["nChatR" .. v[1]] = function( ply, str )
			
			CC[v[1] .. "R"]( ply, str );
			
		end
		netstream.Hook( "nChatR" .. v[1], _G["nChatR" .. v[1]] );
		
		_G["nChatRSurround"..v[1]] = function( ply, str )
		
			CC[v[1] .. "R"]( ply, str, true );
		
		end
		netstream.Hook( "nChatRSurround"..v[1], _G["nChatRSurround"..v[1]] );

	end
	
end