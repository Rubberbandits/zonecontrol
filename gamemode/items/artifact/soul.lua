ITEM.Base = "artifact"
ITEM.Name =  "Soul"
ITEM.Desc =  "Post-animate material that seems to have flowed into a semi-rigid amorphous shape. It is slightly flexible and varies in color and form. Something luminous shifts beneath its surface. Many believe these to be the remains of good stalkers and are held in high regard. Extremely susceptible to radiation, offering protection across the board to compensate, like a radioactive guardian angel."
ITEM.Model =  "models/tnb/stalker/artifacts/soul.mdl"
ITEM.Tier =  3
ITEM.Weight =  0.5;
ITEM.BulkPrice =  50000
ITEM.ArmorValues = {
    -- "Impact" (blunt)
    [DMG_CRUSH] = 0.85,
    [DMG_FALL] = 0.85,
    [DMG_CLUB] = 0.85,
    [DMG_VEHICLE] = 0.85,
    -- "Rupture" (sharp)
    [DMG_SLASH] = 0.85,
    -- "Bulletproof"
    [DMG_BULLET] = 0.85,
    -- "Explosion"
    [DMG_BLAST] = 0.85,
    -- "Thermal"
    [DMG_BURN] = 0.85,
    [DMG_SLOWBURN] = 0.85,
    -- "Chemical Burn"
    [DMG_ACID] = 0.85,
    [DMG_POISON] = 0.85,
    [DMG_NERVEGAS] = 0.85,
    -- "Electric Shock"
    [DMG_SHOCK] = 0.85,
    -- "Radiation"
    [DMG_RADIATION] = 3,
    -- "Psychic"
    [DMG_PARALYZE] = 1,
}
