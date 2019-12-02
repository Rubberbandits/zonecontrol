-- This file was converted to Kingston item system by Niggerlicious conversion kit --
ITEM.Name =  "Kompot";
ITEM.Desc =  "A sweet fruity drink, served hot or cold depending on the season. This kompot is made with... well, something, that's presumably fruit. The indistinct chunks float at the surface of the liquid.";
ITEM.Model =  "models/kali/miscstuff/stalker/food/energy drink.mdl";
ITEM.Weight =  0.5;
ITEM.FOV =  12;
ITEM.CamPos =  Vector( 50, 50, 50 );
ITEM.LookAt =  Vector( 0, 0, 0 );
ITEM.BulkPrice =  800;
ITEM.License =  LICENSE_BLACK;
ITEM.functions = {}
ITEM.functions.Use = {
	SelectionName = "Eat",
	RemoveOnUse = true,
	OnUse = function(self)
		local ply = self:Owner()		
		if( CLIENT ) then
			
			GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "The drink goes down like a thin syrup, tasting like a bad mix of artificial sweeteners and preservative. The taste lingers a while after you've gulped down your fill, and only sours the more your smack your lips to try and get it away.", { CB_ALL, CB_IC } );
	
		end
		
		return true
	end,
	CanRun = function(item)
		return true
	end,
}
