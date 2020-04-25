-- This file was converted to Kingston item system by Niggerlicious conversion kit --
ITEM.Name =  "Coffee";
ITEM.Desc =  "A mug of coffee, made with coffee beans and Breen Water.";
ITEM.Model =  "models/props_junk/garbage_coffeemug001a.mdl";
ITEM.Weight =  0.5;
ITEM.FOV =  6;
ITEM.CamPos =  Vector( 50, 50, 50 );
ITEM.LookAt =  Vector( 0, 0, 0 );
ITEM.functions = {}
ITEM.functions.Use = {
	SelectionName = "Drink",
	RemoveOnUse = true,
	OnUse = function(self)
		local ply = self:Owner()		
		if( CLIENT ) then
			
			LocalPlayer():Notify(nil, Color(200,200,200,255), "You drink the coffee.")
			
		else
			
		end
		
		return true
	end,
	CanRun = function(item)
		return true
	end,
}
