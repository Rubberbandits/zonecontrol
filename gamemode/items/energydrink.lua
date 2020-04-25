-- This file was converted to Kingston item system by Niggerlicious conversion kit --
ITEM.Name =  "Energy Drink";
ITEM.Desc =  "Canned energy drink. One of things that keep a stalker awake during the night.";
ITEM.Model =  "models/stalker/item/food/drink.mdl";
ITEM.Weight =  .5;
ITEM.FOV =  6;
ITEM.CamPos =  Vector( 50, 50, 50 );
ITEM.LookAt =  Vector( 0, 0, 3 );

ITEM.PhysicalMass	= 1;

ITEM.BulkPrice =  300;
ITEM.License =  LICENSE_BLACK;
ITEM.functions = {}
ITEM.functions.Use = {
	SelectionName = "Drink",
	RemoveOnUse = true,
	OnUse = function(self)
		local ply = self:Owner()		
		if( CLIENT ) then
			
			LocalPlayer():Notify(nil, Color(200,200,200,255), "The energy drink has a sugary, acidic taste. It doesn't feel like battery acid, but it does taste like it. Zing!")
			
			
		end
		
		return true
	end,
	CanRun = function(item)
		return true
	end,
}
