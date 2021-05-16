ITEM.Name =  "Documents";
ITEM.Desc =  "Manila folder full of important documents. These can be sold for a reward.";
ITEM.Model =  "models/stalker/item/handhelds/files1.mdl";
ITEM.Weight =  .5;
ITEM.FOV =  20;
ITEM.CamPos =  Vector( 50, 50, 50 );
ITEM.LookAt =  Vector( 0, 0, 0 );
ITEM.BulkPrice =  2500
ITEM.W = 2
ITEM.H = 2
ITEM.Rarity = 2
ITEM.AllowRandomSpawn = false
ITEM.IsSellable = true

function ITEM:GetSellPrice()
	return 500
end