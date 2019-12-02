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
	{ "intrm_toolkit", 1, false },
	--{ "adv_toolkit", 1, false },
	{ "parts_weapon", 3, true },
};

UPGRADE.RequiredUpgrade = "natsmg_rof";
UPGRADE.Incompatible = {
	--"natsmg_rof",
};


--CLASS
UPGRADE.Item = {
    gun_common_mac10 = true,
	gun_common_miniuzi = true,
	gun_common_mp5 = true,
	gun_uncommon_coltsmg = true,
	gun_uncommon_uzi = true,
	gun_rare_fang = true,
	gun_rare_p90 = true,
	gun_rare_spectre = true,
}