-- This file was converted to Kingston item system by Niggerlicious conversion kit --
ITEM.Name =  "Rucksack";
ITEM.Desc =  "A heavy-duty backpack with more space and better rigging.";
ITEM.Model =  "models/props_junk/garbage_bag001a.mdl";
ITEM.Weight =  1;
ITEM.FOV =  25;
ITEM.CamPos =  Vector( 2.56, -0.01, 50 );
ITEM.LookAt =  Vector( 0, 0, 0 );
ITEM.CarryAdd =  35;
ITEM.BulkPrice =  10000;
ITEM.License =  LICENSE_BLACK;

function ITEM:GetCarryWeight()
	return self.CarryAdd
end