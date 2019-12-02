-- This file was converted to Kingston item system by Niggerlicious conversion kit --
ITEM.Name =  "Radio-protectant";
ITEM.Desc =  "Two coin-like pills. Intended to be consumed before exposure, as they only partly shield the effects of radiation on live tissue, and have no effect on absorption prior to use.";
ITEM.Model =  "models/stalker/item/medical/rad_pills.mdl";
ITEM.Weight =  .1;
ITEM.FOV =  8;
ITEM.CamPos =  Vector( 50, 50, 50 );
ITEM.LookAt =  Vector( 0, 0, 0 );

ITEM.PhysicalMass	= 1;

ITEM.BulkPrice =  2500;
ITEM.functions = {}
ITEM.functions.Use = {
	SelectionName = "Swallow",
	RemoveOnUse = true,
	OnUse = function(self)
		local ply = self:Owner()		
		if( CLIENT ) then
			
			GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "You swallow the pills.", { CB_ALL, CB_IC } );
			
			
		end
		
		return true
	end,
	CanRun = function(item)
		return true
	end,
}
