
ITEM.Base = "artifact"
ITEM.Name =  "Elektron"
ITEM.Desc =  "A hunk of acrid crust formed around two double A batteries. They have a negative charge."
ITEM.Model =  "models/kali/miscstuff/stalker/aid/anti-rad.mdl"
ITEM.Tier =  0
ITEM.FOV =  2
ITEM.CamPos =  Vector( 50, 50, 50 )
ITEM.LookAt =  Vector( 0, 0, 0 )
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
    [DMG_BURN] = 1.2,
    [DMG_SLOWBURN] = 1.2,
    -- "Chemical Burn"
    [DMG_ACID] = 0.7,
    [DMG_POISON] = 1,
    [DMG_NERVEGAS] = 1,
    -- "Electric Shock"
    [DMG_SHOCK] = 0.8,
    -- "Radiation"
    [DMG_RADIATION] = 1.0,
    -- "Psychic"
    [DMG_PARALYZE] = 0.9,
}
