ITEM.Name = "M21"
ITEM.Desc = "A match-grade M14 with polymer furniture - designed for marksmen. Can be finicky, with reliability problems in field conditions."
ITEM.Model = "models/weapons/tfa_cod/mwr/w_m21.mdl"
ITEM.WeaponClass = "tfa_mwr_m21"
ITEM.Weight = 5.25
ITEM.SafetyPos = Vector(0,0,0)
ITEM.SafetyAng = Angle(-12.4, 0, 0)
ITEM.JamChance = 0.07
ITEM.DegradeRate = 0.015
ITEM.FOV 			= 12;
ITEM.CamPos 		= Vector( -33.92, 80.36, 50 );
ITEM.LookAt 		= Vector( 4.83, -4.82, -4.82 );
ITEM.SelfRepairCondition = 85
ITEM.AmmoType = "762x51"
ITEM.License = LICENSE_BLACK;
ITEM.BulkPrice = 225000
ITEM.NoDefaultAtts = true
ITEM.Vars = {
	Equipped = false,
	CurrentAttachments = {},
	Upgrades = {
		generic_opt_mount = true,
	},
	Durability = 100,
	Clip1 = 0,
};