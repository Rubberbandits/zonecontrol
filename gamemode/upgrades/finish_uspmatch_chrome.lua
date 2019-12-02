--EFFECT
UPGRADE.Base = "weapon"
UPGRADE.Name = "USP Match Chrome Finish";
UPGRADE.Desc = "Gives the weapon an obnoxious chrome finish. Bad for night ops.";

UPGRADE.IconPage = 1;
UPGRADE.IconX = 1;
UPGRADE.IconY = 5;
UPGRADE.Attachment = "ins2_usp_chrome";

UPGRADE.PropertiesTooltip = {
	{
		IconX = 2,
		IconY = 3,
		Text = "Gives the weapon an obnoxious chrome finish. Bad for night ops.",
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
	gun_rare_uspmatch = true,
}