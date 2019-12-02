-- This file was converted to Kingston item system by Niggerlicious conversion kit --
ITEM.Base = "artifact"
ITEM.Name =  "Shell"
ITEM.Desc =  "Fungus like metal plates interconnected by brown, root like growths. The connection tapers towards the middle and shimmers with forces unseen. Merges with the users’ nervous system and vastly increases endurance. Emits radiation."
ITEM.Model =  "models/tnb/stalker/artifacts/shell.mdl"
ITEM.Tier =  2
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
    [DMG_ACID] = .9,
    [DMG_POISON] = .9,
    [DMG_NERVEGAS] = .9,
    -- "Electric Shock"
    [DMG_SHOCK] = .9,
    -- "Radiation"
    [DMG_RADIATION] = 1.2,
    -- "Psychic"
    [DMG_PARALYZE] = .9,
}
