ITEM.Name =  "Mama's Purse";
ITEM.Desc =  "It's leather surface is etched with eerily familiar patterns. To the right buyer, this could be incredibly valuable. Smells like soap.";
ITEM.Model =  "models/props_lab/box01a.mdl";
ITEM.Weight =  2;
ITEM.FOV =  20;
ITEM.CamPos =  Vector( 50, 50, 50 );
ITEM.LookAt =  Vector( 0, 0, 0 );
ITEM.BulkPrice =  20000
ITEM.W = 1
ITEM.H = 1
ITEM.Rarity = 3
ITEM.AllowRandomSpawn = true
ITEM.IsSellable = true

function ITEM:GetSellPrice()
	return 4000
end