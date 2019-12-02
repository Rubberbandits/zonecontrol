-- This file was converted to Kingston item system by Niggerlicious conversion kit --
ITEM.Name =  "Antidote";
ITEM.Desc =  "An anti-toxin injection that absorbs and neutralizes natural poisons in the body.";
ITEM.Model =  "models/stalker/item/medical/antidote.mdl";
ITEM.Weight =  .1;
ITEM.FOV =  8;
ITEM.CamPos =  Vector( 50, 50, 50 );
ITEM.LookAt =  Vector( 0, 0, 0 );

ITEM.PhysicalMass	= 1;

ITEM.BulkPrice =  1500;
ITEM.License =  LICENSE_BLACK;
ITEM.functions = {}
ITEM.functions.Use = {
	SelectionName = "Inject",
	RemoveOnUse = true,
	OnUse = function(self)
		local ply = self:Owner()		
		if( CLIENT ) then
			
			GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "The antidote starts to clear toxins from your system. Over time, you start to become dehydrated.", { CB_ALL, CB_IC } );
			
			
		end
		
		return true
	end,
	CanRun = function(item)
		return true
	end,
}
