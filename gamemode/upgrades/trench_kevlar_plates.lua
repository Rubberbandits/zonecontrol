--EFFECT
UPGRADE.Base = "clothes"
UPGRADE.Name = "Kevlar Panels";
UPGRADE.Desc = "Soft body armor sewn directly into the coat.";

UPGRADE.IconPage = 5
UPGRADE.IconX = 13
UPGRADE.IconY = 33

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
    suit_trench = true,
}

--TIER
UPGRADE.RequiredItems = {
	{ "basic_sewkit", 1, false },
	{ "scrapfabric", 2, true },
	{ "scrappatch", 2, true },
};