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

--TIER
UPGRADE.RequiredItems = {
	--{ "basic_toolkit", 1, false },
	--{ "intrm_toolkit", 1, false },
	{ "adv_toolkit", 1, false },
	{ "parts_weapon", 3, true },
};

UPGRADE.RequiredUpgrade = "sovrif_rec_rec";
UPGRADE.Incompatible = {
	"sovrif_rec_rec_acc",
};

--CLASS
UPGRADE.Item = {
    gun_common_mosin = true,
	gun_common_sks = true,
    gun_uncommon_dragunov = true,
    gun_rare_svu = true,
	gun_common_svt40 = true,
}
