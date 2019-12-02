--EFFECT
UPGRADE.Base = "clothes"
UPGRADE.Name = "\"Sovereign\" Compound Treatment";
UPGRADE.Desc = "Significantly increases the suit's overall durability in under harsh conditions.";

UPGRADE.IconPage = 5
UPGRADE.IconX = 14
UPGRADE.IconY = 31

UPGRADE.DegradationProtection = 10

UPGRADE.PropertiesTooltip = {
	{
		IconX = 5,
		IconY = 5,
		Text = "+10% Durability Increase.",
	},
}

--CLASS
UPGRADE.Item = {
    suit_trenchsunrise = true,
	suit_sunrise = true,
	suit_combatsunrise = true,
}

UPGRADE.RequiredUpgrade = "sunrise_segmented_armor"

--TIER
UPGRADE.RequiredItems = {
	{ "adv_toolkit", 1, false },
	{ "parts_suit", 3, true },
};