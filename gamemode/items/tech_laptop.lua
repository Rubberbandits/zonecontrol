ITEM.Name =  "Laptop";
ITEM.Desc =  "A TOBISHA brand laptop. Bound to carry some important information.";
ITEM.Model =  "models/z-o-m-b-i-e/st/el_tehnika/st_notebook_01.mdl";
ITEM.Weight =  3;
ITEM.FOV =  20;
ITEM.CamPos =  Vector( 50, 50, 50 );
ITEM.LookAt =  Vector( 5, 0, 6 );
ITEM.BulkPrice =  2000
ITEM.License =  "X";
ITEM.W = 2
ITEM.H = 2
ITEM.Rarity = 3
ITEM.AllowRandomSpawn = true
ITEM.IsSellable = true

function ITEM:GetSellPrice()
	return 400
end