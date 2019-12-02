--EFFECT
UPGRADE.Base = "weapon"
UPGRADE.Name = "Recoil Reduction"
UPGRADE.Desc = "Reduces the amount of recoil the user experiences."

UPGRADE.IconPage = 1;
UPGRADE.IconX = 1;
UPGRADE.IconY = 8;
UPGRADE.Attachment = "";

UPGRADE.ReduceRecoilUp = 0.85
UPGRADE.ReduceRecoilHorizontal = 0.85

UPGRADE.PropertiesTooltip = {
	{
		IconX = 1,
		IconY = 2,
		Text = "-15% Recoil",
	},
}

--CLASS
UPGRADE.Item = {
    gun_common_ak74 = true,
	gun_common_ak74m = true,
	gun_common_ak74u = true,
	gun_common_akm = true,
	gun_uncommon_akmagpul = true,
	gun_rare_an94 = true,
	gun_rare_asval = true,
	gun_rare_groza = true,
}

--TIER
UPGRADE.RequiredItems = {
	--{ "basic_toolkit", 1, false },
	--{ "intrm_toolkit", 1, false },
	{ "adv_toolkit", 1, false },
	{ "parts_weapon", 3, true },
};

UPGRADE.RequiredUpgrade = "sovar_rel_rel";
UPGRADE.Incompatible = {
	--"sovar_rel_wgt",

};
