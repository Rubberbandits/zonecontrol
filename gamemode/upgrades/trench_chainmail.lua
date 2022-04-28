--EFFECT
UPGRADE.Base = "clothes"
UPGRADE.Name = "Sewn-in Chainmail";
UPGRADE.Desc = "Painstakingly linked chain vest integrated into the coat. It's quite heavy.";

UPGRADE.IconPage = 5
UPGRADE.IconX = 15
UPGRADE.IconY = 33

UPGRADE.ArmorValues = {
	-- "Rupture" (sharp)
	[DMG_SLASH] = .85,
}

UPGRADE.ReduceWeight = -2

UPGRADE.PropertiesTooltip = {
	{
		IconX = 8,
		IconY = 8,
		Text = "+15% Rupture.",
	},
	{
		IconX = 6,
		IconY = 3,
		Text = "+2kg Weight",
	},
}

--CLASS
UPGRADE.Item = {
    suit_trench = true,
}

UPGRADE.RequiredUpgrade = "trench_leather_inserts"

--TIER
UPGRADE.RequiredItems = {
	{ "adv_sewkit", 1, false },
	{ "scrapmetal", 3, true },
	{ "kevlartape", 2, true },
};