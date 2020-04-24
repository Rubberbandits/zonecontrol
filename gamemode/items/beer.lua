-- This file was converted to Kingston item system by Niggerlicious conversion kit --
ITEM.Name =  "Beer";
ITEM.Desc =  "A bottle of skunky Czech beer.";
ITEM.Model =  "models/props_junk/garbage_glassbottle003a.mdl";
ITEM.Weight =  1;
ITEM.FOV =  11;
ITEM.CamPos =  Vector( 50, 50, 50 );
ITEM.LookAt =  Vector( 0, 0, 0 );
ITEM.BulkPrice =  50;
ITEM.License =  LICENSE_ALCOHOL;
ITEM.functions = {}
ITEM.functions.Use = {
	SelectionName = "Drink",
	RemoveOnUse = true,
	OnUse = function(self)
		local ply = self:Owner()		
		if( CLIENT ) then
			
			LocalPlayer():Notify(nil, Color(200,200,200,255), "You pop the cap and drink the beer.")
			
		else
			
		end
		
		return true
	end,
	CanRun = function(item)
		return true
	end,
}
