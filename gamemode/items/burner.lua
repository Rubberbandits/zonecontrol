ITEM.Name =  "Butane Stove";
ITEM.Desc =  "An experienced STALKER's best friend.";
ITEM.Model =  "models/kek1ch/multi_fuel_stove.mdl";
ITEM.Weight =  1;
ITEM.FOV =  13;
ITEM.CamPos =  Vector( 50, 50, 50 );
ITEM.LookAt =  Vector( 0, 0, 0 );
ITEM.BulkPrice =  500;
ITEM.License =  "X";
ITEM.W = 1
ITEM.H = 2
ITEM.Rarity = 2
ITEM.AllowRandomSpawn = true
ITEM.IsSellable = true

function ITEM:GetSellPrice()
	return 100
end