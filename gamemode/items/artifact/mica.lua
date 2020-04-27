
ITEM.Base = "artifact"
ITEM.Name =  "Mica"
ITEM.Desc =  "A pocketed membrane of shiny, luminous strands. It could have once been carbon-based matter eaten away by acid. A rare artifact as the circumstances of its creation are seemingly random. Difficult to handle and sears exposed skin. Causes hemophilia."
ITEM.Model =  "models/tnb/stalker/artifacts/mica.mdl"
ITEM.Tier =  2
ITEM.FOV =  35
ITEM.CamPos =  Vector( 50, 50, 50 )
ITEM.LookAt =  Vector( -3.5, -2, 4 )
ITEM.Weight =  1;
ITEM.BulkPrice =  75000
ITEM.ArmorValues = {
    -- "Impact" (blunt)
    [DMG_CRUSH] = .90,
    [DMG_FALL] = .90,
    [DMG_CLUB] = .90,
    [DMG_VEHICLE] = .90,
    -- "Rupture" (sharp)
    [DMG_SLASH] = .90,
    -- "Bulletproof"
    [DMG_BULLET] = 1,
    -- "Explosion"
    [DMG_BLAST] = 1,
    -- "Thermal"
    [DMG_BURN] = 1.1,
    [DMG_SLOWBURN] = 1,
    -- "Chemical Burn"
    [DMG_ACID] = 1.1,
    [DMG_POISON] = 1,
    [DMG_NERVEGAS] = 1,
    -- "Electric Shock"
    [DMG_SHOCK] = 1,
    -- "Radiation"
    [DMG_RADIATION] = 1,
    -- "Psychic"
    [DMG_PARALYZE] = 1,
}
