ITEM.Base = "artifact"
ITEM.Name =  "Snot"
ITEM.Desc =  "An irregular-shaped ball of biotic material. It visibly suctions in radioactive particulates, wheezing like a person with a terrible could would."
ITEM.Model =  "models/kali/miscstuff/stalker/artifacts/flame.mdl"
ITEM.ItemSubmaterials = {
{ 0 , "models/barnacle/roots" }
}
ITEM.Tier =  1
ITEM.Weight =  0.5;
ITEM.BulkPrice =  9000
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
    [DMG_RADIATION] = 0.75,
    -- "Psychic"
    [DMG_PARALYZE] = 1,
}
function ITEM:GetSellPrice()
    return 1800
end