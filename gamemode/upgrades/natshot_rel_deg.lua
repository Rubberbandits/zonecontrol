--EFFECT
UPGRADE.Base = "weapon"
UPGRADE.Name = "Degradation Upgrade";
UPGRADE.Desc = "Decreases the rate of degradation, but increases the chance of a stoppage.";

UPGRADE.IconPage = 1;
UPGRADE.IconX = 1;
UPGRADE.IconY = 10;
UPGRADE.Attachment = "";

UPGRADE.JamChanceModifier = 1.1
UPGRADE.DegradationModifier = 0.7

UPGRADE.PropertiesTooltip = {

	{
		IconX = 1,
		IconY = 3,
		Text = "-30% Degradation",
	},
	{
		IconX = 1,
		IconY = 3,
		Text = "+10% Stoppage Chance",
	},
}

--TIER
UPGRADE.RequiredItems = {
	--{ "basic_toolkit", 1, false },
	{ "intrm_toolkit", 1, false },
	--{ "adv_toolkit", 1, false },
	{ "parts_weapon", 3, true },
};

UPGRADE.RequiredUpgrade = "natshot_rel";
UPGRADE.Incompatible = {
	"natshot_rel_rel",
};


--CLASS
UPGRADE.Item = {
    gun_common_m500 = true,
	gun_uncommon_ksg = true,
	gun_rare_spas12 = true,
	gun_uncommon_w1200 = true,
	gun_uncommon_m1014 = true,
}