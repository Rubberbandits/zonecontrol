ITEM.Name =  "Pseudodog tail";
ITEM.Desc =  "The tail of a Pseudodog, chopped clean from the base. Makes for a decent trophy.";
ITEM.Model =  "models/kek1ch/item_psevdodog_tail.mdl";
ITEM.Weight =  0.3;
ITEM.FOV =  12;
ITEM.CamPos =  Vector( 50, 50, 50 );
ITEM.LookAt =  Vector( 0, 0, 0 );
ITEM.W = 1
ITEM.H = 1
ITEM.Rarity = 3
ITEM.AllowRandomSpawn = false
ITEM.BulkPrice = 625
ITEM.IsSellable = true
ITEM.Experience = 100
function ITEM:GetSellPrice()
	return 300
end
