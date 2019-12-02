--EFFECT
UPGRADE.Base = "weapon"
UPGRADE.Name = "Type A Foregrip Mount";
UPGRADE.Desc = "Allows the installation of all compatible foregrips.";

UPGRADE.IconPage = 1;
UPGRADE.IconX = 3;
UPGRADE.IconY = 5;
UPGRADE.Attachment = "";

UPGRADE.PropertiesTooltip = {
	{
		IconX = 1,
		IconY = 4,
		Text = "Allows the installation of all foregrips compatible with a Type A mount.",
	},
}

--TIER
UPGRADE.RequiredItems = {
	{ "basic_toolkit", 1, false },
	--{ "intrm_toolkit", 1, false },
	--{ "adv_toolkit", 1, false },
	{ "parts_weapon", 1, true },
};

--UPGRADE.RequiredUpgrade = "";
UPGRADE.Incompatible = {
};


--CLASS
UPGRADE.Item = {
    gun_common_ak74m = true,
	gun_rare_an94 = true,
	gun_rare_asval = true,
	gun_rare_aug = true,
	gun_rare_auto5d = true,
	gun_rare_coltsmg = true,
	gun_rare_f2000 = true,
	gun_uncommon_galil = true,
	gun_uncommon_ksg = true,
	gun_rare_svu = true,
	gun_rare_lr300 = true,
	gun_uncommon_m4a1 = true,
	gun_common_sks = true,
	gun_uncommon_sa80 = true,
	gun_rare_mk18 = true,
}