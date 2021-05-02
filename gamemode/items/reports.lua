ITEM.Name =  "Lab Reports";
ITEM.Desc =  "A terrible mess of lab reports. It would take hours to descramble.";
ITEM.Model =  "models/z-o-m-b-i-e/ST/kitchen/st_box_paper_01.mdl";
ITEM.Weight =  1;
ITEM.FOV =  13;
ITEM.CamPos =  Vector( 50, 50, 50 );
ITEM.LookAt =  Vector( 0, 0, 0 );
ITEM.BulkPrice =  4000
ITEM.W = 2
ITEM.H = 2
ITEM.Rarity = 3
ITEM.AllowRandomSpawn = true
ITEM.IsSellable = true

function ITEM:GetSellPrice()
	return 800
end