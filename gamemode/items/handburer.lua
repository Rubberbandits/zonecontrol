ITEM.Name =  "Burer hand";
ITEM.Desc =  "The dry, ashy hand of a Burer. Burer's hand seems to play a vital role in the creature's use of the telekinetic powers. It's probably worth a lot to someone.";
ITEM.Model =  "models/handburer.mdl";
ITEM.Weight =  0.5;
ITEM.FOV =  9;
ITEM.CamPos =  Vector( 50, 50, 50 );
ITEM.LookAt =  Vector( 0, 0, 0 );
ITEM.BulkPrice =  20000
ITEM.W = 1
ITEM.H = 1
ITEM.Rarity = 4
ITEM.AllowRandomSpawn = false
ITEM.IsSellable = true
ITEM.IsSellable = true

function ITEM:GetSellPrice()
	return 4000
end