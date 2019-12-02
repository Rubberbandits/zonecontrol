--EFFECT
UPGRADE.Base = "weapon"
UPGRADE.Name = "Type A Laser Mount";
UPGRADE.Desc = "Allows the installation of all compatible laser projectors.";

UPGRADE.IconPage = 1;
UPGRADE.IconX = 3;
UPGRADE.IconY = 5;
UPGRADE.Attachment = "";

UPGRADE.PropertiesTooltip = {
	{
		IconX = 2;
		IconY = 6;
		Text = "Allows the installation of all laser projectors compatible with a Type A mount.",
	},
}

--TIER
UPGRADE.RequiredItems = {
	{ "basic_toolkit", 1, false },
	--{ "intrm_toolkit", 1, false },
	--{ "adv_toolkit", 1, false },
	--{ "parts_weapon", 1, true },
};

--UPGRADE.RequiredUpgrade = "";
UPGRADE.Incompatible = {
};


--CLASS
UPGRADE.Item = {
	gun_common_ak74m = true,
	gun_common_akm = true,
	gun_rare_aug = true,
	gun_rare_auto5d = true,
	gun_uncommon_coltsmg = true,
	gun_uncommon_cz75 = true,
	gun_rare_f200 = true,
	gun_uncommon_fal = true,
	gun_uncommon_g3a3 = true,
	gun_common_glock17 = true,
	gun_uncommon_galil = true,
	gun_uncommon_uzi = true,
	gun_rare_kimber = true,
	gun_rare_uspmatch = true,
	gun_uncommon_ksg = true,
	gun_rare_svu = true,
	gun_rare_lr300 = true,
	gun_rare_sr2 = true,
	gun_rare_spectre = true,
	gun_common_sks = true,
	gun_uncommon_m4a1 = true,
	gun_common_sks = true,
	gun_common_m500 = true,
	gun_uncommon_sa80 = true,
	gun_rare_659 = true,
	gun_rare_rpk = true,
	gun_uncommon_akmagpul = true,
	gun_rare_mk23 = true,
	gun_rare_mk18 = true,
	gun_rare_p90 = true,
	gun_common_mp5 = true,
	gun_rare_groza = true,
}