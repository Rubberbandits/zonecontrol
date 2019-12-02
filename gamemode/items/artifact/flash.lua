-- This file was converted to Kingston item system by Niggerlicious conversion kit --
ITEM.Base = "artifact"
ITEM.Name =  "Flash"
ITEM.Desc =  "Pure light, stuck out of time. Encased in a dull, yet lustrous shell, it is extremely bright and scorches false after-images into the retinas when looked at. Produces light even when placed in containers or covered up. Conducts electricity away from the wielder."
ITEM.Model =  "models/tnb/stalker/artifacts/flash.mdl"
ITEM.Tier =  1
ITEM.FOV =  35
ITEM.CamPos =  Vector( 50, 50, 50 )
ITEM.LookAt =  Vector( -3.5, -2, 4 )
ITEM.Weight =  1;
ITEM.BulkPrice =  10000 
ITEM.ArmorValues = {
    -- "Impact" (blunt)
    [DMG_CRUSH] = 1,
    [DMG_FALL] = 1,
    [DMG_CLUB] = 1,
    [DMG_VEHICLE] = 1,
    -- "Rupture" (sharp)
    [DMG_SLASH] = .8,
    -- "Bulletproof"
    [DMG_BULLET] = .95,
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
    [DMG_SHOCK] = 1.2,
    -- "Radiation"
    [DMG_RADIATION] = 1,
    -- "Psychic"
    [DMG_PARALYZE] = 1,
}
