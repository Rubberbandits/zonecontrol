--EFFECT
UPGRADE.Base = "clothes"
UPGRADE.Name = "Rubberized Cloth Layer";
UPGRADE.Desc = "Additional fabric remains if the main layer is torn.";

UPGRADE.IconPage = 5
UPGRADE.IconX = 13
UPGRADE.IconY = 34

UPGRADE.DegradationProtection = 10

UPGRADE.PropertiesTooltip = {
	{
		IconX = 5,
		IconY = 5,
		Text = "+10% Durability Increase.",
	},
}

--CLASS
UPGRADE.Item = {
    suit_trench = true,
}

--TIER
UPGRADE.RequiredItems = {
	{ "basic_sewkit", 1, false },
	{ "blanket", 2, true },
	{ "scrapfabric", 2, true },
};