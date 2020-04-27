
ITEM.Base = "artifact"
ITEM.Name =  "Flame Battery"
ITEM.Desc =  "A Battery burned to a cinder. Vaguely shaped like a harp, thin strands of electrostatic material stretch to connect each curve. The texture is rough and corrugated like metal, yet quite light. The surface is lined with glowing reddish cracks that emit ash and embers."
ITEM.Model =  "models/kali/miscstuff/stalker/artifacts/battery.mdl"
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
    [DMG_BURN] = .7,
    [DMG_SLOWBURN] = .7,
    -- "Chemical Burn"
    [DMG_ACID] = 1,
    [DMG_POISON] = 1,
    [DMG_NERVEGAS] = 1,
    -- "Electric Shock"
    [DMG_SHOCK] = 1,
    -- "Radiation"
    [DMG_RADIATION] = 1.3,
    -- "Psychic"
    [DMG_PARALYZE] = 1,
}
