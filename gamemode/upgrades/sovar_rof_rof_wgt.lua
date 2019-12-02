--EFFECT
UPGRADE.Base = "weapon"
UPGRADE.Name = "Weight Reduction";
UPGRADE.Desc = "Uses lower density materials to reduce the weapon's weight.";

UPGRADE.IconPage = 1;
UPGRADE.IconX = 1;
UPGRADE.IconY = 4;
UPGRADE.Attachment = "";

UPGRADE.ReduceWeight = 1

UPGRADE.PropertiesTooltip = {
	{
		IconX = 1,
		IconY = 7,
		Text = "Reduces weight by 1kg",
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

UPGRADE.RequiredUpgrade = "sovar_rof_rof";
UPGRADE.Incompatible = {
	"sovar_rof_rec"
};
