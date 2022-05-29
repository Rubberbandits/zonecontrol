--EFFECT
UPGRADE.Base = "clothes"
UPGRADE.Name = "Rubberized Cloth Layer";
UPGRADE.Desc = "Additional fabric remains if the main layer is torn.";

UPGRADE.IconPage = 5
UPGRADE.IconX = 14
UPGRADE.IconY = 11

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
    suit_io7 = true,
	suit_trenchio7 = true,
}

--TIER
UPGRADE.RequiredItems = {
	{ "basic_sewkit", 1, false },
	{ "scrapfabric", 2, true },
	{ "thread", 2, true },
};