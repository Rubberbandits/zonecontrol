-- This file was converted to Kingston item system by Niggerlicious conversion kit --
ITEM.Name =  "Psy-block";
ITEM.Desc =  "A tray of psychoreducive tabs. Much less shady than anabiotics.";
ITEM.Model =  "models/stalker/item/medical/psy_pills.mdl";
ITEM.Weight =  .1;
ITEM.FOV =  8;
ITEM.CamPos =  Vector( 50, 50, 50 );
ITEM.LookAt =  Vector( 0, 0, 0 );

ITEM.PhysicalMass	= 1;

ITEM.BulkPrice =  2000;
ITEM.License =  LICENSE_BLACK;
ITEM.functions = {}
ITEM.functions.Use = {
	SelectionName = "Swallow",
	RemoveOnUse = true,
	OnUse = function(self)
		local ply = self:Owner()		
		if( CLIENT ) then
			
			LocalPlayer():Notify(nil, Color(200,200,200,255), "As you take the pills, you feel your presence float away from yourself. You are immune to psychostimulation, and devoid of emotion. It's getting cold in here.")
			
			
		end
		
		return true
	end,
	CanRun = function(item)
		return true
	end,
}
