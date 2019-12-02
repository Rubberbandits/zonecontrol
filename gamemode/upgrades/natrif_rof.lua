--EFFECT
UPGRADE.Base = "weapon"
UPGRADE.Name = "Rate of Fire Upgrade";
UPGRADE.Desc = "Increases the weapon's RPM, at cost of reliability.";

UPGRADE.IconPage = 1;
UPGRADE.IconX = 3;
UPGRADE.IconY = 1;
UPGRADE.Attachment = "";

UPGRADE.JamChanceModifier = 1.1
UPGRADE.AddRPM = 100

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
}

--TIER
UPGRADE.RequiredItems = {
	{ "basic_toolkit", 1, false },
	--{ "intrm_toolkit", 1, false },
	--{ "adv_toolkit", 1, false },
	{ "parts_weapon", 2, true },
};

--UPGRADE.RequiredUpgrade = "";
UPGRADE.Incompatible = {

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