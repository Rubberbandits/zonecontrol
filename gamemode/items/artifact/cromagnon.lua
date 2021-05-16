ITEM.Base = "artifact"
ITEM.Name =  "Cro-Magnon"
ITEM.Desc =  "Flesh-coated remainder of an ancient being. When close, you can hear it's whispers. Ironically, it's rumoured that its only benefit are anti-psychic properties."
ITEM.Model =  "models/Gibs/HGIBS.mdl"

ITEM.ItemSubmaterials = {
{ 0 , "models/flesh" }
}

ITEM.Tier =  3
ITEM.Weight =  0.5
ITEM.BulkPrice =  22500
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
    [DMG_RADIATION] = 1,
    -- "Psychic"
    [DMG_PARALYZE] = 0.75,
}
