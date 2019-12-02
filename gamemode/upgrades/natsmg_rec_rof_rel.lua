--EFFECT
UPGRADE.Base = "weapon"
UPGRADE.Name = "Reliability Upgrade";
UPGRADE.Desc = "Makes the weapon less likely to jam, but increases degradation rate.";

UPGRADE.IconPage = 1;
UPGRADE.IconX = 1;
UPGRADE.IconY = 10;
UPGRADE.Attachment = "";

UPGRADE.JamChanceModifier = 0.7
UPGRADE.DegradationModifier = 1.1

UPGRADE.PropertiesTooltip = {
	{
		IconX = 1,
		IconY = 3,
		Text = "-30% Stoppage Chance",
	},
	{
		IconX = 1,
		IconY = 3,
		Text = "+10% Degradation",
	},
}

--TIER
UPGRADE.RequiredItems = {
	--{ "basic_toolkit", 1, false },
	--{ "intrm_toolkit", 1, false },
	{ "adv_toolkit", 1, false },
	{ "parts_weapon", 4, true },
};

UPGRADE.RequiredUpgrade = "natsmg_rec_rof";
UPGRADE.Incompatible = {
	--"natsmg_rof",
};


--CLASS
UPGRADE.Item = {
    gun_common_mac10 = true,
	gun_common_miniuzi = true,
	gun_common_mp5 = true,
	gun_uncommon_coltsmg = true,
	gun_uncommon_uzi = true,
	gun_rare_fang = true,
	gun_rare_p90 = true,
	gun_rare_spectre = true,
}