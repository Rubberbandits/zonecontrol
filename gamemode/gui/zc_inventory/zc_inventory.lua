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
	self.InventoryBack:Receiver("zc_item", function(slot, dropped, has_dropped, index, x, y)
		local dragged_pnl = dropped[1]
		if has_dropped then
			local dropped_item = dragged_pnl.Item
			
			GAMEMODE.Inventory:PopulateItems()
		end
	end)
	
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
	self.EquipBack:Receiver("zc_item", function(slot, dropped, has_dropped, index, x, y)
		local dragged_pnl = dropped[1]
		if has_dropped then
			local dropped_item = dragged_pnl.Item
			
			GAMEMODE.Inventory:PopulateItems()
		end
	end)
	self.EquipBack:Receiver("zc_quickslot", function(slot, dropped, has_dropped, index, x, y)
		local dragged_pnl = dropped[1]
		if has_dropped then
			dragged_pnl:ClearBoundItem()
		end
	end)
	self:PopulateEquipMenu()
	
	self.QuickSlot1 = vgui.Create("zc_quickslot", self.EquipBack)
	self.QuickSlot1:SetSize(ScreenScaleH(50), ScreenScaleH(40))
	self.QuickSlot1:SetPos(ScreenScaleH(10), self.EquipBack:GetTall() - self.EquipBack:GetTall() / 2.07)
	self.QuickSlot1:SetBind(1)
	
	self.QuickSlot2 = vgui.Create("zc_quickslot", self.EquipBack)
	self.QuickSlot2:SetSize(ScreenScaleH(50), ScreenScaleH(40))
	self.QuickSlot2:SetPos(ScreenScaleH(63), self.EquipBack:GetTall() - self.EquipBack:GetTall() / 2.07)
	self.QuickSlot2:SetBind(2)
	
	self.QuickSlot3 = vgui.Create("zc_quickslot", self.EquipBack)
	self.QuickSlot3:SetSize(ScreenScaleH(50), ScreenScaleH(40))
	self.QuickSlot3:SetPos(ScreenScaleH(117), self.EquipBack:GetTall() - self.EquipBack:GetTall() / 2.07)
	self.QuickSlot3:SetBind(3)
	
	self.QuickSlot4 = vgui.Create("zc_quickslot", self.EquipBack)
	self.QuickSlot4:SetSize(ScreenScaleH(50), ScreenScaleH(40))
	self.QuickSlot4:SetPos(ScreenScaleH(171), self.EquipBack:GetTall() - self.EquipBack:GetTall() / 2.07)
	self.QuickSlot4:SetBind(4)
	
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
	
	for k,v in next, self.EquipBack:GetChildren() do
		if v.BoundItem and !v.BoundItem.IsItem then
			v:ClearBoundItem()
		end
	end

	local occupied_slots = {}
	for id,item in next, LocalPlayer().Inventory do
		local slot
		local size_w, size_h
		local parent
		local pos_x
		local pos_y
		
		if item.HasEquipSlot and item:GetVar("Equipped", false) then
			for k,v in next, self.EquipBack:GetChildren() do
				if v.ItemBase == item.Base and !occupied_slots[v] then
					slot = v
					break
				end
			end
			if item.TertiarySlot then
				slot = self.EquipBack.weapon3
			end
			size_w = slot:GetWide()
			size_h = slot:GetTall()
			pos_x = 0
			pos_y = 0
			parent = slot
			occupied_slots[slot] = true
		else
			slot = self.InventoryScroll.Grid[item.y][item.x]
			size_w = slot:GetWide() * item.W
			size_h = slot:GetTall() * item.H
			pos_x, pos_y = slot:GetPos()
			parent = self.InventoryScroll
		end
		
		local item_pnl = vgui.Create("zc_item", parent)
		item_pnl.Item = item
		item_pnl:SetSize(size_w, size_h)
		item_pnl:SetPos(pos_x, pos_y)
		item_pnl:SetModel(item:GetModel())
	
		if item.GetBodygroupCategory then
			item_pnl.Entity:SetBodygroup(item:GetBodygroupCategory(), item:GetBodygroup())
		end
		
		if item.Base == "clothes" then
			local submats = item:GetItemSubmaterials()
			if submats then
				for m,n in next, submats do
					item_pnl.Entity:SetSubMaterial(n[1], n[2])
				end
			end
		else
			if item.ItemSubmaterials then
				for m,n in next, item.ItemSubmaterials do
					item_pnl.Entity:SetSubMaterial(n[1], n[2])
				end
			end
		end
		
		self.InventoryScroll.Items[#self.InventoryScroll.Items + 1] = item_pnl
	end
end

function PANEL:PopulateEquipMenu()
	local pnl = self.EquipBack
	
	pnl.clothes = vgui.Create("zc_slot", pnl)
	pnl.clothes:SetSize(ScreenScaleH(72), ScreenScaleH(112))
	pnl.clothes:SetPos(ScreenScaleH(79), ScreenScaleH(68))
	pnl.clothes:CreateEquipSlot("clothes")
	pnl.clothes.ItemBase = "clothes"
	
	for i = 1, 5 do
		pnl["artifact"..i] = vgui.Create("zc_slot", pnl)
		pnl["artifact"..i]:SetSize(ScreenScaleH(38), ScreenScaleH(38))
		pnl["artifact"..i]:SetPos(ScreenScaleH(10) + (ScreenScaleH(43.2) * i) - ScreenScaleH(43.2), pnl:GetTall() - pnl:GetTall() / 2.6)
		pnl["artifact"..i]:CreateEquipSlot("artifact")
		pnl["artifact"..i].ItemBase = "artifact"
		pnl["artifact"..i].SlotNumber = i
	end
	
	pnl.weapon1 = vgui.Create("zc_slot", pnl)
	pnl.weapon1:SetSize(ScreenScaleH(62), ScreenScaleH(190))
	pnl.weapon1:SetPos(ScreenScaleH(10), ScreenScaleH(8))
	pnl.weapon1:CreateEquipSlot("weapon")
	pnl.weapon1.ItemBase = "weapon"
	pnl.weapon1.SlotNumber = 1
	
	pnl.weapon2 = vgui.Create("zc_slot", pnl)
	pnl.weapon2:SetSize(ScreenScaleH(62), ScreenScaleH(190))
	pnl.weapon2:SetPos(pnl:GetWide() - ScreenScaleH(62) - ScreenScaleH(10), ScreenScaleH(8))
	pnl.weapon2:CreateEquipSlot("weapon")
	pnl.weapon2.ItemBase = "weapon"
	pnl.weapon2.SlotNumber = 2
	
	pnl.weapon3 = vgui.Create("zc_slot", pnl)
	pnl.weapon3:SetSize(ScreenScaleH(64), ScreenScaleH(37))
	pnl.weapon3:SetPos(ScreenScaleH(10), ScreenScaleH(204))
	pnl.weapon3.TertiarySlot = true
	pnl.weapon3:Receiver("zc_item", function(slot, dropped, has_dropped, index, x, y)
		local dragged_pnl = dropped[1]
		if has_dropped then
			local dropped_item = dragged_pnl.Item
			
			if dropped_item.Base != "weapon" or !dropped_item.TertiarySlot then GAMEMODE.Inventory:PopulateItems() return end
			
			dropped_item:CallFunction("Equip", true)
			
			GAMEMODE.Inventory:PopulateItems()
		end
	end)
	function pnl.weapon3:Paint()
	
	end

	pnl.detector = vgui.Create("zc_slot", pnl)
	pnl.detector:SetSize(ScreenScaleH(62), ScreenScaleH(36))
	pnl.detector:SetPos(pnl:GetWide() - ScreenScaleH(62) - ScreenScaleH(10), ScreenScaleH(204))
	pnl.detector:CreateEquipSlot("detector")
	pnl.detector.ItemBase = "detector"
	
	pnl.backpack = vgui.Create("zc_slot", pnl)
	pnl.backpack:SetSize(ScreenScaleH(72), ScreenScaleH(56))
	pnl.backpack:SetPos(ScreenScaleH(79), ScreenScaleH(186))
	pnl.backpack:CreateEquipSlot("backpack")
	pnl.backpack.ItemBase = "backpack"
end

function PANEL:Paint(w, h)

end

function PANEL:Think()
	if input.IsKeyDown(KEY_F3) and !self.LastKeyState and self.HasOpened then
		self:Close()
	end
	
	self.LastKeyState = input.IsKeyDown(KEY_F3)
	if !self.HasOpened then
		self.HasOpened = true
	end
end

vgui.Register("zc_inventory", PANEL, "DFrame")