ITEM.Base = "backpack"
ITEM.Name =  "Rucksack";
ITEM.Desc =  "A heavy-duty backpack with more space and better rigging.";
ITEM.Model =  "models/kek1ch/sumka7.mdl";
ITEM.Weight =  1;
ITEM.FOV =  25;
ITEM.CamPos =  Vector( 2.56, -0.01, 50 );
ITEM.LookAt =  Vector( 0, 0, 0 );
ITEM.CarryAdd =  35;
ITEM.BulkPrice =  10000;
ITEM.License =  "X";
ITEM.Rarity = 3
ITEM.AllowRandomSpawn = true
ITEM.IsSellable = true

function ITEM:GetSellPrice()
    return 2000
end