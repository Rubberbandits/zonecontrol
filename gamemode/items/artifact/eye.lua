
ITEM.Base = "artifact"
ITEM.Name =  "Eye"
ITEM.Desc =  "A tubular shaped, magma-like artifact that resembles a bright yellow- human eye on one end and darkens and tapers off on the other. The eye-portion glows brightly from within. It is pleasantly warm when held and vastly increases the user’s metabolism. It is also said to bring good luck. "
ITEM.Model =  "models/tnb/stalker/artifacts/eye.mdl"
ITEM.Tier =  1
ITEM.Weight =  1;
ITEM.BulkPrice =  40000
ITEM.ArmorValues = {
    -- "Impact" (blunt)
    [DMG_CRUSH] = 1.1,
    [DMG_FALL] = 1.1,
    [DMG_CLUB] = 1.1,
    [DMG_VEHICLE] = 1.1,
    -- "Rupture" (sharp)
    [DMG_SLASH] = 1.1,
    -- "Bulletproof"
    [DMG_BULLET] = 1.1,
    -- "Explosion"
    [DMG_BLAST] = 1.1,
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
    [DMG_RADIATION] = .85,
    -- "Psychic"
    [DMG_PARALYZE] = 1,
}
