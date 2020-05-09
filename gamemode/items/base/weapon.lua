BASE.Vars = {
	Equipped = false,
	CurrentAttachments = {},
	Upgrades = {},
	Durability = 100,
	Clip1 = 0,
};
BASE.WeaponType = "primary";
BASE.DegradeRate = 0.5;
BASE.StartDurability = 100; -- would not recommend you modify, modify DegrateRate!
BASE.UseDurability = true;
BASE.SellDurability = 50;
BASE.W = 4
BASE.H = 2
BASE.HasEquipSlot = true
BASE.functions = {};
BASE.functions.Equip = {
	SelectionName = "Equip",
	OnUse = function( item )

		local MetaItem = GAMEMODE:GetItemByID( item:GetClass() );
		local weapon;
		
		if( item.UseDurability and item:GetVar( "Durability", 0 ) < 1 ) then
		
			if( SERVER ) then
			
				item:Owner():Notify( nil,Color(255,255,255), "This weapon is broken." );
				
			end
			
			return false;
			
		end
		
		if( SERVER ) then

			weapon = item:Owner():Give( item.WeaponClass );
			if !weapon or !IsValid(weapon) then return end
			if !item:GetVar("Equipped", false) then
				item:Owner():SelectWeapon(weapon:GetClass())
			end
			
			local upgrades = item:GetVar( "Upgrades", {} );
			for k,v in next, upgrades do
			
				GAMEMODE.Upgrades[k].OnUpgrade( GAMEMODE.Upgrades[k], item );
			
			end
		
			weapon:SetClip1(item:GetVar("Clip1", 0))
			weapon.JamChance = item:GetJamChance()
		
		end
		
		if item.HasEquipSlot then -- not cool men, but gotta.
			local new_x
			local new_y
			local occupied = item:Owner():IsInventorySlotOccupied(-1,-1)
			if occupied and occupied.Base == item.Base then
				local second_occupied = item:Owner()
				if second_occupied and second_occupied.Base == item.Base and item.IsTertiary then
					new_x = -3
					new_y = -3
				elseif !item.IsTertiary then
					new_x = -2
					new_y = -2
				end
			else
				new_x = -1
				new_y = -1
			end
			
			item.x = new_x
			item.y = new_y
		end
		
		item:SetVar( "Equipped", true );

		if( !item:Owner().EquippedWeapons ) then
		
			item:Owner().EquippedWeapons = {};
			
		end
		item:Owner().EquippedWeapons[item.WeaponClass] = item:GetID();
		
		return true
		
	end,
	CanRun = function( item )

		if item:Owner().EquippedWeapons and item:Owner().EquippedWeapons[item.WeaponClass] then
			return false
		end
		
		if item:GetVar("Durability",100) == 0 then
			return false
		end

		return !item:GetVar( "Equipped", false )
		
	end,
}
BASE.functions.Unequip = {
	SelectionName = "Unequip",
	OnUse = function(item)
		local MetaItem = GAMEMODE:GetItemByID( item:GetClass() );
		local weapon = item:Owner():GetWeapon( item.WeaponClass );
		
		if weapon and weapon:IsValid() then
			local new_durability = math.Clamp(item:GetVar("Durability",100) - (item.DegradeRate * weapon:GetNW2Int("TimesFired", 0)), 0, item:GetVar("Durability",100)) 
			item:SetVar("Durability", new_durability)
			
			item:SetVar("Clip1", weapon:Clip1())
		end
		
		if( IsValid( weapon ) ) then
		
			if( SERVER ) then
		
				item:Owner():StripWeapon( item.WeaponClass );
				
			end
		
		end
		
		if item.HasEquipSlot then
			local x, y = item:FindBestPosition()
			
			item.x = x
			item.y = y
		end
		
		item:SetVar( "Equipped", false );
		item:Owner().EquippedWeapons[MetaItem.WeaponClass] = nil;
		
		return true
	end,
	CanRun = function(item)
		return item:GetVar("Equipped", false)
	end,
}
BASE.functions.Maintain = {
	SelectionName = "Maintain",
	OnUse = function(item)
		if CLIENT then
			local menu = vgui.Create("CMaintainMenu")
			menu:SetItem(item:GetClass(), item:GetID())
		end
		
		return true
	end,
	CanRun = function(item)
		return (item:GetVar("Durability",0) != 100 
		and (item:GetVar("Durability",0) >= (item.SelfRepairCondition or GAMEMODE.DefaultSelfRepairCond)) 
		or item:Owner():HasCharFlag("T"))
	end,
}
BASE.functions.Upgrade = {
	SelectionName = "Upgrade",
	OnUse = function(item)
		if CLIENT then
			local menu = vgui.Create("CTechMenu")
			menu:SendToMenu(item)
			GAMEMODE.TechMenu = menu
		end
		
		return true
	end,
	CanRun = function(item)
		return item:CanUpgrade() -- in range of tbl
	end,
}
BASE.functions.Detach = {
	SelectionName = "Detach",
	OnUse = function(item)
		if CLIENT then
			local menu = vgui.Create("CAttachmentMenu")
			menu:SetWeapon(item:GetClass(), item:GetID())
		end
		
		return true
	end,
	CanRun = function(item)
		return (table.Count(item:GetVar("CurrentAttachments", {})) > 0)
	end,
}

function BASE:Initialize()

	if( self:GetVar( "Equipped", false ) ) then

		if( self.FunctionHooks and self.FunctionHooks["PreEquip"] ) then
			self.FunctionHooks["PreEquip"]( self );
		end
	
		local ret = self.functions["Equip"].OnUse( self );

		if( self.FunctionHooks and self.FunctionHooks["PostEquip"] ) then
			self.FunctionHooks["PostEquip"]( self );
		end
		
		for k,v in next, self:GetVar( "Upgrades", {} ) do
			local upgrade = GAMEMODE.Upgrades[k]
			if !upgrade then continue end
		
			upgrade.OnUpgrade( upgrade, self );
		
		end

	end

end
function BASE:OnNewCreation()

	local meta = GAMEMODE:GetItemByID( self:GetClass() );

	self:SetVar( "Durability", meta.StartDurability );

end
function BASE:CanDrop()

	return !self:GetVar( "Equipped", false );

end
function BASE:CanUpgrade()

	return !self:GetVar("Equipped",false) and self:Owner():HasCharFlag("T")
	
end
function BASE:OnGamemodeLoaded()
	local base_class = weapons.GetStored(self.WeaponClass)
	if base_class then
    	base_class.JamChance = self.JamChance or base_class.JamChance
    end
end
function BASE:GetDesc()
	local upgrades_text = "Weapon has no upgrades.\n"
	local attachments_text = "Weapon has no attachments.\n"
	
	local upgrades = self:GetVar("Upgrades", {})
	if table.Count(upgrades) > 0 then
		upgrades_text = "Weapon has upgrades:\n"
		
		for k,v in next, self:GetVar("Upgrades", {}) do
			local upgrade = GAMEMODE.Upgrades[k]
			if !upgrade then continue end
			
			upgrades_text = upgrades_text..upgrade.Name.."\n"
		end
	end
	
	local attachments = self:GetVar("CurrentAttachments", {})
	if table.Count(attachments) > 0 then
		attachments_text = "Weapon has attachments:\n"
		
		for k,v in next, attachments do
			local attachment = GAMEMODE:GetItemByID(k)
			if !attachment then continue end
			
			attachments_text = attachments_text..attachment.Name.."\n"
		end
	end

	return Format("%s\nLoaded with %d rounds.\nWeapon condition: %d%%\n%s%s", self:GetVar("Desc", self.Desc), self:GetVar("Clip1", 0), self:GetVar("Durability", 100), upgrades_text, attachments_text)
end
function BASE:OnDisconnected()
	if self:GetVar("Equipped", false) then
		local weapon = self:Owner():GetWeapon(self.WeaponClass)
		if !weapon or !weapon:IsValid() then return end
		local new_durability = math.Clamp(self:GetVar("Durability",100) - (self.DegradeRate * weapon:GetNW2Int("TimesFired", 0)), 0, self:GetVar("Durability",100)) 
		
		self:SetVar("Durability", new_durability)
		self:SetVar("Clip1", weapon:Clip1())
	end
end
function BASE:GetJamChance()
	local chance = self.JamChance or 0.04
	for k,v in next, self:GetVar("Upgrades", {}) do
		local upgrade = GAMEMODE.Upgrades[k]
		if upgrade.JamChanceModifier then
			chance = math.Clamp(chance - upgrade.JamChanceModifier, 0.001, 1)
		end
	end
	
	return chance
end
function BASE:GetWeight()
	local weight = self.Weight
	for k,v in next, self:GetVar("Upgrades", {}) do
		local upgrade = GAMEMODE.Upgrades[k]
		if !upgrade then continue end
		
		if upgrade.ReduceWeight then
			weight = math.Clamp(weight - upgrade.ReduceWeight, 0.01, 1000)
		end
		
	end
	
	return weight
end
function BASE:GetSellPrice()
	local base_price = (self.BulkPrice / 5)
	
	local mods_modifier = (GAMEMODE.ModSalesModifier / 100) * table.Count(self:GetVar("Upgrades", {}))
	local attach_modifier = (GAMEMODE.ModSalesModifier / 100) * table.Count(self:GetVar("CurrentAttachments", {}))
	local mods_attach_modifier = mods_modifier + attach_modifier
	local liquid_price = ((GAMEMODE.SellPercentage / 100) * (base_price + (base_price * mods_attach_modifier))) * (self:GetVar("Durability", 0) / 100)
	
	return math.Round(liquid_price)
end
function BASE:CanSell()
	return !self:GetVar("Equipped", false) and (self:GetVar("Durability", 0) >= self.SellDurability)
end
function BASE:OnPlayerDeath()
	local weapon = self:Owner():GetWeapon(self.WeaponClass)
	if weapon and weapon:IsValid() then
		self:SetVar("Clip1", weapon:Clip1(), false, true)
	end
end
function BASE:OnUnloadItem()
	self:Owner().EquippedWeapons[self.WeaponClass] = nil;
end
function BASE:Paint(pnl, w, h)
	if self:GetVar("Equipped", false) and !pnl.PaintingDragging then
		kingston.gui.FindFunc(pnl, "Paint", "ItemDurability", w, h, self)
	end
end