--EFFECT
UPGRADE.Base = "clothes"
UPGRADE.Name = "Treated Bodysuit Fabric";
UPGRADE.Desc = "Defeats incoming chemical particles that may cause poisoning or chemical burns.";

UPGRADE.IconPage = 5
UPGRADE.IconX = 5
UPGRADE.IconY = 15

UPGRADE.ArmorValues = {
	-- "Chemical Burn"
    [DMG_ACID] = 0.65,
    [DMG_POISON] = 0.65,
    [DMG_NERVEGAS] = 0.65,
}

UPGRADE.PropertiesTooltip = {
	{
		IconX = 7,
		IconY = 2,
		Text = "+35% Chemical Protection.",
	},
}

--CLASS
UPGRADE.Item = {
    suit_trenchsunrise = true,
	suit_sunrise = true,
	suit_combatsunrise = true,
}

UPGRADE.Incompatible = {
	"sunrise_rubberized_bodysuit_lead_inserts"
}

UPGRADE.RequiredUpgrade = "sunrise_magnesium_plate_inserts";

--TIER
UPGRADE.RequiredItems = {
	{ "adv_toolkit", 1, false },
	{ "parts_suit", 3, true },
};