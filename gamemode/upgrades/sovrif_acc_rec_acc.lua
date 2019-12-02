--EFFECT
UPGRADE.Base = "weapon"
UPGRADE.Name = "Accuracy Upgrade";
UPGRADE.Desc = "Increases the accuracy of the weapon.";

UPGRADE.IconPage = 1;
UPGRADE.IconX = 3;
UPGRADE.IconY = 8;
UPGRADE.Attachment = "";

UPGRADE.ReduceSpread = 0.8

UPGRADE.PropertiesTooltip = {
	{
		IconX = 4,
		IconY = 3,
		Text = "+20% Accuracy",
	},
}

--TIER
UPGRADE.RequiredItems = {
	--{ "basic_toolkit", 1, false },
	--{ "intrm_toolkit", 1, false },
	{ "adv_toolkit", 1, false },
	{ "parts_weapon", 3, true },
};

UPGRADE.RequiredUpgrade = "sovrif_acc_rec";
UPGRADE.Incompatible = {
	"sovrif_acc_rec_rel",
};

--CLASS
UPGRADE.Item = {
    gun_common_mosin = true,
	gun_common_sks = true,
    gun_uncommon_dragunov = true,
    gun_rare_svu = true,
	gun_common_svt40 = true,
}
