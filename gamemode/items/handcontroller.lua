ITEM.Name =  "Controller hand";
ITEM.Desc =  "The grimy mitt of a Controller. These mutants seem to utilize their hand in some way to attack its prey, making them worth holding onto as trophies or lab specimens. Smells like old socks and bad kimchi.";
ITEM.Model =  "models/kek1ch/hand_kontroler.mdl";
ITEM.Weight =  0.5;
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