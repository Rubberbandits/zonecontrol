--EFFECT
UPGRADE.Base = "clothes"
UPGRADE.Name = "Leather Inserts";
UPGRADE.Desc = "Protective padding to reduce impact of objects on the body.";

UPGRADE.IconPage = 5
UPGRADE.IconX = 14
UPGRADE.IconY = 33

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
    suit_trench = true,
}

UPGRADE.RequiredUpgrade = "trench_kevlar_plates"

--TIER
UPGRADE.RequiredItems = {
	{ "intrm_toolkit", 1, false },
	{ "parts_suit", 2, true },
};