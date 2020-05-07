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
			
			dropped_item.x = slot.inv_x
			dropped_item.y = slot.inv_y
			netstream.Start("ItemSetPos", dropped_item:GetID(), dropped_item.x, dropped_item.y)
			
			GAMEMODE.Inventory:PopulateItems()
		end
	end)
end

function PANEL:Paint(w, h)
	kingston.gui.FindFunc(self, "Paint", "GridSlot", w, h)
end

vgui.Register("zc_slot", PANEL, "DPanel")