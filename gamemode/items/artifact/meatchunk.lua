
ITEM.Base = "artifact"
ITEM.Name =  "Meat Chunk"
ITEM.Desc =  "A semi-organic growth that resembles flesh. It secretes a thin mucous membrane which protects against chemical burns. Appears to form around fossils that have been exposed to anomalies. Causes rapid cell growth and emits radiation."
ITEM.Model =  "models/tnb/stalker/artifacts/meatchunk.mdl"
ITEM.Tier =  1
ITEM.FOV =  35
ITEM.CamPos =  Vector( 50, 50, 50 )
ITEM.LookAt =  Vector( -3.5, -2, 4 )
ITEM.Weight =  1;
ITEM.BulkPrice =  20000
ITEM.ArmorValues = {
    -- "Impact" (blunt)
    [DMG_CRUSH] = 1.1,
    [DMG_FALL] = 1.1,
    [DMG_CLUB] = 1.1,
    [DMG_VEHICLE] = 1.1,
    -- "Rupture" (sharp)
    [DMG_SLASH] = 1.1,
    -- "Bulletproof"
    [DMG_BULLET] = 1.1,
    -- "Explosion"
    [DMG_BLAST] = 1.1,
    -- "Thermal"
    [DMG_BURN] = .9,
    [DMG_SLOWBURN] = .9,
    -- "Chemical Burn"
    [DMG_ACID] = .9,
    [DMG_POISON] = .9,
    [DMG_NERVEGAS] = .9,
    -- "Electric Shock"
    [DMG_SHOCK] = .9,
    -- "Radiation"
    [DMG_RADIATION] = 1.05,
    -- "Psychic"
    [DMG_PARALYZE] = 1,
}
