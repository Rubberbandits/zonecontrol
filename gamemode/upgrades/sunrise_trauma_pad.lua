--EFFECT
UPGRADE.Base = "clothes"
UPGRADE.Name = "Trauma Pad Insert";
UPGRADE.Desc = "What little room is available has been altered to support a cushion for blunt force trauma.";

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
    suit_trenchsunrise = true,
	suit_sunrise = true,
	suit_combatsunrise = true,
}

UPGRADE.RequiredUpgrade = "sunrise_extra_kevlar_layers"

--TIER
UPGRADE.RequiredItems = {
	{ "intrm_sewkit", 1, false },
	{ "sewing_machine", 1, false },
	{ "thread", 3, true },
};