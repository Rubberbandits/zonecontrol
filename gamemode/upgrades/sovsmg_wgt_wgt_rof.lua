--EFFECT
UPGRADE.Base = "weapon"
UPGRADE.Name = "Rate of Fire Upgrade";
UPGRADE.Desc = "Increases the weapon's RPM.";

UPGRADE.IconPage = 1;
UPGRADE.IconX = 3;
UPGRADE.IconY = 1;
UPGRADE.Attachment = "";

UPGRADE.AddRPM = 70

UPGRADE.PropertiesTooltip = {
	{
		IconX = 1,
		IconY = 1,
		Text = "Adds 70 RPM",
	},
}
--TIER
UPGRADE.RequiredItems = {
	--{ "basic_toolkit", 1, false },
	--{ "intrm_toolkit", 1, false },
	{ "adv_toolkit", 1, false },
	{ "parts_weapon", 3, true },
};

UPGRADE.RequiredUpgrade = "sovsmg_wgt_wgt";
UPGRADE.Incompatible = {
	"sovsmg_wgt_wgt_rec",
};

--CLASS
UPGRADE.Item = {
    gun_common_ppsh = true,
    gun_uncommon_skorpion = true,
	gun_rare_psd9 = true,
	gun_rare_sr2 = true,
}