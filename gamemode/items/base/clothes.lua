/* Legend for bonemerge values */
--[[
	ITEM.Bonemerge - string, model to use for bonemerge, cannot also use WearModel
	ITEM.AllowGender - bool, set model defined in bonemerge based on gender. automatically appends _f to filename after stripping extension
	ITEM.Bodygroups - table, bodygroups to set on bonemerged 
	ITEM.RemoveBody - bool, remove default bonemerged body
	ITEM.HelmetBodygroup - table, bodygroup to be set when helmet is worn.
	ITEM.ScaleForGender - int, when you dont have a female variant of a model, scale the body to try to make it fit better.
--]]

-- hey, maybe we can find the helmet mat indexes on the model for each suit and just set them to ambient/occlusionproxy. lmao ghetto bonemerge models.

BASE.Vars = {
	Equipped = false,
	Upgrades = {},
	Durability = 100,
	SuitClass = "",
}
BASE.UseDurability = true;
BASE.DegradationProtection = 75; -- a percentage: 100% allows no durability damage, 0% allows full durability damage.
BASE.HandsModel = {
	body = "100000000",
	model = "models/poc/stalker_viewmodels/c_sunrise.mdl",
	skin = 0,
}
BASE.functions = {};
BASE.functions.Equip = {
	SelectionName = "Equip",
	OnUse = function( item )
		local metaitem = GAMEMODE:GetItemByID( item:GetClass() );

		item:SetVar( "Equipped", true );
		
		if SERVER then
			if metaitem.WearModel then
				item:Owner():SetModelCC( item:GetWearModel() );
				item:Owner().Uniform = item:GetWearModel();
				item:Owner():SetBody("")
			elseif metaitem.Bonemerge then
				item:Transmit()
			end
			
			GAMEMODE:SpeedThink( item:Owner() )
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
		
		return !item:GetVar( "Equipped", false ) and item:GetVar("Durability",0) > 0;
	end,
}
BASE.functions.WearHelmet = {
	SelectionName = "Wear Helmet",
	OnUse = function( item )
		local metaitem = GAMEMODE:GetItemByID( item:GetClass() );
	
		item:SetVar( "HelmetEquipped", true );
		
		--engine/occlusionproxy
		
		if SERVER then
			item:Owner():SetSkin(0)
			for i = 1, #item:Owner():GetMaterials() do
				item:Owner():SetSubMaterial(i - 1, "engine/occlusionproxy")
			end
			item:Transmit()
		end
		
		return true
	end,
	CanRun = function( item )
		return item:GetVar( "Equipped", false ) and !item:GetVar( "HelmetEquipped", false ) and item.HelmetBodygroup;
	end,
}
BASE.functions.RemoveHelmet = {
	SelectionName = "Remove Helmet",
	OnUse = function( item )
		local metaitem = GAMEMODE:GetItemByID( item:GetClass() );
	
		item:SetVar( "HelmetEquipped", false );
		
		if SERVER then
			item:Transmit()
			item:Owner():SetSkin(item:Owner():GetCharFromID( item:Owner():CharID() ).Skingroup)
			item:Owner():SetSubMaterial()
		end
		
		return true
	end,
	CanRun = function( item )
		return item:GetVar( "Equipped", false ) and item:GetVar( "HelmetEquipped", false ) and item.HelmetBodygroup;
	end,
}
BASE.functions.Unequip = {
	SelectionName = "Unequip",
	OnUse = function( item )
		local metaitem = GAMEMODE:GetItemByID( item:GetClass() );
	
		item:SetVar( "Equipped", false );
		
		if SERVER then
			if item.WearModel then
				item:Owner():SetModelCC( item:Owner().CharModel );
				item:Owner().Uniform = nil;
				item:Owner():SetSkin( item:Owner():GetCharFromID( item:Owner():CharID() ).Skingroup );
				item:Owner():SetBody( item:Owner():GetCharFromID( item:Owner():CharID() ).Body );
			elseif metaitem.Bonemerge then
				item:Transmit()
			end
			
			if item:GetVar( "Durability", 0 ) < 1 then
				item:Owner():Notify(nil, Color(255,255,255), "Your suit has broken.")
			end
			
			GAMEMODE:SpeedThink( item:Owner() )
		end
		
		return true
	end,
	CanRun = function( item )
		return item:GetVar( "Equipped", false );
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
		return !item:GetVar("Equipped",false) and item:Owner():HasCharFlag("T") -- in range of tbl
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
	end
end
function BASE:CanDrop()
	return !self:GetVar( "Equipped", false );
end
function BASE:CanUpgrade()
	return !self:GetVar( "Equipped", false );
end
function BASE:OnTakeDamage(dmginfo)
	-- need to properly do this so it only saves when it needs to
	if !self:GetVar("Equipped",false) then return end
	if !self.UseDurability then return end

	local protection = self.DegradationProtection;
	for class,_ in next, self:GetVar("Upgrades", {}) do
		local upgrade = GAMEMODE.Upgrades[class]
		if upgrade.DegradationProtection then
			protection = protection + upgrade.DegradationProtection
		end
	end

	local dmg_total = dmginfo:GetDamage()
	local cond_dmg = dmg_total - ((protection / 100) * dmg_total)
	local new_durability = math.Clamp(self:GetVar("Durability",0) - cond_dmg, 0, 100)
	
	self:SetVar("Durability", new_durability, false, true)
	if new_durability == 0 then
		self:CallFunction("Unequip", true)
	end
end
function BASE:GetArtifactSlots()
	local base = self:GetVar("ArtifactSlots", self.ArtifactSlots or 0)
	
	for k,v in next, self:GetVar("Upgrades", {}) do
		local upgrade = GAMEMODE.Upgrades[k]
		if !upgrade then continue end
		
		base = base + (upgrade.ArtifactSlots or 0)
	end
	
	return base
end
function BASE:GetArmorValues()
	if !self.ArmorValues then return {} end
	local base_tbl = table.Copy(self.ArmorValues or {})
	
	for class,_ in next, self:GetVar("Upgrades", {}) do
		local upgrade = GAMEMODE.Upgrades[class]
		if !upgrade then continue end
		
		for index,mult in next, upgrade.ArmorValues do
			local num = base_tbl[index] or 1
			
			base_tbl[index] = num * mult
		end
	end
	
	return base_tbl
end
function BASE:GetSpeeds()
	local speeds = table.Copy(self.Speeds or {})
	for k,v in next, self:GetVar("Upgrades", {}) do
		local upgrade = GAMEMODE.Upgrades[k]
		if !upgrade then continue end
		
		speeds["w"] = (speeds["w"] or 0) + (upgrade.AddWalkSpeed or 0)
		speeds["r"] = (speeds["r"] or 0) + (upgrade.AddRunSpeed or 0)
		speeds["c"] = (speeds["c"] or 0) + (upgrade.AddCrouchSpeed or 0)
		speeds["j"] = (speeds["j"] or 0) + (upgrade.AddJumpHeight or 0)
	end
	
	return speeds
end
function BASE:GetCarryWeight()
	if !self:GetVar("Equipped", false) then return 0 end
	
	local base = self.CarryAdd or 0
	for k,v in next, self:GetVar("Upgrades", {}) do
		local upgrade = GAMEMODE.Upgrades[k]
		if !upgrade then continue end
		
		base = base + (upgrade.CarryAdd or 0)
	end
	
	return base
end
function BASE:GetSubmaterials()
	local suit = GAMEMODE.SuitVariants[self:GetVar("SuitClass", "")]
	if !suit then return end
	
	return suit.Submaterial
end
function BASE:GetItemSubmaterials()
	local suit = GAMEMODE.SuitVariants[self:GetVar("SuitClass", "")]
	if !suit then return end
	
	return suit.ItemSubmaterials
end
function BASE:GetName()
	if self:GetVar("Name", nil) then return self:GetVar("Name", self.Name) end
	
	local suit = GAMEMODE.SuitVariants[self:GetVar("SuitClass", "")]
	if !suit then return self.Name end
	
	return suit.Name
end
function BASE:GetDesc()
	local upgrades_text = "Suit has no upgrades.\n"
	
	local upgrades = self:GetVar("Upgrades", {})
	if table.Count(upgrades) > 0 then
		upgrades_text = "Suit has upgrades:\n"
		
		for k,v in next, self:GetVar("Upgrades", {}) do
			local upgrade = GAMEMODE.Upgrades[k]
			if !upgrade then continue end
			
			upgrades_text = upgrades_text..upgrade.Name.."\n"
		end
	end

	local desc_string = self:GetVar("Desc", self.Desc)
	local desc = Format("%s\nSuit condition: %d%%\nArtifact slots: %d\n%s", desc_string, self:GetVar("Durability",0), self:GetArtifactSlots(), upgrades_text)
	
	return desc
end
function BASE:GetWeight()
	local weight = self:GetVar("Weight", self.Weight)
	for k,v in next, self:GetVar("Upgrades", {}) do
		local upgrade = GAMEMODE.Upgrades[k]
		if !upgrade then continue end
		
		if upgrade.ReduceWeight then
			weight = math.Clamp(weight - upgrade.ReduceWeight, 0.01, 1000)
		end
		
	end
	
	return weight
end
function BASE:GetHands()
	local suit = GAMEMODE.SuitVariants[self:GetVar("SuitClass", "")]
	if !suit then return self.HandsModel end
	
	return suit.HandsModel or self.HandsModel
end
-- self in this func is dummy item. only has Owner, Vars, and szClass. Clientside only.
function BASE:DummyItemUpdate()
	local metaitem = GAMEMODE:GetItemByID(self.szClass)
	
	if metaitem.HelmetBodygroup then
		if !IsValid(self.Owner[self.szClass]) then return end
	
		if self.Vars["HelmetEquipped"] then
			self.Owner[self.szClass]:SetBodygroup(metaitem.HelmetBodygroup[1], metaitem.HelmetBodygroup[2])
		else
			if metaitem.Bodygroups then
				for _,bodygroup in next, metaitem.Bodygroups do
					self.Owner[self.szClass]:SetBodygroup(bodygroup[1], bodygroup[2])
				end
			else
				self.Owner[self.szClass]:SetBodygroup(0, 0)
			end
		end
	end
end

BASE.FunctionHooks = {}
BASE.FunctionHooks.PreEquip = function(item)
	local metaitem = GAMEMODE:GetItemByID(item:GetClass())
	if SERVER and metaitem.WearModel then
		for i = 1, #item:Owner():GetMaterials() do
			item:Owner():SetSubMaterial(i - 1, item:Owner():GetMaterials()[i])
		end
	end
end
BASE.FunctionHooks.PostEquip = function(item)
	local metaitem = GAMEMODE:GetItemByID(item:GetClass())
	if SERVER then
		local submats = item:GetSubmaterials()
		if submats then
			if metaitem.WearModel then
				for k,v in next, submats do
					item:Owner():SetSubMaterial(v[1], v[2])
				end
			end
		end
		if item:GetVar( "HelmetEquipped", false ) then
			item:Owner():SetSkin(0)
			for i = 1, #item:Owner():GetMaterials() do
				item:Owner():SetSubMaterial(i - 1, "engine/occlusionproxy")
			end
		end
	end
end
BASE.FunctionHooks.PostUnequip = function(item)
	if SERVER then
		for i = 1, #item:Owner():GetMaterials() do
			item:Owner():SetSubMaterial(i - 1, item:Owner():GetMaterials()[i])
		end
	end
end