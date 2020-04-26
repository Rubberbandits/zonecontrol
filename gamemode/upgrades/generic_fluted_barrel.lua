UPGRADE.Base = "weapon"
UPGRADE.Name = "Fluted barrel";
UPGRADE.Desc = "A high-end barrel that has relief cuts in an attempt to make it lighter. These barrels heat up faster, causing zero to shift the more you fire.";

UPGRADE.IconPage = 1;
UPGRADE.IconX = 8;
UPGRADE.IconY = 1;
UPGRADE.Attachment = "";

UPGRADE.ReduceSpread = 1.05
UPGRADE.ReduceRecoilUp = 1.1
UPGRADE.ReduceWeight = 1.25

UPGRADE.PropertiesTooltip = {
	{
		IconX = 4,
		IconY = 3,
		Text = "-5% Accuracy",
	},
	{
		IconX = 1,
		IconY = 5,
		Text = "+5% Recoil",
	},
	{
		IconX = 1,
		IconY = 7,
		Text = "Reduces weight by 1.25kg",
	},
}

UPGRADE.RequiredUpgrade = "generic_freefloat"
UPGRADE.RequiredItems = {
	{ "intrm_toolkit", 1, false },
	{ "parts_weapon", 2, true },
};
UPGRADE.Incompatible = {
	"generic_heavy_barrel",
};
UPGRADE.Item = WEAPON_RIFLES;