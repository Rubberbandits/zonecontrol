-- This file was converted to Kingston item system by Niggerlicious conversion kit --
ITEM.Name =  "Tea";
ITEM.Desc =  "A mug of tea, made with tea leaves and water.";
ITEM.Model =  "models/props_junk/garbage_coffeemug001a.mdl";
ITEM.Weight =  0.5;
ITEM.FOV =  6;
ITEM.CamPos =  Vector( 50, 50, 50 );
ITEM.LookAt =  Vector( 0, 0, 0 );
ITEM.functions = {}
ITEM.functions.Use = {
	SelectionName = "Drink",
	RemoveOnUse = true,
	OnUse = function(self)
		local ply = self:Owner()		
		if( CLIENT ) then
			
			GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "You drink the hot tea.", { CB_ALL, CB_IC } );
			
		else
	
		end
		
		return true
	end,
	CanRun = function(item)
		return true
	end,
}
