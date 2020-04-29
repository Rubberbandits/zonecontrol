local PANEL = {}

function PANEL:Init()
	self:SetSize(ScrW() / 1.3, ScrH())
	self:Center()
	self:SetTitle("")
	self:MakePopup()
	self:SetSkin("zc_pda")
	self.TabButtons = {}
	
	self.Header = vgui.Create("zc_pda_header", self)
	self.Header:SetPos(ScreenScaleH(16), ScreenScaleH(24))
	self.Header:SetSize(self:GetWide() - ScreenScaleH(32), ScreenScaleH(56))
	
	self.Body = vgui.Create("zc_pda_body", self)
	self.Body:SetPos(ScreenScaleH(16), ScreenScaleH(86))
	self.Body:SetSize(self:GetWide() - ScreenScaleH(32), self:GetTall() - (ScreenScaleH(64) * 2))
end

function PANEL:AddTab(title, func)
	local button = vgui.Create("DButton", self.Header)
	button.IsTabButton = true
	button:SetSize(ScreenScale(72), ScreenScale(12))
	button:SetFont("CombineControl.ChatNormal")
	button:SetText(title)
	
	local count = #self.TabButtons
	local side_w = ScreenScaleH(16)
	local left_x = ScreenScaleH(8)
	local right_w = ScreenScaleH(64)
	
	local left_w = self.Header:GetWide() - right_w - left_x - side_w * 2
	local left_w = left_w - (count*ScreenScaleH(76)) - ScreenScale(56) - (count*ScreenScale(8))
	
	button:SetPos(left_w, ScreenScaleH(12))
	button.DoClick = function(button)
		self.Body:Clear()
		
		for k,v in next, self.TabButtons do
			v.ActivePage = nil
		end
		
		func(self.Body)

		self.CurrentTab = button
		button.ActivePage = true
	end
	button:SetSkin("zc_pda")
	
	self.TabButtons[#self.TabButtons + 1] = button
end

function PANEL:Paint(w, h)
	kingston.gui.FindFunc(self, "Paint", "Main", w, h)
end

vgui.Register("zc_pda", PANEL, "DFrame")