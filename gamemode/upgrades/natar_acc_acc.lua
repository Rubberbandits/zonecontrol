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

UPGRADE.RequiredUpgrade = "natar_acc";
UPGRADE.Incompatible = {
	--"natar_acc",
};


--CLASS
UPGRADE.Item = {
    gun_uncommon_g36c = true,
	gun_uncommon_sa80 = true,
	gun_uncommon_m16 = true,
	gun_uncommon_m4a1 = true,
	gun_uncommon_galil = true,
	gun_rare_aug = true,
	gun_rare_auto5d = true,
	gun_rare_f2000 = true,
	gun_rare_lr300 = true,
	gun_rare_mk18 = true,
}