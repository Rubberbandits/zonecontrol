-- This file was converted to Kingston item system by Niggerlicious conversion kit --
ITEM.Name =  "Burnt Beans";
ITEM.Desc =  "A burnt can of beans.";
ITEM.Model =  "models/props_junk/garbage_metalcan001a.mdl";
ITEM.Weight =  1;
ITEM.FOV =  7;
ITEM.CamPos =  Vector( 50, 50, 50 );
ITEM.LookAt =  Vector( 0, 0, 0 );
ITEM.functions = {}
ITEM.functions.Use = {
	SelectionName = "Eat",
	RemoveOnUse = true,
	OnUse = function(self)
		local ply = self:Owner()		
		if( CLIENT ) then
			
			LocalPlayer():Notify(nil, Color(200,200,200,255), "You open and eat the can of burnt beans.")
			
		else
			
		end
		
		return true
	end,
	CanRun = function(item)
		return true
	end,
}
