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
	self:Receiver("zc_item", function(pnl, dropped, has_dropped, index, x, y)
		local dragged_pnl = dropped[1]
		if has_dropped then
			local item = dragged_pnl.Item
			if !item:CanDrop() then return end
			
			netstream.Start("nDropItem", item:GetID())
			item:DropItem()
			
			self:PopulateItems()
		end
	end)

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
	end
	self.InventoryScroll.Grid = {}
	
	for y = 1, GAMEMODE.InventoryHeight do
		self.InventoryScroll.Grid[y] = {}
		for x = 1, GAMEMODE.InventoryWidth do
			local slot = vgui.Create("zc_slot", self.InventoryScroll)
			slot:SetPos((slot:GetWide() * x) - slot:GetWide(), (slot:GetTall() * y) - slot:GetTall())
			slot.inv_x = x
			slot.inv_y = y
			
			self.InventoryScroll.Grid[y][x] = slot
		end
	end
	self.InventoryScroll.Items = {}
	
	self.EquipBack = vgui.Create("DPanel", self)
	self.EquipBack:SetSize(ScrW() / 3.7, ScrH())
	self.EquipBack:SetPos((ScrW() / 2) - ((ScrW() / 3.7) / 2), 0)
	function self.EquipBack:Paint(w, h)
		kingston.gui.FindFunc(self, "Paint", "EquipFrame", w, h)
	end
	
	self.CloseButton = vgui.Create("DButton", self.EquipBack)
	self.CloseButton:SetSize(self.EquipBack:GetWide() - ScreenScaleH(16), ScreenScaleH(16))
	self.CloseButton:SetPos(ScreenScaleH(8), self.EquipBack:GetTall() - ScreenScaleH(20))
	self.CloseButton:SetFont("CombineControl.ChatBig")
	self.CloseButton:SetTextColor(Color(216, 195, 177))
	self.CloseButton:SetText("Close")
	self.CloseButton.LongButton = true
	self.CloseButton.DoClick = function(btn)
		self:Close()
	end
	
	self:PopulateItems()
end

function PANEL:PopulateItems()
	for _,pnl in next, self.InventoryScroll.Items do
		pnl:Remove()
	end

	for id,item in next, LocalPlayer().Inventory do
		local item_pnl = vgui.Create("zc_item", self.InventoryScroll)
		local slot = self.InventoryScroll.Grid[item.y][item.x]
		
		item_pnl:SetSize(slot:GetWide() * item.W, slot:GetTall() * item.H)
		item_pnl:SetPos(slot:GetPos())
		item_pnl:SetModel(item:GetModel())
		item_pnl.Item = item
		
		self.InventoryScroll.Items[#self.InventoryScroll.Items + 1] = item_pnl
	end
end

function PANEL:Paint(w, h)

end

vgui.Register("zc_inventory", PANEL, "DFrame")