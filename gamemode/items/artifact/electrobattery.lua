ITEM.Base = "artifact"
ITEM.Name =  "Electro Battery"
ITEM.Desc =  "Composed seemingly only of rust, this artifact appears to be generated around what in ordinary circumstances would be a centralized electromagnet. Bands of string-like oxidation have twisted to intersect across two parabolic arches, giving it a delicate appearance. The air around it thrums, heavy with potential. Reported to absorb static electricity whilst making the user more susceptible to radiation."
ITEM.Model =  "models/tnb/stalker/artifacts/battery.mdl"
ITEM.Tier =  3
ITEM.Weight =  0.5
ITEM.BulkPrice =  55000
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
    [DMG_SHOCK] = 0.7,
    -- "Radiation"
    [DMG_RADIATION] = 1.2,
    -- "Psychic"
    [DMG_PARALYZE] = 1,
}
