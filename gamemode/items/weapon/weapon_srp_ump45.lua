ITEM.Name = "UMP45"
ITEM.Desc = "A cheaper, lighter alternative to the MP5 that makes heavy use of polymers, primarily designed for American military and law enforcement units. Despite the UMP's improvements and reduced cost, it did not replace the MP5. Fires .45 ACP."
ITEM.Model = "models/weapons/tfa_ins2/w_ump45.mdl"
ITEM.WeaponClass = "tfa_ins2_ump45"
ITEM.Weight = 2.65
ITEM.SafetyPos = Vector(0,0,0)
ITEM.SafetyAng = Vector(-12.4, 0, 0)
ITEM.JamChance = 0.00024
ITEM.DegradeRate = 0.016
ITEM.FOV 			= 19;
ITEM.CamPos 		= Vector( 0, 100, 0 );
ITEM.LookAt 		= Vector( 0, 0, 0 );
ITEM.SelfRepairCondition = 75
ITEM.AmmoType = "ammo_45acp"
ITEM.License = "B"
ITEM.BulkPrice = 112500
ITEM.Slot = 2
ITEM.Damage = 46
ITEM.Rarity = 3
ITEM.RepairCost = 9
ITEM.Vars = {
	Equipped = false,
	CurrentAttachments = {},
	Upgrades = {
		generic_opt_mount = true,
        generic_barrel_thread = true,
	},
	Durability = 100,
	Clip1 = 0,
}