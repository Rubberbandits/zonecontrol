-- This file was converted to Kingston item system by Niggerlicious conversion kit --
ITEM.Name =  "Bread";
ITEM.Desc =  "Half of a loaf of rye bread. Pairs great with canned meat and pats of butter.";
ITEM.Model =  "models/kali/miscstuff/stalker/food/bread.mdl";
ITEM.Weight =  0.3;
ITEM.FOV =  12;
ITEM.CamPos =  Vector( 50, 50, 50 );
ITEM.LookAt =  Vector( 0, 0, 0 );
ITEM.BulkPrice =  350;
ITEM.License =  LICENSE_BLACK;
ITEM.functions = {}
ITEM.functions.Use = {
	SelectionName = "Eat",
	RemoveOnUse = true,
	OnUse = function(self)
		local ply = self:Owner()		
		if( CLIENT ) then
			
			LocalPlayer():Notify(nil, Color(200,200,200,255), "Your teeth can just barely penetrate the rockhard crust of the bread. It was well worth it. You feel nourished to an extent.")
	
		end
		
		return true
	end,
	CanRun = function(item)
		return true
	end,
}
