--EFFECT
UPGRADE.Base = "weapon"
UPGRADE.Name = "Accuracy Upgrade";
UPGRADE.Desc = "Increases the accuracy of the weapon.";

UPGRADE.IconPage = 1;
UPGRADE.IconX = 3;
UPGRADE.IconY = 8;
UPGRADE.Attachment = "";

UPGRADE.ReduceSpread = 0.9

UPGRADE.PropertiesTooltip = {
	{
		IconX = 4,
		IconY = 3,
		Text = "+10% Accuracy",
	},
}

--CLASS
UPGRADE.Item = {
    gun_common_ak74 = true,
	gun_common_ak74m = true,
	gun_common_ak74u = true,
	gun_common_akm = true,
	gun_uncommon_akmagpul = true,
	gun_rare_an94 = true,
	gun_rare_asval = true,
	gun_rare_groza = true,
}

--TIER
UPGRADE.RequiredItems = {
	--{ "basic_toolkit", 1, false },
	--{ "intrm_toolkit", 1, false },
	{ "adv_toolkit", 1, false },
	{ "parts_weapon", 3, true },
};

UPGRADE.RequiredUpgrade = "sovar_rec_rel";
UPGRADE.Incompatible = {
	"sovar_rec_rel_rec",
};
