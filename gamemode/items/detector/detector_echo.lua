ITEM.Base = "detector"
ITEM.Name =	"Artifact Detector (echo)"
ITEM.Desc =	"One of the simplest types of artifact detectors, and most common."
ITEM.Model =	"models/kali/miscstuff/stalker/detector_echo.mdl"
ITEM.Size =	1
ITEM.Amount = 1
ITEM.FOV = 8;
ITEM.DetectorType = 1
ITEM.CamPos = Vector( 0.5, 18.75, 60 );
ITEM.LookAt = Vector( 0, 1, 4.83 );
ITEM.Weight = 0.65;
ITEM.BulkPrice = 22500;
ITEM.License = "X"
ITEM.Rarity = 3
ITEM.AllowRandomSpawn = true
ITEM.IsSellable = true

function ITEM:GetSellPrice()
    return 4500
end