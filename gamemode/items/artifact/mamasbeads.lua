
ITEM.Base = "artifact"
ITEM.Name =  "Mama's Beads"
ITEM.Desc =  "A rotating double helix tipped by colored knobs on each side. It floats above the ground, suspended by a weird magic. Its colors vary from darkest blue to the color of cooling magma. Emits dull reddish emanations and is only found at night, hidden away from prying eyes."
ITEM.Model =  "models/tnb/stalker/artifacts/mamasbeads.mdl"
ITEM.Tier =  2
ITEM.Weight =  1;
ITEM.BulkPrice =  30000
ITEM.ArmorValues = {
    -- "Impact" (blunt)
    [DMG_CRUSH] = 1,
    [DMG_FALL] = 1,
    [DMG_CLUB] = 1,
    [DMG_VEHICLE] = 1,
    -- "Rupture" (sharp)
    [DMG_SLASH] = .9,
    -- "Bulletproof"
    [DMG_BULLET] = .9,
    -- "Explosion"
    [DMG_BLAST] = .9,
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
    [DMG_RADIATION] = 1.2,
    -- "Psychic"
    [DMG_PARALYZE] = 1,
}
