--EFFECT
UPGRADE.Base = "clothes"
UPGRADE.Name = "Magnesium Plate Inserts";
UPGRADE.Desc = "Protects the user from intense thermal activity.";

UPGRADE.IconPage = 5
UPGRADE.IconX = 2
UPGRADE.IconY = 21

UPGRADE.ArmorValues = {
	-- "Thermal"
    [DMG_BURN] = 0.90,
    [DMG_SLOWBURN] = 0.90,
}

UPGRADE.PropertiesTooltip = {
	{
		IconX = 7,
		IconY = 3,
		Text = "+10% Thermal Protection.",
	},
}

--CLASS
UPGRADE.Item = {
    suit_trenchsunrise = true,
	suit_sunrise = true,
	suit_combatsunrise = true,
}

UPGRADE.Incompatible = {
	"sunrise_polymer_internal_layer"
}

UPGRADE.RequiredUpgrade = "sunrise_synthetic_materials_replacement";

--TIER
UPGRADE.RequiredItems = {
	{ "intrm_sewkit", 1, false },
	{ "scrapmetal", 4, true },
	{ "thread", 3, true },
};