--EFFECT
UPGRADE.Base = "clothes"
UPGRADE.Name = "Thickened Fabric Layer";
UPGRADE.Desc = "Prevents damage to soft tissue from the impact of stopped bullets.";

UPGRADE.IconPage = 5
UPGRADE.IconX = 14
UPGRADE.IconY = 27

UPGRADE.ArmorValues = {
	-- "Impact" (blunt)
	[DMG_CRUSH] = 0.9, -- 10% increase
	[DMG_FALL] = 0.9,
	[DMG_CLUB] = 0.9,
	[DMG_VEHICLE] = 0.9,
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
	{ "basic_sewkit", 1, false },
	{ "kevlartape", 1, true },
	{ "scrapfabric", 2, true },
	{ "thread", 2, true },
};