ITEM.Name =  "Class A Extinguisher";
ITEM.Desc =  "Very expired. WARNING: WOOD, PAPER, OR TEXTILE ONLY.";
ITEM.Model =  "models/props/cs_office/Fire_Extinguisher.mdl";
ITEM.Weight =  1;
ITEM.FOV =  13;
ITEM.CamPos =  Vector( 50, 50, 50 );
ITEM.LookAt =  Vector( 0, 0, 0 );
ITEM.BulkPrice =  2500
ITEM.W = 1
ITEM.H = 2
ITEM.Rarity = 1
ITEM.AllowRandomSpawn = true
ITEM.IsSellable = true

function ITEM:GetSellPrice()
	return 500
end