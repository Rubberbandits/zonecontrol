ITEM.Name =  "Stone-sharpening Set";
ITEM.Desc =  "A three-piece stone sharpening set suited to honing the blade of a knife.";
ITEM.Model =  "models/kek1ch/sharpening_stones.mdl";
ITEM.Weight =  1.2
ITEM.FOV =  9;
ITEM.CamPos =  Vector( 50, 50, 50 );
ITEM.LookAt =  Vector( 0, 0, 0 );
ITEM.BulkPrice =  200
ITEM.W = 1
ITEM.H = 2
ITEM.functions = {}
ITEM.functions.Use = {
	SelectionName = "Use",
	OnUse = function(self)
		local ply = self:Owner()		
		if( CLIENT ) then
			
			LocalPlayer():Notify(nil, Color(200,200,200,255), "You take a blade and carefully sharpen it against the stone blocks, honing its edge.")
			
			
		end
		
		return true
	end,
	CanRun = function(item)
		return true
	end,
}
ITEM.Rarity = 2
ITEM.AllowRandomSpawn = true
ITEM.IsSellable = true

function ITEM:GetSellPrice()
	return 40
end