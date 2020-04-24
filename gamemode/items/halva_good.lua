-- This file was converted to Kingston item system by Niggerlicious conversion kit --
ITEM.Name =  "Homemade Halva";
ITEM.Desc =  "The crumbly working mans' treat, made from semechki and sugar.";
ITEM.Model =  "models/kali/miscstuff/stalker/food/tourist's breakfast.mdl";
ITEM.Weight =  0.2;
ITEM.FOV =  12;
ITEM.CamPos =  Vector( 50, 50, 50 );
ITEM.LookAt =  Vector( 0, 0, 0 );
ITEM.BulkPrice =  150;
ITEM.License =  LICENSE_BLACK;
ITEM.functions = {}
ITEM.functions.Use = {
	SelectionName = "Eat",
	RemoveOnUse = true,
	OnUse = function(self)
		local ply = self:Owner()		
		if( CLIENT ) then
			
			LocalPlayer():Notify(nil, Color(200,200,200,255), "The sweet confection crumbles and crunches in your mouth. It's not much for a meal, but it's a fine dessert.")
	
		end
		
		return true
	end,
	CanRun = function(item)
		return true
	end,
}
