-- This file was converted to Kingston item system by Niggerlicious conversion kit --
ITEM.Name =  "Gauze Bandages";
ITEM.Desc =  "A roll of gauze bandages. Used for emergency first aid.";
ITEM.Model =  "models/stalker/item/medical/bandage.mdl";
ITEM.Weight =  1;
ITEM.FOV =  9;
ITEM.CamPos =  Vector( 50, 50, 50 );
ITEM.LookAt =  Vector( 0, 0, 5.02 );
ITEM.BulkPrice =  500;
ITEM.License =  LICENSE_BLACK;
ITEM.functions = {}
ITEM.functions.Use = {
	SelectionName = "Apply",
	RemoveOnUse = true,
	OnUse = function(self)
		local ply = self:Owner()		
		if( CLIENT ) then
			
			LocalPlayer():Notify(nil, Color(200,200,200,255), "You wrap the wound in bandages.")
			
		else
			
			ply:SetHealth( math.min( ply:Health() + 20, 100 ) );
			
		end
		
		return true
	end,
	CanRun = function(item)
		return true
	end,
}
