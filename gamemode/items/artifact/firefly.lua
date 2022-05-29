ITEM.Base = "artifact"
ITEM.Name =  "Firefly"
ITEM.Desc =  "A seafoam-colored ball with a couple golden ringed holes permeating its surface. Beloved by some of the Zone's first stalkers, this little treat has great healing properties at the expense of quickly irradiating the holder. Medics like them in emergency situations for a quick fixup."
ITEM.Model =  "models/tnb/stalker/artifacts/thorn.mdl"
ITEM.ItemSubmaterials = {
	{ 0 , "models/shadertest/predator" },
	{ 1 , "models/tnb/artifacts/elec1" }
}
ITEM.Tier =  3
ITEM.Weight =  1.5
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
    [DMG_RADIATION] = 2,
    -- "Psychic"
    [DMG_PARALYZE] = 1,
}