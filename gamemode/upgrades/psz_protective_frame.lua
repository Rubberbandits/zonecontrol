--EFFECT
UPGRADE.Base = "clothes"
UPGRADE.Name = "Protective Frame";
UPGRADE.Desc = "Allows the suit to remain functional for longer periods of time without maintenance.";

UPGRADE.IconPage = 5
UPGRADE.IconX = 14
UPGRADE.IconY = 31

UPGRADE.DegradationProtection = 10

UPGRADE.PropertiesTooltip = {
	{
		IconX = 5,
		IconY = 5,
		Text = "+10% Durability Increase.",
	},
}

--CLASS
UPGRADE.Item = {
    suit_psz = true,
}

UPGRADE.RequiredUpgrade = "psz_synth_mats"

--TIER
UPGRADE.RequiredItems = {
	{ "adv_sewkit", 1, false },
	{ "sewing_machine", 1, false },
	{ "scrapmetal", 3, true },
	{ "buckleparts", 2, true },
};