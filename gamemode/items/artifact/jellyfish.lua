
ITEM.Base = "artifact"
ITEM.Name =  "Jellyfish"
ITEM.Desc =  "One of the most common artifacts in the Zone. An intertwining web of ossified matter that has a strange energy emanating from its center. Widespread and not very valuable, but has the pleasant quality of something familiar. Emits radiation."
ITEM.Model =  "models/tnb/stalker/artifacts/jellyfish.mdl"
ITEM.Tier =  1
ITEM.Weight =  1;
ITEM.BulkPrice =  4000
ITEM.ArmorValues = {
    -- "Impact" (blunt)
    [DMG_CRUSH] = 1,
    [DMG_FALL] = 1,
    [DMG_CLUB] = 1,
    [DMG_VEHICLE] = 1,
    -- "Rupture" (sharp)
    [DMG_SLASH] = 1,
    -- "Bulletproof"
    [DMG_BULLET] = .95,
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
    [DMG_PARALYZE] = 1,
}
