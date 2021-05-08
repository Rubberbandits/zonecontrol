ITEM.Name =  "Heavy Case";
ITEM.Desc =  "A locked case. You can only guess what's inside, but it's heavy as all hell. This must be worth your trouble.";
ITEM.Model =  "models/z-o-m-b-i-e/st/equipment_cache/st_equipment_seif_04.mdl";
ITEM.Weight =  5;
ITEM.FOV =  20;
ITEM.CamPos =  Vector( 50, 50, 50 );
ITEM.LookAt =  Vector( 0, -2, 3 );
ITEM.BulkPrice =  3500
ITEM.W = 4
ITEM.H = 4
ITEM.Rarity = 4
ITEM.AllowRandomSpawn = false
ITEM.IsSellable = true

function ITEM:GetSellPrice()
	return 700
end