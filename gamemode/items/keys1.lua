ITEM.Name =  "Key";
ITEM.Desc =  "A small wrought-iron key. It probably opens a door somewhere, maybe.";
ITEM.Model =  "models/key.mdl";
ITEM.Weight =  0.33
ITEM.FOV =  5;
ITEM.CamPos =  Vector( 50, 50, 50 );
ITEM.LookAt =  Vector( 0, 0, 0 );
ITEM.BulkPrice =  500
ITEM.W = 1
ITEM.H = 1
ITEM.Rarity = 1
ITEM.AllowRandomSpawn = true
ITEM.IsSellable = true

function ITEM:GetSellPrice()
	return 100
end