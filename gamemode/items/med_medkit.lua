-- This file was converted to Kingston item system by Niggerlicious conversion kit --
ITEM.Name =  "Medkit";
ITEM.Desc =  "General purpose medkit. Contains emergency first aid materials to stave off death.";
ITEM.Model =  "models/kali/miscstuff/stalker/aid/first aid kit.mdl";
ITEM.Weight =  1;
ITEM.FOV =  9;
ITEM.CamPos =  Vector( 50, 50, 50 );
ITEM.LookAt =  Vector( 0, 0, 5.02 );
ITEM.BulkPrice =  4000;
ITEM.License =  LICENSE_BLACK;
ITEM.functions = {}
ITEM.functions.Use = {
	SelectionName = "Use",
	RemoveOnUse = true,
	OnUse = function(self)
		local ply = self:Owner()		
		if( CLIENT ) then
			
			LocalPlayer():Notify(nil, Color(200,200,200,255), "You tend to your wounds. It'll do for now.")
			
		else
			
			ply:SetHealth( math.min( ply:Health() + 20, 100 ) );
			
		end
		
		return true
	end,
	CanRun = function(item)
		return true
	end,
}
