
ITEM.Name =  "Backpack";
ITEM.Desc =  "A backpack. Useful for carrying more things.";
ITEM.Model =  "models/props_junk/garbage_bag001a.mdl";
ITEM.Weight =  1;
ITEM.FOV =  25;
ITEM.CamPos =  Vector( 2.56, -0.01, 50 );
ITEM.LookAt =  Vector( 0, 0, 0 );
ITEM.CarryAdd =  15;
ITEM.BulkPrice =  1000;
ITEM.License =  LICENSE_BLACK;

function ITEM:GetCarryWeight()
	return self.CarryAdd
end