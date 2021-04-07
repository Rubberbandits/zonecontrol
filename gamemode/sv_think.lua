function GM:Think()
	
	for _, v in ipairs( player.GetAll() ) do
		
		self:ConsciousThink( v );
		self:HungerThink( v );
		v:WaterThink();
		
	end
	
	if( !GAMEMODE.NextCheck or CurTime() > GAMEMODE.NextCheck ) then
	
		for k,v in next, self.g_ItemTable do

			if( !IsValid( v.owner ) or !v.owner ) then
			
				self.g_ItemTable[k] = nil;
				
			end
			
		end
	
		local function onSuccess( ret )	
		end
		mysqloo.Query( "SHOW STATUS LIKE 'Uptime'", onSuccess );
		
		GAMEMODE.NextCheck = CurTime() + 10;
		
	end
	
	self:SQLThink();
	
end

hook.Add("Think", "STALKER.SatiatedHealthRegen", function()
	if !GAMEMODE.NextHealthRegenThink then
		GAMEMODE.NextHealthRegenThink = CurTime()
	end

	if GAMEMODE.NextHealthRegenThink <= CurTime() then
		for _,ply in ipairs(player.GetAll()) do
			if ply:CharID() == 0 then continue end

			if ply:Hunger() <= 25 then
				ply:SetHealth(math.Clamp(ply:Health() + 1, 0, ply:GetMaxHealth()))
			end
		end

		GAMEMODE.NextHealthRegenThink = CurTime() + 60
	end
end)