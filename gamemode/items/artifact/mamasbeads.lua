ITEM.Base = "artifact"
ITEM.Name =  "Mama's Beads"
ITEM.Desc =  "A rotating double helix tipped by colored knobs on each side. It floats above the ground, suspended by a weird magic. Its colors vary from darkest blue to the color of cooling magma. Only found at night, it is beloved for its protective properties, shielding Stalkers from ballistic damage. Seems to attract radiation."
ITEM.Model =  "models/tnb/stalker/artifacts/mamasbeads.mdl"
ITEM.Tier =  2
ITEM.Weight =  0.5;
ITEM.BulkPrice =  35000
ITEM.ArmorValues = {
    -- "Impact" (blunt)
    [DMG_CRUSH] = 1,
    [DMG_FALL] = 1,
    [DMG_CLUB] = 1,
    [DMG_VEHICLE] = 1,
    -- "Rupture" (sharp)
    [DMG_SLASH] = 0.85,
    -- "Bulletproof"
    [DMG_BULLET] = 0.85,
    -- "Explosion"
    [DMG_BLAST] = 0.85,
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