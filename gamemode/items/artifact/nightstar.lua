ITEM.Base = "artifact"
ITEM.Name =  "Night Star"
ITEM.Desc =  "Only found in the evening, this rare artifact is covered in intangible spikes of light, frozen in space. The center is a velvety grey substance that is cool to the touch. Causes bouts of paranoia and depressive emotions. It is unknown whether it makes the owner stronger temporarily, or merely makes nearby things lighter. Attracts radiation."
ITEM.Model =  "models/tnb/stalker/artifacts/nightstar.mdl"
ITEM.Tier =  2
ITEM.Weight =  0.5;
ITEM.BulkPrice =  25000
ITEM.CarryAdd		= 4;
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
    [DMG_RADIATION] = 1.3,
    -- "Psychic"
    [DMG_PARALYZE] = 1,
}
