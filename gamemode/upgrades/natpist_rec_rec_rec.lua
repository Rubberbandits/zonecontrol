--EFFECT
UPGRADE.Base = "weapon"
UPGRADE.Name = "Recoil Reduction"
UPGRADE.Desc = "Reduces the amount of recoil the user experiences, but increases weight."

UPGRADE.IconPage = 1;
UPGRADE.IconX = 1;
UPGRADE.IconY = 8;
UPGRADE.Attachment = "";

UPGRADE.ReduceRecoilUp = 0.75
UPGRADE.ReduceRecoilHorizontal = 0.75

UPGRADE.ReduceWeight = -0.5

UPGRADE.PropertiesTooltip = {
	{
		IconX = 1,
		IconY = 2,
		Text = "-25% Recoil",
	},
	{
		IconX = 1,
		IconY = 7,
		Text = "Increases weight by 0.5kg",
	},
}



--TIER
UPGRADE.RequiredItems = {
	--{ "basic_toolkit", 1, false },
	--{ "intrm_toolkit", 1, false },
	{ "adv_toolkit", 1, false },
	{ "parts_weapon", 4, true },
};

UPGRADE.RequiredUpgrade = "natpist_rec_rec";
UPGRADE.Incompatible = {
	"natpist_rec_rec_acc",
};


--CLASS
UPGRADE.Item = {
    gun_common_glock17 = true,
	gun_uncommon_1911 = true,
	gun_uncommon_m9 = true,
	gun_uncommon_usp = true,
	gun_uncommon_cs75 = true,
	gun_rare_44mag = true,
	gun_rare_deagle = true,
	gun_rare_kimber = true,
	gun_rare_mk23 = true,
	gun_rare_659 = true,
	gun_rare_uspmatch = true,
	gun_rare_arsenalstrike = true,
}