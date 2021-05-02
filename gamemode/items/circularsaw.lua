ITEM.Name =  "Circular Saw";
ITEM.Desc =  "A saw for cutting wood. It doesn't work anymore.";
ITEM.Model =  "models/props_forest/circularsaw01.mdl";
ITEM.Weight =  2;
ITEM.FOV =  13;
ITEM.CamPos =  Vector( 50, 50, 50 );
ITEM.LookAt =  Vector( 0, 0, 0 );
ITEM.BulkPrice =  50
ITEM.License =  "X"
ITEM.W = 2
ITEM.H = 2
ITEM.Rarity = 1
ITEM.AllowRandomSpawn = true
ITEM.IsSellable = true

function ITEM:GetSellPrice()
	return 10
end