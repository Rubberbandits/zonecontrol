--EFFECT
UPGRADE.Base = "clothes"
UPGRADE.Name = "Additional Two-Compartment Artifact Containe";
UPGRADE.Desc = "Installation of a double duty artifact container.";

UPGRADE.IconPage = 5
UPGRADE.IconX = 3
UPGRADE.IconY = 22

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
    suit_trenchsunrise = true,
	suit_sunrise = true,
	suit_combatsunrise = true,
}

UPGRADE.RequiredUpgrade = "sunrise_weight_distribution_frame";

--TIER
UPGRADE.RequiredItems = {
	{ "adv_toolkit", 1, false },
	{ "parts_suit", 2, true },
};