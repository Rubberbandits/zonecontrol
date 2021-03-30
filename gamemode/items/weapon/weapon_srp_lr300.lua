ITEM.Name = "LR-300"
ITEM.Desc = "A buffer tube-less AR-15 allowing for a folding stock. Can be made very short while still being a useful rifle. Fires 5.56x45mm."
ITEM.Model = "models/weapons/tfa_ins2/w_zm_lr300.mdl"
ITEM.WeaponClass = "tfa_ins2_zm_lr300"
ITEM.Weight = 3
ITEM.SafetyPos = Vector(0,0,0)
ITEM.SafetyAng = Vector(-12.4, 0, 0)
ITEM.JamChance = 0.0002
ITEM.DegradeRate = 0.013
ITEM.FOV 			= 8;
ITEM.CamPos 		= Vector( 100, 100, 25 );
ITEM.LookAt 		= Vector( 2, 0, 0 );
ITEM.SelfRepairCondition = 90
ITEM.AmmoType = "ammo_556x45"
ITEM.License = "C"
ITEM.BulkPrice = 187000
ITEM.Vars = {
	Equipped = false,
	CurrentAttachments = {},
	Upgrades = {
		generic_opt_mount = true,
	},
	Durability = 100,
	Clip1 = 0,
};
