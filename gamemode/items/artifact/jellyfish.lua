ITEM.Base = "artifact"
ITEM.Name =  "Jellyfish"
ITEM.Desc =  "This gravitational artifact attracts and absorbs radioactive particles, reducing the effects of radiation on the body. Very common in the Zone and not very valuable, it is unofficially used outside the Zone for treating acute radiation sickness in exceptional circumstances. Holders report pleasant thoughts and show unbothered demeanors with it, but are capable of withdrawing from those positive effects if exposed for long periods of time."
ITEM.Model =  "models/tnb/stalker/artifacts/jellyfish.mdl"
ITEM.Tier =  1
ITEM.Weight =  0.5;
ITEM.BulkPrice =  5000
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
    [DMG_RADIATION] = 0.85,
    -- "Psychic"
    [DMG_PARALYZE] = 1,
}