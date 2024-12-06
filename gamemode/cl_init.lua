MsgC(Color(200, 200, 200, 255), "Loading clientside...\n")

GM.FullyLoaded = GM.FullyLoaded or false;

function ScreenScaleH(size)
	return size * (ScrH() / 480.0)
end

include("utils/include.lua")

includes.directory("utils")
includes.directory("core/client", nil, "")

include("shared.lua")

function GM:InitPostEntity()
	netstream.Start( "nRequestPData" );
	netstream.Start( "RetrieveDummyItems" );
	if cookie.GetNumber( "zc_thirdperson", 0 ) == 1 then
	
		ctp:Enable();
	
	end

	net.Start("zcSendCustomPrices")
	net.SendToServer()

	//self:CreateItemTooltipPanel()
	
	_G.b_keyf7_pressed = true
end

hook.Add("Think", "STALKER.ScreenResolutionChange", function()
	if ScrW() != GAMEMODE.LastScrW or ScrH() != GAMEMODE.LastScrH then
		hook.Run("ScreenResolutionChanged")
	end
	
	GAMEMODE.LastScrW = ScrW()
	GAMEMODE.LastScrH = ScrH()
end)

GM.FullyLoaded = true

MsgC(Color(200, 200, 200, 255), "Clientside loaded.\n")