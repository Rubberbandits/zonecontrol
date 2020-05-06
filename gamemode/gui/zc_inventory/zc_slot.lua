local PANEL = {}

function PANEL:Init()

end

function PANEL:Paint()
	surface.SetDrawColor(255,0,0)
	surface.DrawOutlinedRect(0,0,w,h)
end

vgui.Register("zc_slot", PANEL, "DPanel")