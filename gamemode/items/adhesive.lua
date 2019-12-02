-- This file was converted to Kingston item system by Niggerlicious conversion kit --
ITEM.Name =  "Adhesive";
ITEM.Desc =  "A bottle of glue to stick things together.";
ITEM.Model =  "models/props_junk/garbage_plasticbottle001a.mdl";
ITEM.Weight =  1;
ITEM.FOV =  14;
ITEM.CamPos =  Vector( 50, 50, 50 );
ITEM.LookAt =  Vector( 0, 0, 0 );
ITEM.BulkPrice =  100;
ITEM.License =  LICENSE_MISC;
ITEM.functions = {}
ITEM.functions.Use = {
	SelectionName = "Drink",
	RemoveOnUse = true,
	OnUse = function(self)
		local ply = self:Owner()		
		if( CLIENT ) then
			
			GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "You drink the liquid glue. Are you okay?", { CB_ALL, CB_IC } );
			
		else
			
			ply:Kill();
			
		end
		
		return true
	end,
	CanRun = function(item)
		return true
	end,
}
