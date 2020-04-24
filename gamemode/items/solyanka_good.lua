-- This file was converted to Kingston item system by Niggerlicious conversion kit --
ITEM.Name =  "Wholesome Solyanka";
ITEM.Desc =  "A delightful stew of leftovers. You can't tell exactly what's in it, but there's got to be at least three kinds of meat, loads of potatoes, and assorted vegetables.";
ITEM.Model =  "models/z-o-m-b-i-e/st/kitchen/st_posuda_konservy_01_3.mdl";
ITEM.Weight =  0.5;
ITEM.FOV =  12;
ITEM.CamPos =  Vector( 50, 50, 50 );
ITEM.LookAt =  Vector( 0, 0, 0 );
ITEM.BulkPrice =  600;
ITEM.License =  LICENSE_BLACK;
ITEM.functions = {}
ITEM.functions.Use = {
	SelectionName = "Eat",
	RemoveOnUse = true,
	OnUse = function(self)
		local ply = self:Owner()		
		if( CLIENT ) then
			
			LocalPlayer():Notify(nil, Color(200,200,200,255), "Luckily, the soup's a tolerable temperature. The different chunks of meal remind you of about every different dinner you've experienced over the past month. They say hot Solyanka is a cure for any sickness, and you find it hard to argue.")
	
		end
		
		return true
	end,
	CanRun = function(item)
		return true
	end,
}
