-- This file was converted to Kingston item system by Niggerlicious conversion kit --
ITEM.Name =  "Anti-Rad Pills";
ITEM.Desc =  "A packet of anti-radiation drugs that neutralize radiation accumulated in the body.";
ITEM.Model =  "models/kali/miscstuff/stalker/aid/anti-rad.mdl";
ITEM.Weight =  .1;
ITEM.FOV =  12;
ITEM.CamPos =  Vector( 50, 50, 50 );
ITEM.LookAt =  Vector( 0, 0, 0 );
ITEM.BulkPrice =  1500;
ITEM.License =  LICENSE_BLACK;
ITEM.functions = {}
ITEM.functions.Use = {
	SelectionName = "Consume",
	RemoveOnUse = true,
	OnUse = function(self)
		local ply = self:Owner()		
		if( CLIENT ) then
			
			GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "You swallow the two pills. Afterwards, you feel a tad dizzy and nauseous.", { CB_ALL, CB_IC } );
			
			
		end
		
		return true
	end,
	CanRun = function(item)
		return true
	end,
}
