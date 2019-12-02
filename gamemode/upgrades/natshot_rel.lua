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
	{ "basic_toolkit", 1, false },
	--{ "intrm_toolkit", 1, false },
	--{ "adv_toolkit", 1, false },
	{ "parts_weapon", 2, true },
};

--UPGRADE.RequiredUpgrade = "";
UPGRADE.Incompatible = {

};


--CLASS
UPGRADE.Item = {
    gun_common_m500 = true,
	gun_uncommon_ksg = true,
	gun_rare_spas12 = true,
	gun_uncommon_w1200 = true,
	gun_uncommon_m1014 = true,
}