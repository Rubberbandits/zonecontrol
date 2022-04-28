--EFFECT
UPGRADE.Base = "clothes"
UPGRADE.Name = "Sewn-in Chainmail";
UPGRADE.Desc = "Painstakingly linked chain vest integrated into the vest. It's quite heavy.";

UPGRADE.IconPage = 5
UPGRADE.IconX = 15
UPGRADE.IconY = 12

UPGRADE.ArmorValues = {
	-- "Rupture" (sharp)
	[DMG_SLASH] = 0.85,
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
    suit_io7 = true,
}

UPGRADE.RequiredUpgrade = "io7_synth_mats"

--TIER
UPGRADE.RequiredItems = {
	{ "adv_sewkit", 1, false },
	{ "scrapmetal", 2, true },
	{ "thread", 1, true },
};