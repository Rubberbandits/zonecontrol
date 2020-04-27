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
    suit_psz = true,
}

UPGRADE.RequiredUpgrade = "psz_fabric_layer"
UPGRADE.Incompatible = {
	"psz_rubber_suit",
}

--TIER
UPGRADE.RequiredItems = {
	{ "intrm_toolkit", 1, false },
	{ "parts_suit", 2, true },
};