ITEM.Base = "artifact"
ITEM.Name =  "Spring"
ITEM.Desc =  "Two bluish copper discs about a quarter-inch thick held a foot and a half apart. Ethereal, white translucence holds them together which slightly compresses in the center. Matter can freely pass in between but the discs cannot be moved out of position. Rumours say using this artifact is like wearing a sleeve of armor on your entire body."
ITEM.Model =  "models/tnb/stalker/artifacts/spring.mdl"
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
    [DMG_BULLET] = 0.75,
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
    [DMG_RADIATION] = 1,
    -- "Psychic"
    [DMG_PARALYZE] = 1,
}
