ITEM.Base = "artifact"
ITEM.Name =  "Ion's Heart"
ITEM.Desc =  "The calcified, radioactive heart of the legendary loner Ion. Those lucky enough to hold it are filled with loops of his last thoughts."
ITEM.Model =  "models/kali/miscstuff/stalker/artifacts/goldfish.mdl"
ITEM.ItemSubmaterials = {
{ 0 , "models/weapons/v_crowbar/crowbar_cyl" }
}

ITEM.Weight =  0.66;
ITEM.BulkPrice =  100000
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
    [DMG_RADIATION] = 2,
    -- "Psychic"
    [DMG_PARALYZE] = 2,
}
