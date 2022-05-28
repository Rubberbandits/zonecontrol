ITEM.Base = "artifact"
ITEM.Name =  "Balloon"
ITEM.Desc =  "A tiny crystal known to absorb aerosolized neurotoxins, chemicals and poisons."
ITEM.Model =  "models/tnb/stalker/artifacts/droplet.mdl"
ITEM.ItemSubmaterials = {
{ 0 , "models/props/cs_office/clouds" }
}
ITEM.Tier =  1
ITEM.Weight =  0.33
ITEM.BulkPrice =  6000
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
    [DMG_ACID] = 0.85,
    [DMG_POISON] = 0.85,
    [DMG_NERVEGAS] = 0.85,
    -- "Electric Shock"
    [DMG_SHOCK] = 1,
    -- "Radiation"
    [DMG_RADIATION] = 1,
    -- "Psychic"
    [DMG_PARALYZE] = 1,
}
function ITEM:GetSellPrice()
    return 1300
end