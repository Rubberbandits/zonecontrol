-- This file was converted to Kingston item system by Niggerlicious conversion kit --
ITEM.Name =  "Russian Playboy";
ITEM.Desc =  "25 pages worth of prime nude Russian gals. Probably the best way to travel to a better place, at least mentally.";
ITEM.Model =  "models/porn.mdl";
ITEM.Weight =  0.5;
ITEM.FOV =  13;
ITEM.CamPos =  Vector( 50, 50, 50 );
ITEM.LookAt =  Vector( 0, 0, 0 );
ITEM.BulkPrice =  1500;
ITEM.License =  LICENSE_BLACK;
ITEM.functions = {}
ITEM.functions.Use = {
	SelectionName = "Use",
	RemoveOnUse = true,
	OnUse = function(self)
		local ply = self:Owner()		
		if( CLIENT ) then
			
			LocalPlayer():Notify(nil, Color(200,200,200,255), "Page by page, you eat the magazine. Salty.")
			GAMEMODE:DrugEffectVodka();
			
		end
		
		return true
	end,
	CanRun = function(item)
		return true
	end,
}
