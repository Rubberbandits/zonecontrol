ITEM.Name =  "US Dollars";
ITEM.Desc =  "A fistful of dollars. Nobody will accept this around here.";
ITEM.Model =  "models/kek1ch/money_usa.mdl";
ITEM.Weight =  0.001;
ITEM.FOV =  13;
ITEM.CamPos =  Vector( 50, 50, 50 );
ITEM.LookAt =  Vector( 0, 0, 0 );
ITEM.BulkPrice =  125
ITEM.Stackable = true
ITEM.W = 2
ITEM.H = 1
ITEM.Vars = {
	Stacked = 1,
}
ITEM.Rarity = 2
ITEM.AllowRandomSpawn = true
ITEM.IsSellable = true

function ITEM:GetSellPrice()
	return 25
end