ITEM.Base = "artifact"
ITEM.Name =  "Sarcophagus"
ITEM.Desc =  "An ecologist's lunchbox. Green light seeps through from inside, but you cannot open it. A sense of power and clarity comes to those who possess it, despite experiencing dry and fragile skin to contradict. Limbs tend to resist harm when exposed to chemical damage, only turning a slight green upon impact. Extremely radioactive."
ITEM.Model =  "models/instrument.mdl"
ITEM.Tier =  2
ITEM.Weight =  2;
ITEM.BulkPrice =  50000
ITEM.ArmorValues = {
    -- "Impact" (blunt)
    [DMG_CRUSH] = 1.2,
    [DMG_FALL] = 1.2,
    [DMG_CLUB] = 1.2,
    [DMG_VEHICLE] = 1,
    -- "Rupture" (sharp)
    [DMG_SLASH] = 1.2,
    -- "Bulletproof"
    [DMG_BULLET] = 1.2,
    -- "Explosion"
    [DMG_BLAST] = 1.2,
    -- "Thermal"
    [DMG_BURN] = 1.2,
    [DMG_SLOWBURN] = 1.2,
    -- "Chemical Burn"
    [DMG_ACID] = 0.7,
    [DMG_POISON] = 0.7,
    [DMG_NERVEGAS] = 0.7,
    -- "Electric Shock"
    [DMG_SHOCK] = 1.2,
    -- "Radiation"
    [DMG_RADIATION] = 3,
    -- "Psychic"
    [DMG_PARALYZE] = 0.7,
}