-- This file was converted to Kingston item system by Niggerlicious conversion kit --
ITEM.Name =  "Vodka";
ITEM.Desc =  "A bottle of vodka. Probably unsafe to drink.";
ITEM.Model =  "models/props_junk/glassjug01.mdl";
ITEM.Weight =  2;
ITEM.FOV =  11;
ITEM.CamPos =  Vector( 50, 50, 50 );
ITEM.LookAt =  Vector( 0, 0, 5.56 );
ITEM.BulkPrice =  100;
ITEM.License =  LICENSE_ALCOHOL;
ITEM.functions = {}
ITEM.functions.Use = {
	SelectionName = "Drink",
	RemoveOnUse = true,
	OnUse = function(self)
		local ply = self:Owner()		
		if( CLIENT ) then
			
			GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "You open and drink the vodka.", { CB_ALL, CB_IC } );
			
		else
			
		end
		
		return true
	end,
	CanRun = function(item)
		return true
	end,
}
