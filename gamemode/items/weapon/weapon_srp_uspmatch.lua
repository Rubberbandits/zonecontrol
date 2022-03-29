ITEM.Name = "H&K USP Match"
ITEM.Desc = "A specialized USP with a compensator and more finely machined parts. A weapon for Stalkers not content with regular pistols.  Uses .45 ACP."
ITEM.Model = "models/weapons/tfa_ins2/w_usp_match.mdl"
ITEM.WeaponClass = "tfa_ins2_usp_match"
ITEM.Weight = 1.25
ITEM.SafetyPos = Vector(0,0,0)
ITEM.SafetyAng = Vector(-12.4, 0, 0)
ITEM.JamChance = 0.0007
ITEM.DegradeRate = 0.0166
ITEM.FOV 			= 10;
ITEM.CamPos 		= Vector( 50, 50, 50 );
ITEM.LookAt 		= Vector( 0, 0, 0 );
ITEM.SelfRepairCondition = 85
ITEM.AmmoType = "ammo_45acp"
ITEM.License = "B"
ITEM.BulkPrice = 122500
ITEM.Damage = 45
ITEM.Rarity = 4
ITEM.RepairCost = 10
ITEM.Vars = {
	Equipped = false,
	CurrentAttachments = {},
	Upgrades = {
		generic_opt_mount = true,
	},
	Durability = 100,
	Clip1 = 0,
}