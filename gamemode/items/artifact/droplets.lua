-- This file was converted to Kingston item system by Niggerlicious conversion kit --
ITEM.Base = "artifact"
ITEM.Name =  "Droplets"
ITEM.Desc =  "Formed from the Burner anomaly, this artifact is tear-shaped and has a cracked, glossy substance similar to remains from a fire. Absorbs light, heat, and radiation from the environment. It has been attributed to erratic or manic-depressive behavior in Stalkers all of whom exhibit extreme fatigue."
ITEM.Model =  "models/tnb/stalker/artifacts/droplet.mdl"
ITEM.Tier =  1
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
    [DMG_SHOCK] = 1.1,
    -- "Radiation"
    [DMG_RADIATION] = .9,
    -- "Psychic"
    [DMG_PARALYZE] = 1.1,
}
