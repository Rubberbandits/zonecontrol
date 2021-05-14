ITEM.Base = "artifact"
ITEM.Name =  "Fireball"
ITEM.Desc =  "Even though the Fireball is a thermal artifact, it can be handled without fear of being burned. This artifact is valued for its ability to maintain a temperature of 75 degrees Fahrenheit within a small radius, virtually regardless of its surroundings. Seems to make holders sensitive to radiation."
ITEM.Model =  "models/tnb/stalker/artifacts/fireball.mdl"
ITEM.Tier =  2
ITEM.Weight =  0.66;
ITEM.BulkPrice =  32500
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
    [DMG_BURN] = 0.75,
    [DMG_SLOWBURN] = 0.75,
    -- "Chemical Burn"
    [DMG_ACID] = 1,
    [DMG_POISON] = 1,
    [DMG_NERVEGAS] = 1,
    -- "Electric Shock"
    [DMG_SHOCK] = 1,
    -- "Radiation"
    [DMG_RADIATION] = 1.6,
    -- "Psychic"
    [DMG_PARALYZE] = 1,
}
