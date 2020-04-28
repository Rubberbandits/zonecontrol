ITEM.Name = "M14"
ITEM.Desc = "Old american service rifle. Heavy, durable, and with a fast rate of fire. Uses 7.62x51mm."
ITEM.Model = "models/weapons/tfa_cod/mwr/w_m14.mdl"
ITEM.WeaponClass = "tfa_mwr_m14"
ITEM.Weight = 4.5
ITEM.SafetyPos = Vector(0,0,0)
ITEM.SafetyAng = Angle(-12.4, 0, 0)
ITEM.JamChance = 0.04
ITEM.DegradeRate = 0.03
ITEM.FOV 			= 20;
ITEM.CamPos 		= Vector( 100, 50, 50 );
ITEM.LookAt 		= Vector( 0, 0, 0 );
ITEM.SelfRepairCondition = 75
ITEM.AmmoType = "762x51"
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