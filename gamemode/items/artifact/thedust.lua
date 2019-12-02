-- This file was converted to Kingston item system by Niggerlicious conversion kit --
ITEM.Base = "artifact"
ITEM.Name =  "Dust"
ITEM.Desc =  "Radioactive dust. Opaque to the eye yet transparent to light. Soft like ash, but appears coarse like sand. Weighs only as much as it's container."
ITEM.Model =  "models/z-o-m-b-i-e/st/kitchen_room/st_teapot_01.mdl"
ITEM.Tier =  2
ITEM.FOV =  12
ITEM.CamPos =  Vector( 50, 50, 50 )
ITEM.LookAt =  Vector( 0, 0, 5 )
ITEM.Weight =  0;
ITEM.BulkPrice =  4000
ITEM.ArmorValues = {
    -- "Impact" (blunt)
    [DMG_CRUSH] = 1.4,
    [DMG_FALL] = 1.4,
    [DMG_CLUB] = 1.1,
    [DMG_VEHICLE] = 1,
    -- "Rupture" (sharp)
    [DMG_SLASH] = 0.9,
    -- "Bulletproof"
    [DMG_BULLET] = 1,
    -- "Explosion"
    [DMG_BLAST] = 1,
    -- "Thermal"
    [DMG_BURN] = 0.2,
    [DMG_SLOWBURN] = 0.2,
    -- "Chemical Burn"
    [DMG_ACID] = 1,
    [DMG_POISON] = 1,
    [DMG_NERVEGAS] = 0.9,
    -- "Electric Shock"
    [DMG_SHOCK] = 0.8,
    -- "Radiation"
    [DMG_RADIATION] = 0.9,
    -- "Psychic"
    [DMG_PARALYZE] = 0.8,
}
