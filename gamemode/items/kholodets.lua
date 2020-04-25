-- This file was converted to Kingston item system by Niggerlicious conversion kit --
ITEM.Name =  "Kholodets";
ITEM.Desc =  "Traditional Russian meat jelly. You can see shredded pork and onions buried within the translucent gelatin. It's reminiscent of harsher times and goes great with vodka.";
ITEM.Model =  "models/z-o-m-b-i-e/st/kitchen/st_posuda_konservy_01_3.mdl";
ITEM.Weight =  0.5;
ITEM.FOV =  12;
ITEM.CamPos =  Vector( 50, 50, 50 );
ITEM.LookAt =  Vector( 0, 0, 0 );
ITEM.BulkPrice =  500;
ITEM.License =  LICENSE_BLACK;
ITEM.functions = {}
ITEM.functions.Use = {
	SelectionName = "Eat",
	RemoveOnUse = true,
	OnUse = function(self)
		local ply = self:Owner()		
		if( CLIENT ) then
			
			LocalPlayer():Notify(nil, Color(200,200,200,255), "It's about what you expected: bland, generally slimy, and stringy in all the wrong ways. At least it's a filling and potentially wholesome meal. There's never been a more perfect food analogy for Soviet rule.")
	
		end
		
		return true
	end,
	CanRun = function(item)
		return true
	end,
}
