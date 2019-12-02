-- This file was converted to Kingston item system by Niggerlicious conversion kit --
ITEM.Name =  "Stone-sharpening Set";
ITEM.Desc =  "A three-piece stone sharpening set suited to honing the blade of a knife.";
ITEM.Model =  "models/box_condensers.mdl";
ITEM.Weight =  2;
ITEM.FOV =  9;
ITEM.CamPos =  Vector( 50, 50, 50 );
ITEM.LookAt =  Vector( 0, 0, 0 );
ITEM.BulkPrice =  12500;
ITEM.functions = {}
ITEM.functions.Use = {
	SelectionName = "Use",
	OnUse = function(self)
		local ply = self:Owner()		
		if( CLIENT ) then
			
			GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "You take a blade and carefully sharpen it against the stone blocks, honing its edge.", { CB_ALL, CB_IC } );
			
			
		end
		
		return true
	end,
	CanRun = function(item)
		return true
	end,
}
