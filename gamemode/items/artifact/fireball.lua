
ITEM.Base = "artifact"
ITEM.Name =  "Fireball"
ITEM.Desc =  "Living metal the color of iron encased in raw glass. The air around it warps and roils as if heated and light the color of a forge shines brightly through splits in its inner surface. Invigorates the wielder, and is known as a Stalker’s best friend. No known negative effects other than slight fatigue."
ITEM.Model =  "models/kali/miscstuff/stalker/artifacts/fireball.mdl"
ITEM.Tier =  1
ITEM.Weight =  1;
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
    [DMG_BLAST] = 1,
    -- "Thermal"
    [DMG_BURN] = .8,
    [DMG_SLOWBURN] = .8,
    -- "Chemical Burn"
    [DMG_ACID] = 1,
    [DMG_POISON] = 1,
    [DMG_NERVEGAS] = 1,
    -- "Electric Shock"
    [DMG_SHOCK] = 1,
    -- "Radiation"
    [DMG_RADIATION] = 1.3,
    -- "Psychic"
    [DMG_PARALYZE] = 1,
}
