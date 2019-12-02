-- This file was converted to Kingston item system by Niggerlicious conversion kit --
ITEM.Name =  "Union Banana";
ITEM.Desc =  "A yellow banana with a little CMB sticker.";
ITEM.Model =  "models/props/cs_italy/bananna.mdl";
ITEM.Weight =  1;
ITEM.FOV =  14;
ITEM.CamPos =  Vector( 50, 50, 50 );
ITEM.LookAt =  Vector( 0, 0, 0 );
ITEM.BulkPrice =  75;
ITEM.License =  LICENSE_FOOD;
ITEM.functions = {}
ITEM.functions.Use = {
	SelectionName = "Eat",
	RemoveOnUse = true,
	OnUse = function(self)
		local ply = self:Owner()		
		if( CLIENT ) then
			
			GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "You bite straight into the banana with an audible crunch. Sicko.", { CB_ALL, CB_IC } );
			
		else
			
		end
		
		return true
	end,
	CanRun = function(item)
		return true
	end,
}
