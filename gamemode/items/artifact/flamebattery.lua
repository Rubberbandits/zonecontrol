ITEM.Base = "artifact"
ITEM.Name =  "Flame Battery"
ITEM.Desc =  "A Battery burned to a cinder. Seemingly a vessel for radiation, this Zone beauty is vaguely shaped like a harp, thin strands of electrostatic material stretch to connect each curve decorating it. The texture is rough and corrugated like metal, yet light and lined with glowing reddish cracks that emit ash and embers on its surface. Rumoured to offer burn protection."
ITEM.Model =  "models/kali/miscstuff/stalker/artifacts/battery.mdl"
ITEM.Tier =  3
ITEM.Weight =  0.5;
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
    [DMG_BURN] = 0.7,
    [DMG_SLOWBURN] = 0.7,
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
