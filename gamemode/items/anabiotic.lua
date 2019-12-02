-- This file was converted to Kingston item system by Niggerlicious conversion kit --
ITEM.Name =  "Anabiotic";
ITEM.Desc =  "An experimental drug developed by research teams inside the Zone. Supposedly, it can be used to survive an emission, but the cost is yet unknown.";
ITEM.Model =  "models/stalker/item/medical/antibotic.mdl";
ITEM.Weight =  .5;
ITEM.FOV =  8;
ITEM.CamPos =  Vector( 50, 50, 50 );
ITEM.LookAt =  Vector( 0, -1, 0 );

ITEM.PhysicalMass	= 1;

ITEM.BulkPrice =  2500;
ITEM.License =  LICENSE_BLACK;
ITEM.functions = {}
ITEM.functions.Use = {
	SelectionName = "Consume",
	RemoveOnUse = true,
	OnUse = function(self)
		local ply = self:Owner()		
		if( CLIENT ) then
			
			GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "The anabiotic starts to kick in quickly. Your mind is overwhelmed with emptiness. Within moments, your vision fades, and you black out entirely. You wake to a cold sweat, your body shaking and your head aching.", { CB_ALL, CB_IC } );
			GAMEMODE:DrugEffectBreen();	
			
		else
			
			timer.Simple( 5, function() ply:TakeCDamage( 100 ) end )	
	
		end
		
		return true
	end,
	CanRun = function(item)
		return true
	end,
}
