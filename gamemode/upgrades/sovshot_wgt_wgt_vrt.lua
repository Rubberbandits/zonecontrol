--EFFECT
UPGRADE.Base = "weapon"
UPGRADE.Name = "Vertical Recoil Removal"
UPGRADE.Desc = "Nearly removes vertical recoil, at cost of added lateral recoil."

UPGRADE.IconPage = 1;
UPGRADE.IconX = 1;
UPGRADE.IconY = 8;
UPGRADE.Attachment = "";

UPGRADE.ReduceRecoilUp = 0.1
UPGRADE.ReduceRecoilHorizontal = 1.3

UPGRADE.PropertiesTooltip = {
	{
		IconX = 1,
		IconY = 2,
		Text = "-90% Vertical Recoil",
	},
	{
		IconX = 1,
		IconY = 2,
		Text = "+30% Lateral Recoil",
	},
}


--TIER
UPGRADE.RequiredItems = {
	--{ "basic_toolkit", 1, false },
	--{ "intrm_toolkit", 1, false },
	{ "adv_toolkit", 1, false },
	{ "parts_weapon", 3, true },
};
UPGRADE.RequiredUpgrade = "sovshot_wgt_wgt";
UPGRADE.Incompatible = {
	"sovshot_wgt_wgt_rof",
};

--CLASS
UPGRADE.Item = {
    gun_common_sawnoff = true,
    gun_common_toz = true,
	gun_rare_kam12 = true,
}