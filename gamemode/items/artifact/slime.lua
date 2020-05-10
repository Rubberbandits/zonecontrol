
ITEM.Base = "artifact"
ITEM.Name =  "Slime"
ITEM.Desc =  "A dazzling web of transparent, brittle chemical residue. The gaze rolls off it like water and its form seems to subtly change with time. A subtle current of air is detectable around it as well as a cooling effect."
ITEM.Model =  "models/tnb/stalker/artifacts/slime.mdl"
ITEM.Tier =  1
ITEM.Weight =  1;
ITEM.BulkPrice =  7500
ITEM.ArmorValues = {
    -- "Impact" (blunt)
    [DMG_CRUSH] = 1,
    [DMG_FALL] = 1,
    [DMG_CLUB] = 1,
    [DMG_VEHICLE] = 1,
    -- "Rupture" (sharp)
    [DMG_SLASH] = .90,
    -- "Bulletproof"
    [DMG_BULLET] = 1,
    -- "Explosion"
    [DMG_BLAST] = 1,
    -- "Thermal"
    [DMG_BURN] = 1.2,
    [DMG_SLOWBURN] = 1.2,
    -- "Chemical Burn"
    [DMG_ACID] = 1,
    [DMG_POISON] = 1,
    [DMG_NERVEGAS] = 1,
    -- "Electric Shock"
    [DMG_SHOCK] = 1,
    -- "Radiation"
    [DMG_RADIATION] = 1,
    -- "Psychic"
    [DMG_PARALYZE] = 1,
}
