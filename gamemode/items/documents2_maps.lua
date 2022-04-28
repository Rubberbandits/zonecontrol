ITEM.Name =  "Military Maps";
ITEM.Desc =  "Manila folder full of important military maps. Somewhat redundant to anyone who owns a PDA, but these can be sold for a reward.";
ITEM.Model =  "models/kek1ch/mili_maps.mdl";
ITEM.Weight =  0.5
ITEM.FOV =  20;
ITEM.CamPos =  Vector( 50, 50, 50 );
ITEM.LookAt =  Vector( 0, 0, 0 );
ITEM.BulkPrice =  15000
ITEM.W = 2
ITEM.H = 2
ITEM.Rarity = 4
ITEM.AllowRandomSpawn = false
ITEM.IsSellable = true
ITEM.Experience = 250
function ITEM:GetSellPrice()
	return 3000
end