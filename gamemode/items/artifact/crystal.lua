-- This file was converted to Kingston item system by Niggerlicious conversion kit --
ITEM.Base = "artifact"
ITEM.Name =  "Crystal"
ITEM.Desc =  "This artifact is formed in anomalous zones with intense thermal activity. Actively consumes excessive heat, remaining cool to the touch throughout. Emits radiation."
ITEM.Model =  "models/tnb/stalker/artifacts/crystal.mdl"
ITEM.Tier =  2
ITEM.FOV =  35
ITEM.CamPos =  Vector( 50, 50, 50 )
ITEM.LookAt =  Vector( -3.5, -2, 4 )
ITEM.Weight =  1;
ITEM.BulkPrice =  7500
ITEM.ArmorValues = {
    -- "Impact" (blunt)
    [DMG_CRUSH] = 1,
    [DMG_FALL] = 1,
    [DMG_CLUB] = 1,
    [DMG_VEHICLE] = 1,
    -- "Rupture" (sharp)
    [DMG_SLASH] = 1,
    -- "Bulletproof"
    [DMG_BULLET] = 1.2,
    -- "Explosion"
    [DMG_BLAST] = 1.2,
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
    [DMG_RADIATION] = .7,
    -- "Psychic"
    [DMG_PARALYZE] = 1,
}
