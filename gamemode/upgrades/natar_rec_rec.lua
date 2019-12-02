--EFFECT
UPGRADE.Base = "weapon"
UPGRADE.Name = "Recoil Reduction"
UPGRADE.Desc = "Reduces the amount of recoil the user experiences, but increases weight."

UPGRADE.IconPage = 1;
UPGRADE.IconX = 1;
UPGRADE.IconY = 8;
UPGRADE.Attachment = "";

UPGRADE.ReduceRecoilUp = 0.75
UPGRADE.ReduceRecoilHorizontal = 0.75

UPGRADE.ReduceWeight = -0.5

UPGRADE.PropertiesTooltip = {
	{
		IconX = 1,
		IconY = 2,
		Text = "-25% Recoil",
	},
	{
		IconX = 1,
		IconY = 7,
		Text = "Increases weight by 0.5kg",
	},
}

--TIER
UPGRADE.RequiredItems = {
	--{ "basic_toolkit", 1, false },
	{ "intrm_toolkit", 1, false },
	--{ "adv_toolkit", 1, false },
	{ "parts_weapon", 3, true },
};

UPGRADE.RequiredUpgrade = "natar_rec";
UPGRADE.Incompatible = {
};


--CLASS
UPGRADE.Item = {
    gun_uncommon_g36c = true,
	gun_uncommon_sa80 = true,
	gun_uncommon_m16 = true,
	gun_uncommon_m4a1 = true,
	gun_uncommon_galil = true,
	gun_rare_aug = true,
	gun_rare_auto5d = true,
	gun_rare_f2000 = true,
	gun_rare_lr300 = true,
	gun_rare_mk18 = true,
}