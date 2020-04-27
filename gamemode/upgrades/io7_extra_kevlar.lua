--EFFECT
UPGRADE.Base = "clothes"
UPGRADE.Name = "Extra Kevlar Layers";
UPGRADE.Desc = "The natural addition of one of the most common body armor solutions in the Zone.";

UPGRADE.IconPage = 5
UPGRADE.IconX = 13
UPGRADE.IconY = 11

UPGRADE.ArmorValues = {
	-- "Bulletproof"
	[DMG_BULLET] = 0.95, -- 5% increase in resistance
}

UPGRADE.PropertiesTooltip = {
	{
		IconX = 5,
		IconY = 1,
		Text = "+5% Bulletproof.",
	},
}

--CLASS
UPGRADE.Item = {
    suit_io7 = true,
}

--TIER
UPGRADE.RequiredItems = {
	{ "basic_toolkit", 1, false },
	{ "parts_suit", 1, true },
};