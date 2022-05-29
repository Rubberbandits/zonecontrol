ITEM.Base = "artifact"
ITEM.Name =  "Sponge"
ITEM.Desc =  "A powerful resistor, the sponge is capable of absorbing lethal doses of electricity. However, it's ability to spontaneously combust under mild heat makes it difficult to employ. Makes users more susceptible to radiation."
ITEM.Model =  "models/kali/miscstuff/stalker/artifacts/stone flower.mdl"
ITEM.ItemSubmaterials = {
{ 0 , "models/tnb/artifacts/slug1" }
}
ITEM.Tier =  1
ITEM.Weight =  0.5;
ITEM.BulkPrice =  10000
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
    [DMG_BLAST] = 0.8,
    -- "Thermal"
    [DMG_BURN] = 2,
    [DMG_SLOWBURN] = 2,
    -- "Chemical Burn"
    [DMG_ACID] = 1,
    [DMG_POISON] = 1,
    [DMG_NERVEGAS] = 1,
    -- "Electric Shock"
    [DMG_SHOCK] = 0.5,
    -- "Radiation"
    [DMG_RADIATION] = 1.2,
    -- "Psychic"
    [DMG_PARALYZE] = 1,
}
function ITEM:GetSellPrice()
    return 2000
end