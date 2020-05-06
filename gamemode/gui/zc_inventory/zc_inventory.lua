local PANEL = {}

function PANEL:Init()
	GAMEMODE.Inventory = self; -- maybe use return value from vgui.Create instead
	
	self.w, self.h = ScrW(), ScrH()
	self.x, self.y = ScrW() / 2 - self.w / 2, ScrH() / 2 - self.h / 2
	
	self:SetSize(self.w, self.h)
	self:SetPos(self.x, self.y)
	self:SetTitle("")
	self:MakePopup()
	self:ShowCloseButton(false)
	self:SetAlpha(0)
	self:AlphaTo(255, 0.2, 0)
	self:SetDraggable(false)
	self:SetSkin("zc_inventory")

	self.InventoryBack = vgui.Create("DPanel", self)
	self.InventoryBack:SetSize(ScrW() / 3.7, ScrH())
	self.InventoryBack:SetPos(ScrW() / 1.575, 0)
	self.InventoryBack:SetSkin("StalkerSkin")
	function self.InventoryBack:Paint(w, h)
		kingston.gui.FindFunc(self, "Paint", "InventoryFrame", w, h)
		
		surface.SetFont("InventoryNameDisplay")
		
		local tW,tH = surface.GetTextSize(LocalPlayer():RPName())
		
		surface.SetTextColor(Color(216, 195, 177))
		surface.SetTextPos(self:GetWide() / 20, ScreenScaleH(16))
		surface.DrawText(LocalPlayer():RPName())
		
		surface.SetFont("InventoryNameDisplay")
		
		local tW,tH = surface.GetTextSize(LocalPlayer():Money().." RU")
		
		surface.SetTextColor(Color(255, 255, 255))
		surface.SetTextPos(self:GetWide() / 1.7 - tW - ScreenScaleH(4), ScreenScaleH(46))
		surface.DrawText(LocalPlayer():Money().." RU")
		
		surface.SetFont("InventoryWeight")
		
		surface.SetTextColor(Color(100, 100, 100, 175))
		surface.SetTextPos(self:GetWide() / 3.33, ScrH() / 1.042)
		surface.DrawText("Total weight:")
		
		local tW,tH = surface.GetTextSize("Total weight:")
		
		surface.SetTextColor(Color(255, 255, 255))
		surface.SetTextPos(self:GetWide() / 3.33 + tW + ScreenScaleH(2), ScrH() / 1.042)
		surface.DrawText(LocalPlayer():InventoryWeight().." kg")
		
		local tW,tH = surface.GetTextSize("Total weight: "..LocalPlayer():InventoryWeight().." kg")
		
		surface.SetTextColor(Color(100, 100, 100, 175))
		surface.SetTextPos(self:GetWide() / 3.33 + tW + ScreenScaleH(3), ScrH() / 1.042)
		surface.DrawText("(max "..LocalPlayer():InventoryMaxWeight().." kg)")
	end
	
	self.InventoryScroll = vgui.Create("DScrollPanel", self.InventoryBack)
	self.InventoryScroll:SetSize(ScrW() / 4.04, self.InventoryBack:GetTall() - (self.InventoryBack:GetTall() / 4.5))
	self.InventoryScroll:SetPos(ScreenScaleH(12), self.InventoryBack:GetTall() / 6.8)
	function self.InventoryScroll:Paint(w, h)
		surface.SetDrawColor(255,0,0)
		surface.DrawOutlinedRect(0,0,w,h)
	end
	self.InventoryScroll.Containers = {}
	
	self.EquipBack = vgui.Create("DPanel", self)
	self.EquipBack:SetSize(ScrW() / 3.7, ScrH())
	self.EquipBack:SetPos((ScrW() / 2) - ((ScrW() / 3.7) / 2), 0)
	function self.EquipBack:Paint(w, h)
		kingston.gui.FindFunc(self, "Paint", "EquipFrame", w, h)
	end
end

function PANEL:Paint(w, h)
	surface.SetDrawColor(255,0,0)
	surface.DrawOutlinedRect(0,0,w,h)
end

vgui.Register("zc_inventory", PANEL, "DFrame")