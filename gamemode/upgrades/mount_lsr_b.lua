--EFFECT
UPGRADE.Base = "weapon"
UPGRADE.Name = "USP .45 Laser Mount";
UPGRADE.Desc = "Allows the installation of all compatible laser projectors.";

UPGRADE.IconPage = 1;
UPGRADE.IconX = 2;
UPGRADE.IconY = 6;
UPGRADE.Attachment = "";

UPGRADE.PropertiesTooltip = {
	{
		IconX = 1,
		IconY = 4,
		Text = "Allows the installation of a laser projector onto a USP .45. It doesn't even fit onto a USP Match. Who designed this crap? Probably an American.",
	},
}

--TIER
UPGRADE.RequiredItems = {
	{ "basic_toolkit", 1, false },
	--{ "intrm_toolkit", 1, false },
	--{ "adv_toolkit", 1, false },
	--{ "parts_weapon", 1, true },
};

--UPGRADE.RequiredUpgrade = "";
UPGRADE.Incompatible = {
};


--CLASS
UPGRADE.Item = {
	gun_uncommon_usp = true,
}