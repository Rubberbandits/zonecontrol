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
	--{ "intrm_toolkit", 1, false },
	{ "adv_toolkit", 1, false },
	{ "parts_weapon", 3, true },
};

UPGRADE.RequiredUpgrade = "sovsmg_rel_rel";
UPGRADE.Incompatible = {
	"sovsmg_rel_rel_rec",
};

--CLASS
UPGRADE.Item = {
    gun_common_ppsh = true,
    gun_uncommon_skorpion = true,
	gun_rare_psd9 = true,
	gun_rare_sr2 = true,
}