ITEM.Name =  "Bottle of Katkov Brew";
ITEM.Desc =  "Liquor said to be produced in the Zone itself. It's origins are forever lost, but it's still just as intriguing. Dated 2009. Full, but the cork just won't budge.";
ITEM.Model =  "models/kek1ch/drink_tea.mdl";
ITEM.Weight =  0.5;
ITEM.FOV =  15;
ITEM.CamPos =  Vector( 50, 50, 50 );
ITEM.LookAt =  Vector( 0, 0, 7 );
ITEM.BulkPrice =  1000;
ITEM.W = 1
ITEM.H = 2
ITEM.License =  "X";
ITEM.Rarity = 3
ITEM.AllowRandomSpawn = true
ITEM.IsSellable = true

function ITEM:GetSellPrice()
	return 250
end