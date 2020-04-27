
ITEM.Base = "artifact"
ITEM.Name =  "Pellicle"
ITEM.Desc =  "An unidentifiable aqua-colored substrate with iridescent properties. Its surface is striated and contoured, stretched thin by anomalous processes. Exhibits gravimetric properties and insulates from acid burns by changing the makeup of the skin."
ITEM.Model =  "models/kali/miscstuff/stalker/artifacts/bubble.mdl"
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
    [DMG_ACID] = .7,
    [DMG_POISON] = .7,
    [DMG_NERVEGAS] = .7,
    -- "Electric Shock"
    [DMG_SHOCK] = 1,
    -- "Radiation"
    [DMG_RADIATION] = 1,
    -- "Psychic"
    [DMG_PARALYZE] = 1,
}
