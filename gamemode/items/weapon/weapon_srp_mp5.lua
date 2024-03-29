ITEM.Name = "H&K MP5"
ITEM.Desc = "Classic NATO submachine gun. Very common and extremely popular. Uses 9x19mm."
ITEM.Model = "models/weapons/tfa_ins2/w_mp5.mdl"
ITEM.WeaponClass = "tfa_ins2_mp5"
ITEM.Weight = 2.5
ITEM.SafetyPos = Vector(0,0,0)
ITEM.SafetyAng = Vector(-12.4, 0, 0)
ITEM.JamChance = 0.00025
ITEM.DegradeRate = 0.018
ITEM.FOV 			= 10;
ITEM.CamPos 		= Vector( 100, 100, 25 );
ITEM.LookAt 		= Vector( 2, 0, 0 );
ITEM.SelfRepairCondition = 75
ITEM.AmmoType = "ammo_9x19"
ITEM.License = "B"
ITEM.BulkPrice = 97500
ITEM.Damage = 34
ITEM.Rarity = 3
ITEM.RepairCost = 8
ITEM.Vars = {
	Equipped = false,
	CurrentAttachments = {},
	Upgrades = {
		generic_barrel_thread = true,
	},
	Durability = 100,
	Clip1 = 0,
}