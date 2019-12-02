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
	{ "intrm_toolkit", 1, false },
	--{ "adv_toolkit", 1, false },
	{ "parts_weapon", 3, true },
};

UPGRADE.RequiredUpgrade = "natrif_rof";
UPGRADE.Incompatible = {
	"natrif_rof_rof",
};


--CLASS
UPGRADE.Item = {
    gun_uncommon_fal = true,
	gun_uncommon_m14 = true,
	--gun_uncommon_r700 = true,
	gun_uncommon_g3a3 = true,
	--gun_rare_m21 = true,
	--gun_rare_m40a3 = true,
	gun_rare_m82a1 = true,
	gun_veryrare_d25s = true,
	--gun_veryrare_tac330 = true,
}