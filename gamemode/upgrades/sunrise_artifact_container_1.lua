--EFFECT
UPGRADE.Base = "clothes"
UPGRADE.Name = "Artifact Container";
UPGRADE.Desc = "Attaches another artifact container to the suit.";

UPGRADE.IconPage = 5
UPGRADE.IconX = 15
UPGRADE.IconY = 31

UPGRADE.ArtifactSlots = 1

UPGRADE.PropertiesTooltip = {
	{
		IconX = 6,
		IconY = 7,
		Text = "+1 Artifact Container.",
	},
}

--CLASS
UPGRADE.Item = {
    suit_trenchsunrise = true,
	suit_sunrise = true,
	suit_combatsunrise = true,
}

--TIER
UPGRADE.RequiredItems = {
	{ "basic_sewkit", 1, false },
	{ "solder", 1, false },
	{ "scrapmetal", 3, true},
};