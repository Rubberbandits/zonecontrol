--EFFECT
UPGRADE.Base = "clothes"
UPGRADE.Name = "Polymer Internal Layer";
UPGRADE.Desc = "Creates a barrier between the user and various chemical and electric threats.";

UPGRADE.IconPage = 5
UPGRADE.IconX = 2
UPGRADE.IconY = 30

UPGRADE.ArmorValues = {
	-- "Chemical Burn"
    [DMG_ACID] = 0.80,
    [DMG_POISON] = 0.80,
    [DMG_NERVEGAS] = 0.80,
    -- "Electric Shock"
    [DMG_SHOCK] = 0.80,
}

UPGRADE.PropertiesTooltip = {
	{
		IconX = 7,
		IconY = 2,
		Text = "+20% Chemical Protection.",
	},
	{
		IconX = 5,
		IconY = 7,
		Text = "+20% Electricity Protection.",
	}
}

--CLASS
UPGRADE.Item = {
    suit_trenchsunrise = true,
	suit_sunrise = true,
	suit_combatsunrise = true,
}

UPGRADE.Incompatible = {
	"sunrise_magnesium_plate_inserts"
}

UPGRADE.RequiredUpgrade = "sunrise_synthetic_materials_replacement";

--TIER
UPGRADE.RequiredItems = {
	{ "intrm_toolkit", 1, false },
	{ "parts_suit", 3, true },
};