--EFFECT
UPGRADE.Base = "weapon"
UPGRADE.Name = "Weight Reduction";
UPGRADE.Desc = "Uses lower density materials to reduce the weapon's weight.";

UPGRADE.IconPage = 1;
UPGRADE.IconX = 1;
UPGRADE.IconY = 4;
UPGRADE.Attachment = "";

UPGRADE.ReduceWeight = 0.5

UPGRADE.PropertiesTooltip = {
	{
		IconX = 1,
		IconY = 7,
		Text = "Reduces weight by 0.5kg",
	},
}


--TIER
UPGRADE.RequiredItems = {
	{ "basic_toolkit", 1, false },
	--{ "intrm_toolkit", 1, false },
	--{ "adv_toolkit", 1, false },
	{ "parts_weapon", 1, true },
};

--UPGRADE.RequiredUpgrade = "";
UPGRADE.Incompatible = {
	--"test_upgrade_2",
};


--CLASS
UPGRADE.Item = {
    gun_common_sawnoff = true,
    gun_common_toz = true,
	gun_rare_kam12 = true,
}
