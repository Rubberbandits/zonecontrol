BASE.Name =  "Backpack Base";
BASE.Desc =  "";
BASE.Weight =  1;
BASE.W = 1;
BASE.H = 1;
BASE.CarryAdd =  0;
BASE.HasEquipSlot = true
BASE.IsSellable = true
BASE.functions = {}
BASE.functions.Equip = {
	SelectionName = "Equip",
	OnUse = function( item )
		local metaitem = GAMEMODE:GetItemByID( item:GetClass() );
		
		if item.HasEquipSlot then
			item.x = -1
			item.y = -1
		end

		item:SetVar( "Equipped", true );
		
		if SERVER then
			hook.Run("UpdateEncumberance", item:Owner(), item)
		end
		
		return true
	end,
	CanRun = function( item )
		for k,v in next, item:Owner().Inventory do
			if v == item then continue end
			if v.Base == item.Base and v:GetVar("Equipped", false) then
				return false
			end
		end
		
		return !item:GetVar("Equipped", false);
	end,
}
BASE.functions.Unequip = {
	SelectionName = "Unequip",
	OnUse = function( item )
		local metaitem = GAMEMODE:GetItemByID( item:GetClass() );
		
		if item.HasEquipSlot then
			local x, y = item:FindBestPosition()
			
			item.x = x
			item.y = y
		end
		
		item:SetVar( "Equipped", false );
		
		if SERVER then
			hook.Run("UpdateEncumberance", item:Owner(), item)
		end
		
		return true
	end,
	CanRun = function( item )
		return item:GetVar( "Equipped", false );
	end,
}

function BASE:GetCarryWeight()
	return (self:GetVar("Equipped", false) and self.CarryAdd) or 0
end