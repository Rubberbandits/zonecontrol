ITEM.Base = "artifact"
ITEM.Name =  "Slug"
ITEM.Desc =  "An almost invisible, insubstantial mass whose edges seem to melt out of existence. If not for its copper-red emanations and silver edges, it would be impossible to see. It burdens the bearer greatly and any exertion seems greatly magnified, as if their strength is being drawn to something far away. A protective shell canvases the wearer, offering them fabulous protection across the board."
ITEM.Model =  "models/tnb/stalker/artifacts/slug.mdl"
ITEM.Tier =  3
ITEM.Weight =  5
ITEM.BulkPrice =  105000
ITEM.ArmorValues = {
    -- "Impact" (blunt)
    [DMG_CRUSH] = 0.6,
    [DMG_FALL] = 0.6,
    [DMG_CLUB] = 0.6,
    [DMG_VEHICLE] = 0.6,
    -- "Rupture" (sharp)
    [DMG_SLASH] = 0.6,
    -- "Bulletproof"
    [DMG_BULLET] = 0.6,
    -- "Explosion"
    [DMG_BLAST] = 0.6,
    -- "Thermal"
    [DMG_BURN] = 0.6,
    [DMG_SLOWBURN] = 0.6,
    -- "Chemical Burn"
    [DMG_ACID] = 0.6,
    [DMG_POISON] = 0.6,
    [DMG_NERVEGAS] = 0.6,
    -- "Electric Shock"
    [DMG_SHOCK] = 0.6,
    -- "Radiation"
    [DMG_RADIATION] = 0.6,
    -- "Psychic"
    [DMG_PARALYZE] = 1,
}
function ITEM:GetSellPrice()
    return 21000
end