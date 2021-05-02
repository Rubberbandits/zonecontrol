ITEM.Name =  "Box of Engine Parts";
ITEM.Desc =  "Assorted parts and kits for an engine.";
ITEM.Model =  "models/z-o-m-b-i-e/st/kitchen/st_box_paper_01.mdl";
ITEM.Weight =  8
ITEM.FOV =  12;
ITEM.CamPos =  Vector( 50, 50, 50 );
ITEM.LookAt =  Vector( 0, 0, 0 );
ITEM.BulkPrice =  4000;
ITEM.W = 4
ITEM.H = 4
ITEM.Rarity = 3
ITEM.AllowRandomSpawn = true
ITEM.IsSellable = true

function ITEM:GetSellPrice()
	return 800
end