--EFFECT
UPGRADE.Base = "clothes"
UPGRADE.Name = "Rubberized Bodysuit With Lead Mesh Inserts";
UPGRADE.Desc = "Radiologically insulates the wearer from the environment.";

UPGRADE.IconPage = 5
UPGRADE.IconX = 5
UPGRADE.IconY = 13

UPGRADE.ArmorValues = {
	-- "Radiation"
    [DMG_RADIATION] = 0.70,
}

UPGRADE.PropertiesTooltip = {
	{
		IconX = 6,
		IconY = 4,
		Text = "+30% Radiation Protection.",
	},
}

--CLASS
UPGRADE.Item = {
    suit_trenchsunrise = true,
	suit_sunrise = true,
	suit_combatsunrise = true,
}

UPGRADE.Incompatible = {
	"sunrise_treated_bodysuit_fabric"
}

UPGRADE.RequiredUpgrade = "sunrise_polymer_internal_layer";

--TIER
UPGRADE.RequiredItems = {
	{ "adv_toolkit", 1, false },
	{ "parts_suit", 4, true },
};