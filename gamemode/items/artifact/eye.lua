ITEM.Base = "artifact"
ITEM.Name =  "Eye"
ITEM.Desc =  "This artifact, which resembles the human eye, is known to considerably increases the body's metabolism, helping wounds heal quicker and protecting skin from lacerations. These are uncommonly found in burner anomalies. Many speculate that it brings good luck, making this a highly collectable artifact. Seems to absorb radiation."
ITEM.Model =  "models/tnb/stalker/artifacts/eye.mdl"
ITEM.Tier =  1
ITEM.Weight =  0.50
ITEM.BulkPrice =  20000
ITEM.ArmorValues = {
    -- "Impact" (blunt)
    [DMG_CRUSH] = 1,
    [DMG_FALL] = 1,
    [DMG_CLUB] = 1,
    [DMG_VEHICLE] = 1,
    -- "Rupture" (sharp)
    [DMG_SLASH] = 0.85,
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
    [DMG_RADIATION] = 1.2,
    -- "Psychic"
    [DMG_PARALYZE] = 1,
}
