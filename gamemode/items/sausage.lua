-- This file was converted to Kingston item system by Niggerlicious conversion kit --
ITEM.Name =  "Sausage";
ITEM.Desc =  "Preserved and packaged roll of ground pork. A high protein meal that is tastier than bread.";
ITEM.Model =  "models/stalker/item/food/sausage.mdl";
ITEM.Weight =  .5;
ITEM.FOV =  6;
ITEM.CamPos =  Vector( 50, 50, 50 );
ITEM.LookAt =  Vector( 1, -1, 0 );

ITEM.PhysicalMass	= 1;

ITEM.BulkPrice =  800;
ITEM.License =  LICENSE_BLACK;
ITEM.functions = {}
ITEM.functions.Use = {
	SelectionName = "Eat",
	RemoveOnUse = true,
	OnUse = function(self)
		local ply = self:Owner()		
		if( CLIENT ) then
			
			GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "The sausage is very chewy. Every so often there is a speck of bone, but otherwise the meat is very flavorful. Very salty.", { CB_ALL, CB_IC } );
			
			
		end
		
		return true
	end,
	CanRun = function(item)
		return true
	end,
}
