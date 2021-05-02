ITEM.Name =  "Plastic Jar";
ITEM.Desc =  "A fistful of gold teeth in a small plastic jar filled with leaves and sand to minimize excess noise while running. Liberating a fallen Stalker of his teeth is a favored practice among bandits.";
ITEM.Model =  "models/z-o-m-b-i-e/ST/prop/st_banka_kraski_01.mdl";
ITEM.Weight =  2;
ITEM.FOV =  16;
ITEM.CamPos =  Vector( 50, 50, 50 );
ITEM.LookAt =  Vector( 0, 0, 0 );
ITEM.BulkPrice = 2000
ITEM.W = 1
ITEM.H = 1
ITEM.Rarity = 3
ITEM.AllowRandomSpawn = true
ITEM.IsSellable = true

function ITEM:GetSellPrice()
	return 400
end