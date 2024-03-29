ITEM.Name = "PKP"
ITEM.Desc = "A modernized PKM. Obviously rarer than the PKM. Not many differences aside from a more accurate but non-removable barrel.  Uses 7.62x54R."
ITEM.Model = "models/weapons/tfa_ins2/w_pkm.mdl"
ITEM.WeaponClass = "tfa_ins2_pkp"
ITEM.Weight = 8.5
ITEM.SafetyPos = Vector(0,0,0)
ITEM.SafetyAng = Vector(-12.4, 0, 0)
ITEM.JamChance = 0.00015
ITEM.DegradeRate = 0.01
ITEM.FOV 			= 12;
ITEM.CamPos 		= Vector( 100, 100, 25 );
ITEM.LookAt 		= Vector( 8, 0, 0 );
ITEM.SelfRepairCondition = 80
ITEM.AmmoType = "ammo_762x54r"
ITEM.BulkPrice = 310000
ITEM.Damage = 65
ITEM.Rarity = 4
ITEM.RepairCost = 25
ITEM.Vars = {
	Equipped = false,
	CurrentAttachments = {},
	Upgrades = {
		generic_opt_mount = true,
	},
	Durability = 100,
	Clip1 = 0,
}