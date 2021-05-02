ITEM.Name =  "Socket Set";
ITEM.Desc =  "A 21 piece socket set. Supposedly, these can tighten bolts.";
ITEM.Model =  "models/toolkit_p.mdl";
ITEM.Weight =  3;
ITEM.FOV =  14;
ITEM.CamPos =  Vector( 50, 50, 50 );
ITEM.LookAt =  Vector( 0, 0, 0 );
ITEM.BulkPrice =  250
ITEM.License =  "X";
ITEM.W = 2
ITEM.H = 1
ITEM.Rarity = 2
ITEM.AllowRandomSpawn = true
ITEM.IsSellable = true

function ITEM:GetSellPrice()
	return 50
end