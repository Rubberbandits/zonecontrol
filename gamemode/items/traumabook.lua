ITEM.Name =  "Prehospital Trauma";
ITEM.Desc =  "A Western publication on trauma-based emergency medical care.";
ITEM.Model =  "models/props_lab/bindergreen.mdl";
ITEM.Weight =  1;
ITEM.FOV =  13;
ITEM.CamPos =  Vector( 50, 50, 50 );
ITEM.LookAt =  Vector( 0, 0, 0 );
ITEM.BulkPrice =  150
ITEM.W = 2
ITEM.H = 2
ITEM.Rarity = 2
ITEM.AllowRandomSpawn = true
ITEM.IsSellable = true

function ITEM:GetSellPrice()
	return 30
end