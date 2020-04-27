
ITEM.Base = "artifact"
ITEM.Name =  "Goldfish"
ITEM.Desc =  "A deadspace pocket of focused gravitational energy turned in on itself. Physically it is almost indescribable; the closest one can come is its superficial resemblance to a human stomach. Its surface is grey and reflective, yet shimmers with vigor like a disturbed pool of water. Emits radiation."
ITEM.Model =  "models/kali/miscstuff/stalker/artifacts/goldfish.mdl"
ITEM.Tier =  2
ITEM.FOV =  35
ITEM.CamPos =  Vector( 50, 50, 50 )
ITEM.LookAt =  Vector( -3.5, -2, 4 )
ITEM.Weight =  1;
ITEM.BulkPrice =  75000
ITEM.ArmorValues = {
    -- "Impact" (blunt)
    [DMG_CRUSH] = .95,
    [DMG_FALL] = .95,
    [DMG_CLUB] = .95,
    [DMG_VEHICLE] = .95,
    -- "Rupture" (sharp)
    [DMG_SLASH] = .8,
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
