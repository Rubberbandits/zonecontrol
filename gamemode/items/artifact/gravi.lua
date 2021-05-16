ITEM.Base = "artifact"
ITEM.Name =  "Gravi"
ITEM.Desc =  "An amalgamation of metallic compounds blended together by intense gravitational fields. Bright and incandescent streaks auburn and dusky beige stand out against the darker impurities inlaid into the artifact. It comes away smooth to the touch, and exhibits a mild zero-point gravitational field around it that pushes things away. Makes users vulnerable to radiation."
ITEM.Model =  "models/tnb/stalker/artifacts/gravi.mdl"
ITEM.Tier =  2
ITEM.Weight =  0.5;
ITEM.BulkPrice =  25000
ITEM.CarryAdd		= 6;
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
    [DMG_RADIATION] = 1.2,
    -- "Psychic"
    [DMG_PARALYZE] = 1,
}
