--EFFECT
UPGRADE.Base = "clothes"
UPGRADE.Name = "UHMWPE Plates";
UPGRADE.Desc = "Polyethylene inserts allow the suit to defeat intermediate rifle threats in most circumstances. However, these won’t last very long under sustained use.";

UPGRADE.IconPage = 5
UPGRADE.IconX = 15
UPGRADE.IconY = 27

UPGRADE.ArmorValues = {
	-- "Bulletproof"
	[DMG_BULLET] = 0.7, -- 30% increase in resistance
}

UPGRADE.DegradationProtection = -10

UPGRADE.PropertiesTooltip = {
	{
		IconX = 5,
		IconY = 1,
		Text = "+30% Bulletproof.",
	},
	{
		IconX = 5,
		IconY = 5,
		Text = "-10% Durability Increase.",
	},
}

--CLASS
UPGRADE.Item = {
    suit_psz = true,
}

UPGRADE.RequiredUpgrade = "psz_trauma_pad"

--TIER
UPGRADE.RequiredItems = {
	{ "adv_toolkit", 1, false },
	{ "parts_suit", 3, true },
};