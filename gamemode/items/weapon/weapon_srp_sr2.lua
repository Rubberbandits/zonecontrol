ITEM.Name = "SR2 Veresk"
ITEM.Desc = "A compact machine pistol often seeing use with special forces. With an overpressured cartridge, it has particularly good stopping power. Uses 9x21mm."
ITEM.Model = "models/weapons/tfa_ins2/sr2_veresk/w_sr2_veresk.mdl"
ITEM.WeaponClass = "tfa_ins2_sr_veresk"
ITEM.Weight = 1.5
ITEM.SafetyPos = Vector(0,0,0)
ITEM.SafetyAng = Vector(-12.4, 0, 0)
ITEM.JamChance = 0.0004
ITEM.DegradeRate = 0.022
ITEM.FOV 			= 8;
ITEM.CamPos 		= Vector( 100, 100, 25 );
ITEM.LookAt 		= Vector( 2, 0, 0 );
ITEM.SelfRepairCondition = 85
ITEM.AmmoType = "9x21"
ITEM.License = LICENSE_BLACK;
ITEM.BulkPrice = 150000
ITEM.Vars = {
	Equipped = false,
	CurrentAttachments = {},
	Upgrades = {
		generic_opt_mount = true,
	},
	Durability = 100,
	Clip1 = 0,
};
