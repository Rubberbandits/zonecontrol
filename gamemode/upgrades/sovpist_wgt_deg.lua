--EFFECT
UPGRADE.Base = "weapon"
UPGRADE.Name = "Degradation Resistance Upgrade";
UPGRADE.Desc = "Decreases the rate at which the weapon degrades by strengthening internal parts.";

UPGRADE.IconPage = 1;
UPGRADE.IconX = 1;
UPGRADE.IconY = 10;
UPGRADE.Attachment = "";

UPGRADE.DegradationModifier = 0.8

UPGRADE.PropertiesTooltip = {
	{
		IconX = 1,
		IconY = 3,
		Text = "-20% Degradation",
	},
}
--TIER
UPGRADE.RequiredItems = {
	--{ "basic_toolkit", 1, false },
	{ "intrm_toolkit", 1, false },
	--{ "adv_toolkit", 1, false },
	{ "parts_weapon", 2, true },
};
UPGRADE.RequiredUpgrade = "sovpist_wgt";
UPGRADE.Incompatible = {
	"sovpist_wgt_rec",
};

--CLASS
UPGRADE.Item = {
    gun_common_makarov = true,
    gun_common_tokarev = true,
	gun_uncommon_grach = true,
	gun_rare_arsenalstrike = true,
}