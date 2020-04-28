UPGRADE.Name = "Clothes Upgrade Base";
UPGRADE.Desc = "";
UPGRADE.Item = "";
UPGRADE.IconX = 1;
UPGRADE.IconY = 1;
-- UPGRADE.RequiredItems arguments
-- First value is item classname required
-- Second value is the amount of the item needed
-- Third value is ConsumeOnUse
UPGRADE.RequiredItems = {
	--{ "item_classname", 1, true },
};
-- Technical details about RequiredUpgrade:
-- Do not go further than 3 levels deep!
-- The menus simply aren't meant to handle it, and thus the upgrades will never be seen in the GUI.
-- They can technically exist.
--UPGRADE.RequiredUpgrade = "";
UPGRADE.Incompatible = {
	--"test_upgrade_2",
};
-- UPGRADE.ArmorValues
-- function and layout the same as suit version

-- UPGRADE.AddWalkSpeed, AddRunSpeed, AddCrouchSpeed, AddJumpHeight
-- These add the number straight onto the default run speed of the suit.

-- UPGRADE.ReduceWeight
-- reduces weight of item, negative values can increase weight

-- UPGRADE.ArtifactSlots
-- adds artifact slots

-- base CanUpgrade
function UPGRADE:CanUpgrade( item )
	if( self.RequiredItems ) then
		for _,requirement in next, self.RequiredItems do
			local Items = item:Owner():HasItem( requirement[1] )
			if !Items then return false end
			if Items.IsItem and requirement[2] > 1 then return false end
			if !Items.IsItem and #Items < requirement[2] then return false end
		end
	end
	
	if( self.Incompatible ) then
		local CurrentUpgrades = item:GetVar( "Upgrades", {} )
		for _,upgrade in next, self.Incompatible do
			local bHasUpgrade = CurrentUpgrades[upgrade]
			if( bHasUpgrade ) then return false end
		end
	end
	
	if( self.RequiredUpgrade ) then
		local CurrentUpgrades = item:GetVar( "Upgrades", {} )
		local bHasUpgrade = CurrentUpgrades[self.RequiredUpgrade]
		if( !bHasUpgrade ) then return false end
	end
	
	return true
end

-- This is a shared function.
function UPGRADE:OnUpgrade( item )
	local upgrades = item:GetVar( "Upgrades", {} )
	if( !upgrades[upgrade] ) then
		upgrades[self.ClassName] = true
		item:SetVar( "Upgrades", upgrades )
		
		if( self.RequiredItems ) then
			for _,requirement in next, self.RequiredItems do
				if( !requirement[3] ) then continue end
				
				local Items = item:Owner():HasItem( requirement[1] )
				if Items.IsItem then
					Items:RemoveItem()
				else
					for i=1, requirement[2] do
						local item = Items[i]
						item:RemoveItem()
					end
				end
			end
		end
	end
	
	if( SERVER ) then
		
	end
end