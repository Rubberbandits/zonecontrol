--EFFECT
UPGRADE.Base = "weapon"
UPGRADE.Name = "Recoil Reduction"
UPGRADE.Desc = "Reduces the amount of recoil the user experiences."

UPGRADE.IconPage = 1;
UPGRADE.IconX = 1;
UPGRADE.IconY = 8;
UPGRADE.Attachment = "";

UPGRADE.ReduceRecoilUp = 0.85
UPGRADE.ReduceRecoilHorizontal = 0.85

UPGRADE.PropertiesTooltip = {
	{
		IconX = 1,
		IconY = 2,
		Text = "-15% Recoil",
	},
}

--TIER
UPGRADE.RequiredItems = {
	--{ "basic_toolkit", 1, false },
	--{ "intrm_toolkit", 1, false },
	{ "adv_toolkit", 1, false },
	{ "parts_weapon", 3, true },
};

UPGRADE.RequiredUpgrade = "sovsmg_rel_rel";
UPGRADE.Incompatible = {
	"sovsmg_rel_rel_deg",
};

--CLASS
UPGRADE.Item = {
    gun_common_ppsh = true,
    gun_uncommon_skorpion = true,
	gun_rare_psd9 = true,
	gun_rare_sr2 = true,
}