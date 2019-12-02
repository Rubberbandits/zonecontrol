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
	--{ "basic_toolkit", 1, false },
	--{ "intrm_toolkit", 1, false },
	{ "adv_toolkit", 1, false },
	{ "parts_weapon", 4, true },
};

UPGRADE.RequiredUpgrade = "natar_rec_rec";
UPGRADE.Incompatible = {
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