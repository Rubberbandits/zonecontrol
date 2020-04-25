-- This file was converted to Kingston item system by Niggerlicious conversion kit --
ITEM.Name =  "Berry Kompot";
ITEM.Desc =  "A sweet fruity drink, served hot or cold depending on the season. This kompot is made with blueberries, strawberries, and cherries. The saturated slices of fruit float at the top.";
ITEM.Model =  "models/kali/miscstuff/stalker/food/energy drink.mdl";
ITEM.Weight =  0.5;
ITEM.FOV =  12;
ITEM.CamPos =  Vector( 50, 50, 50 );
ITEM.LookAt =  Vector( 0, 0, 0 );
ITEM.BulkPrice =  850;
ITEM.License =  LICENSE_BLACK;
ITEM.functions = {}
ITEM.functions.Use = {
	SelectionName = "Eat",
	RemoveOnUse = true,
	OnUse = function(self)
		local ply = self:Owner()		
		if( CLIENT ) then
			
			LocalPlayer():Notify(nil, Color(200,200,200,255), "The sweet liquid washes down your throat, and it's quite satisfying. The solid fruit itself is delightful as well. You remind yourself that such a happily refreshing culinary experience is rare and regret not adequately savoring this one. If only the winter fruits were colder.")
	
		end
		
		return true
	end,
	CanRun = function(item)
		return true
	end,
}
