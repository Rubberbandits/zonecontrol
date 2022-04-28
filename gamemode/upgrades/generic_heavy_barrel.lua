UPGRADE.Base = "weapon"
UPGRADE.Name = "Heavy Barrel";
UPGRADE.Desc = "A heavy and very accurate barrel that doesn't heat much when firing.";

UPGRADE.IconPage = 1;
UPGRADE.IconX = 9;
UPGRADE.IconY = 5;
UPGRADE.Attachment = "";

UPGRADE.ReduceSpread = 0.95
UPGRADE.ReduceRecoilUp = 0.95
UPGRADE.ReduceWeight = -1.25

UPGRADE.PropertiesTooltip = {
	{
		IconX = 4,
		IconY = 3,
		Text = "+5% Accuracy",
	},
	{
		IconX = 1,
		IconY = 5,
		Text = "-5% Recoil",
	},
	{
		IconX = 1,
		IconY = 7,
		Text = "Increases weight by 1.25kg",
	},
}

UPGRADE.RequiredUpgrade = "generic_freefloat"
UPGRADE.RequiredItems = {
	{ "intrm_toolkit", 1, false },
	{ "parts_basic", 2, true },
	{ "scrapmetal", 3, true },
	{ "wrench", 1, false },
};
UPGRADE.Incompatible = {
	"generic_fluted_barrel",
};
UPGRADE.Item = WEAPON_ALL;