ITEM.Name =  "Hard Drive";
ITEM.Desc =  "A convenient way to store and transfer data. 1 terabyte of storage, whatever that means. This thing is beefy.";
ITEM.Model =  "models/memory_module.mdl";
ITEM.Weight =  0.25
ITEM.FOV =  10;
ITEM.CamPos =  Vector( 50, 50, 50 );
ITEM.LookAt =  Vector( 0, 0, 5 );
ITEM.BulkPrice =  4000
ITEM.W = 1
ITEM.H = 1
ITEM.Rarity = 4
ITEM.AllowRandomSpawn = false
ITEM.IsSellable = true
ITEM.Experience = 300
function ITEM:GetSellPrice()
	return 800
end