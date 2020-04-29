ITEM.Name = "M4A1"
ITEM.Desc = "Tried and true American carbine, reliable if kept in working condition. If this weapon is your go-to you're probably a cowboy or a mercenary. Uses 5.56x45mm."
ITEM.Model = "models/weapons/tfa_ins2/w_m4a1.mdl"
ITEM.WeaponClass = "tfa_ins2_m4a1"
ITEM.Weight = 3.5
ITEM.SafetyPos = Vector(0,0,0)
ITEM.SafetyAng = Angle(-12.4, 0, 0)
ITEM.JamChance = 0.03
ITEM.DegradeRate = 0.06
ITEM.FOV 			= 46
ITEM.CamPos 		= Vector( 50, 4.47, 0.9 )
ITEM.LookAt 		= Vector( -90, -4.82, 4.83 )
ITEM.SelfRepairCondition = 80
ITEM.AmmoType = "556x45"
ITEM.License = LICENSE_BLACK;
ITEM.BulkPrice = 110000
ITEM.Vars = {
	Equipped = false,
	CurrentAttachments = {},
	Upgrades = {
		generic_opt_mount = true,
	},
	Durability = 100,
	Clip1 = 0,
};
