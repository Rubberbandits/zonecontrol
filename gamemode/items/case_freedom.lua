ITEM.Name =  "Svoboda Case";
ITEM.Desc =  "A suitcase with an airport security lock on the handle. FREEDOM emblem stenciled onto it's face. You'll need help or a key to crack it open.";
ITEM.Model =  "models/kek1ch/case.mdl";
ITEM.Weight =  5;
ITEM.FOV =  22;
ITEM.CamPos =  Vector( 50, 50, 50 );
ITEM.LookAt =  Vector( 0, -2, -3 );
ITEM.BulkPrice =  10000;
ITEM.W = 2
ITEM.H = 2
ITEM.Rarity = 4
ITEM.AllowRandomSpawn = false
ITEM.IsSellable = true

function ITEM:GetSellPrice()
	return 2000
end