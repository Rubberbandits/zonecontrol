--EFFECT
UPGRADE.Base = "weapon"
UPGRADE.Name = "Vertical Recoil Removal"
UPGRADE.Desc = "Removes lateral recoil, at cost of accuracy and added vertical recoil."

UPGRADE.IconPage = 1;
UPGRADE.IconX = 1;
UPGRADE.IconY = 8;
UPGRADE.Attachment = "";

UPGRADE.ReduceRecoilUp = 1.2
UPGRADE.ReduceRecoilHorizontal = 0

UPGRADE.ReduceSpread = 1.2

UPGRADE.PropertiesTooltip = {
	{
		IconX = 1,
		IconY = 2,
		Text = "-100% Lateral Recoil",
	},
	{
		IconX = 1,
		IconY = 2,
		Text = "+20% Vertical Recoil",
	},
	{
		IconX = 4,
		IconY = 3,
		Text = "-20% Accuracy",
	},
}


--TIER
UPGRADE.RequiredItems = {
	--{ "basic_toolkit", 1, false },
	--{ "intrm_toolkit", 1, false },
	{ "adv_toolkit", 1, false },
	{ "parts_weapon", 4, true },
};

UPGRADE.RequiredUpgrade = "natsmg_rof_wgt";
UPGRADE.Incompatible = {
	"natsmg_rof_wgt_vrt",
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