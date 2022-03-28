ITEM.Name = "RPK"
ITEM.Desc = "An LMG-ized AKM. Uses a heavier barrel and either larger magazines or drum magazines. Decently accurate and fairly versatile compared to other LMGs. Uses 7.62x39mm"
ITEM.Model = "models/weapons/tfa_ins2/w_rpk.mdl"
ITEM.WeaponClass = "tfa_ins2_rpk"
ITEM.Weight = 5
ITEM.SafetyPos = Vector(0,0,0)
ITEM.SafetyAng = Vector(-12.4, 0, 0)
ITEM.JamChance = 0.0007
ITEM.DegradeRate = 0.01
ITEM.FOV 			= 15;
ITEM.CamPos 		= Vector( 100, 100, 25 );
ITEM.LookAt 		= Vector( 12, 0, 0.5 );
ITEM.SelfRepairCondition = 75
ITEM.AmmoType = "ammo_762x39"
ITEM.License = "B"
ITEM.BulkPrice = 144000
ITEM.Damage = 42
ITEM.Rarity = 3
ITEM.RepairCost = 12
ITEM.Vars = {
	Equipped = false,
	CurrentAttachments = {},
	Upgrades = {
		generic_opt_mount = true,
	},
	Durability = 100,
	Clip1 = 0,
},