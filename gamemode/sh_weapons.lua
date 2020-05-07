local t 	= { };
t.name		= "cc_none";
t.dmgtype	= DMG_GENERIC;
t.tracer	= TRACER_NONE;
t.plydmg	= 0;
t.npcdmg	= 0;
t.force		= 0;
t.minsplash	= 0;
t.maxsplash	= 0;
game.AddAmmoType( t );

local t 	= { };
t.name		= "cc_pistol";
t.dmgtype	= DMG_BULLET;
t.tracer	= TRACER_LINE;
t.plydmg	= 3;
t.npcdmg	= 5;
t.force		= 66;
t.minsplash	= 10;
t.maxsplash	= 5;
game.AddAmmoType( t );

local t 	= { };
t.name		= "cc_smg";
t.dmgtype	= DMG_BULLET;
t.tracer	= TRACER_LINE;
t.plydmg	= 4;
t.npcdmg	= 5;
t.force		= 66;
t.minsplash	= 10;
t.maxsplash	= 5;
game.AddAmmoType( t );

local t 	= { };
t.name		= "cc_357";
t.dmgtype	= DMG_BULLET;
t.tracer	= TRACER_LINE;
t.plydmg	= 30;
t.npcdmg	= 40;
t.force		= 1088.2;
t.minsplash	= 10;
t.maxsplash	= 5;
game.AddAmmoType( t );

local t 	= { };
t.name		= "cc_ar2";
t.dmgtype	= DMG_BULLET;
t.tracer	= TRACER_LINE;
t.plydmg	= 3;
t.npcdmg	= 8;
t.force		= 66;
t.minsplash	= 10;
t.maxsplash	= 5;
game.AddAmmoType( t );

local t 	= { };
t.name		= "cc_shotgun";
t.dmgtype	= DMG_BULLET;
t.tracer	= TRACER_LINE;
t.plydmg	= 3;
t.npcdmg	= 8;
t.force		= 130.6;
t.minsplash	= 10;
t.maxsplash	= 5;
game.AddAmmoType( t );

GM.HandsWeapons = {
	"weapon_cc_hands",
	"weapon_cc_vortigaunt",
	"weapon_cc_vortigaunt_slave",
	"weapon_cc_vortbroom",
	"weapon_cc_vortbroom_diss",
};

GM.OverrideSlots = { };
GM.OverrideSlots["weapon_physgun"] = { 3, 1 };
GM.OverrideSlots["weapon_physcannon"] = { 3, 2 };
GM.OverrideSlots["gmod_tool"] = { 3, 3 };
GM.OverrideSlots["weapon_cc_hands"] = {1, 1};
GM.OverrideSlots["weapon_cc_bolt"] = {1, 2};
GM.OverrideSlots["weapon_cc_knife"] = {1, 3};

function GM:PlayerSwitchWeapon( ply, old, new )

	if (new.IsTFAWeapon) then
		ply:SetHolstered(true)
		new:SetFireMode(#new.FireModes)
	else
		if (SERVER and new.Holsterable) then
			ply:SetHolstered(true)
		end
		if (!new.Holsterable) then
			ply:SetHolstered(false)
		end
	end
	
	if( ply:PassedOut() and !table.HasValue( self.HandsWeapons, new:GetClass() ) ) then return true end
	if( ply:TiedUp() and !table.HasValue( self.HandsWeapons, new:GetClass() ) ) then return true end
	if( ply:MountedGun() and ply:MountedGun():IsValid() and !table.HasValue( self.HandsWeapons, new:GetClass() ) ) then return true end
	if( ply:APC() and ply:APC():IsValid() and !table.HasValue( self.HandsWeapons, new:GetClass() ) ) then return true end
	
	for _, v in pairs( ents.GetNPCs() ) do
		
		if( v:NPCHatesWeapons() ) then
			
			local class = new:GetClass();
			
			if( class != "weapon_cc_hands" and class != "weapon_cc_vortigaunt_slave" and class != "weapon_cc_vortbroom" and class != "weapon_cc_vortbroom_diss" and class != "weapon_physgun" and class != "gmod_tool" and class != "weapon_physcannon" ) then
				
				v:AddEntityRelationship( ply, D_HT, 99 );
				
			else
				
				if( !ply:Visible( v ) ) then
					
					self:RefreshNPCRelationship( v );
					
				end
				
			end
			
		end
		
	end
	
	self.BaseClass:PlayerSwitchWeapon( ply, old, new );
	
end

function GM:PlayerSwitchFlashlight( ply, enabled )
	
	if( !ply.NextFlashlight ) then ply.NextFlashlight = CurTime(); end
	
	if( CurTime() >= ply.NextFlashlight ) then
		
		ply.NextFlashlight = CurTime() + 0.3;
		return true;
		
	end
	
	return false;
	
end

if( SERVER ) then
	
	local function nToggleHolster( ply )
		
		if( ply:PassedOut() ) then return end
		if( ply:TiedUp() ) then return end
		if( ply:MountedGun() and ply:MountedGun():IsValid() ) then return end
		if( ply:APC() and ply:APC():IsValid() ) then return end
		
		if( ply:GetActiveWeapon() != NULL ) then
			
			if( ply:GetActiveWeapon().Holsterable or ply:GetActiveWeapon().IsTFAWeapon ) then
				
				ply:SetHolstered( !ply:Holstered() );
				
				if( ply:Holstered() and ply:GetActiveWeapon().IsTFAWeapon ) then
				
					ply:GetActiveWeapon():SetFireMode(#ply:GetActiveWeapon().FireModes);
					
				elseif( !ply:Holstered() and ply:GetActiveWeapon().IsTFAWeapon ) then
				
					ply:GetActiveWeapon():SetFireMode(1);
					
				end
				
			else
				
				ply:SetHolstered( false );
				
			end
			
		end
		
	end
	netstream.Hook( "nToggleHolster", nToggleHolster );
	
	local function nSelectWeapon( ply, class )
		
		if( ply:PassedOut() ) then return end
		if( ply:TiedUp() ) then return end
		if( ply:MountedGun() and ply:MountedGun():IsValid() ) then return end
		if( ply:APC() and ply:APC():IsValid() ) then return end
		
		ply:SelectWeapon( class );
		
	end
	netstream.Hook( "nSelectWeapon", nSelectWeapon );
	
end

function GM:IronsightsMul()
	
	return FrameTime() / 1.5;
	
end

function GM:GetTraceDecal( tr )
	
	if( tr.MatType == MAT_ALIENFLESH ) then return "Impact.AlientFlesh" end
	if( tr.MatType == MAT_ANTLION ) then return "Impact.Antlion" end
	if( tr.MatType == MAT_CONCRETE ) then return "Impact.Concrete" end
	if( tr.MatType == MAT_METAL ) then return "Impact.Metal" end
	if( tr.MatType == MAT_WOOD ) then return "Impact.Wood" end
	if( tr.MatType == MAT_GLASS ) then return "Impact.Glass" end
	if( tr.MatType == MAT_FLESH ) then return "Impact.Flesh" end
	if( tr.MatType == MAT_BLOODYFLESH ) then return "Impact.BloodyFlesh" end
	
	return "Impact.Concrete";
	
end

function GM:GetImpactSound( tr )
	
	if( tr.MatType == MAT_ALIENFLESH ) then return "Flesh.BulletImpact" end
	if( tr.MatType == MAT_ANTLION ) then return "Flesh.BulletImpact" end
	if( tr.MatType == MAT_CONCRETE ) then return "Concrete.BulletImpact" end
	if( tr.MatType == MAT_METAL ) then return "SolidMetal.BulletImpact" end
	if( tr.MatType == MAT_WOOD ) then return "Wood.BulletImpact" end
	if( tr.MatType == MAT_GLASS ) then return "Glass.BulletImpact" end
	if( tr.MatType == MAT_FLESH ) then return "Flesh.BulletImpact" end
	if( tr.MatType == MAT_BLOODYFLESH ) then return "Flesh.BulletImpact" end
	if( tr.MatType == MAT_DIRT ) then return "Dirt.BulletImpact" end
	if( tr.MatType == MAT_GRATE ) then return "MetalGrate.BulletImpact" end
	if( tr.MatType == MAT_TILE ) then return "Tile.BulletImpact" end
	if( tr.MatType == MAT_COMPUTER ) then return "Computer.BulletImpact" end
	if( tr.MatType == MAT_SAND ) then return "Sand.BulletImpact" end
	if( tr.MatType == MAT_PLASTIC ) then return "Plastic_Box.BulletImpact" end
	
	return "Default.BulletImpact";
	
end

GM.WeaponStatistics = {};
GM.WeaponStatistics["Primary.Spread"] = function(weapon, value)
	if !weapon:GetOwner().EquippedWeapons then return value end
	local id = weapon:GetOwner().EquippedWeapons[weapon:GetClass()]
	local item = GAMEMODE.g_ItemTable[id]
	local new_value = value
	if item then
		for k,v in next, item:GetVar("Upgrades",{}) do
			local upgrade = GAMEMODE.Upgrades[k]
			
			if !upgrade.ReduceSpread then continue end
			
			new_value = math.Clamp(new_value * upgrade.ReduceSpread, 0.001, 0.5)
		end
	end
	
	return new_value
end
GM.WeaponStatistics["Primary.IronAccuracy"] = function(weapon, value)
	if !weapon:GetOwner().EquippedWeapons then return value end
	local id = weapon:GetOwner().EquippedWeapons[weapon:GetClass()]
	local item = GAMEMODE.g_ItemTable[id]
	local new_value = value
	if item then
		for k,v in next, item:GetVar("Upgrades",{}) do
			local upgrade = GAMEMODE.Upgrades[k]
			
			if !upgrade.ReduceSpread then continue end
			
			return math.Clamp(value - upgrade.ReduceSpread, 0.001, 0.1)
		end
	end
end
GM.WeaponStatistics["Primary.KickUp"] = function( weapon, value )
	if !weapon:GetOwner().EquippedWeapons then return value end
	local id = weapon:GetOwner().EquippedWeapons[weapon:GetClass()]
	local item = GAMEMODE.g_ItemTable[id]
	local new_value = value
	if item then
		for k,v in next, item:GetVar("Upgrades",{}) do
			local upgrade = GAMEMODE.Upgrades[k]
			
			if !upgrade.ReduceRecoilUp then continue end
			
			new_value = math.Clamp(new_value * upgrade.ReduceRecoilUp, 0.001, 1)
		end
	end
	
	return new_value
end
GM.WeaponStatistics["Primary.KickHorizontal"] = function( weapon, value )
	if !weapon:GetOwner().EquippedWeapons then return value end
	local id = weapon:GetOwner().EquippedWeapons[weapon:GetClass()]
	local item = GAMEMODE.g_ItemTable[id]
	local new_value = value
	if item then
		for k,v in next, item:GetVar("Upgrades",{}) do
			local upgrade = GAMEMODE.Upgrades[k]
			
			if !upgrade.ReduceRecoilHorizontal then continue end
			
			new_value = math.Clamp(new_value * upgrade.ReduceRecoilHorizontal, 0.001, 1)
		end
	end
	
	return new_value
end
GM.WeaponStatistics["SafetyPos"] = function(weapon, value)
	if weapon:GetOwner().EquippedWeapons then
		local item = GAMEMODE.g_ItemTable[weapon:GetOwner().EquippedWeapons[weapon:GetClass()]]
		if item and item.SafetyPos then
			return item.SafetyPos
		end
	end
end
GM.WeaponStatistics["SafetyAng"] = function(weapon, value)
	if weapon:GetOwner().EquippedWeapons then
		local item = GAMEMODE.g_ItemTable[weapon:GetOwner().EquippedWeapons[weapon:GetClass()]]
		if item and item.SafetyAng then
			return item.SafetyAng
		end
	end
end
GM.WeaponStatistics["data.ironsights"] = function(weapon, value)
	if weapon:GetOwner():Holstered() then
		return 0
	end
end
GM.WeaponStatistics["Primary.Ammo"] = function(weapon, value)
	if !weapon:GetOwner().EquippedWeapons then return value end
	
	local item = GAMEMODE.g_ItemTable[weapon:GetOwner().EquippedWeapons[weapon:GetClass()]]
	if item then
		for k,v in next, item:GetVar("Upgrades",{}) do
			local upgrade = GAMEMODE.Upgrades[k]
			
			if !upgrade.ChangeAmmoType then continue end
			
			return upgrade.ChangeAmmoType
		end
	
		return item.AmmoType or value
	end
end
GM.WeaponStatistics["Primary.RPM"] = function(weapon, value)
	if !weapon:GetOwner().EquippedWeapons then return value end
	local id = weapon:GetOwner().EquippedWeapons[weapon:GetClass()]
	local item = GAMEMODE.g_ItemTable[id]
	local new_value = value
	if item then
		for k,v in next, item:GetVar("Upgrades",{}) do
			local upgrade = GAMEMODE.Upgrades[k]
			
			if !upgrade.AddRPM then continue end
			
			new_value = math.Clamp(new_value + upgrade.AddRPM, 1, 2000)
		end
	end
	
	return new_value
end
GM.WeaponStatistics["PrintName"] = function( weapon, value )
	if !weapon:GetOwner().EquippedWeapons then return value end
	local id = weapon:GetOwner().EquippedWeapons[weapon:GetClass()]
	local item = GAMEMODE.g_ItemTable[id]
	if item then
		return item:GetVar("Name", item.Name)
	end
end
GM.WeaponStatistics["Secondary.IronFOV"] = function( weapon, value )
	if !weapon:GetOwner().EquippedWeapons then return value end
	local id = weapon:GetOwner().EquippedWeapons[weapon:GetClass()]
	local item = GAMEMODE.g_ItemTable[id]
	if item and item.IronFOV then
		return item.IronFOV
	end
end
GM.WeaponStatistics["Slot"] = function( weapon, value )
	if !weapon:GetOwner().EquippedWeapons then return value end
	local id = weapon:GetOwner().EquippedWeapons[weapon:GetClass()]
	local item = GAMEMODE.g_ItemTable[id]
	if item and item.Slot then
		return item.Slot
	end
end
GM.WeaponStatistics["SlotPos"] = function( weapon, value )
	if !weapon:GetOwner().EquippedWeapons then return value end
	local id = weapon:GetOwner().EquippedWeapons[weapon:GetClass()]
	local item = GAMEMODE.g_ItemTable[id]
	if item and item.SlotPos then
		return item.SlotPos
	end
end
GM.WeaponStatistics["Primary.Damage"] = function(weapon, value)
	if weapon:GetOwner().EquippedWeapons then
		local item = GAMEMODE.g_ItemTable[weapon:GetOwner().EquippedWeapons[weapon:GetClass()]]
		if item and item.Damage then
			return item.Damage
		end
	end
end
GM.WeaponStatistics["Secondary.CanBash"] = function(weapon, value)
	if weapon:GetOwner():Holstered() then
		return false
	end
end
GM.WeaponStatistics["FireModes"] = function(weapon, value)
	if weapon:GetOwner():Holstered() then
		local tbl = {}
		for i = 1, #value do
			tbl[i] = "Safe"
		end
		
		return tbl
	end
end

hook.Add( "TFA_GetStat", "STALKER.Statistics", function( weapon, stat, value )

	if( GAMEMODE.WeaponStatistics[stat] ) then
	
		local result = GAMEMODE.WeaponStatistics[stat]( weapon, value );
		if( result ~= nil ) then
		
			return result;
		
		end
	
	end
	
end );

hook.Add("TFA_PreCanPrimaryAttack", "STALKER.PreventFire", function(weapon)
	if (weapon:GetOwner():Holstered()) then
		return false
	end
end)
hook.Add("TFA_CanPrimaryAttack", "STALKER.PreventFire", function(weapon)
	if (weapon:GetOwner():Holstered()) then
		return false
	end
end)
hook.Add("TFA_SecondaryAttack", "STALKER.PreventADS", function(weapon)
	if (weapon:GetOwner():Holstered()) then
		return true
	end
end)

hook.Add("TFA_PreInitAttachments", "STALKER.PreventDefaultAtts", function(weapon)
	if !weapon:GetOwner().EquippedWeapons then return end
	local item = GAMEMODE.g_ItemTable[weapon:GetOwner().EquippedWeapons[weapon:GetClass()]]
	if !item then return end
	if !item.NoDefaultAtts then return end
	
	for k,v in next, weapon.Attachments do
		if v.sel then
			v.sel = nil
		end
	end
end)

hook.Add("TFA_FinalInitAttachments", "STALKER.Attachments", function(weapon)
	if !weapon:GetOwner().EquippedWeapons then return end
	local item = GAMEMODE.g_ItemTable[weapon:GetOwner().EquippedWeapons[weapon:GetClass()]]
	if !item then return end
	
	local attachments = item:GetVar("CurrentAttachments", {})
	for k,v in next, attachments do
		local attachment = GAMEMODE:GetItemByID(k)

		for k,v in next, weapon.Attachments do
			for m,n in next, attachment.Attachment do
				if table.HasValue(v.atts, m) then
					weapon:Attach(m)
				end
			end
		end
	end
	
	local upgrades = item:GetVar("Upgrades", {})
	for k,v in next, upgrades do
		local upgrade = GAMEMODE.Upgrades[k]
		
		if upgrade.Attachment then
			weapon:Attach(upgrade.Attachment)
		end
	end
end)

hook.Add("TFA_PostPrimaryAttack", "STALKER.Durability", function(weapon)
	if CLIENT then
		if !IsFirstTimePredicted() then return end
	end
	
	weapon:SetNW2Int("TimesFired", weapon:GetNW2Int("TimesFired", 0) + 1)
	
	local item = GAMEMODE.g_ItemTable[weapon:GetOwner().EquippedWeapons[weapon:GetClass()]]
	if item then
		if item.UseDurability then
			if item:GetVar("Durability", 100) - (item.DegradeRate * weapon:GetNW2Int("TimesFired",0)) <= 0 then
				item:SetVar("Durability", 0)
				
				if SERVER then
					weapon:GetOwner():Notify( nil, Color(255,255,255), "This weapon is broken." );
				end
				
				item:CallFunction("Unequip")
			end
		end
		
		if item.PostPrimaryAttack then
			item:PostPrimaryAttack(weapon)
		end
	end
end)

hook.Add("TFA_CompleteReload", "STALKER.Durability", function(weapon)
	if CLIENT then
		if !IsFirstTimePredicted() then return end
	end

	local item = GAMEMODE.g_ItemTable[weapon:GetOwner().EquippedWeapons[weapon:GetClass()]]
	if item and item.UseDurability then
		local new_durability = math.Clamp(item:GetVar("Durability",100) - (item.DegradeRate * weapon:GetNW2Int("TimesFired", 0)), 0, item:GetVar("Durability",100)) 
		item:SetVar("Durability", new_durability)
		
		local maxclip = weapon:GetPrimaryClipSizeForReload(true)
		local curclip = weapon:Clip1()
		local amounttoreplace = math.min(maxclip - curclip, weapon:Ammo1())

		item:SetVar("Clip1", curclip + amounttoreplace)
		print((item.StartDurability / new_durability) * 100)
		weapon:SetJamFactor((item.StartDurability / new_durability) * 100)
	end
	
	weapon:SetNW2Int("TimesFired", 0)
end)

hook.Add("TFA_CanAttach", "STALKER.Attachments", function(weapon, attachment)
	local item = GAMEMODE.g_ItemTable[weapon:GetOwner().EquippedWeapons[weapon:GetClass()]]
	if !item then return end

	local found = false
	for k,v in next, item:GetVar("CurrentAttachments", {}) do
		local attachment_item = GAMEMODE:GetItemByID(k)
		if attachment_item.Attachment[attachment] then
			found = true
		end
	end
	if !found then
		return false
	end
end)

hook.Add("TFA_DrawHUDAmmo", "STALKER.Remove3D2DAmmoHUD", function()
	return false
end)

local weapon_meta = FindMetaTable("Weapon")
local player_meta = FindMetaTable("Player")
local old_GetAmmoCount = old_GetAmmoCount or player_meta.GetAmmoCount
local old_GetPrimaryAmmoType = old_GetPrimaryAmmoType or weapon_meta.GetPrimaryAmmoType
local old_RemoveAmmo = old_RemoveAmmo or player_meta.RemoveAmmo

function player_meta:GetAmmoCount(ammotype)
	local id = game.GetAmmoID(ammotype or "")
	if id > -1 then
		return old_GetAmmoCount(self, ammotype)
	else
		local amt = 0
		
		if !self.Inventory then return 0 end
		
		for _,item in next, self.Inventory do
			if item:GetClass() == ammotype then
				amt = amt + item:GetVar("Amount",0)
			end
		end
		
		return amt
	end
end

function weapon_meta:GetPrimaryAmmoType()
	if !self.Primary then return end
	
	local id = game.GetAmmoID(self.Primary.Ammo)
	if id > -1 then
		return id
	else
		if self.GetStat then
			return self:GetStat("Primary.Ammo")
		end
	end
end

function player_meta:RemoveAmmo(amt, ammo_type)
	if CLIENT then return end
	if !isstring(ammo_type) then
		return old_RemoveAmmo(self, amt, ammo_type)
	else
		local needed = amt
		local items_to_remove = {}
		for _, item in next, self.Inventory do
			if item:GetClass() == ammo_type then
				local delta = item:GetVar("Amount", 0) - needed
				if delta > 0 then
					item:SetVar("Amount", delta, nil, true)
					needed = 0
				else
					items_to_remove[#items_to_remove + 1] = { item, item:GetVar("Amount", 0) }
					needed = needed - item:GetVar("Amount", 0)
				end
				
				if needed == 0 then
					for m,n in next, items_to_remove do
						n[1]:RemoveItem(true)
					end
					
					break
				end
			end
		end
	end
end