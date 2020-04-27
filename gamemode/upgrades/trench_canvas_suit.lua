--EFFECT
UPGRADE.Base = "clothes"
UPGRADE.Name = "Canvas Bodysuit";
UPGRADE.Desc = "Provides a barrier from electricity and caustic substances.";

UPGRADE.IconPage = 5
UPGRADE.IconX = 14
UPGRADE.IconY = 34

UPGRADE.ArmorValues = {
	-- "Chemical Burn"
    [DMG_ACID] = 0.85,
    [DMG_POISON] = 0.85,
    [DMG_NERVEGAS] = 0.85,
	-- "Electric Shock"
	[DMG_SHOCK] = .25,
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
		Text = "+10% Electrical Protection",
	},
}

--CLASS
UPGRADE.Item = {
    suit_trench = true
}

UPGRADE.Incompatible = {
	"trench_flame_suit"
}

UPGRADE.RequiredUpgrade = "trench_rubber_layer";

--TIER
UPGRADE.RequiredItems = {
	{ "intrm_toolkit", 1, false },
	{ "parts_suit", 2, true },
};