ITEM.Name = "M82A1"
ITEM.Desc = ".50 BMG semi-automatic anti-materiel rifle. With the right round, can penetrate almost anything in the Zone. For the man whose cost of doing business is 400 rubles a round."
ITEM.Model = "models/weapons/tfa_cod/mwr/w_m82.mdl"
ITEM.WeaponClass = "tfa_mwr_m82"
ITEM.Weight = 13.5
ITEM.SafetyPos = Vector(0,0,0)
ITEM.SafetyAng = Angle(-12.4, 0, 0)
ITEM.JamChance = 0.05
ITEM.DegradeRate = 0.015
ITEM.FOV 			= 23;
ITEM.CamPos 		= Vector( -33.92, 80.36, 50 );
ITEM.LookAt 		= Vector( 4.83, -4.82, -4.82 );
ITEM.SelfRepairCondition = 80
ITEM.AmmoType = "50bmg"
ITEM.License = LICENSE_BLACK;
ITEM.BulkPrice = 750000
ITEM.NoDefaultAtts = true
ITEM.Vars = {
	Equipped = false,
	CurrentAttachments = {},
	Upgrades = {
		generic_opt_mount = true,
	},
	Durability = 100,
	Clip1 = 0,
};