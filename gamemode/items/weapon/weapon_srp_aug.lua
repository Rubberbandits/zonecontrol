ITEM.Name = "Aug A2"
ITEM.Desc = "Austrian bullpup rifle. One of the first successful bullpups in the world and still very good today. Sometimes comes stock with a scope. Fires 5.56x45mm."
ITEM.Model = "models/weapons/tfa_ins2/w_aug.mdl"
ITEM.WeaponClass = "tfa_ins2_aug"
ITEM.Weight = 3.5
ITEM.SafetyPos = Vector(0,0,0)
ITEM.SafetyAng = Vector(-12.4, 0, 0)
ITEM.JamChance = 0.00065
ITEM.DegradeRate = 0.0165
ITEM.FOV 			= 12;
ITEM.CamPos 		= Vector( 100, 100, 0 );
ITEM.LookAt 		= Vector( 7, 0, 0 );
ITEM.SelfRepairCondition = 90
ITEM.AmmoType = "ammo_556x45"
ITEM.License = "C"
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
ITEM.Damage = 30