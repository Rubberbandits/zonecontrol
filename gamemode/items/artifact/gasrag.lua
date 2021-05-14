ITEM.Base = "artifact"
ITEM.Name =  "Gas Rag"
ITEM.Desc =  "A piece of cloth that smells strongly of gasoline. By nature, hanging onto this makes those who equip it very susceptible to being lit ablaze; conversely, its insulative properties are the only perceived benefit."
ITEM.Model =  "models/kali/miscstuff/stalker/aid/bandage.mdl"
ITEM.Tier =  2
ITEM.BulkPrice = 30000
ITEM.Weight =  0.5;
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
    [DMG_BURN] = 2,
    [DMG_SLOWBURN] = 2,
    -- "Chemical Burn"
    [DMG_ACID] = 1,
    [DMG_POISON] = 1,
    [DMG_NERVEGAS] = 1,
    -- "Electric Shock"
    [DMG_SHOCK] = 0.5,
    -- "Radiation"
    [DMG_RADIATION] = 1,
    -- "Psychic"
    [DMG_PARALYZE] = 1,
}
