ITEM.Name = "M67 Grenade"
ITEM.Desc = "An American offensive fragmentation grenade. Spicy."
ITEM.Model = "models/weapons/tfa_ins2/w_m67.mdl"
ITEM.WeaponClass = "tfa_ins2_m67"
ITEM.Weight = 1.7
ITEM.SafetyPos = Vector(0,0,0)
ITEM.SafetyAng = Angle(-12.4, 0, 0)
ITEM.JamChance = 0
ITEM.DegradeRate = 0.05
ITEM.FOV 			= 46
ITEM.CamPos 		= Vector( 50, 4.47, 0.9 )
ITEM.LookAt 		= Vector( -90, -4.82, 4.83 )
ITEM.SelfRepairCondition = 70
ITEM.License = LICENSE_BLACK;
ITEM.BulkPrice = 7500
ITEM.Slot = 2
ITEM.Throwable = true
ITEM.UseDurability = false
ITEM.HasEquipSlot = false
ITEM.Vars = {
	Equipped = false,
	CurrentAttachments = {},
	Upgrades = {},
	Clip1 = 1,
}

function ITEM:GetDesc()
	return self.Desc
end

function ITEM:CanUpgrade()
	return false
end

function ITEM:OnThrow(weapon)
	if SERVER then
		local ply = self:Owner()
		timer.Simple(0.15, function()
			ply:StripWeapon(weapon:GetClass())
		end)
	end
	self:Owner().EquippedWeapons[self.WeaponClass] = nil
	self:RemoveItem()
end
ITEM.W = 1
ITEM.H = 1