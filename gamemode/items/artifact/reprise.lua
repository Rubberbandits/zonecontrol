ITEM.Base = "artifact"
ITEM.Name =  "Reprise"
ITEM.Desc =  "An artifact of times before the Zone. Those who wield it are typically thought-looped with a singular phrase, 'Pust' ty nikogda ne uznayesh' istinnyy mir', or 'may you never know the true world'. Stalkers with this in their belt are known to be goal-oriented, organized, and deadset on achievement. A slight brush of the blade causes one to gush blood like a waterfall."
ITEM.Model =  "models/props/de_cbble/old_weapons/single_sword.mdl"
ITEM.ItemSubmaterials = {
{ 0 , "models/props_wasteland/metal_tram001a" }
}

ITEM.Weight =  2;
ITEM.BulkPrice =  22500
ITEM.ArmorValues = {
    -- "Impact" (blunt)
    [DMG_CRUSH] = 1,
    [DMG_FALL] = 1,
    [DMG_CLUB] = 1,
    [DMG_VEHICLE] = 1,
    -- "Rupture" (sharp)
    [DMG_SLASH] = 1.3,
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
    [DMG_PARALYZE] = 0.7,
}
