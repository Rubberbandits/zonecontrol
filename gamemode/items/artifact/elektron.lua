ITEM.Base = "artifact"
ITEM.Name =  "Elektron"
ITEM.Desc =  "A hunk of acrid crust formed around two double A batteries with a negative charge. Users report increased skin sensitivity with acid and electricity; it possesses cooling effects and strengthens their wits, making them more sensitive to radiation."
ITEM.Model =  "models/kali/miscstuff/stalker/aid/anti-rad.mdl"
ITEM.Tier =  2
ITEM.Weight =  0.50;
ITEM.BulkPrice =  35000
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
    [DMG_RADIATION] = 1.2,
    -- "Psychic"
    [DMG_PARALYZE] = 0.9,
}
