--EFFECT
UPGRADE.Base = "clothes"
UPGRADE.Name = "Polymer Internal Layer";
UPGRADE.Desc = "Creates a barrier between the user and various chemical and electric threats.";

UPGRADE.IconPage = 5
UPGRADE.IconX = 2
UPGRADE.IconY = 30

UPGRADE.ArmorValues = {
	-- "Chemical Burn"
    [DMG_ACID] = 0.85,
    [DMG_POISON] = 0.85,
    [DMG_NERVEGAS] = 0.85,
    -- "Electric Shock"
    [DMG_SHOCK] = 0.85,
}

UPGRADE.PropertiesTooltip = {
	{
		IconX = 7,
		IconY = 2,
		Text = "+15% Chemical Protection.",
	},
	{
		IconX = 5,
		IconY = 7,
		Text = "+15% Electricity Protection.",
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
	{ "intrm_sewkit", 1, false },
	{ "scrapfabric", 4, true },
	{ "thread", 3, true },
};