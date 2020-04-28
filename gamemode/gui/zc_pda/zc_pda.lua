local PANEL = {}

function PANEL:Init()
	self:SetSize(ScrW() / 1.3, ScrH())
	self:Center()
	self:SetTitle("")
	self:MakePopup()
	self:SetSkin("zc_pda")
	
	self.Header = vgui.Create("zc_pda_header", self)
	self.Header:SetPos(ScreenScaleH(8), ScreenScaleH(8))
	self.Header:SetSize(self:GetWide() - ScreenScaleH(8), ScreenScaleH(32))
	
	self.Body = vgui.Create("zc_pda_body", self)
	self.Body:SetPos(ScreenScaleH(8), ScreenScaleH(48))
	self.Body:SetSize(self:GetWide() - ScreenScaleH(8), self:GetTall() - (ScreenScaleH(48) * 2))
end

function PANEL:Paint(w, h)
	kingston.gui.FindFunc(self, "Paint", "Main", w, h)
end

vgui.Register("zc_pda", PANEL, "DFrame")