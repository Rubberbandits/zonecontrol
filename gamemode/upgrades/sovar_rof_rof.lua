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

--CLASS
UPGRADE.Item = {
    gun_common_ak74 = true,
	gun_common_ak74m = true,
	gun_common_ak74u = true,
	gun_common_akm = true,
	gun_uncommon_akmagpul = true,
	gun_rare_an94 = true,
	gun_rare_asval = true,
	gun_rare_groza = true,
}

--TIER
UPGRADE.RequiredItems = {
	--{ "basic_toolkit", 1, false },
	{ "intrm_toolkit", 1, false },
	--{ "adv_toolkit", 1, false },
	{ "parts_weapon", 2, true },
};

UPGRADE.RequiredUpgrade = "sovar_rof";
UPGRADE.Incompatible = {
	--"sovar"
};
