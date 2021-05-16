ITEM.Base = "artifact"
ITEM.Name =  "Moonlight"
ITEM.Desc =  "A solitary mote of purest energy held within what appears to be thick, translucent ceramic. Occasionally gives off strong static discharges and is far heavier than it appears. Strands of energy trace the fingers when held. It gazes into you, calming mind and spirit. Renders users sensitive to radiation."
ITEM.Model =  "models/tnb/stalker/artifacts/moonlight.mdl"
ITEM.Tier =  3
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
    [DMG_ACID] = 1,
    [DMG_POISON] = 1,
    [DMG_NERVEGAS] = 1,
    -- "Electric Shock"
    [DMG_SHOCK] = 1,
    -- "Radiation"
    [DMG_RADIATION] = 1.3,
    -- "Psychic"
    [DMG_PARALYZE] = 0.5,
}
