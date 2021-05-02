ITEM.Name =  "Kanifol";
ITEM.Desc =  "A tin of a resin-like substance.";
ITEM.Model =  "models/box_kanifol.mdl";
ITEM.Weight =  .5;
ITEM.FOV =  8;
ITEM.CamPos =  Vector( 50, 50, 50 );
ITEM.LookAt =  Vector( 0, -1, 1 );
ITEM.BulkPrice =  1000
ITEM.W = 1
ITEM.H = 1
ITEM.Rarity = 2
ITEM.AllowRandomSpawn = true
ITEM.IsSellable = true

function ITEM:GetSellPrice()
	return 200
end