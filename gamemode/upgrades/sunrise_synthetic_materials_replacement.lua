--EFFECT
UPGRADE.Base = "clothes"
UPGRADE.Name = "Synthetic Materials Replacement";
UPGRADE.Desc = "Substitution of heavier components with more modern alternatives helps to remove unnecessary weight.";

UPGRADE.IconPage = 5
UPGRADE.IconX = 14
UPGRADE.IconY = 28

UPGRADE.ReduceWeight = 1

UPGRADE.PropertiesTooltip = {
	{
		IconX = 5,
		IconY = 3,
		Text = "-1kg weight.",
	},
}

--CLASS
UPGRADE.Item = {
    suit_trenchsunrise = true,
	suit_sunrise = true,
	suit_combatsunrise = true,
}

--TIER
UPGRADE.RequiredItems = {
	{ "basic_toolkit", 1, false },
	{ "parts_suit", 1, true },
};