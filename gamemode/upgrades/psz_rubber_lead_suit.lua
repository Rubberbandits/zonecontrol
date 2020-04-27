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
    suit_psz = true,
}

UPGRADE.Incompatible = {
	"psz_protective_frame"
}

UPGRADE.RequiredUpgrade = "psz_rubber_suit";

--TIER
UPGRADE.RequiredItems = {
	{ "adv_toolkit", 1, false },
	{ "parts_suit", 4, true },
};