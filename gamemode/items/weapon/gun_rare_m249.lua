ITEM.Name = "M249"
ITEM.Desc = "American LMG made by belgians. Puts out a lot of semi-accurate fire at a good rate. Somewhat heavy but a very good force multiplier.  Uses 5.56x45."
ITEM.Model = "models/weapons/tfa_cod/mwr/w_m249.mdl"
ITEM.WeaponClass = "tfa_mwr_saw"
ITEM.Weight = 4.75
ITEM.SafetyPos = Vector(0,0,0)
ITEM.SafetyAng = Angle(-12.4, 0, 0)
ITEM.JamChance = 0.02
ITEM.DegradeRate = 0.010
ITEM.FOV 			= 20;
ITEM.CamPos 		= Vector( 50, 50, 50 );
ITEM.LookAt 		= Vector( 0, 0, 0 );
ITEM.SelfRepairCondition = 75
ITEM.AmmoType = "556x45"
ITEM.License = LICENSE_BLACK;
ITEM.BulkPrice = 300000
ITEM.Vars = {
	Equipped = false,
	CurrentAttachments = {},
	Upgrades = {
		generic_opt_mount = true,
	},
	Durability = 100,
	Clip1 = 0,
};