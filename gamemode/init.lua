MsgC( Color( 200, 200, 200, 255 ), "Loading serverside...\n" );

GM.FullyLoaded = GM.FullyLoaded or false;

include( "sh_util.lua" );
include( "sh_enum.lua" );

include( "config/sv_config.lua" );
include( "config/sh_config.lua" );

include( "pon.lua" );
include( "netstream2.lua" );
include( "shared.lua" );

include( "meta/sh_item.lua" );
include( "sh_admin.lua" );
include( "sh_animation.lua" );
include( "sh_consciousness.lua" );
include( "sh_chat.lua" );
include( "sh_door.lua" );
include( "sh_entity.lua" );
include( "sh_inventory.lua" );
include( "sh_items.lua" );
include( "sh_flags.lua" );
include( "sh_map.lua" );
include( "sh_mapevents.lua" );
include( "sh_npc.lua" );
include( "sh_player.lua" );
include( "sh_playerclass.lua" );
include( "sh_reload.lua" );
include( "sh_sandbox.lua" );
include( "sh_weapons.lua" );
include( "sh_blowout.lua" );
include( "sh_logs.lua" );
include( "sh_command.lua" );

include( "sv_admin.lua" );
include( "sv_business.lua" );
include( "sv_charcreate.lua" );
include( "sv_context.lua" );
include( "sv_dev.lua" );
include( "sv_drugs.lua" );
include( "sv_logs.lua" );
include( "sv_net.lua" );
include( "sv_map.lua" );
include( "sv_paper.lua" );
include( "sv_player.lua" );
include( "sv_items.lua" );
include( "sv_resource.lua" );
include( "sv_security.lua" );
include( "sv_sockets.lua" );
include( "sv_sql.lua" );
include( "sv_think.lua" );
include( "sv_blowout.lua" );

include( "ctp/sv_ctp.lua" );

AddCSLuaFile( "cl_init.lua" );
AddCSLuaFile( "sh_util.lua" );
AddCSLuaFile( "sh_enum.lua" );
AddCSLuaFile( "shared.lua" );

AddCSLuaFile( "config/sh_config.lua" );

AddCSLuaFile( "pon.lua" )
AddCSLuaFile( "gui_helper.lua" );
AddCSLuaFile( "utf8.lua" );
AddCSLuaFile( "markup.lua" );

AddCSLuaFile( "meta/sh_item.lua" );
AddCSLuaFile( "sh_admin.lua" );
AddCSLuaFile( "sh_animation.lua" );
AddCSLuaFile( "sh_chat.lua" );
AddCSLuaFile( "sh_consciousness.lua" );
AddCSLuaFile( "sh_door.lua" );
AddCSLuaFile( "sh_entity.lua" );
AddCSLuaFile( "sh_inventory.lua" );
AddCSLuaFile( "sh_items.lua" );
AddCSLuaFile( "sh_flags.lua" );
AddCSLuaFile( "sh_map.lua" );
AddCSLuaFile( "sh_mapevents.lua" );
AddCSLuaFile( "sh_npc.lua" );
AddCSLuaFile( "sh_player.lua" );
AddCSLuaFile( "sh_playerclass.lua" );
AddCSLuaFile( "sh_reload.lua" );
AddCSLuaFile( "sh_sandbox.lua" );
AddCSLuaFile( "sh_weapons.lua" );
AddCSLuaFile( "sh_blowout.lua" );
AddCSLuaFile( "sh_logs.lua" );
AddCSLuaFile( "sh_command.lua" );

AddCSLuaFile( "cl_items.lua" );
AddCSLuaFile( "cl_admin.lua" );
AddCSLuaFile( "cl_adminmenu.lua" );
AddCSLuaFile( "cl_binds.lua" );
AddCSLuaFile( "cl_charcreate.lua" );
AddCSLuaFile( "cl_chat.lua" );
AddCSLuaFile( "cl_context.lua" );
AddCSLuaFile( "cl_dev.lua" );
AddCSLuaFile( "cl_drugs.lua" );
AddCSLuaFile( "cl_help.lua" );
AddCSLuaFile( "cl_hud.lua" );
AddCSLuaFile( "cl_map.lua" );
AddCSLuaFile( "cl_music.lua" );
AddCSLuaFile( "cl_names.lua" );
AddCSLuaFile( "cl_playermenu.lua" );
AddCSLuaFile( "cl_scoreboard.lua" );
AddCSLuaFile( "cl_think.lua" );
AddCSLuaFile( "cl_weaponselect.lua" );
AddCSLuaFile( "cl_blowout.lua" );
AddCSLuaFile( "cl_bonemerge.lua" );
AddCSLuaFile( "cl_geiger.lua" );
AddCSLuaFile( "cl_logs.lua" );

AddCSLuaFile( "ctp/cl_ctp.lua" );

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
	game.ConsoleCommand( "sv_tfa_jamming_factor_inc 0\n" ); -- since we are doing it via the durability of the item
	
	if( game.IsDedicated() and !self.PrivateMode ) then
		
		game.ConsoleCommand( "sv_allowcslua 0\n" );
		
	else
		
		game.ConsoleCommand( "sv_allowcslua 1\n" );
		
	end
	
	self:InitSQL();
	hook.Run("SetupDataDirectories")
	self:LoadBans();
	RetrieveStockpiles();
	
	for k,v in next, buttons do
		local ent = ents.GetMapCreatedEntity(k)
		if !ent then return end
		ent:Fire("lock")
	end
end

GM.FullyLoaded = true;

MsgC( Color( 200, 200, 200, 255 ), "Serverside loaded.\n" );