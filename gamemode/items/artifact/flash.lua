ITEM.Base = "artifact"
ITEM.Name =  "Flash"
ITEM.Desc =  "Pure light, almost impossible to grasp - physically and philosophically. Encased in a dull, yet lustrous shell, it is extremely bright and scorches false after-images into the retinas when looked at. Produces light even when placed in containers or covered up. Conducts electricity away from the wielder, simultaneously suscepting them to radiation."
ITEM.Model =  "models/tnb/stalker/artifacts/flash.mdl"
ITEM.Tier =  2
ITEM.Weight =  0.5;
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
    [DMG_BURN] = 1,
    [DMG_SLOWBURN] = 1,
    -- "Chemical Burn"
    [DMG_ACID] = 1,
    [DMG_POISON] = 1,
    [DMG_NERVEGAS] = 1,
    -- "Electric Shock"
    [DMG_SHOCK] = 0.6,
    -- "Radiation"
    [DMG_RADIATION] = 1.2,
    -- "Psychic"
    [DMG_PARALYZE] = 1,
}
