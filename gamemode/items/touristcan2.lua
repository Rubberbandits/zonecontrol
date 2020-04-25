-- This file was converted to Kingston item system by Niggerlicious conversion kit --
ITEM.Name =  "Kalakukko";
ITEM.Desc =  "Smoked salmon in rye bread, tinned. 439kcals of energy, 26g's of protein, 32g's of carbohydrates, and 22g's of fat.";
ITEM.Model =  "models/kali/miscstuff/stalker/food/tourist's breakfast.mdl";
ITEM.Weight =  .5;
ITEM.FOV =  8;
ITEM.CamPos =  Vector( 50, 50, 50 );
ITEM.LookAt =  Vector( 0, 0, 0 );
ITEM.BulkPrice =  600;
ITEM.License =  LICENSE_BLACK; 
ITEM.functions = {}
ITEM.functions.Use = {
	SelectionName = "Eat",
	RemoveOnUse = true,
	OnUse = function(self)
		local ply = self:Owner()	   
	    if( CLIENT ) then
	       
	        LocalPlayer():Notify(nil, Color(200,200,200,255), "It's very dense, and it looks like a cake-and-fish Oreo. It has a bit of an acquired taste, and isn't as moist as you would like, but it is pretty filling.")
	       
	    end
	   
		return true
	end,
	CanRun = function(item)
		return true
	end,
}
