
ITEM.Base = "artifact"
ITEM.Name =  "Thorn"
ITEM.Desc =  "The unfortunate result of human interaction with acidic anomalies. Unique in that it only forms from human flesh in such circumstances. It is a small black-brown ball covered with thick, razor sharp spikes, giving it a severe appearance. Handling it will inevitably result in numerous lacerations and hemorrhaging of blood. Drains radiation from the body."
ITEM.Model =  "models/tnb/stalker/artifacts/thorn.mdl"
ITEM.Tier =  2
ITEM.Weight =  1;
ITEM.BulkPrice =  7500
ITEM.ArmorValues = {
    -- "Impact" (blunt)
    [DMG_CRUSH] = 1.05,
    [DMG_FALL] = 1.05,
    [DMG_CLUB] = 1.05,
    [DMG_VEHICLE] = 1.05,
    -- "Rupture" (sharp)
    [DMG_SLASH] = 1.05,
    -- "Bulletproof"
    [DMG_BULLET] = 1.05,
    -- "Explosion"
    [DMG_BLAST] = 1.05,
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
    [DMG_RADIATION] = .9,
    -- "Psychic"
    [DMG_PARALYZE] = 1,
}
