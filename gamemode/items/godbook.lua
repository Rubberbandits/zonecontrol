ITEM.Name =  "The God Particle: Fact or Fiction?";
ITEM.Desc =  "Recent literature on particle physics. It's hard to understand.";
ITEM.Model =  "models/props_lab/binderredlabel.mdl";
ITEM.Weight =  1;
ITEM.FOV =  13;
ITEM.CamPos =  Vector( 50, 50, 50 );
ITEM.LookAt =  Vector( 0, 0, 0 );
ITEM.BulkPrice =  500
ITEM.W = 2
ITEM.H = 2
ITEM.Rarity = 2
ITEM.AllowRandomSpawn = true
ITEM.IsSellable = true

function ITEM:GetSellPrice()
	return 100
end