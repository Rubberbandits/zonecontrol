-- This file was converted to Kingston item system by Niggerlicious conversion kit --
ITEM.Name =  "Box of Crayons";
ITEM.Desc =  "A box of assorted crayons. They double as candles, conveniently.";
ITEM.Model =  "models/props_lab/box01a.mdl";
ITEM.Weight =  0;
ITEM.FOV =  10;
ITEM.CamPos =  Vector( 50, 50, 50 );
ITEM.LookAt =  Vector( 0, 0, 0 );
ITEM.BulkPrice =  300;
ITEM.functions = {}
ITEM.functions.Use = {
	SelectionName = "Eat",
	RemoveOnUse = true,
	OnUse = function(self)
		local ply = self:Owner()		
		if( CLIENT ) then
			
			LocalPlayer():Notify(nil, Color(200,200,200,255), "You chew the crayons with ease. Whether you snack one at a time or all at once, these colorful treats are not so easy to get out as they were to get in.")
			
			
		end
		
		return true
	end,
	CanRun = function(item)
		return true
	end,
}
