UPGRADE.Name = "Weapon Upgrade Base";
UPGRADE.Desc = "";
-- item this upgrade is to be used on
UPGRADE.Item = "";
-- if you want to give an attachment based on an upgrade
UPGRADE.Attachment = "";

-- page to select upgrade icons from, 1-6
-- pages can be found in materials/kingston
UPGRADE.IconPage = 1;
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
-- UPGRADE.ReduceWeight
-- reduces weight of item, negative values can increase weight

-- UPGRADE.JamChanceModifier
-- subtracts JamChanceModifier from base JamChance of weapon item.

-- UPGRADE.ReduceSpread
-- UPGRADE.ReduceRecoilUp
-- UPGRADE.ReduceRecoilHorizontal
-- min value for all of these is 0.001, so keep the amount you reduce low! 0.001 is a laser beam.

-- UPGRADE.AddRPM
-- Adds number to base RPM

-- UPGRADE.ChangeAmmoType
-- Changes weapon ammo type.

-- base CanUpgrade
function UPGRADE:CanUpgrade( item )
	if( self.RequiredItems ) then
		for _,requirement in next, self.RequiredItems do
			local Items = item:Owner():HasItem( requirement[1] )
			if( !Items or #Items < requirement[2] ) then return false end
		end
	end
	
	if( self.Incompatible ) then
		local CurrentUpgrades = item:GetVar( "Upgrades", {} )
		for _,upgrade in next, self.Incompatible do
			local bHasUpgrade = CurrentUpgrades[upgrade]
			if( bHasUpgrade ) then return false end
		end
	end
	
	if( self.RequiredUpgrades ) then
		local CurrentUpgrades = item:GetVar( "Upgrades", {} )
		local bHasUpgrade
		for k,v in next, CurrentUpgrades do
			if self.RequiredUpgrades[k] then
				bHasUpgrade = true
			end
		end

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
				for i=1, requirement[2] do
					local item = Items[i]
					item:RemoveItem()
				end
				
				if( CLIENT ) then
					
				end
			end
		end
	end
	
	if( SERVER ) then
		if self.Attachment then
			if item:GetVar("Equipped", false) then
				local weapon = item:Owner():GetWeapon( item.WeaponClass )
				local szAttachment = self.Attachment
				weapon:Attach( szAttachment )
			end
		end
	end
end