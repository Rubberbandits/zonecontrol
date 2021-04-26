ITEM.Base = "detector"
ITEM.Name = "Artifact Detector (veles)"
ITEM.Desc = "One of the most advanced artifact detectors you can get a hold of."
ITEM.Model = "models/kali/miscstuff/stalker/detector_veles.mdl"
ITEM.Size =	1
ITEM.Amount = 1
ITEM.FOV = 8;
ITEM.DetectorType = 3
ITEM.CamPos = Vector( 0.5, 18.75, 60 );
ITEM.LookAt = Vector( 0, 1, 4.83 );
ITEM.Weight = 0.65
ITEM.BulkPrice = 200000;
ITEM.License = "X";
ITEM.Rarity = 5
ITEM.AllowRandomSpawn = false
ITEM.IsSellable = true

function ITEM:GetSellPrice()
    return 40000
end