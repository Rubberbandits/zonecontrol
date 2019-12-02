-- This file was converted to Kingston item system by Niggerlicious conversion kit --
ITEM.Base = "artifact"
ITEM.Name =  "Gravi"
ITEM.Desc =  "An amalgamation of metallic compounds blended together by intense gravitational fields. Bright and incandescent streaks auburn and dusky beige stand out against the darker impurities inlaid into the artifact. It comes away smooth to the touch, and exhibits a mild zero-point gravitational field around it that pushes things away. Emits radiation."
ITEM.Model =  "models/tnb/stalker/artifacts/gravi.mdl"
ITEM.Tier =  1
ITEM.FOV =  35
ITEM.CamPos =  Vector( 50, 50, 50 )
ITEM.LookAt =  Vector( -3.5, -2, 4 )
ITEM.Weight =  1;
ITEM.BulkPrice =  40000
ITEM.ArmorValues = {
    -- "Impact" (blunt)
    [DMG_CRUSH] = 1.05,
    [DMG_FALL] = 1.05,
    [DMG_CLUB] = 1.05,
    [DMG_VEHICLE] = 1.05,
    -- "Rupture" (sharp)
    [DMG_SLASH] = .95,
    -- "Bulletproof"
    [DMG_BULLET] = .95,
    -- "Explosion"
    [DMG_BLAST] = .95,
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
    [DMG_RADIATION] = 1.15,
    -- "Psychic"
    [DMG_PARALYZE] = 1,
}
