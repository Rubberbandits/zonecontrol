ITEM.Name = "AS Val"
ITEM.Desc = "An assault rifle firing subsonic, armor piercing 9x39mm. Sought after due to high power and the integrated suppressor. Better suited for general tasks due to better combat ergonomics."
ITEM.Model = "models/weapons/tfa_ins2/w_asval.mdl"
ITEM.WeaponClass = "tfa_ins2_asval"
ITEM.Weight = 3.6
ITEM.SafetyPos = Vector(0,0,0)
ITEM.SafetyAng = Vector(-12.4, 0, 0)
ITEM.JamChance = 0.0012
ITEM.DegradeRate = 0.025
ITEM.FOV 			= 12;
ITEM.CamPos 		= Vector( 100, 100, 0 );
ITEM.LookAt 		= Vector( 4, 0, 0 );
ITEM.SelfRepairCondition = 85
ITEM.AmmoType = "ammo_9x39"
ITEM.BulkPrice = 400000
ITEM.Damage = 39
ITEM.Rarity = 4
ITEM.RepairCost = 32
ITEM.Vars = {
	Equipped = false,
	CurrentAttachments = {},
	Upgrades = {
		generic_opt_mount = true,
	},
	Durability = 100,
	Clip1 = 0,
}