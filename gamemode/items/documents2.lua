ITEM.Name =  "Military Documents";
ITEM.Desc =  "Manila folder full of important military documents. These can be sold for a reward.";
ITEM.Model =  "models/stalker/item/handhelds/files2.mdl";
ITEM.Weight =  0.5
ITEM.FOV =  20;
ITEM.CamPos =  Vector( 50, 50, 50 );
ITEM.LookAt =  Vector( 0, 0, 0 );
ITEM.BulkPrice =  20000
ITEM.W = 2
ITEM.H = 2
ITEM.Rarity = 4
ITEM.AllowRandomSpawn = false
ITEM.IsSellable = true
ITEM.Experience = 250 
function ITEM:GetSellPrice()
	return 4000
end