--EFFECT
UPGRADE.Base = "weapon"
UPGRADE.Name = ".44 Magnum Cut-Down Kit";
UPGRADE.Desc = "Cuts down the weapon's profile.";

UPGRADE.IconPage = 1;
UPGRADE.IconX = 1;
UPGRADE.IconY = 5;
UPGRADE.Attachment = "cod_kit_spo";

UPGRADE.ReduceWeight = 0.25

UPGRADE.PropertiesTooltip = {
	{
		IconX = 2,
		IconY = 3,
		Text = "Cuts down the weapon's profile.",
	},
		{
		IconX = 1,
		IconY = 7,
		Text = "Reduces weight by 0.25kg",
	},
}

--TIER
UPGRADE.RequiredItems = {
	--{ "basic_toolkit", 1, false },
	{ "intrm_toolkit", 1, false },
	--{ "adv_toolkit", 1, false },
	{ "parts_weapon", 1, true },
};

--UPGRADE.RequiredUpgrade = "";
UPGRADE.Incompatible = {
};


--CLASS
UPGRADE.Item = {
	gun_rare_44mag = true,
}