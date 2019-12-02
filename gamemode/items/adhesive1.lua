-- This file was converted to Kingston item system by Niggerlicious conversion kit --
ITEM.Name =  "Zviezda Glue";
ITEM.Desc =  "A half-empty tube of glue most commonly used for suit and weapon repairs.";
ITEM.Model =  "models/box_condensers.mdl";
ITEM.Weight =  0.1;
ITEM.FOV =  9;
ITEM.CamPos =  Vector( 50, 50, 50 );
ITEM.LookAt =  Vector( 0, 0, 0 );
ITEM.BulkPrice =  500;
ITEM.License =  LICENSE_BLACK;
ITEM.functions = {}
ITEM.functions.Use = {
	SelectionName = "Use",
	RemoveOnUse = true,
	OnUse = function(self)
		local ply = self:Owner()		
		if( CLIENT ) then
			
			GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "You eat what glue is left in the tube.", { CB_ALL, CB_IC } );
			
			
		end
		
		return true
	end,
	CanRun = function(item)
		return true
	end,
}
