-- This file was converted to Kingston item system by Niggerlicious conversion kit --
ITEM.Base = "artifact"
ITEM.Name =  "Lucky Walnut"
ITEM.Desc =  "A pale tree nut, roughly 3ccm in size. Heavy and intricately hollowed-makes noise like a seashell. Radioactive and charred."
ITEM.Model =  "models/tnb/stalker/artifacts/snowflake.mdl"

ITEM.ItemSubmaterials = {
{ 1 , "console/background01_widescreen" }
}

ITEM.Tier =  0
ITEM.FOV =  6
ITEM.CamPos =  Vector( 50, 50, 50 )
ITEM.LookAt =  Vector( 0, 0, 0 )
ITEM.Weight =  2;
ITEM.BulkPrice =  1000
ITEM.ArmorValues = {
    -- "Impact" (blunt)
    [DMG_CRUSH] = 0.8,
    [DMG_FALL] = 0.8,
    [DMG_CLUB] = 0.8,
    [DMG_VEHICLE] = 0.8,
    -- "Rupture" (sharp)
    [DMG_SLASH] = 1,
    -- "Bulletproof"
    [DMG_BULLET] = 1.1,
    -- "Explosion"
    [DMG_BLAST] = 1.1,
    -- "Thermal"
    [DMG_BURN] = 0.8,
    [DMG_SLOWBURN] = 0.8,
    -- "Chemical Burn"
    [DMG_ACID] = 1.1,
    [DMG_POISON] = 1.1,
    [DMG_NERVEGAS] = 1.1,
    -- "Electric Shock"
    [DMG_SHOCK] = 1.1,
    -- "Radiation"
    [DMG_RADIATION] = 1.6,
    -- "Psychic"
    [DMG_PARALYZE] = 2.0,
}
