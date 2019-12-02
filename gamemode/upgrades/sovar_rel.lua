--EFFECT
UPGRADE.Base = "weapon"
UPGRADE.Name = "Reliability Upgrade";
UPGRADE.Desc = "Makes the weapon less likely to jam.";

UPGRADE.IconPage = 1;
UPGRADE.IconX = 1;
UPGRADE.IconY = 10;
UPGRADE.Attachment = "";

UPGRADE.JamChanceModifier = 0.9
UPGRADE.DegradationModifier = 0.9

UPGRADE.PropertiesTooltip = {
	{
		IconX = 1,
		IconY = 3,
		Text = "-10% Stoppage Chance",
	},
		{
		IconX = 1,
		IconY = 3,
		Text = "-10% Degradation",
	},
}

--CLASS
UPGRADE.Item = {
    gun_common_ak74 = true,
	gun_common_ak74m = true,
	gun_common_ak74u = true,
	gun_common_akm = true,
	gun_uncommon_akmagpul = true,
	gun_rare_an94 = true,
	gun_rare_asval = true,
	gun_rare_groza = true,
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
