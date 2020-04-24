MsgC( Color( 200, 200, 200, 255 ), "Loading clientside...\n" );

GM.FullyLoaded = GM.FullyLoaded or false;

if( !CCP ) then
	
	CCP = { }; -- CombineControl Panels.
	
end

include( "sh_enum.lua" );

include( "config/sh_config.lua" );

include( "shared.lua" );
include( "pon.lua" );
include( "netstream2.lua" );
include( "gui_helper.lua" );
include( "utf8.lua" );
include( "markup.lua" );

include( "meta/sh_item.lua" );
include( "cl_items.lua" );
include( "sh_admin.lua" );
include( "sh_animation.lua" );
include( "sh_chat.lua" );
include( "sh_consciousness.lua" );
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
include( "cl_admin.lua" );
include( "cl_adminmenu.lua" );
include( "cl_binds.lua" );
include( "cl_charcreate.lua" );
include( "cl_chat.lua" );
include( "cl_context.lua" );
include( "cl_dev.lua" );
include( "cl_drugs.lua" );
include( "cl_help.lua" );
include( "cl_hud.lua" );
include( "cl_map.lua" );
include( "cl_music.lua" );
include( "cl_names.lua" );
include( "cl_playermenu.lua" );
include( "cl_scoreboard.lua" );
include( "cl_think.lua" );
include( "cl_weaponselect.lua" );
include( "cl_blowout.lua" );
include( "cl_bonemerge.lua" );
include( "cl_geiger.lua" );

include( "gui/skin.lua" );
include( "gui/ccarea.lua" );
include( "gui/cccamera.lua" );
include( "gui/ccchat.lua" );
include( "gui/ccframe.lua" );
include( "gui/cclabel.lua" );
include( "gui/ccdetector.lua" )
include( "gui/ccprogbar.lua" );
include( "gui/cctree.lua" );
include( "gui/cctree_node.lua" );
include( "gui/cctree_node_button.lua" );
include( "gui/ccnotification.lua" );
include( "gui/ccattachmentmenu.lua" );
include( "gui/ccmaintainmenu.lua" );
include( "gui/cctechmenu.lua" );
include( "gui/ccupgrade_button.lua" );
include( "gui/ccweapon_display.lua" );
include( "gui/ccbdumenu.lua" );
include( "gui/ccitem_creator.lua" );
include( "gui/cccharpanel.lua" ); 

include( "ctp/cl_ctp.lua" );

GM.ParticleSystems = {
	"st_elmos_fire",
	"electrical_arc_01_system",
	"pfx_fruit_punch",
	"pfx_fruit_punch_pop",
	"hunter_shield_impact2",
	"warp_shield_impact",
	"striderbuster_shotdown_core_flash",
	"acid",
	"electrical_arc_01",
	"burner",
	"vortex_inactive",
	"vortex_armed",
	"vortex_repulse",
	"vortex_repulse_bloody",
}

GM.ParticleFiles = {
	"particles/electrical_fx.pcf",
	"particles/stalker_fx.pcf",
	"particles/hunter_shield_impact.pcf",
	"particles/warpshield.pcf",
	"particles/acid.pcf",
	"particles/burner.pcf",
	"particles/vortex.pcf",
}

_G.oldVGUICreate = _G.oldVGUICreate or vgui.Create -- lol
_G.vguiElements = _G.vguiElements or {}

function vgui.Create(...)
	local pnl = oldVGUICreate(...)
	table.insert(vguiElements, pnl)
	return pnl;
end

local cursor = Material("kingston/cursor")

function GM:CreateCursor()
	function hideCursor()
		for _, pnl in next, vguiElements do
			if pnl and pnl:IsValid() then
				pnl:SetCursor("blank")
			end
		end
	end
	hook.Add("Think", "STALKER.HideCursor", hideCursor)
	
	hook.Add("PostRenderVGUI", "STALKER.Cursor", function()
		if vgui.CursorVisible() and !gui.IsGameUIVisible() and system.HasFocus() then
			local x,y = input.GetCursorPos()
			
			surface.SetDrawColor(255, 255, 255, 255)
			surface.SetMaterial(cursor)
			surface.DrawTexturedRectUV(x, y, 48, 48, 0, 0, 0.65, 0.65)
		end
	end)
	
	local overlay = vgui.Create("DPanel") 
	overlay:SetSize(ScrW(), ScrH()) 
	overlay.Paint = function() end
	_G.CursorOverlay = overlay
end

function GM:DisableCursor()
	hook.Remove("Think", "STALKER.HideCursor")
	hook.Remove("PostRenderVGUI", "STALKER.Cursor")
	
	for _, pnl in next, vguiElements do
		if pnl and pnl:IsValid() then
			pnl:SetCursor("arrow")
		end
	end
	
	_G.CursorOverlay:Remove()
end

if cookie.GetNumber("zc_cursor", 0) == 1 then
	GM:CreateCursor()
end

function GM:Initialize()
	
	RunConsoleCommand( "cl_showhints", "0" );
	RunConsoleCommand( "gmod_mcore_test", "1" );
	RunConsoleCommand( "con_filter_enable", "1" );
	RunConsoleCommand( "con_filter_text_out", "Model '(null)' doesn't have attachment '' to attach particle system" );

	for k,v in next, self.ParticleFiles do
	
		game.AddParticles( v );
	
	end
	
	for k,v in next, self.ParticleSystems do
	
		PrecacheParticleSystem( v );
	
	end
	
end

function GM:InitPostEntity()
	
	netstream.Start( "nRequestPData" );
	netstream.Start( "RetrieveDummyItems" );
	if cookie.GetNumber( "zc_thirdperson", 0 ) == 1 then
	
		ctp:Enable();
	
	end
	
end

local meta = FindMetaTable( "Player" );

function meta:GetCharFromID( id )

	for _, v in pairs( GAMEMODE.Characters ) do
		
		if( tonumber( v.id ) == id ) then
			
			return v;
			
		end
		
	end
	
end

netstream.Hook( "nPDANameTaken", function()

	LocalPlayer():Notify(nil, COLOR_ERR, "This PDA name is taken.")

end );

game.AddParticles( "particles/hunter_shield_impact.pcf" )
game.AddParticles( "particles/warpshield.pcf" )
game.AddParticles( "particles/advisor.pcf" )
game.AddParticles( "particles/steampuff.pcf" )

GM.FullyLoaded = true;

MsgC( Color( 200, 200, 200, 255 ), "Clientside loaded.\n" );