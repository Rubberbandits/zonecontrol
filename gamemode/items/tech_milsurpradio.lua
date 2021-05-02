ITEM.Name =  "Radio Equipment";
ITEM.Desc =  "A piece of high quality radio equipment widely used by stalkers of all factions throughout the Zone, particularly those with some spending money.";
ITEM.Model =  "models/z-o-m-b-i-e/st/el_tehnika/st_priemnik_gorizont_01.mdl";
ITEM.Weight =  3;
ITEM.FOV =  15;
ITEM.CamPos =  Vector( 50, 50, 50 );
ITEM.LookAt =  Vector( 2, 0, 5 );
ITEM.BulkPrice = 2000
ITEM.License =  "X";
ITEM.W = 2
ITEM.H = 2
ITEM.Rarity = 3
ITEM.AllowRandomSpawn = true
ITEM.IsSellable = true

function ITEM:GetSellPrice()
	return 400
end