ITEM.Name = "FN P90"
ITEM.Desc = "A compact PDW designed in Belgium. Created for usage in tight quarters, it boasts a high magazine capacity and short barrel length. Uses 5.7x28mm."
ITEM.Model = "models/weapons/tfa_cod/mwr/w_p90.mdl"
ITEM.WeaponClass = "tfa_mwr_p90"
ITEM.Weight = 2.5
ITEM.SafetyPos = Vector(0,0,0)
ITEM.SafetyAng = Angle(-12.4, 0, 0)
ITEM.JamChance = 0.03
ITEM.DegradeRate = 0.08
ITEM.FOV 			= 12;
ITEM.CamPos 		= Vector( 50, 50, 50 );
ITEM.LookAt 		= Vector( 1.61, -4.82, 0 );
ITEM.SelfRepairCondition = 85
ITEM.AmmoType = "57x28"
ITEM.License = LICENSE_BLACK;
ITEM.BulkPrice = 240000
ITEM.Vars = {
	Equipped = false,
	CurrentAttachments = {},
	Upgrades = {
		generic_opt_mount = true,
	},
	Durability = 100,
	Clip1 = 0,
};