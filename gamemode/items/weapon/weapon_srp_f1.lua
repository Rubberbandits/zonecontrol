ITEM.Name = "F1 Grenade"
ITEM.Desc = "A Russian offensive fragmentation grenade."
ITEM.Model = "models/weapons/tfa_ins2/w_f1.mdl"
ITEM.WeaponClass = "tfa_ins2_f1"
ITEM.Weight = 2
ITEM.SafetyPos = Vector(0,0,0)
ITEM.SafetyAng = Angle(-12.4, 0, 0)
ITEM.JamChance = 0.02
ITEM.DegradeRate = 0.05
ITEM.FOV 			= 46
ITEM.CamPos 		= Vector( 50, 4.47, 0.9 )
ITEM.LookAt 		= Vector( -90, -4.82, 4.83 )
ITEM.SelfRepairCondition = 70
ITEM.License = LICENSE_BLACK;
ITEM.BulkPrice = 5000
ITEM.Slot = 2
ITEM.Throwable = true
ITEM.UseDurability = false
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