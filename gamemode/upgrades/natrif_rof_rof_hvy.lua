--EFFECT
UPGRADE.Base = "weapon"
UPGRADE.Name = "Combined ROF and Recoil Upgrade";
UPGRADE.Desc = "Increases the weapon's RPM, and decreases its recoil, at cost of reliability and added weight.";

UPGRADE.IconPage = 1;
UPGRADE.IconX = 3;
UPGRADE.IconY = 1;
UPGRADE.Attachment = "";

UPGRADE.JamChanceModifier = 1.1
UPGRADE.AddRPM = 100

UPGRADE.ReduceRecoilUp = 0.75
UPGRADE.ReduceRecoilHorizontal = 0.75

UPGRADE.ReduceWeight = -1

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

UPGRADE.RequiredUpgrade = "natrif_rof_rof";
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