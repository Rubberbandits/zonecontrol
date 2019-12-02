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

UPGRADE.RequiredUpgrade = "natpist_rof";
UPGRADE.Incompatible = {
	"natpist_rof_rof",
};


--CLASS
UPGRADE.Item = {
    gun_common_glock17 = true,
	gun_uncommon_1911 = true,
	gun_uncommon_m9 = true,
	gun_uncommon_usp = true,
	gun_uncommon_cs75 = true,
	gun_rare_44mag = true,
	gun_rare_deagle = true,
	gun_rare_kimber = true,
	gun_rare_mk23 = true,
	gun_rare_659 = true,
	gun_rare_uspmatch = true,
	gun_rare_arsenalstrike = true,
}