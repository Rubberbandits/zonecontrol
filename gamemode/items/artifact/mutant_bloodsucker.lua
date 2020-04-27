
ITEM.Base = "artifact"
ITEM.Name =  "Bloodsucker Resistances"
ITEM.Desc =  "If you have this, you're either a bloodsucker or a CHEATING BASTARD."
ITEM.Model =  "models/Gibs/HGIBS.mdl"
ITEM.Tier =  5
ITEM.FOV =  35
ITEM.CamPos =  Vector( 50, 50, 50 )
ITEM.LookAt =  Vector( -3.5, -2, 4 )
ITEM.Weight =  1;
ITEM.ArmorValues = {
    -- "Impact" (blunt)
    [DMG_CRUSH] = .1,
    [DMG_FALL] = .1,
    [DMG_CLUB] = .1,
    [DMG_VEHICLE] = .1,
    -- "Rupture" (sharp)
    [DMG_SLASH] =.1,
    -- "Bulletproof"
    [DMG_BULLET] = .1,
    -- "Explosion"
    [DMG_BLAST] = .1,
    -- "Thermal"
    [DMG_BURN] = .1,
    [DMG_SLOWBURN] = .1,
    -- "Chemical Burn"
    [DMG_ACID] = .1,
    [DMG_POISON] = .1,
    [DMG_NERVEGAS] = .1,
    -- "Electric Shock"
    [DMG_SHOCK] = .1,
    -- "Radiation"
    [DMG_RADIATION] = .1,
    -- "Psychic"
    [DMG_PARALYZE] = .1,
}
