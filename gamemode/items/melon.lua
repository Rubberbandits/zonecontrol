-- This file was converted to Kingston item system by Niggerlicious conversion kit --
ITEM.Name =  "Melon";
ITEM.Desc =  "A fruit, watery and juicy.";
ITEM.Model =  "models/props_junk/watermelon01.mdl";
ITEM.Weight =  10;
ITEM.FOV =  14;
ITEM.CamPos =  Vector( 50, 50, 50 );
ITEM.LookAt =  Vector( 0, 0, 0 );
ITEM.BulkPrice =  75;
ITEM.License =  LICENSE_FOOD;
ITEM.functions = {}
ITEM.functions.Use = {
	SelectionName = "Eat",
	RemoveOnUse = true,
	OnUse = function(self)
		local ply = self:Owner()		
		if( CLIENT ) then
			
			LocalPlayer():Notify(nil, Color(200,200,200,255), "You eat the entire melon. You must have been hungry.")
			
		else
			
		end
		
		return true
	end,
	CanRun = function(item)
		return true
	end,
}
