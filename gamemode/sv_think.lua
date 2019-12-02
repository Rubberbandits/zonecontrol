function GM:Think()
	
	for _, v in pairs( player.GetAll() ) do
		
		self:ConsciousThink( v );
		self:HungerThink( v );
		self:AdminThink( v );
		self:AFKThink( v );
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