--EFFECT
UPGRADE.Base = "weapon"
UPGRADE.Name = "Weight Reduction";
UPGRADE.Desc = "Uses lower density materials to reduce the weapon's weight, unfortunately increasing the recoil.";

UPGRADE.IconPage = 1;
UPGRADE.IconX = 1;
UPGRADE.IconY = 4;
UPGRADE.Attachment = "";

UPGRADE.ReduceWeight = 1

UPGRADE.ReduceRecoilUp = 1.2
UPGRADE.ReduceRecoilHorizontal = 1.2

UPGRADE.PropertiesTooltip = {
	{
		IconX = 1,
		IconY = 7,
		Text = "Reduces weight by 1kg",
	},
	{
		IconX = 1,
		IconY = 2,
		Text = "+20% Recoil",
	},
}

--TIER
UPGRADE.RequiredItems = {
	--{ "basic_toolkit", 1, false },
	--{ "intrm_toolkit", 1, false },
	{ "adv_toolkit", 1, false },
	{ "parts_weapon", 4, true },
};

UPGRADE.RequiredUpgrade = "natshot_rel_rel";
UPGRADE.Incompatible = {
	--"natshot_rec",
};


--CLASS
UPGRADE.Item = {
    gun_common_m500 = true,
	gun_uncommon_ksg = true,
	gun_rare_spas12 = true,
	gun_uncommon_w1200 = true,
	gun_uncommon_m1014 = true,
}