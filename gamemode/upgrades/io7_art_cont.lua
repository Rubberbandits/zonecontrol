--EFFECT
UPGRADE.Base = "clothes"
UPGRADE.Name = "Artifact Container";
UPGRADE.Desc = "Attaches another artifact container to the suit.";

UPGRADE.IconPage = 5
UPGRADE.IconX = 14
UPGRADE.IconY = 16

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
    suit_io7 = true,
}

UPGRADE.RequiredUpgrade = "io7_weight_distro"

--TIER
UPGRADE.RequiredItems = {
	{ "intrm_sewkit", 1, false },
	{ "solder", 1, false },
	{ "scrapmetal", 3, true},
};