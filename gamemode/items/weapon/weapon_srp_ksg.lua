ITEM.Name = "KSG"
ITEM.Desc = "A double-tubed shotgun for extra capacity without gaining length. Pump action. Uses 12 gauge shells or slugs."
ITEM.Model = "models/weapons/tfa_ins2/w_ksg.mdl"
ITEM.WeaponClass = "tfa_ins2_ksg"
ITEM.Weight = 4
ITEM.SafetyPos = Vector(0,0,0)
ITEM.SafetyAng = Vector(-12.4, 0, 0)
ITEM.JamChance = 0.0009
ITEM.DegradeRate = 0.018
ITEM.FOV 			= 10;
ITEM.CamPos 		= Vector( 100, 100, 25 );
ITEM.LookAt 		= Vector( 2, 0, 1 );
ITEM.SelfRepairCondition = 80
ITEM.AmmoType = "12ga"
ITEM.License = LICENSE_BLACK;
ITEM.BulkPrice = 166000
ITEM.Vars = {
	Equipped = false,
	CurrentAttachments = {},
	Upgrades = {
		generic_opt_mount = true,
	},
	Durability = 100,
	Clip1 = 0,
};
