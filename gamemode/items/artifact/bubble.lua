
ITEM.Base = "artifact"
ITEM.Name =  "Bubble"
ITEM.Desc =  "A fluorescent, lustrous green compound of several hollow, organic formations. Emits a visible gaseous substance that eliminates radiation rapidly without harming the wielder. The user, over time, seems to become more insubstantial, their presence diminished."
ITEM.Model =  "models/tnb/stalker/artifacts/bubble.mdl"
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
    [DMG_RADIATION] = .5,
    -- "Psychic"
    [DMG_PARALYZE] = 1,
}
