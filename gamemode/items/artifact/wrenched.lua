ITEM.Base = "artifact"
ITEM.Name =  "Wrenched"
ITEM.Desc =  "Metallic compounds that have been turned inside out and perforated by overlapping attractive forces and subsequent reactions to high pressure. Certain conditions create smoother or more jagged edges. A constant force flows across its surface in unending, random patterns. Word on stalkerNET is that it siphons radiation at the cost of heightened sensitivity to electricity and chemicals."
ITEM.Model =  "models/tnb/stalker/artifacts/wrenched.mdl"
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
    [DMG_SLASH] = 1,
    -- "Bulletproof"
    [DMG_BULLET] = 1,
    -- "Explosion"
    [DMG_BLAST] = 1,
    -- "Thermal"
    [DMG_BURN] = 1,
    [DMG_SLOWBURN] = 1,
    -- "Chemical Burn"
    [DMG_ACID] = 1.05,
    [DMG_POISON] = 1.05,
    [DMG_NERVEGAS] = 1.05,
    -- "Electric Shock"
    [DMG_SHOCK] = 1.05,
    -- "Radiation"
    [DMG_RADIATION] = 0.7,
    -- "Psychic"
    [DMG_PARALYZE] = 1,
}

