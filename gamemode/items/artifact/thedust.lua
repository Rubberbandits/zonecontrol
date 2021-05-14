ITEM.Base = "artifact"
ITEM.Name =  "Dust"
ITEM.Desc =  "Radioactive dust. Opaque to the eye yet transparent to light. Soft like ash, but appears coarse like sand. Weighs only as much as it's container. Field tests from Ecologists report thermal, electric and laceration resistances, with an increased absorption rate of radiation and increased emotional intelligence and psy-control protection. Some Bandits smuggle this to the outside world as an alternative to fentanyl or cocaine."
ITEM.Model =  "models/z-o-m-b-i-e/st/kitchen_room/st_teapot_01.mdl"
ITEM.Tier =  1
ITEM.Weight =  0;
ITEM.BulkPrice =  7500
ITEM.ArmorValues = {
    -- "Impact" (blunt)
    [DMG_CRUSH] = 1.4,
    [DMG_FALL] = 1.4,
    [DMG_CLUB] = 1.4,
    [DMG_VEHICLE] = 1,
    -- "Rupture" (sharp)
    [DMG_SLASH] = 0.9,
    -- "Bulletproof"
    [DMG_BULLET] = 1,
    -- "Explosion"
    [DMG_BLAST] = 1,
    -- "Thermal"
    [DMG_BURN] = 0.75,
    [DMG_SLOWBURN] = 0.75,
    -- "Chemical Burn"
    [DMG_ACID] = 1,
    [DMG_POISON] = 1,
    [DMG_NERVEGAS] = 1,
    -- "Electric Shock"
    [DMG_SHOCK] = 0.8,
    -- "Radiation"
    [DMG_RADIATION] = 1.2,
    -- "Psychic"
    [DMG_PARALYZE] = 0.8,
}