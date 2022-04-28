--EFFECT
UPGRADE.Base = "clothes"
UPGRADE.Name = "Weight Distribution Vest";
UPGRADE.Desc = "Special mounts distribute the carried load more evenly across the body.";

UPGRADE.IconPage = 5
UPGRADE.IconX = 13
UPGRADE.IconY = 36

UPGRADE.CarryAdd = 5

UPGRADE.PropertiesTooltip = {
	{
		IconX = 6,
		IconY = 3,
		Text = "+5kg Carrying Capacity.",
	},
}

--CLASS
UPGRADE.Item = {
    suit_trench = true,
}

--TIER
UPGRADE.RequiredItems = {
	{ "basic_sewkit", 1, false },
	{ "buckleparts", 1, true },
	{ "thread", 2, true },
	{ "kevlartape", 1, true },
};