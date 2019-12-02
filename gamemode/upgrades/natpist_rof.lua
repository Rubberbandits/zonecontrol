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