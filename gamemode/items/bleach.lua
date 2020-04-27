
ITEM.Name =  "Bleach";
ITEM.Desc =  "It's used to take the stains out of clothes. Highly toxic.";
ITEM.Model =  "models/props_junk/garbage_plasticbottle002a.mdl";
ITEM.Weight =  1;
ITEM.FOV =  14;
ITEM.CamPos =  Vector( 50, 50, 50 );
ITEM.LookAt =  Vector( 0, 0, 0 );
ITEM.BulkPrice =  100;
ITEM.License =  LICENSE_MISC;
ITEM.functions = {}
ITEM.functions.Use = {
	SelectionName = "Drink",
	RemoveOnUse = true,
	OnUse = function(self)
		local ply = self:Owner()		
		if( CLIENT ) then
			
			LocalPlayer():Notify(nil, Color(200,200,200,255), "You drink the bleach. Great idea!")
			
		else
			
			ply:Kill();
			
		end
		
		return true
	end,
	CanRun = function(item)
		return true
	end,
}
