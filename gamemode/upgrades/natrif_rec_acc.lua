--EFFECT
UPGRADE.Base = "weapon"
UPGRADE.Name = "Accuracy Upgrade";
UPGRADE.Desc = "Increases the accuracy of the weapon, but decreases the rate of fire.";

UPGRADE.IconPage = 1;
UPGRADE.IconX = 3;
UPGRADE.IconY = 8;
UPGRADE.Attachment = "";

UPGRADE.ReduceSpread = 0.7
UPGRADE.AddRPM = -100

UPGRADE.PropertiesTooltip = {
	{
		IconX = 4,
		IconY = 3,
		Text = "+30% Accuracy",
	},
	{
		IconX = 1,
		IconY = 1,
		Text = "Removes 100 RPM",
	},
}

--TIER
UPGRADE.RequiredItems = {
	--{ "basic_toolkit", 1, false },
	{ "intrm_toolkit", 1, false },
	--{ "adv_toolkit", 1, false },
	{ "parts_weapon", 3, true },
};

UPGRADE.RequiredUpgrade = "natrif_rec";
UPGRADE.Incompatible = {
	--"natrif_rec",
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