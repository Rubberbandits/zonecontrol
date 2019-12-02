--EFFECT
UPGRADE.Base = "weapon"
UPGRADE.Name = "Type B Optic Mount";
UPGRADE.Desc = "Allows the installation of all compatible optics.";

UPGRADE.IconPage = 1;
UPGRADE.IconX = 8;
UPGRADE.IconY = 5;
UPGRADE.Attachment = "";

UPGRADE.PropertiesTooltip = {
	{
		IconX = 4,
		IconY = 7,
		Text = "Allows the installation of all optic compatible with a Type B mount.",
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
	gun_rare_fang = true,
	gun_uncommon_g36c = true,
	gun_rare_kam12 = true,
	gun_uncommon_m1014 = true,
	gun_uncommon_m14 = true,
	gun_uncommon_m16a4 = true,
	gun_rare_M60e4 = true,
	gun_common_mac10 = true,
	gun_common_miniuzi = true,
	gun_rare_mk8 = true,
	gun_rare_psd9 = true,
	gun_rare_pkm = true,
	gun_rare_rpd = true,
	gun_uncommon_skorpion = true,
	gun_uncommon_w1200 = true,
	gun_veryrare_d25s = true,
	gun_rare_m21 = true,
	gun_rare_m40a3 = true,
	gun_rare_m82a1 = true,
	gun_veryrare_tac330 = true,
	gun_rare_m249 = true,
}