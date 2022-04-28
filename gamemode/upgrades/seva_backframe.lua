--EFFECT
UPGRADE.Base = "clothes"
UPGRADE.Name = "Weight Distribution Back Frame";
UPGRADE.Desc = "A back frame relieves focused shoulder load from the carried weight by distributing it over the body, increasing max load."

UPGRADE.IconPage = 5
UPGRADE.IconX = 12
UPGRADE.IconY = 36

UPGRADE.CarryAdd = 10

UPGRADE.PropertiesTooltip = {
	{
		IconX = 6,
		IconY = 3,
		Text = "+10kg Carrying Capacity.",
	},
}

--CLASS
UPGRADE.Item = {
    suit_seva = true,
}

UPGRADE.RequiredUpgrade = "seva_weight_distro"

--TIER
UPGRADE.RequiredItems = {
	{ "intrm_sewkit", 1, false },
	{ "buckleparts", 1, true },
    { "scrapmetal", 3, true },
	{ "scrapfabric", 1, true },
};