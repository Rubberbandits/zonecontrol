ITEM.Base = "detector"
ITEM.Name =	"Artifact Detector (bear)"
ITEM.Desc =	"A more advanced artifact detector, which doesnt only beep but also points you in the right direction!"
ITEM.Model =	"models/kali/miscstuff/stalker/detector_bear.mdl"
ITEM.Size =	1
ITEM.Amount = 1
ITEM.DetectorType = 2
ITEM.FOV = 5;
ITEM.CamPos = Vector( -1.37, -0, 100 );
ITEM.LookAt = Vector( 0, 0, 0 );
ITEM.Weight = 0.65
ITEM.BulkPrice = 62500;
ITEM.Rarity = 4
ITEM.AllowRandomSpawn = true
ITEM.IsSellable = true

function ITEM:GetSellPrice()
    return 12500
end