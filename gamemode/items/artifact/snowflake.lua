
ITEM.Base = "artifact"
ITEM.Name =  "Snowflake"
ITEM.Desc =  "A convincing facsimile of serrated, bluish-white ice crystals. Constantly emits a numbing mist of cold and causes condensation all around it. Reacts violently with other artifacts and saps the warmth from the body. Emits radiation."
ITEM.Model =  "models/tnb/stalker/artifacts/snowflake.mdl"
ITEM.Tier =  1
ITEM.Weight =  1;
ITEM.BulkPrice =  75000
ITEM.ArmorValues = {
    -- "Impact" (blunt)
    [DMG_CRUSH] = 1,
    [DMG_FALL] = 1,
    [DMG_CLUB] = 1,
    [DMG_VEHICLE] = 1,
    -- "Rupture" (sharp)
    [DMG_SLASH] = 1,
    -- "Bulletproof"
    [DMG_BULLET] = 1.1,
    -- "Explosion"
    [DMG_BLAST] = 1.1,
    -- "Thermal"
    [DMG_BURN] = .85,
    [DMG_SLOWBURN] = .85,
    -- "Chemical Burn"
    [DMG_ACID] = 1,
    [DMG_POISON] = 1,
    [DMG_NERVEGAS] = 1,
    -- "Electric Shock"
    [DMG_SHOCK] = 1,
    -- "Radiation"
    [DMG_RADIATION] = 1.25,
    -- "Psychic"
    [DMG_PARALYZE] = 1,
}
