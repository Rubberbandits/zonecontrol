ITEM.Base = "artifact"
ITEM.Name =  "Vamp"
ITEM.Desc =  "A gold ring set in stone. You feel cold with it in your possession, protected from harsh hot elements. After short periods of use, users become anaemic. It is a tested insulator, with experimentation proving it to have anti-psychotic properties."
ITEM.Model =  "models/tnb/stalker/artifacts/slime.mdl"
ITEM.Tier =  1
ITEM.Weight =  0.5;
ITEM.BulkPrice = 24000
ITEM.ArmorValues = {
    -- "Impact" (blunt)
    [DMG_CRUSH] = 1,
    [DMG_FALL] = 1,
    [DMG_CLUB] = 1,
    [DMG_VEHICLE] = 1,
    -- "Rupture" (sharp)
    [DMG_SLASH] = 1.5,
    -- "Bulletproof"
    [DMG_BULLET] = 1.4,
    -- "Explosion"
    [DMG_BLAST] = 1.4,
    -- "Thermal"
    [DMG_BURN] = 0.9,
    [DMG_SLOWBURN] = 0.9,
    -- "Chemical Burn"
    [DMG_ACID] = 1,
    [DMG_POISON] = 1,
    [DMG_NERVEGAS] = 1,
    -- "Electric Shock"
    [DMG_SHOCK] = 0.8,
    -- "Radiation"
    [DMG_RADIATION] = 1.0,
    -- "Psychic"
    [DMG_PARALYZE] = 0.8,
}
