BASE.W = 1
BASE.H = 1
BASE.Vars = {
	Equipped = false,
};
BASE.Tier = 1;
BASE.Artifact = true;
BASE.HasEquipSlot = true
BASE.functions = {};
BASE.functions.Equip = {
	SelectionName = "Equip",
	OnUse = function( item )
	
		if item.HasEquipSlot then
			item.x = -1
			item.y = -1
		end

		item:SetVar( "Equipped", true );
		
		return true
		
	end,
	CanRun = function(item)
		local consumed_slots = 0
		local suit
		for k,v in next, item:Owner().Inventory do
			if v.Base == "artifact" and v:GetVar("Equipped", false) then
				consumed_slots = consumed_slots + 1
			elseif v.Base == "clothes" and v:GetVar("Equipped", false) then
				suit = v
			end
		end
		
		if !suit then return false end
	
		return !item:GetVar("Equipped", false) and consumed_slots < suit:GetArtifactSlots()
	end,
}
BASE.functions.Unequip = {
	SelectionName = "Unequip",
	OnUse = function( item )
	
		if item.HasEquipSlot then
			local x, y = item:FindBestPosition()
			
			item.x = x
			item.y = y
		end
	
		item:SetVar( "Equipped", false );
		return true
		
	end,
	CanRun = function( item )
	
		return item:GetVar( "Equipped", false );
		
	end,
}
function BASE:Initialize()

	if( self:GetVar( "Equipped", false ) ) then
		
		self.functions.Equip.OnUse( self );
	
	end

end
function BASE:CanDrop()

	return !self:GetVar( "Equipped", false );
	
end
function BASE:CanPickup( ply, ent )

	if( ent:GetNoDraw() ) then
	
		return false;
		
	end
	
	return true;

end
function BASE:CanSell()
	return true
end
function BASE:GetSellPrice()
	return self.BulkPrice / 5
end
function BASE:GetArmorValues()
	return self.ArmorValues or {}
end
function BASE:GetCarryWeight()
	return (self:GetVar("Equipped", false) and self.CarryAdd) or 0
end