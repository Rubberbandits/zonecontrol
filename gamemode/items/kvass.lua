-- This file was converted to Kingston item system by Niggerlicious conversion kit --
ITEM.Name =  "Kvass";
ITEM.Desc =  "Smuggled bread-beer, made from raisins and black bread. The contents are a thick and murky dark orange.";
ITEM.Model =  "models/kali/miscstuff/stalker/food/cossacks vodka.mdl";
ITEM.Weight =  0.4;
ITEM.FOV =  12;
ITEM.CamPos =  Vector( 50, 50, 50 );
ITEM.LookAt =  Vector( 0, 0, 0 );
ITEM.BulkPrice =  650;
ITEM.License =  LICENSE_BLACK;
ITEM.functions = {}
ITEM.functions.Use = {
	SelectionName = "Eat",
	RemoveOnUse = true,
	OnUse = function(self)
		local ply = self:Owner()		
		if( CLIENT ) then
			
			LocalPlayer():Notify(nil, Color(200,200,200,255), "Taking a drink, you're reminded of nasty western light beers and cheap apple cider. There's not enough alcohol in the kvass for it to be classified as an alcoholic beverage in Russia, but you're certain enough of this stuff will give you a good buzz. That is, if you can stomach enough of the piss-like drink.")
	
		end
		
		return true
	end,
	CanRun = function(item)
		return true
	end,
}
