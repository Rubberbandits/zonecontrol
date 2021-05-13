--EFFECT
UPGRADE.Base = "clothes"
UPGRADE.Name = "Synthetic Materials Replacement";
UPGRADE.Desc = "Substitution of heavier components with more modern alternatives helps to remove unnecessary weight.";

UPGRADE.IconPage = 5
UPGRADE.IconX = 14
UPGRADE.IconY = 28

UPGRADE.ReduceWeight = 2

UPGRADE.PropertiesTooltip = {
	{
		IconX = 5,
		IconY = 3,
		Text = "-2kg weight.",
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
	{ "basic_sewkit", 1, false },
	{ "blanket", 1, true },
	{ "thread", 3, true },
	{ "scrapfabric", 1, true },
};