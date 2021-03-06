ITEM.Name =  "LifePak EKG";
ITEM.Desc =  "An electrocardiogram machine. All the controls are in English.";
ITEM.Model =  "models/z-o-m-b-i-e/ST/technica/st_transiver_13.mdl";
ITEM.Weight =  5;
ITEM.FOV =  13;
ITEM.CamPos =  Vector( 50, 50, 50 );
ITEM.LookAt =  Vector( 0, 0, 0 );
ITEM.BulkPrice =  50000
ITEM.W = 2
ITEM.H = 2
ITEM.Rarity = 4
ITEM.AllowRandomSpawn = false
ITEM.IsSellable = true

function ITEM:GetSellPrice()
	return 10000
end