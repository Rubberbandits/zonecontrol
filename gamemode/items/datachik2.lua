ITEM.Name =  "Advanced GPS";
ITEM.Desc =  "A more modern way to store and transfer co-ordinate data. It's also secured by some kind of encryption.";
ITEM.Model =  "models/kali/miscstuff/stalker/sensor_c.mdl";
ITEM.Weight =  .5;
ITEM.FOV =  5;
ITEM.CamPos =  Vector( 50, 50, 50 );
ITEM.LookAt =  Vector( 0, 0, 0 );
ITEM.BulkPrice =  1500
ITEM.License =  "X";
ITEM.W = 1
ITEM.H = 1
ITEM.Rarity = 4
ITEM.AllowRandomSpawn = true
ITEM.IsSellable = true

function ITEM:GetSellPrice()
	return 300
end