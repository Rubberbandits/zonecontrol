-- This file was converted to Kingston item system by Niggerlicious conversion kit --
ITEM.Name =  "Chinese Noodles";
ITEM.Desc =  "A cheap-looking package of Chinese instant noodles.";
ITEM.Model =  "models/props_junk/garbage_takeoutcarton001a.mdl";
ITEM.Weight =  1;
ITEM.FOV =  10;
ITEM.CamPos =  Vector( 50, 50, 50 );
ITEM.LookAt =  Vector( 0, 0, 0 );
ITEM.BulkPrice =  50;
ITEM.License =  LICENSE_FOOD;
ITEM.functions = {}
ITEM.functions.Use = {
	SelectionName = "Eat",
	RemoveOnUse = true,
	OnUse = function(self)
		local ply = self:Owner()		
		if( CLIENT ) then
			
			GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "You eat the dry noodles.", { CB_ALL, CB_IC } );
			
		else
			
		end
		
		return true
	end,
	CanRun = function(item)
		return true
	end,
}
