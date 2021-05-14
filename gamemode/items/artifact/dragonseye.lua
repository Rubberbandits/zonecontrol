ITEM.Base = "artifact"
ITEM.Name =  "Dragon's Eye"
ITEM.Desc =  "An artifact resembling the eye of a reptile. Known to form in thermal anomalies. Rumoured to make a Stalker's skin tough like an alligator's, it seems to absorb radioation and enduce a sense of calm within the holder."
ITEM.Model =  "models/tnb/stalker/artifacts/goldensphere.mdl"
ITEM.Tier =  2
ITEM.Weight =  0.50;
ITEM.BulkPrice =  32000
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
    [DMG_RADIATION] = 0.85,
    -- "Psychic"
    [DMG_PARALYZE] = 0.85,
}