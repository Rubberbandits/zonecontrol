--EFFECT
UPGRADE.Base = "clothes"
UPGRADE.Name = "Additional Two-compartment Artifact Container";
UPGRADE.Desc = "Installation of a double duty artifact container.";

UPGRADE.IconPage = 5
UPGRADE.IconX = 18
UPGRADE.IconY = 31

UPGRADE.ArtifactSlots = 2

UPGRADE.PropertiesTooltip = {
	{
		IconX = 6,
		IconY = 7,
		Text = "+2 Artifact Container.",
	},
}

--CLASS
UPGRADE.Item = {
    suit_psz = true,
}

UPGRADE.RequiredUpgrade = "psz_art_cont_1"

--TIER
UPGRADE.RequiredItems = {
	{ "adv_sewkit", 1, false },
	{ "solder", 1, false },
	{ "scrapmetal", 3, true},
};