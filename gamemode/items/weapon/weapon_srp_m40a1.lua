ITEM.Name = "M40A1"
ITEM.Desc = "This US Army sniper rifle must have 'fallen off a truck.' Based on the civilian Remington 700, the M40A1 is a basic but accurate rifle. Fires 7.62x51mm."
ITEM.Model = "models/weapons/tfa_ins2/w_m40a1.mdl"
ITEM.WeaponClass = "tfa_ins2_m40a1"
ITEM.Weight = 2
ITEM.SafetyPos = Vector(0,0,0)
ITEM.SafetyAng = Angle(-12.4, 0, 0)
ITEM.JamChance = 0.0002
ITEM.DegradeRate = 0.05
ITEM.FOV 			= 12
ITEM.CamPos 		= Vector( 100, 100, 25 )
ITEM.LookAt 		= Vector( 7, 0, 0 )
ITEM.SelfRepairCondition = 70
ITEM.AmmoType = "ammo_762x51"
ITEM.License = "B"
ITEM.BulkPrice = 250000
ITEM.Slot = 2
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
