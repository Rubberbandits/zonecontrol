ITEM.Base = "artifact"
ITEM.Name =  "Charger"
ITEM.Desc =  "A metallic shell containing an electric arc. While it has no insulating properties and makes the user more prone to radiation, it is speculated to offer some protection in event of electrocution. It's named after it's useful ability to provide a unidirectional electrical charge, able to sustainably trickle-charge small electronics."
ITEM.Model =  "models/kali/miscstuff/stalker/artifacts/shell.mdl"

ITEM.ItemSubmaterials = {
{ 0 , "models/gibs/metalgibs/metal_gibs" }
}

ITEM.Tier =  1
ITEM.Weight =  0.50;
ITEM.BulkPrice =  6500
ITEM.ArmorValues = {
    -- "Impact" (blunt)
    [DMG_CRUSH] = 1,
    [DMG_FALL] = 1,
    [DMG_CLUB] = 1,
    [DMG_VEHICLE] = 1,
    -- "Rupture" (sharp)
    [DMG_SLASH] = 1,
    -- "Bulletproof"
    [DMG_BULLET] = 1,
    -- "Explosion"
    [DMG_BLAST] = 1,
    -- "Thermal"
    [DMG_BURN] = 1,
    [DMG_SLOWBURN] = 1,
    -- "Chemical Burn"
    [DMG_ACID] = 1,
    [DMG_POISON] = 1,
    [DMG_NERVEGAS] = 1,
    -- "Electric Shock"
    [DMG_SHOCK] = 0.8,
    -- "Radiation"
    [DMG_RADIATION] = 1.2,
    -- "Psychic"
    [DMG_PARALYZE] = 1,
}
