--EFFECT
UPGRADE.Base = "clothes"
UPGRADE.Name = "Trauma Pad Insert";
UPGRADE.Desc = "What little room is available has been altered to support a cushion for blunt force trauma.";

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

UPGRADE.RequiredUpgrade = "psz_poly_layers"

--TIER
UPGRADE.RequiredItems = {
	{ "intrm_sewkit", 1, false },
	{ "sewing_machine", 1, false },
	{ "thread", 3, true },
}