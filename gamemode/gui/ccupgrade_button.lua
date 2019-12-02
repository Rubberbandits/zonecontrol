local PANEL = {};

function PANEL:Init()

	self:SetText( "" );

end

function PANEL:DoClick()

	-- parent is TechMenu.Container
	local ItemObj = self.CurrentItem;
	if( ItemObj ) then
	
		local upgrade = GAMEMODE.Upgrades[self.UpgradeID];
		if( upgrade.CanUpgrade( upgrade, ItemObj ) ) then

			upgrade.OnUpgrade( upgrade, ItemObj );
			netstream.Start( "RequestItemUpgrade", ItemObj:GetID(), self.UpgradeID );
			self.ItemHasUpgrade = true;
			GAMEMODE.TechMenu:SendToMenu( ItemObj ); -- ghetto refresh technique.
			
			-- loop through all upgrade buttons and update as upgrade circumstances change
			
		end
	
	end

end

-- since all the upgrades are a bunch of images stitched together in a single file.
function PANEL:SetUpgradeImage( nPage, nX, nY )

	self.nUpgradePage = nPage;
	self.nUpgradeX = nX;
	self.nUpgradeY = nY;

end

function PANEL:Paint( w, h )
	if !self.NoHover then
		if self:IsHovered() and !self.LastHovered then
			self.HoverStart = RealTime()
		end
		
		if self.HoverStart and self.HoverStart + 1 <= RealTime() then
			GAMEMODE.TooltipPanel = self
		end
		
		if !self:IsHovered() and self.LastHovered then
			self.HoverStart = nil
			GAMEMODE.TooltipPanel = nil
		end
	end

	kingston.gui.FindFunc( self, "Paint", "UpgradeButton", w, h );
	
	self.LastHovered = self:IsHovered()
end

vgui.Register( "CUpgradeButton", PANEL, "DButton" );