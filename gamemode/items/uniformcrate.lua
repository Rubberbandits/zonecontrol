ITEM.Name =  "Crate full of BDUs"
ITEM.Desc =  "Every BDU is well-worn. Collectors abroad might pay well for these.";
ITEM.Model =  "models/z-o-m-b-i-e/ST/box/st_box_01.mdl";
ITEM.Weight =  4
ITEM.FOV =  13;
ITEM.CamPos =  Vector( 50, 50, 50 );
ITEM.LookAt =  Vector( 0, 0, 0 );
ITEM.BulkPrice =  1000
ITEM.W = 4
ITEM.H = 4
ITEM.Rarity = 3
ITEM.AllowRandomSpawn = false
ITEM.IsSellable = true

function ITEM:GetSellPrice()
	return 200
end