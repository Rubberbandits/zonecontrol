BASE.W = 2
BASE.H = 1
BASE.Vars = {
	Uses = 1,
};
BASE.RaiseCondition = 5 -- amount of points to fix on weapon
BASE.IsSellable = true

function BASE:GetDesc()
	return Format("%s\n\nUses left: %d\nThis repairs %d%% of a weapon.\n", self.Desc, self:GetVar("Uses", 1), self.RaiseCondition)
end

if SERVER then
	netstream.Hook("MaintainWeapon", function(ply, item_id, weapon_id, support_id)
		local item = GAMEMODE.g_ItemTable[item_id]
		local weapon = GAMEMODE.g_ItemTable[weapon_id]
		local support = GAMEMODE.g_ItemTable[support_id]
		
		if !weapon then return end
		local repair_amt = 0
		if item then
			if item.Base != "weapon_maintainers" then return end
			if item.TechOnly and !ply:IsMaintainTech() then return end
			if item.SuitOnly and weapon.Base != "clothes" then return end
			if item.WeaponOnly and weapon.Base != "weapon" then return end

			repair_amt = item.RaiseCondition
		end

		if weapon:GetVar("Durability", 100) == 100 then return end
		if weapon:GetVar("Durability", 100) < (weapon.SelfRepairCondition or GAMEMODE.DefaultSelfRepairCond) then return end

		if support then
			if support.SuitOnly and weapon.Base != "clothes" then return end
			if support.WeaponOnly and weapon.Base != "weapon" then return end
		
			repair_amt = repair_amt + support.RaiseCondition
			support:RemoveItem(true)
		end
		
		local new_durability = math.Clamp(weapon:GetVar("Durability", 100) + repair_amt, 0, 100)
		weapon:SetVar("Durability", new_durability, nil, true)
		
		if item then
			if item:GetVar("Uses", 1) - 1 == 0 then
				item:RemoveItem(true)
			else
				item:SetVar("Uses", item:GetVar("Uses", 1) - 1, nil, true)
			end
		end
	end)
end
