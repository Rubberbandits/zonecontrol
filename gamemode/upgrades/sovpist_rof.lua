--EFFECT
UPGRADE.Base = "weapon"
UPGRADE.Name = "Rate of Fire Upgrade";
UPGRADE.Desc = "Increases the weapon's RPM.";

UPGRADE.IconPage = 1;
UPGRADE.IconX = 3;
UPGRADE.IconY = 1;
UPGRADE.Attachment = "";

UPGRADE.AddRPM = 70

UPGRADE.PropertiesTooltip = {
	{
		IconX = 1,
		IconY = 1,
		Text = "Adds 70 RPM",
	},
}

--TIER
UPGRADE.RequiredItems = {
	{ "basic_toolkit", 1, false },
	--{ "intrm_toolkit", 1, false },
	--{ "adv_toolkit", 1, false },
	{ "parts_weapon", 1, true },
};
--UPGRADE.RequiredUpgrade = "";
UPGRADE.Incompatible = {
	--"test",
};

--CLASS
UPGRADE.Item = {
    gun_common_makarov = true,
    gun_common_tokarev = true,
	gun_uncommon_grach = true,
	gun_rare_arsenalstrike = true,
}