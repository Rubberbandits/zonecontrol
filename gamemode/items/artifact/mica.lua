ITEM.Base = "artifact"
ITEM.Name =  "Mica"
ITEM.Desc =  "A pocketed membrane of shiny, luminous strands. A rare artifact, as the circumstances of its creation are seemingly random. Hastens the speed of blood coagulation in users, but sears exposed skin."
ITEM.Model =  "models/tnb/stalker/artifacts/mica.mdl"
ITEM.Tier =  2
ITEM.Weight =  0.5;
ITEM.BulkPrice =  30000
ITEM.ArmorValues = {
    -- "Impact" (blunt)
    [DMG_CRUSH] = 1,
    [DMG_FALL] = 1,
    [DMG_CLUB] = 1,
    [DMG_VEHICLE] = 1,
    -- "Rupture" (sharp)
    [DMG_SLASH] = 0.5,
    -- "Bulletproof"
    [DMG_BULLET] = 1,
    -- "Explosion"
    [DMG_BLAST] = 1,
    -- "Thermal"
    [DMG_BURN] = 1.2,
    [DMG_SLOWBURN] = 1.2,
    -- "Chemical Burn"
    [DMG_ACID] = 1.2,
    [DMG_POISON] = 1.2,
    [DMG_NERVEGAS] = 1.2,
    -- "Electric Shock"
    [DMG_SHOCK] = 1,
    -- "Radiation"
    [DMG_RADIATION] = 1,
    -- "Psychic"
    [DMG_PARALYZE] = 1,
}
