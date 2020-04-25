-- This file was converted to Kingston item system by Niggerlicious conversion kit --
ITEM.Name =  "Milk Jug";
ITEM.Desc =  "A jug of spoiled milk. Tastes like lemons, if lemons were bitter.";
ITEM.Model =  "models/props_junk/garbage_milkcarton001a.mdl";
ITEM.Weight =  1;
ITEM.FOV =  13;
ITEM.CamPos =  Vector( 50, 50, 50 );
ITEM.LookAt =  Vector( 0, 0, 0 );
ITEM.BulkPrice =  25;
ITEM.License =  LICENSE_FOOD;
ITEM.functions = {}
ITEM.functions.Use = {
	SelectionName = "Drink",
	RemoveOnUse = true,
	OnUse = function(self)
		local ply = self:Owner()		
		if( CLIENT ) then
			
			LocalPlayer():Notify(nil, Color(200,200,200,255), "You drink the jug of milk. Maybe not a great idea.")
			
		else
			
		end
		
		return true
	end,
	CanRun = function(item)
		return true
	end,
}
