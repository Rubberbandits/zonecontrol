--EFFECT
UPGRADE.Base = "clothes"
UPGRADE.Name = "Segmented Armor";
UPGRADE.Desc = "Armor is layered more effectively to increase durability from sustained use.";

UPGRADE.IconPage = 5
UPGRADE.IconX = 14
UPGRADE.IconY = 31

UPGRADE.DegradationProtection = 5

UPGRADE.PropertiesTooltip = {
	{
		IconX = 5,
		IconY = 5,
		Text = "+5% Durability Increase.",
	},
}

--CLASS
UPGRADE.Item = {
    suit_trenchsunrise = true,
	suit_sunrise = true,
	suit_combatsunrise = true,
}

UPGRADE.RequiredUpgrade = "sunrise_extra_kevlar_layers"

--TIER
UPGRADE.RequiredItems = {
	{ "intrm_toolkit", 1, false },
	{ "parts_suit", 2, true },
};