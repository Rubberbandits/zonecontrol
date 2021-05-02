ITEM.Name =  "Bar";
ITEM.Desc =  "A heavy, tarnished chunk of metal.";
ITEM.Model =  "models/props_debris/concrete_chunk05g.mdl";
ITEM.Weight =  4
ITEM.FOV =  8;
ITEM.CamPos =  Vector( 50, 50, 50 );
ITEM.LookAt =  Vector( 0, 0, 0 );
ITEM.BulkPrice = 7500
ITEM.W = 2
ITEM.H = 1
ITEM.Rarity = 5
ITEM.AllowRandomSpawn = false
ITEM.IsSellable = true

function ITEM:GetSellPrice()
	return 1500
end