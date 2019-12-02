-- This file was converted to Kingston item system by Niggerlicious conversion kit --
ITEM.Name =  "Morley Reds";
ITEM.Desc =  "A pack of cigarettes from the west with a stark red label. Smooth.";
ITEM.Model =  "models/kali/miscstuff/stalker/sensor_d.mdl";

ITEM.ItemSubmaterials = {
	{ 0 , "models/props_canal/metalcrate001d" }
}

ITEM.Weight =  0.5;
ITEM.FOV =  14;
ITEM.CamPos =  Vector( 50, 50, 50 );
ITEM.LookAt =  Vector( 0, 0, 0 );
ITEM.BulkPrice =  600;
ITEM.License =  LICENSE_BLACK;
ITEM.functions = {}
ITEM.functions.Use = {
	SelectionName = "Smoke",
	RemoveOnUse = true,
	OnUse = function(self)
		local ply = self:Owner()		
		if( CLIENT ) then
			
			GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "You light up a smoke and take a few puffs, feeling sated.", { CB_ALL, CB_IC } );
			
			
		end
		
		return true
	end,
	CanRun = function(item)
		return true
	end,
}
