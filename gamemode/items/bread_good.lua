-- This file was converted to Kingston item system by Niggerlicious conversion kit --
ITEM.Name =  "Fresh Bread";
ITEM.Desc =  "Crunchy on the outside, soft on the inside. Presumably Zone-made in the past few days.";
ITEM.Model =  "models/kali/miscstuff/stalker/food/bread.mdl";
ITEM.Weight =  0.3;
ITEM.FOV =  12;
ITEM.CamPos =  Vector( 50, 50, 50 );
ITEM.LookAt =  Vector( 0, 0, 0 );
ITEM.BulkPrice =  400;
ITEM.License =  LICENSE_BLACK;
ITEM.functions = {}
ITEM.functions.Use = {
	SelectionName = "Eat",
	RemoveOnUse = true,
	OnUse = function(self)
		local ply = self:Owner()		
		if( CLIENT ) then
			
			GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "Your mouth confirms with joy that this is, indeed, bread: pleasantly ordinary, and thankfully far from stale.", { CB_ALL, CB_IC } );
	
		end
		
		return true
	end,
	CanRun = function(item)
		return true
	end,
}
