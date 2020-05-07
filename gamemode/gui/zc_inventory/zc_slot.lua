local PANEL = {}

function PANEL:Init()
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
			if input.IsKeyDown(KEY_LCONTROL) and input.IsKeyDown(KEY_LSHIFT) then
				should_split = 3
			else
				if input.IsKeyDown(KEY_LSHIFT) then
					should_split = 1
				elseif input.IsKeyDown(KEY_LCONTROL) then
					should_split = 2
				end
			end
			
			if should_split and dropped_item:CanSplitStack() then
				if should_split == 1 then --split half
					netstream.Start("SplitStack", dropped_item:GetID(), nil, slot.inv_x, slot.inv_y)
				elseif should_split == 2 then --split one
					netstream.Start("SplitStack", dropped_item:GetID(), 1, slot.inv_x, slot.inv_y)
				elseif should_split == 3 then --dialog
				
				end
			else
				dropped_item.x = slot.inv_x
				dropped_item.y = slot.inv_y
				netstream.Start("ItemSetPos", dropped_item:GetID(), dropped_item.x, dropped_item.y)
			end
			
			GAMEMODE.Inventory:PopulateItems()
		end
	end)
end

function PANEL:Paint(w, h)
	kingston.gui.FindFunc(self, "Paint", "GridSlot", w, h)
end

vgui.Register("zc_slot", PANEL, "DPanel")