ITEM.Base = "artifact"
ITEM.Name =  "Lucky Walnut"
ITEM.Desc =  "A pale tree nut, roughly 3ccm in size. Heavy and intricately hollowed. Makes noise like a seashell. Radioactive and charred. Many consider it completely useless, save for potentially strengthening bones and cartilage in joints."
ITEM.Model =  "models/tnb/stalker/artifacts/snowflake.mdl"

ITEM.ItemSubmaterials = {
{ 1 , "console/background01_widescreen" }
}

ITEM.Tier =  0
ITEM.Weight =  1;
ITEM.BulkPrice =  2000
ITEM.ArmorValues = {
    -- "Impact" (blunt)
    [DMG_CRUSH] = 0.95,
    [DMG_FALL] = 0.95,
    [DMG_CLUB] = 0.95,
    [DMG_VEHICLE] = 0.95,
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
    [DMG_SHOCK] = 1,
    -- "Radiation"
    [DMG_RADIATION] = 1,
    -- "Psychic"
    [DMG_PARALYZE] = 1,
}