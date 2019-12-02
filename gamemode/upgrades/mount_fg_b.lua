--EFFECT
UPGRADE.Base = "weapon"
UPGRADE.Name = "Type B Foregrip Mount";
UPGRADE.Desc = "Allows the installation of all compatible foregrips.";

UPGRADE.IconPage = 1;
UPGRADE.IconX = 3;
UPGRADE.IconY = 5;
UPGRADE.Attachment = "";

UPGRADE.PropertiesTooltip = {
	{
		IconX = 1,
		IconY = 4,
		Text = "Allows the installation of all foregrips compatible with a Type B mount.",
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
	gun_rare_kam12 = true,
	gun_uncommon_m1014 = true,
	gun_rare_M60e4 = true,
	gun_rare_mk8 = true,
	gun_rare_pkm = true,
	gun_rare_rpd = true,
	gun_uncommon_w1200 = true,
	gun_rare_m249 = true,
}