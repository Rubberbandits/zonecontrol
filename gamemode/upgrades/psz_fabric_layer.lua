--EFFECT
UPGRADE.Base = "clothes"
UPGRADE.Name = "Thickened Fabric Layer";
UPGRADE.Desc = "Prevents damage to soft tissue from the impact of stopped bullets.";

UPGRADE.IconPage = 5
UPGRADE.IconX = 14
UPGRADE.IconY = 27

UPGRADE.ArmorValues = {
	-- "Impact" (blunt)
	[DMG_CRUSH] = .9, -- 10% increase
	[DMG_FALL] = .9,
	[DMG_CLUB] = .9,
	[DMG_VEHICLE] = .9,
}

UPGRADE.PropertiesTooltip = {
	{
		IconX = 8,
		IconY = 8,
		Text = "+10% Impact.",
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