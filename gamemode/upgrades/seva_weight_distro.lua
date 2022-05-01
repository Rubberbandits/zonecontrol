--EFFECT
UPGRADE.Base = "clothes"
UPGRADE.Name = "Weight Distribution Back Frame";
UPGRADE.Desc = "A back frame relieves focused shoulder load from the carried weight by distributing it over the body, increasing max load."

UPGRADE.IconPage = 5
UPGRADE.IconX = 13
UPGRADE.IconY = 36

UPGRADE.CarryAdd = 7

UPGRADE.PropertiesTooltip = {
	{
		IconX = 5,
		IconY = 2,
		Text = "+7kg Carrying Capacity.",
	},
}

--CLASS
UPGRADE.Item = {
    suit_seva = true,
}

--TIER
UPGRADE.RequiredItems = {
	{ "basic_sewkit", 1, false },
	{ "buckleparts", 2, true },
    { "scrapmetal", 3, true },
	{ "scrapfabric", 2, true },
};