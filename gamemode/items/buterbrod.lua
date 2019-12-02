-- This file was converted to Kingston item system by Niggerlicious conversion kit --
ITEM.Name =  "Buterbrod";
ITEM.Desc =  "Butterbread. Rye bread slathered with butter, stacked with cheese and sausage, and topped finally by a generous dollop of mayonez.";
ITEM.Model =  "models/kali/miscstuff/stalker/food/bread.mdl";
ITEM.Weight =  0.4;
ITEM.FOV =  12;
ITEM.CamPos =  Vector( 50, 50, 50 );
ITEM.LookAt =  Vector( 0, 0, 0 );
ITEM.BulkPrice =  400;
ITEM.License =  LICENSE_BLACK;
ITEM.functions = {}
ITEM.functions.Use = {
	SelectionName = "Eat",
	RemoveOnUse = true,
	OnUse = function(self)
		local ply = self:Owner()		
		if( CLIENT ) then
			
			GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "Your teeth sink with a crunch into the wholesome snack. The bread and all of the stacked items atop it are wonderfully warm and fresh. You've safely concluded that is yet another of life's invaluable little pleasures.", { CB_ALL, CB_IC } );
	
		end
		
		return true
	end,
	CanRun = function(item)
		return true
	end,
}
