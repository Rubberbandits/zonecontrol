--EFFECT
UPGRADE.Base = "clothes"
UPGRADE.Name = "Trauma Pad";
UPGRADE.Desc = "Insert behind the ballistic plate that helps to disperse blunt trauma from stopped rounds.";

UPGRADE.IconPage = 5
UPGRADE.IconX = 15
UPGRADE.IconY = 12

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
    suit_io7 = true,
	suit_trenchio7 = true,
}

UPGRADE.RequiredUpgrade = "io7_extra_kevlar"

--TIER
UPGRADE.RequiredItems = {
	{ "intrm_sewkit", 1, false },
	{ "sewing_machine", 1, false },
	{ "thread", 3, true },
};