-- This file was converted to Kingston item system by Niggerlicious conversion kit --
ITEM.Name =  "Tourist's Delight";
ITEM.Desc =  "Tinned tuna, in water. The kind of cheap stuff Stalker's grab at a gas station, just before slipping into the Cordon.";
ITEM.Model =  "models/kali/miscstuff/stalker/food/tourist's breakfast.mdl";
ITEM.Weight =  .5;
ITEM.FOV =  8;
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
	       
	        LocalPlayer():Notify(nil, Color(200,200,200,255), "Although bland, the canned tuna is quite filling. The meat is wet, but it feels dry. The oiley taste lingers in your mouth.")
	       
	    end
	   
		return true
	end,
	CanRun = function(item)
		return true
	end,
}
