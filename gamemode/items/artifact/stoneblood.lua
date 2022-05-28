ITEM.Base = "artifact"
ITEM.Name =  "Stone Blood"
ITEM.Desc =  "Raw viscera that has formed into a nebulous mass. Varies in color, ranging from light reds to deep blacks. Seems to take on characteristics from that which it is formed. Oozes a sticky, crimson substance. Lab reports indicate increased sensitivty to radiation, but protection from chemical damage such as poison, acid, or nerve gas."
ITEM.Model =  "models/tnb/stalker/artifacts/stoneblood.mdl"
ITEM.Tier =  2
ITEM.Weight =  0.5
ITEM.BulkPrice =  27500
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
    [DMG_ACID] = 0.72,
    [DMG_POISON] = 0.72,
    [DMG_NERVEGAS] = 0.72,
    -- "Electric Shock"
    [DMG_SHOCK] = 1,
    -- "Radiation"
    [DMG_RADIATION] = 1.1,
    -- "Psychic"
    [DMG_PARALYZE] = 1,
}
function ITEM:GetSellPrice()
    return 5500
end