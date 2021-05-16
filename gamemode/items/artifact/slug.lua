ITEM.Base = "artifact"
ITEM.Name =  "Slug"
ITEM.Desc =  "An almost invisible, insubstantial mass whose edges seem to melt out of existence. If not for its copper-red emanations and silver edges, it would be impossible to see. It burdens the bearer greatly and any exertion seems greatly magnified, as if their strength is being drawn to something far away. A protective shell canvases the wearer, but renders them elementally sensitive."
ITEM.Model =  "models/tnb/stalker/artifacts/slug.mdl"
ITEM.Tier =  3
ITEM.Weight =  1;
ITEM.BulkPrice =  40000
ITEM.ArmorValues = {
    -- "Impact" (blunt)
    [DMG_CRUSH] = 0.95,
    [DMG_FALL] = 0.95,
    [DMG_CLUB] = 0.95,
    [DMG_VEHICLE] = 0.95,
    -- "Rupture" (sharp)
    [DMG_SLASH] = 1,
    -- "Bulletproof"
    [DMG_BULLET] = 1,
    -- "Explosion"
    [DMG_BLAST] = 1,
    -- "Thermal"
    [DMG_BURN] = 1.1,
    [DMG_SLOWBURN] = 1.1,
    -- "Chemical Burn"
    [DMG_ACID] = 1.1,
    [DMG_POISON] = 1.1,
    [DMG_NERVEGAS] = 1.1,
    -- "Electric Shock"
    [DMG_SHOCK] = 1,
    -- "Radiation"
    [DMG_RADIATION] = 1,
    -- "Psychic"
    [DMG_PARALYZE] = 1,
}