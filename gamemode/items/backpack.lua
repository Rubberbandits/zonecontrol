ITEM.Base = "backpack"
ITEM.Name =  "Backpack";
ITEM.Desc =  "A backpack. Useful for carrying more things.";
ITEM.Model =  "models/kek1ch/dev_rukzak.mdl";
ITEM.Weight =  1;
ITEM.FOV =  25;
ITEM.CamPos =  Vector( 2.56, -0.01, 50 );
ITEM.LookAt =  Vector( 0, 0, 0 );
ITEM.CarryAdd =  15;
ITEM.BulkPrice =  1000;
ITEM.License =  "X";
ITEM.Rarity = 2
ITEM.AllowRandomSpawn = false
ITEM.IsSellable = true

function ITEM:GetSellPrice()
    return 200
end