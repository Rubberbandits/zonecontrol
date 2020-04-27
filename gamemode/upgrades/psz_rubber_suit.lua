--EFFECT
UPGRADE.Base = "clothes"
UPGRADE.Name = "Rubberized Bodysuit";
UPGRADE.Desc = "An ergonomic suit facilitates greater maneuverability in spite of the life support and protective equipment.";

UPGRADE.IconPage = 5
UPGRADE.IconX = 15
UPGRADE.IconY = 26

UPGRADE.AddWalkSpeed = 25
UPGRADE.AddRunSpeed = 25
UPGRADE.AddCrouchSpeed = 25

UPGRADE.PropertiesTooltip = {
	{
		IconX = 5,
		IconY = 5,
		Text = "+5% Movement Speed Increase.",
	},
}

--CLASS
UPGRADE.Item = {
    suit_psz = true,
}

UPGRADE.RequiredUpgrade = "psz_fabric_layer"
UPGRADE.Incompatible = {
	"psz_synth_mats"
}

--TIER
UPGRADE.RequiredItems = {
	{ "intrm_toolkit", 1, false },
	{ "parts_suit", 2, true },
};