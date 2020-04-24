-- This file was converted to Kingston item system by Niggerlicious conversion kit --
ITEM.Name =  "Jerry-Can of Water";
ITEM.Desc =  "A can filled with drinking water.";
ITEM.Model =  "models/z-o-m-b-i-e/st/balon/st_kanistra_01.mdl";
ITEM.Weight =  2;
ITEM.FOV =  20;
ITEM.CamPos =  Vector( 50, 50, 50 );
ITEM.LookAt =  Vector( 0, 0, 12 );
ITEM.BulkPrice =  10000;
ITEM.functions = {}
ITEM.functions.Use = {
	SelectionName = "Drink",
	RemoveOnUse = true,
	OnUse = function(self)
		local ply = self:Owner()		
		if( CLIENT ) then
			
			LocalPlayer():Notify(nil, Color(200,200,200,255), "You can't drink this all in one sitting, but the jerry can of water keeps you hydrated throughout the day.")
			
			
		end
		
		return true
	end,
	CanRun = function(item)
		return true
	end,
}
