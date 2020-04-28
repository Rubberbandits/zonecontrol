ITEM.Name = "M40A3"
ITEM.Desc = "The primary sniper rifle of the USMC. Glass bedded action in a McMillan fibreglass stock, with a free floated match-grade heavy barrel. Uses 7.61x51mm."
ITEM.Model = "models/weapons/tfa_cod/mwr/w_m40a3.mdl"
ITEM.WeaponClass = "tfa_mwr_m40a3"
ITEM.Weight = 7.5
ITEM.SafetyPos = Vector(0,0,0)
ITEM.SafetyAng = Angle(-12.4, 0, 0)
ITEM.JamChance = 0.05
ITEM.DegradeRate = 0.015
ITEM.FOV 			= 12;
ITEM.CamPos 		= Vector( -19.64, 80.36, 26.79 );
ITEM.LookAt 		= Vector( 8.04, -11.25, -4.82 );
ITEM.SelfRepairCondition = 75
ITEM.AmmoType = "762x51"
ITEM.License = LICENSE_BLACK;
ITEM.BulkPrice = 180000
ITEM.Vars = {
	Equipped = false,
	CurrentAttachments = {},
	Upgrades = {
		generic_opt_mount = true,
	},
	Durability = 100,
	Clip1 = 0,
};