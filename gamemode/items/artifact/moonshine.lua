-- This file was converted to Kingston item system by Niggerlicious conversion kit --
ITEM.Name =  "Moonshine";
ITEM.Desc =  "A bottle of home-made moonshine. Possibly dangerous to drink.";
ITEM.Model =  "models/props_junk/garbage_glassbottle002a.mdl";
ITEM.Weight =  2;
ITEM.FOV =  11;
ITEM.CamPos =  Vector( 50, 50, 50 );
ITEM.LookAt =  Vector( 0, 0, 5.56 );
ITEM.BulkPrice =  100;
ITEM.License =  LICENSE_BLACK;
ITEM.functions = {}
ITEM.functions.Use = {
	SelectionName = "Drink",
	OnUse = function(self)
		local ply = self:Owner()		
		if( CLIENT ) then
			
			LocalPlayer():Notify(nil, Color(200,200,200,255), "You open and drink the moonshine.")
			
		else
			
		end
		
		return true
	end,
	CanRun = function(item)
		return true
	end,
}
