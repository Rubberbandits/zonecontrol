-- This file was converted to Kingston item system by Niggerlicious conversion kit --
ITEM.Name =  "Canned Water";
ITEM.Desc =  "Purified water in a can.";
ITEM.Model =  "models/props_junk/PopCan01a.mdl";
ITEM.Weight =  0.4;
ITEM.FOV =  7;
ITEM.CamPos =  Vector( 50, 50, 50 );
ITEM.LookAt =  Vector( 0, 0, 0.18 );
ITEM.BulkPrice =  400;
ITEM.License =  LICENSE_BLACK; 
ITEM.functions = {}
ITEM.functions.Use = {
	SelectionName = "Drink",
	RemoveOnUse = true,
	OnUse = function(self)
		local ply = self:Owner()		
		if( CLIENT ) then
			
			GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "You open and drink the entire can.", { CB_ALL, CB_IC } );
			
		else
			
		end
		
		return true
	end,
	CanRun = function(item)
		return true
	end,
}
