ITEM.Base = "artifact"
ITEM.Name =  "Goldfish"
ITEM.Desc =  "A deadspace pocket of focused gravitational energy turned in on itself. Physically it is almost indescribable; the closest one can come is its superficial resemblance to a human stomach. Its surface is grey and reflective, yet shimmers with vigor like a disturbed pool of water. Known to make users sensitive to radiation, though it invigorates them with an unrealized strength."
ITEM.Model =  "models/kali/miscstuff/stalker/artifacts/goldfish.mdl"
ITEM.Tier =  2
ITEM.Weight =  0.5;
ITEM.BulkPrice =  50000
ITEM.CarryAdd		= 10;
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
    [DMG_PARALYZE] = 1,
}
