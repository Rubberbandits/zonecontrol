--EFFECT
UPGRADE.Base = "weapon"
UPGRADE.Name = "Type B Barrel Thread";
UPGRADE.Desc = "Allows the installation type B suppressors.";

UPGRADE.IconPage = 1;
UPGRADE.IconX = 3;
UPGRADE.IconY = 5;
UPGRADE.Attachment = "";

UPGRADE.PropertiesTooltip = {
	{
		IconX = 2,
		IconY = 3,
		Text = "Allows the installation of all suppressors compatible with a Type B Barrel Thread.",
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
	gun_rare_44mag = true,
	gun_rare_fang = true,
	gun_uncommon_g36c = true,
	gun_uncommon_m14 = true,
	gun_uncommon_m16a4 = true,
	gun_rare_m21 = true,
	gun_uncommon_m9 = true,
	gun_common_mac10 = true,
	gun_common_miniuzi = true,
	gun_rare_psd9 = true,
	gun_rare_arsenalstrike = true,
	gun_uncommon_skorpion = true,
	gun_uncommon_usp = true,
}