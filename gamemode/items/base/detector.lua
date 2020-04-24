BASE.Vars = {
	Equipped = false,
}
BASE.DetectorType = DETECTOR_ECHO;
BASE.functions = {};
BASE.functions.Equip = {
	SelectionName = "Equip",
	OnUse = function( item )
	
		local metaitem = GAMEMODE:GetItemByID( item:GetClass() );
		item:SetVar( "Equipped", true );
		
		if( CLIENT ) then
		
			local detector = vgui.Create("CCDetector")
			detector:SetSize(400, 600)
			detector:SetPos(ScrW() - 350, ScrH() - 600)
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