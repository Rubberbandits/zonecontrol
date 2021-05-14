ITEM.Base = "artifact"
ITEM.Name =  "Shell"
ITEM.Desc =  "Fungus-like metal plates interconnected by brown, root-like growths. The connection tapers towards the middle and shimmers with forces unseen. Merges with the users' nervous system to heighten senses and vastly increases endurance, chemical and electricity protection at the expense of rendering them susceptible to radioactive sensitivity."
ITEM.Model =  "models/tnb/stalker/artifacts/shell.mdl"
ITEM.Tier =  2
ITEM.Weight =  0.5;
ITEM.BulkPrice =  40000
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
    [DMG_ACID] = 0.9,
    [DMG_POISON] = 0.9,
    [DMG_NERVEGAS] = 0.9,
    -- "Electric Shock"
    [DMG_SHOCK] = 0.9,
    -- "Radiation"
    [DMG_RADIATION] = 1.2,
    -- "Psychic"
    [DMG_PARALYZE] = 0.9,
}
