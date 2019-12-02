--EFFECT
UPGRADE.Base = "weapon"
UPGRADE.Name = "Weight Reduction";
UPGRADE.Desc = "Uses lower density materials to reduce the weapon's weight.";

UPGRADE.IconPage = 1;
UPGRADE.IconX = 1;
UPGRADE.IconY = 4;
UPGRADE.Attachment = "";

UPGRADE.ReduceWeight = 0.75

UPGRADE.PropertiesTooltip = {
	{
		IconX = 1,
		IconY = 7,
		Text = "Reduces weight by 0.75kg",
	},
}

--TIER
UPGRADE.RequiredItems = {
	--{ "basic_toolkit", 1, false },
	--{ "intrm_toolkit", 1, false },
	{ "adv_toolkit", 1, false },
	{ "parts_weapon", 3, true },
};

UPGRADE.RequiredUpgrade = "sovrif_rel_wgt";
UPGRADE.Incompatible = {
	--"sovrif_rec_rec_acc",
};

--CLASS
UPGRADE.Item = {
    gun_common_mosin = true,
	gun_common_sks = true,
    gun_uncommon_dragunov = true,
    gun_rare_svu = true,
	gun_common_svt40 = true,
}
