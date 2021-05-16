ITEM.Base = "artifact"
ITEM.Name =  "Meat Chunk"
ITEM.Desc =  "This organic artifact consists of deformed, mutated animal tissue. When placed in a chemically contaminated area, Meat Chunk transforms the airborne chemicals into a mucous fluid. Strangely enough, it also has healing properties, upping sensitivity to radiation in favor of cell overproduction, healing faster yet making scars uglier."
ITEM.Model =  "models/tnb/stalker/artifacts/meatchunk.mdl"
ITEM.Tier =  2
ITEM.Weight =  0.5;
ITEM.BulkPrice =  25000
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
    [DMG_ACID] = 0.5,
    [DMG_POISON] = 0.5,
    [DMG_NERVEGAS] = 0.5,
    -- "Electric Shock"
    [DMG_SHOCK] = 1,
    -- "Radiation"
    [DMG_RADIATION] = 1.3,
    -- "Psychic"
    [DMG_PARALYZE] = 1,
}
