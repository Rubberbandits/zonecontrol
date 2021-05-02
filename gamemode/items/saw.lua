ITEM.Name =  "Big Circular Saw";
ITEM.Desc =  "An off-brand circular saw. There's no finger guard. It doesn't work anymore.";
ITEM.Model =  "models/props/CS_militia/circularsaw01.mdl";
ITEM.Weight =  1;
ITEM.FOV =  13;
ITEM.CamPos =  Vector( 50, 50, 50 );
ITEM.LookAt =  Vector( 0, 0, 0 );
ITEM.BulkPrice =  100
ITEM.W = 2
ITEM.H = 2
ITEM.Rarity = 2
ITEM.AllowRandomSpawn = true
ITEM.IsSellable = true

function ITEM:GetSellPrice()
	return 20
end