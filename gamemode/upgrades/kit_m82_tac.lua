--EFFECT
UPGRADE.Base = "weapon"
UPGRADE.Name = "M82 Tactical Kit";
UPGRADE.Desc = "Replaces the M82's standard upper receiver with one made of composite materials.";

UPGRADE.IconPage = 1;
UPGRADE.IconX = 1;
UPGRADE.IconY = 5;
UPGRADE.Attachment = "cod_kit_slt";

UPGRADE.ReduceWeight = 1

UPGRADE.PropertiesTooltip = {
	{
		IconX = 2,
		IconY = 3,
		Text = "Replaces the M82's standard upper receiver with one made of composite materials.",
	},
		{
		IconX = 1,
		IconY = 7,
		Text = "Reduces weight by 1kg",
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
	gun_rare_m82a1 = true,
}