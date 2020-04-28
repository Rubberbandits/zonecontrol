local PANEL = {}

function PANEL:Init()
	self:SetSkin("zc_pda")
end

function PANEL:Paint(w, h)
	kingston.gui.FindFunc(self, "Paint", "Header", w, h)
end

vgui.Register("zc_pda_header", PANEL, "DPanel")