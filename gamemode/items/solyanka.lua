-- This file was converted to Kingston item system by Niggerlicious conversion kit --
ITEM.Name =  "Solyanka";
ITEM.Desc =  "A stew of pitiful leftovers. You can't tell exactly what's in it, just that there's a lot of indistinct... stuff. Hopefully some of it is meat, and all of it is edible.";
ITEM.Model =  "models/z-o-m-b-i-e/st/kitchen/st_posuda_konservy_01_3.mdl";
ITEM.Weight =  0.5;
ITEM.FOV =  12;
ITEM.CamPos =  Vector( 50, 50, 50 );
ITEM.LookAt =  Vector( 0, 0, 0 );
ITEM.BulkPrice =  550;
ITEM.License =  LICENSE_BLACK;
ITEM.functions = {}
ITEM.functions.Use = {
	SelectionName = "Eat",
	RemoveOnUse = true,
	OnUse = function(self)
		local ply = self:Owner()		
		if( CLIENT ) then
			
			LocalPlayer():Notify(nil, Color(200,200,200,255), "You choke down the cold soup with bitterness. The different chunks of meal remind you of about every different dinner you've experienced over the past month, but all in exceptionally shitty ways. They say hot solyanka is a cure for any sickness, but the way your stomach's beginning to rumble, you wonder if cold solyanka has the opposite effect.")
	
		end
		
		return true
	end,
	CanRun = function(item)
		return true
	end,
}
