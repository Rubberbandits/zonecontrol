MsgC( Color( 200, 200, 200, 255 ), "Loading serverside...\n" );

GM.FullyLoaded = GM.FullyLoaded or false;

AddCSLuaFile("utils/include.lua")
include("utils/include.lua")

includes.directory("utils")
includes.directory("core/server")

include( "config/sv_config.lua" )
include( "shared.lua" );

local buttons = {
	[2605] = true,
	[2663] = true,
	[2492] = true,
	[2662] = true,
}

function GM:Initialize()
	game.ConsoleCommand( "net_maxfilesize 64\n" );
	game.ConsoleCommand( "sv_kickerrornum 0\n" );
	
	game.ConsoleCommand( "sv_allowupload 0\n" );
	game.ConsoleCommand( "sv_allowdownload 0\n" );
	game.ConsoleCommand( "pac_restrictions 1\n" );
	game.ConsoleCommand( "mp_falldamage 1\n" );

	game.ConsoleCommand( "sv_tfa_cmenu 0\n" );
	game.ConsoleCommand( "sv_tfa_default_clip 0\n" );
	game.ConsoleCommand( "sv_tfa_jamming_factor_inc 0.5\n" );
	game.ConsoleCommand( "sv_tfa_jamming_mult 0.6\n" );
	game.ConsoleCommand( "sv_tfa_penetration_hitmarker 0\n" );
	game.ConsoleCommand( "sv_tfa_damage_multiplier 1\n" );
	game.ConsoleCommand( "sv_tfa_damage_mult_min 1\n" );
	game.ConsoleCommand( "sv_tfa_damage_mult_max 1\n" );
	
	if( game.IsDedicated() and !self.PrivateMode ) then
		
		game.ConsoleCommand( "sv_allowcslua 0\n" );
		
	else
		
		game.ConsoleCommand( "sv_allowcslua 1\n" );
		
	end
	
	hook.Run("SetupDataDirectories")
	
	for k,v in next, buttons do
		local ent = ents.GetMapCreatedEntity(k)
		if !ent then return end
		ent:Fire("lock")
	end

	resource.AddSingleFile( "maps/" .. game.GetMap() .. ".bsp" );
end

GM.FullyLoaded = true;

MsgC( Color( 200, 200, 200, 255 ), "Serverside loaded.\n" );