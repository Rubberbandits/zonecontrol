ENT.Type = "point";
ENT.Base = "base_point";

function ENT:Think()
	
	for _, v in ipairs( player.GetAll() ) do
		
		local d = v:GetPos():Distance( self:GetPos() );
		
		if( d < self.Radius ) then
			
			if( !v.LastServerOffer ) then v.LastServerOffer = CurTime() end
			
			if( CurTime() >= v.LastServerOffer + 1 ) then
				
				netstream.Start(v, "nServerOffer", self.Location, self.Port)
				
			end
			
		end
		
	end
	
end