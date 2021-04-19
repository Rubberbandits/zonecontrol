ITEM.Name =  "Anabiotic";
ITEM.Desc =  "An experimental drug developed by research teams inside the Zone. Supposedly, it can be used to survive an emission, but the cost is yet unknown.";
ITEM.Model =  "models/stalker/item/medical/antibotic.mdl";
ITEM.Weight =  .5;
ITEM.FOV =  8;
ITEM.CamPos =  Vector( 50, 50, 50 );
ITEM.LookAt =  Vector( 0, -1, 0 );
ITEM.PhysicalMass	= 1;
ITEM.BulkPrice =  2500;
ITEM.License =  "D";
ITEM.UseText = "Swallow"
ITEM.ConsumeText = "The anabiotic starts to kick in quickly. Your mind is overwhelmed with emptiness. Within moments, your vision fades, and you black out entirely. You wake to a cold sweat, your body shaking and your head aching."
ITEM.HealAmount = 0
ITEM.FunctionHooks = {}
ITEM.FunctionHooks.PostUse = function(item)
	if SERVER then
		local ply = item.owner -- have to cache because item gets removed!!
		timer.Simple( 5, function() ply:TakeCDamage( 100 ) end )	
	end
end
ITEM.Rarity = 4
ITEM.AllowRandomSpawn = true