local PANEL = {};

function PANEL:Init()

	self:SetText( "" );

end

function PANEL:DoClick()

	-- parent is TechMenu.Container
	local ItemObj = self.CurrentItem;
	print(ItemObj)
	if( ItemObj ) then
	
		local upgrade = GAMEMODE.Upgrades[self.UpgradeID];
		print(upgrade.CanUpgrade( upgrade, ItemObj ))
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
	
	if self.UpgradeID then
		local required_items = {}
		local upgrade = GAMEMODE.Upgrades[self.UpgradeID]
		if upgrade and upgrade.RequiredItems then
			for k,v in next, upgrade.RequiredItems do
				required_items[v[1]] = (LocalPlayer():HasItem(v[1]) and true) or false
			end
			
			self.RequiredItems = required_items
		end
	end

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