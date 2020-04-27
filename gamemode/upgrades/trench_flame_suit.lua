--EFFECT
UPGRADE.Base = "clothes"
UPGRADE.Name = "Flame Retardant Bodysuit";
UPGRADE.Desc = "The coat and underclothes are treated with a fire retardant substance.";

UPGRADE.IconPage = 5
UPGRADE.IconX = 14
UPGRADE.IconY = 35

UPGRADE.ArmorValues = {
	-- "Thermal"
	[DMG_BURN] = .85,
	[DMG_SLOWBURN] = .85,
}

UPGRADE.PropertiesTooltip = {
	{
		IconX = 7,
		IconY = 3,
		Text = "+15% Thermal Protection.",
	},
}

--CLASS
UPGRADE.Item = {
    suit_trench = true
}

UPGRADE.Incompatible = {
	"trench_canvas_suit"
}

UPGRADE.RequiredUpgrade = "trench_rubber_layer";

--TIER
UPGRADE.RequiredItems = {
	{ "intrm_toolkit", 1, false },
	{ "parts_suit", 2, true },
};