--EFFECT
UPGRADE.Base = "clothes"
UPGRADE.Name = "Trauma Pad";
UPGRADE.Desc = "Insert behind the ballistic plate that helps to disperse blunt trauma from stopped rounds.";

UPGRADE.IconPage = 5
UPGRADE.IconX = 15
UPGRADE.IconY = 12

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
    suit_io7 = true,
}

UPGRADE.RequiredUpgrade = "io7_extra_kevlar"

--TIER
UPGRADE.RequiredItems = {
	{ "intrm_toolkit", 1, false },
	{ "parts_suit", 2, true },
};