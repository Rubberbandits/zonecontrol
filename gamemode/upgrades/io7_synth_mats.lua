--EFFECT
UPGRADE.Base = "clothes"
UPGRADE.Name = "Synthetic Materials Replacement";
UPGRADE.Desc = "Substitution of heavier components with more modern alternatives helps to remove unnecessary weight.";

UPGRADE.IconPage = 5
UPGRADE.IconX = 14
UPGRADE.IconY = 13

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
    suit_io7 = true,
}

UPGRADE.RequiredUpgrade = "io7_rubber_layer"

--TIER
UPGRADE.RequiredItems = {
	{ "intrm_toolkit", 1, false },
	{ "parts_suit", 2, true },
};