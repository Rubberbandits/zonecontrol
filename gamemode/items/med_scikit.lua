-- This file was converted to Kingston item system by Niggerlicious conversion kit --
ITEM.Name =  "Scientific Medkit";
ITEM.Desc =  "A top shelf medkit designed especially for use in the Zone. Includes enough aerospace-grade tape to patch a sealed suit in an emergency.";
ITEM.Model =  "models/kali/miscstuff/stalker/aid/first aid kit.mdl";

ITEM.ItemSubmaterials = {
	{ 0 , "models/kali/miscstuff/stalker/aid/firstaid_scientific_c" }
}

ITEM.Weight =  1;
ITEM.FOV =  9;
ITEM.CamPos =  Vector( 50, 50, 50 );
ITEM.LookAt =  Vector( 0, 0, 5.02 );
ITEM.BulkPrice =  15000;
ITEM.License =  LICENSE_BLACK;
ITEM.functions = {}
ITEM.functions.Use = {
	SelectionName = "Use",
	RemoveOnUse = true,
	OnUse = function(self)
		local ply = self:Owner()		
		if( CLIENT ) then
			
			GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "You tend to your wounds. By the power of science, you are healed.", { CB_ALL, CB_IC } );
			
		else
			
			ply:SetHealth( math.min( ply:Health() + 70, 100 ) );
			
		end
		
		return true
	end,
	CanRun = function(item)
		return true
	end,
}
