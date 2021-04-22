BASE.W = 1
BASE.H = 2
BASE.Vars = {
	Equipped = false,
}
BASE.DetectorType = DETECTOR_ECHO;
BASE.HasEquipSlot = true
BASE.IsSellable = true
BASE.functions = {};
BASE.functions.Equip = {
	SelectionName = "Equip",
	OnUse = function( item )
		local metaitem = GAMEMODE:GetItemByID( item:GetClass() );
		
		if item.HasEquipSlot then
			item.x = -1
			item.y = -1
		end
		
		item:SetVar( "Equipped", true );
		
		if( CLIENT ) then
		
			local detector = vgui.Create("CCDetector")
			detector:SetSize(400, 600)
			detector:SetPos(ScrW() - (ScrW() / 4.571), ScrH() - (ScrH() / 1.49))
			detector:SetType(metaitem.DetectorType)
			GAMEMODE.Detector = detector
			
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
		
		return !item:GetVar( "Equipped", false );
	end,
}
BASE.functions.Unequip = {
	SelectionName = "Unequip",
	OnUse = function( item )

		local metaitem = GAMEMODE:GetItemByID( item:GetClass() );
	
		if( CLIENT ) then
	
			if( GAMEMODE.Detector and IsValid( GAMEMODE.Detector ) ) then
			
				GAMEMODE.Detector:Remove();
				GAMEMODE.Detector = nil;
				
			end
			
		end
		
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
function BASE:OnUnloadItem()
	if( GAMEMODE.Detector and IsValid( GAMEMODE.Detector ) ) then
		GAMEMODE.Detector:Remove();
		GAMEMODE.Detector = nil;
	end
end