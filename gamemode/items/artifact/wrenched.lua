
ITEM.Base = "artifact"
ITEM.Name =  "Wrenched"
ITEM.Desc =  "Metallic compounds that have been turned inside out and perforated by overlapping attractive forces and subsequent reactions to high pressure. Certain conditions create smoother or more jagged edges. A constant force flows across its surface in unending, random patterns. Emits radiation."
ITEM.Model =  "models/tnb/stalker/artifacts/wrenched.mdl"
ITEM.Weight =  1;
ITEM.BulkPrice =  30000 
ITEM.ArmorValues = {
    -- "Impact" (blunt)
    [DMG_CRUSH] = .95,
    [DMG_FALL] = .95,
    [DMG_CLUB] = .95,
    [DMG_VEHICLE] = .95,
    -- "Rupture" (sharp)
    [DMG_SLASH] = .95,
    -- "Bulletproof"
    [DMG_BULLET] = 1,
    -- "Explosion"
    [DMG_BLAST] = 1,
    -- "Thermal"
    [DMG_BURN] = 1.05,
    [DMG_SLOWBURN] = 1.05,
    -- "Chemical Burn"
    [DMG_ACID] = 1.05,
    [DMG_POISON] = 1.05,
    [DMG_NERVEGAS] = 1.05,
    -- "Electric Shock"
    [DMG_SHOCK] = 1.05,
    -- "Radiation"
    [DMG_RADIATION] = 1.15,
    -- "Psychic"
    [DMG_PARALYZE] = 1,
}
