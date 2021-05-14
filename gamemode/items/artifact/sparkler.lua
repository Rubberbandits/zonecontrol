ITEM.Base = "artifact"
ITEM.Name =  "Sparkler"
ITEM.Desc =  "Hardened discharge preserved by anomalous forces. Generates strong electromagnetic forces and a static field, attracting electricity to itself and slightly protecting the wielder. Bright energy currents flow across its surface at varying speeds and then dissipate. Emanates occasional metallic ringing noises. Users are slightly more conductive to radiation with this."
ITEM.Model =  "models/tnb/stalker/artifacts/static.mdl"
ITEM.Tier =  1
ITEM.Weight =  0.5;
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
    [DMG_SHOCK] = 0.8,
    -- "Radiation"
    [DMG_RADIATION] = 1.2,
    -- "Psychic"
    [DMG_PARALYZE] = 1,
}