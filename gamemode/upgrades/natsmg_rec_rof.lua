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
	{ "intrm_toolkit", 1, false },
	--{ "adv_toolkit", 1, false },
	{ "parts_weapon", 3, true },
};

UPGRADE.RequiredUpgrade = "natsmg_rec";
UPGRADE.Incompatible = {
	"natsmg_rec_rec",
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