-- This file was converted to Kingston item system by Niggerlicious conversion kit --
ITEM.Name =  "Blood Orange";
ITEM.Desc =  "An orange with a small sticker on it that reads 'Burke Agricultural Cooperative'.";
ITEM.Model =  "models/props/cs_italy/orange.mdl";
ITEM.Weight =  10;
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
			
			LocalPlayer():Notify(nil, Color(200,200,200,255), "You eat the orange whole. Who needs transfusions?")
			
		else
			
			ply:SetHealth( math.min( ply:Health() + 60, 100 ) );
			
		end
		
		return true
	end,
	CanRun = function(item)
		return true
	end,
}
