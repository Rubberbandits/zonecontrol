ITEM.Name = "Kel-Tec RFB"
ITEM.Desc = "A modern tactical bullpup battle rifle. 7.62x51mm NATO chambering, semi-auto only."
ITEM.Model = "models/weapons/tfa_ins2/w_rfb.mdl"
ITEM.WeaponClass = "tfa_ins2_rfb"
ITEM.Weight = 4
ITEM.SafetyPos = Vector(0,0,0)
ITEM.SafetyAng = Vector(-12.4, 0, 0)
ITEM.JamChance = 0.0002
ITEM.DegradeRate = 0.018
ITEM.FOV 			= 10
ITEM.CamPos 		= Vector( 100, 100, 0 )
ITEM.LookAt 		= Vector( 1, 0, 0 )
ITEM.SelfRepairCondition = 85
ITEM.AmmoType = "ammo_762x51"
ITEM.License = "C"
ITEM.BulkPrice = 235000
ITEM.Slot = 2
ITEM.Vars = {
	Equipped = false,
	CurrentAttachments = {},
	Upgrades = {
		generic_opt_mount = true,
	},
	Durability = 100,
	Clip1 = 0,
};
ITEM.Damage = 51