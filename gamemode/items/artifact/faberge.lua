ITEM.Base = "artifact"
ITEM.Name =  "Fabergé Egg"
ITEM.Desc =  "An elaborately decorated testament to Russian vanity dating to the late 1800s. It's unknown whether or not this fine ornament was birthed by the Zone, but it is reported to send users into royal delusions, perceiving themselves to be grandiose royalty or czars."
ITEM.Model =  "models/props_phx/misc/egg.mdl"

ITEM.ItemSubmaterials = {
{ 0 , "models/synth/backcyl" }
}

ITEM.Tier =  1
ITEM.Weight =  0.5;
ITEM.BulkPrice = 7500
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
    [DMG_RADIATION] = 1,
    -- "Psychic"
    [DMG_PARALYZE] = 2,
}
