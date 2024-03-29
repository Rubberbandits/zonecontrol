ITEM.Name = "M4 Spectre"
ITEM.Desc = "A scarce but excellent submachine gun made in Italy. Due to its rarity, it commands a premium on the open market. Uses 9x19mm."
ITEM.Model = "models/weapons/tfa_ins2/w_spectre.mdl"
ITEM.WeaponClass = "tfa_ins2_spectre"
ITEM.Weight = 3
ITEM.SafetyPos = Vector(0,0,0)
ITEM.SafetyAng = Vector(-12.4, 0, 0)
ITEM.JamChance = 0.00025
ITEM.DegradeRate = 0.018
ITEM.FOV 			= 10;
ITEM.CamPos 		= Vector( 0, 100, 25 );
ITEM.LookAt 		= Vector( 2, 0, 0 );
ITEM.SelfRepairCondition = 85
ITEM.AmmoType = "ammo_9x19"
ITEM.BulkPrice = 180000
ITEM.Damage = 34
ITEM.Rarity = 5
ITEM.RepairCost = 15
ITEM.Vars = {
	Equipped = false,
	CurrentAttachments = {},
	Upgrades = {
		generic_barrel_thread = true,
		generic_opt_mount = true,
	},
	Durability = 100,
	Clip1 = 0,
}