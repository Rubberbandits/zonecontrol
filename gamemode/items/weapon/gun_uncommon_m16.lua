ITEM.Name = "M16A4"
ITEM.Desc = "Slightly older american assault rifle. Longer barrel and can use a cool heatshield. Burst-fire only. Uses 5.56x45mm."
ITEM.Model = "models/weapons/tfa_cod/mwr/w_m16a4.mdl"
ITEM.WeaponClass = "tfa_mwr_m16a4"
ITEM.Weight = 4
ITEM.SafetyPos = Vector(0,0,0)
ITEM.SafetyAng = Angle(-12.4, 0, 0)
ITEM.JamChance = 0.05
ITEM.DegradeRate = 0.08
ITEM.FOV 			= 20;
ITEM.CamPos 		= Vector( 50, 50, 50 );
ITEM.LookAt 		= Vector( 0, 0, 0 );
ITEM.SelfRepairCondition = 80
ITEM.AmmoType = "556x45"
ITEM.License = LICENSE_BLACK;
ITEM.BulkPrice = 120000
ITEM.Vars = {
	Equipped = false,
	CurrentAttachments = {},
	Upgrades = {
		generic_opt_mount = true,
	},
	Durability = 100,
	Clip1 = 0,
};