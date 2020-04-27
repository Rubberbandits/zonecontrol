
ITEM.Base = "artifact"
ITEM.Name =  "Electro Battery"
ITEM.Desc =  "Composed seemingly only of rust, this artifact appears to be generated around what in ordinary circumstances would be a centralized electromagnet. Bands of string-like oxidation have twisted to intersect across two parabolic arches, giving it a delicate appearance. The air around it thrums, heavy with potential. Generates an intense static charge."
ITEM.Model =  "models/tnb/stalker/artifacts/battery.mdl"
ITEM.Tier =  1
ITEM.FOV =  35
ITEM.CamPos =  Vector( 50, 50, 50 )
ITEM.LookAt =  Vector( -3.5, -2, 4 )
ITEM.Weight =  1;
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
    [DMG_SHOCK] = .7,
    -- "Radiation"
    [DMG_RADIATION] = 1.2,
    -- "Psychic"
    [DMG_PARALYZE] = 1,
}
