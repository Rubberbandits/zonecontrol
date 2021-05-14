ITEM.Base = "artifact"
ITEM.Name =  "Death Lamp"
ITEM.Desc =  "Big, red, and cursed. Otherwise known as the Seed of Satan, many traders believe the rumors regarding this artifact and thus refuse to purchase it. Little is known of its origins. It's discovery is accredited to a man named Stefan Norman, who has since gone missing."
ITEM.Model =  "models/kek1ch/crystal_plant.mdl"

ITEM.ItemSubmaterials = {
	{ 0 , "models/props_combine/tprings_globe"},
	{ 1 , "models/props_combine/tprings_globe"},
	{ 2 , "models/props_combine/tprings_globe"},
	{ 3 , "Models/effects/vol_light001"}
}

ITEM.Tier =  2
ITEM.Weight =  9;
ITEM.ArmorValues = {
    -- "Impact" (blunt)
    [DMG_CRUSH] = 2,
    [DMG_FALL] = 2,
    [DMG_CLUB] = 2,
    [DMG_VEHICLE] = 2,
    -- "Rupture" (sharp)
    [DMG_SLASH] = 2,
    -- "Bulletproof"
    [DMG_BULLET] = 2,
    -- "Explosion"
    [DMG_BLAST] = 2,
    -- "Thermal"
    [DMG_BURN] = 2,
    [DMG_SLOWBURN] = 2,
    -- "Chemical Burn"
    [DMG_ACID] = 2,
    [DMG_POISON] = 2,
    [DMG_NERVEGAS] = 2,
    -- "Electric Shock"
    [DMG_SHOCK] = 2,
    -- "Radiation"
    [DMG_RADIATION] = 2,
    -- "Psychic"
    [DMG_PARALYZE] = 2,
}