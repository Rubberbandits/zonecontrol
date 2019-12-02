--EFFECT
UPGRADE.Base = "weapon"
UPGRADE.Name = "Combined Accuracy and Recoil Upgrade";
UPGRADE.Desc = "Increases the accuracy of the weapon, and reduces the recoil, but decreases the rate of fire and adds weight.";

UPGRADE.IconPage = 1;
UPGRADE.IconX = 3;
UPGRADE.IconY = 8;
UPGRADE.Attachment = "";

UPGRADE.ReduceSpread = 0.7
UPGRADE.ReduceRecoilUp = 0.75
UPGRADE.ReduceRecoilHorizontal = 0.75
UPGRADE.AddRPM = -100
UPGRADE.ReduceWeight = -0.5

UPGRADE.PropertiesTooltip = {
	{
		IconX = 4,
		IconY = 3,
		Text = "+30% Accuracy",
	},
		{
		IconX = 1,
		IconY = 2,
		Text = "-25% Recoil",
	},
	{
		IconX = 1,
		IconY = 1,
		Text = "Removes 100 RPM",
	},
	{
		IconX = 1,
		IconY = 7,
		Text = "Increases weight by 0.5kg",
	},
}

--TIER
UPGRADE.RequiredItems = {
	--{ "basic_toolkit", 1, false },
	--{ "intrm_toolkit", 1, false },
	{ "adv_toolkit", 1, false },
	{ "parts_weapon", 4, true },
};

UPGRADE.RequiredUpgrade = "natsmg_rec_rec";
UPGRADE.Incompatible = {
	--"natsmg_rof",
};


--CLASS
UPGRADE.Item = {
    gun_common_mac10 = true,
	gun_common_miniuzi = true,
	gun_common_mp5 = true,
	gun_uncommon_coltsmg = true,
	gun_uncommon_uzi = true,
	gun_rare_fang = true,
	gun_rare_p90 = true,
	gun_rare_spectre = true,
}