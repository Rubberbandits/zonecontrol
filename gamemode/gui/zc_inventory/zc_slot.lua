local PANEL = {}

function PANEL:Init()
	
	if self.SlotType then
		self:CreateEquipSlot(self.SlotType)
		
		return
	end
	
	self:SetSize(ScreenScaleH(29), ScreenScaleH(29))
	self:Receiver("zc_item", function(slot, dropped, has_dropped, index, x, y)
		local dragged_pnl = dropped[1]
		if has_dropped then
			local dropped_item = dragged_pnl.Item
			
			if LocalPlayer():IsInventorySlotOccupiedItem(slot.inv_x, slot.inv_y, dropped_item.W, dropped_item.H) then
				GAMEMODE.Inventory:PopulateItems()
				
				return
			end
			
			local should_split = false
			local old_x = dropped_item.x
			local old_y = dropped_item.y
			if (input.IsKeyDown(KEY_LCONTROL) and input.IsKeyDown(KEY_LSHIFT)) or index == 3 then
				should_split = 3
			else
				if input.IsKeyDown(KEY_LSHIFT) or index == 1 then
					should_split = 1
				elseif input.IsKeyDown(KEY_LCONTROL) or index == 2 then
					should_split = 2
				end
			end
			
			if should_split and dropped_item:CanSplitStack() then
				if should_split == 1 then --split half
					netstream.Start("SplitStack", dropped_item:GetID(), nil, slot.inv_x, slot.inv_y)
					dropped_item:SplitStack(nil, slot.inv_x, slot.inv_y)
				elseif should_split == 2 then --split one
					netstream.Start("SplitStack", dropped_item:GetID(), 1, slot.inv_x, slot.inv_y)
					dropped_item:SplitStack(1, slot.inv_x, slot.inv_y)
				elseif should_split == 3 then --dialog
					Derma_StringRequest(
						"Split Amount",
						"Specify amount to take from this stack.",
						"",
						function(text)
							netstream.Start("SplitStack", dropped_item:GetID(), tonumber(text), slot.inv_x, slot.inv_y)
							dropped_item:SplitStack(tonumber(text), slot.inv_x, slot.inv_y)
						end
					)
				end
			else
				if dropped_item.HasEquipSlot and dropped_item:GetVar("Equipped", false) then
					dropped_item:CallFunction("Unequip", true)
				end
			
				dropped_item.x = slot.inv_x
				dropped_item.y = slot.inv_y
				netstream.Start("ItemSetPos", dropped_item:GetID(), dropped_item.x, dropped_item.y)
			end
			
			GAMEMODE.Inventory:PopulateItems()
		end
	end, {"split one", "split half", "split amount"})
end

local SLOT_TYPES = {
	clothes = function(pnl)
		pnl:Receiver("zc_item", function(slot, dropped, has_dropped, index, x, y)
			local dragged_pnl = dropped[1]
			if has_dropped then
				local dropped_item = dragged_pnl.Item
				
				if dropped_item.Base != "clothes" then GAMEMODE.Inventory:PopulateItems() return end
				
				dropped_item:CallFunction("Equip", true)
				
				GAMEMODE.Inventory:PopulateItems()
			end
		end)
		function pnl:Paint()
		
		end
	end,
	weapon = function(pnl)
		pnl:Receiver("zc_item", function(slot, dropped, has_dropped, index, x, y)
			local dragged_pnl = dropped[1]
			if has_dropped then
				local dropped_item = dragged_pnl.Item
				
				if dropped_item.Base != "weapon" then GAMEMODE.Inventory:PopulateItems() return end
				
				dropped_item:CallFunction("Equip", true)
				
				GAMEMODE.Inventory:PopulateItems()
			end
		end)
		function pnl:Paint()
		
		end
	end,
	artifact = function(pnl)
		pnl:Receiver("zc_item", function(slot, dropped, has_dropped, index, x, y)
			local dragged_pnl = dropped[1]
			if has_dropped then
				local dropped_item = dragged_pnl.Item
				
				if dropped_item.Base != "artifact" then GAMEMODE.Inventory:PopulateItems() return end
				
				dropped_item:CallFunction("Equip", true)
				
				GAMEMODE.Inventory:PopulateItems()
			end
		end)
		function pnl:Paint(w,h)
			kingston.gui.FindFunc(self, "Paint", "ArtifactSlot", w, h)
		end
	end,
	detector = function(pnl)
		pnl:Receiver("zc_item", function(slot, dropped, has_dropped, index, x, y)
			local dragged_pnl = dropped[1]
			if has_dropped then
				local dropped_item = dragged_pnl.Item
				
				if dropped_item.Base != "detector" then GAMEMODE.Inventory:PopulateItems() return end
				
				dropped_item:CallFunction("Equip", true)
				
				GAMEMODE.Inventory:PopulateItems()
			end
		end)
		function pnl:Paint()
		
		end
	end,
	backpack = function(pnl)
		pnl:Receiver("zc_item", function(slot, dropped, has_dropped, index, x, y)
			local dragged_pnl = dropped[1]
			if has_dropped then
				local dropped_item = dragged_pnl.Item
				
				if dropped_item.Base != "backpack" then GAMEMODE.Inventory:PopulateItems() return end
				
				dropped_item:CallFunction("Equip", true)
				
				GAMEMODE.Inventory:PopulateItems()
			end
		end)
		function pnl:Paint()
		
		end
	end,
}

function PANEL:CreateEquipSlot(slot_type)
	if SLOT_TYPES[slot_type] then
		SLOT_TYPES[slot_type](self)
	end
end

function PANEL:Paint(w, h)
	kingston.gui.FindFunc(self, "Paint", "GridSlot", w, h)
end

vgui.Register("zc_slot", PANEL, "DPanel")