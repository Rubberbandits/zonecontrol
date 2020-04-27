--EFFECT
UPGRADE.Base = "clothes"
UPGRADE.Name = "Extra Polyethylene Layers";
UPGRADE.Desc = "The natural addition of a particularly effective and lightweight body armor solution.";

UPGRADE.IconPage = 5
UPGRADE.IconX = 15
UPGRADE.IconY = 27

UPGRADE.ArmorValues = {
	-- "Bulletproof"
	[DMG_BULLET] = 0.9, -- 10% increase in resistance
}

UPGRADE.PropertiesTooltip = {
	{
		IconX = 5,
		IconY = 1,
		Text = "+10% Bulletproof.",
	},
}

--CLASS
UPGRADE.Item = {
    suit_psz = true,
}

--TIER
UPGRADE.RequiredItems = {
	{ "basic_toolkit", 1, false },
	{ "parts_suit", 1, true },
};