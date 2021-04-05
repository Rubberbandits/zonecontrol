--EFFECT
UPGRADE.Base = "clothes"
UPGRADE.Name = "Insulation Treatment";
UPGRADE.Desc = "Provides a barrier from electricity, thermal activity, and chemical compounds.";

UPGRADE.IconPage = 5
UPGRADE.IconX = 16
UPGRADE.IconY = 31

UPGRADE.ArmorValues = {
	-- "Thermal"
    [DMG_BURN] = 0.80,
    [DMG_SLOWBURN] = 0.80,
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
		IconY = 3,
		Text = "+20% Thermal Protection.",
	},
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
    suit_psz = true,
}

UPGRADE.Incompatible = {
	"psz_art_cont_1"
}

UPGRADE.RequiredUpgrade = "psz_weight_distro";

--TIER
UPGRADE.RequiredItems = {
	{ "intrm_toolkit", 1, false },
	{ "parts_suit", 3, true },
};