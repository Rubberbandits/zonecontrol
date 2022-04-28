ITEM.Name =  "Chimera claw";
ITEM.Desc =  "The razor sharp middle claw of the fearsome chimera - a worthy trophy.";
ITEM.Model =  "models/kek1ch/item_chimera_cogot.mdl";
ITEM.Weight =  0.2;
ITEM.FOV =  12;
ITEM.CamPos =  Vector( 50, 50, 50 );
ITEM.LookAt =  Vector( 0, 0, 0 );
ITEM.BulkPrice =  50000
ITEM.W = 1
ITEM.H = 1
ITEM.Rarity = 5
ITEM.AllowRandomSpawn = false
ITEM.IsSellable = true
ITEM.Experience = 2000
function ITEM:GetSellPrice()
	return 10000
end