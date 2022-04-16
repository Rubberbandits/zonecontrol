UPGRADE.Base = "weapon"
UPGRADE.Name = "Free-floated barrel";
UPGRADE.Desc = "Removes any contact from the barrel and the handguard, making it so zero won't shift when bracing the weapon against something.";

UPGRADE.IconPage = 1;
UPGRADE.IconX = 7;
UPGRADE.IconY = 3;
UPGRADE.Attachment = "";

UPGRADE.ReduceSpread = 0.9
UPGRADE.ReduceRecoilUp = 1.1

UPGRADE.PropertiesTooltip = {
	{
		IconX = 4,
		IconY = 3,
		Text = "+10% Accuracy",
	},
	{
		IconX = 1,
		IconY = 5,
		Text = "+10% Recoil",
	},
}

UPGRADE.RequiredItems = {
	{ "basic_toolkit", 1, false },
	{ "parts_weapon", 2, true },
	{ "scrapmetal", 2, true },
};

UPGRADE.Incompatible = {};
UPGRADE.Item = WEAPON_ALL;