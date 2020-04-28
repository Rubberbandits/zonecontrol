ITEM.Name = "HK G36C"
ITEM.Desc = "Another roller delayed blowback rifle from Heckler and Koch. Durable and reliable, this rifle sees service with many nations across the world. Uses 5.56x45mm."
ITEM.Model = "models/weapons/tfa_cod/mwr/w_g36.mdl"
ITEM.WeaponClass = "tfa_mwr_g36c"
ITEM.Weight = 2.75
ITEM.SafetyPos = Vector(0,0,0)
ITEM.SafetyAng = Angle(-12.4, 0, 0)
ITEM.JamChance = 0.01
ITEM.DegradeRate = 0.08
ITEM.FOV 			= 20;
ITEM.CamPos 		= Vector( 50, 50, 50 );
ITEM.LookAt 		= Vector( 0, 0, 0 );
ITEM.SelfRepairCondition = 80
ITEM.AmmoType = "556x45"
ITEM.License = LICENSE_BLACK;
ITEM.BulkPrice = 135000
ITEM.Vars = {
	Equipped = false,
	CurrentAttachments = {},
	Upgrades = {
		generic_opt_mount = true,
	},
	Durability = 100,
	Clip1 = 0,
};