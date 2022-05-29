ITEM.Base = "artifact"
ITEM.Name =  "Kolobok"
ITEM.Desc =  "A relatively rare artifact which forms in areas contaminated with chemicals, Kolobok is highly valued for its ability to heal wounds of any kind in mere minutes. For unknown reasons, scientists are spreading rumors among stalkers that the artifact interacts with the bearer's genetic code. Slightly irradiated, though oddly protects against the contaminants it's birthed in."
ITEM.Model =  "models/kali/miscstuff/stalker/artifacts/kolobok.mdl"
ITEM.Tier =  2
ITEM.Weight =  0.5
ITEM.BulkPrice =  37500
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
    [DMG_ACID] = 0.7,
    [DMG_POISON] = 0.7,
    [DMG_NERVEGAS] = 0.7,
    -- "Electric Shock"
    [DMG_SHOCK] = 1,
    -- "Radiation"
    [DMG_RADIATION] = 1.2,
    -- "Psychic"
    [DMG_PARALYZE] = 1,
}
function ITEM:GetSellPrice()
    return 7500
end