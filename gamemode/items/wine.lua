-- This file was converted to Kingston item system by Niggerlicious conversion kit --
ITEM.Name =  "Red Red Wine";
ITEM.Desc =  "It's up to you.";
ITEM.Model =  "models/props_junk/garbage_glassbottle003a.mdl";
ITEM.Weight =  1;
ITEM.FOV =  11;
ITEM.CamPos =  Vector( 50, 50, 50 );
ITEM.LookAt =  Vector( 0, 0, 0 );
ITEM.BulkPrice =  1000;
ITEM.License =  LICENSE_BLACK;
ITEM.functions = {}
ITEM.functions.Use = {
	SelectionName = "Drink",
	RemoveOnUse = true,
	OnUse = function(self)
		local ply = self:Owner()		
		if( CLIENT ) then
			
			GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "The red red wine makes you feel so fine.", { CB_ALL, CB_IC } );
			
		else
			
		end
		
		return true
	end,
	CanRun = function(item)
		return true
	end,
}
