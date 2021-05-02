ITEM.Name =  "Hookah";
ITEM.Desc =  "A makeshift hookah made from a teapot and some gas mask components. This is right up Freedom's alley.";
ITEM.Model =  "models/z-o-m-b-i-e/ST/relax_room/st_kalyan_01.mdl";
ITEM.Weight =  1;
ITEM.FOV =  13;
ITEM.CamPos =  Vector( 50, 50, 50 );
ITEM.LookAt =  Vector( 0, 0, 0 );
ITEM.BulkPrice =  1500
ITEM.License =  "X";
ITEM.W = 1
ITEM.H = 2
ITEM.Rarity = 3
ITEM.AllowRandomSpawn = true
ITEM.IsSellable = true

function ITEM:GetSellPrice()
	return 300
end