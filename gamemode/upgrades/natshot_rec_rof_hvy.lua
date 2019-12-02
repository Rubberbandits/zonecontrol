--EFFECT
UPGRADE.Base = "weapon"
UPGRADE.Name = "Combined ROF and Recoil Upgrade";
UPGRADE.Desc = "Increases the weapon's RPM, and decreases its recoil, at cost of reliability and added weight.";

UPGRADE.IconPage = 1;
UPGRADE.IconX = 1;
UPGRADE.IconY = 1;
UPGRADE.Attachment = "";

UPGRADE.JamChanceModifier = 1.1
UPGRADE.AddRPM = 100

UPGRADE.ReduceRecoilUp = 0.75
UPGRADE.ReduceRecoilHorizontal = 0.75

UPGRADE.ReduceWeight = -0.5

UPGRADE.PropertiesTooltip = {
	{
		IconX = 1,
		IconY = 1,
		Text = "Adds 100 RPM",
	},
		{
		IconX = 1,
		IconY = 1,
		Text = "+10% Stoppage Chance",
	},
	{
		IconX = 1,
		IconY = 2,
		Text = "-25% Recoil",
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

UPGRADE.RequiredUpgrade = "natshot_rec_rof";
UPGRADE.Incompatible = {
	--"natshot_rel",
};


--CLASS
UPGRADE.Item = {
    gun_common_m500 = true,
	gun_uncommon_ksg = true,
	gun_rare_spas12 = true,
	gun_uncommon_w1200 = true,
	gun_uncommon_m1014 = true,
}