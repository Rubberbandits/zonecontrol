include('shared.lua')

/*---------------------------------------------------------
   Name: Draw
   Desc: Draw it!
---------------------------------------------------------*/
function ENT:Draw()
	local mypos = self:GetPos()
	local dist = LocalPlayer():GetPos():Distance(mypos)
	
	if(dist < 5000) then
		--self.Entity:DrawModel()
	end
end

function ENT:Initialize()

end

/*---------------------------------------------------------
   Name: IsTranslucent
   Desc: Return whether object is translucent or opaque
---------------------------------------------------------*/
function ENT:IsTranslucent()
	return true
end

function ENT:Think()

	local mypos = self:GetPos()
	local dist = LocalPlayer():GetPos():Distance(mypos)
	
	if(dist < 5000) then

		if( !self.FruitPunchParticleSystem ) then

			self.FruitPunchParticleSystem = CreateParticleSystem( self.Entity, "acid", PATTACH_ABSORIGIN_FOLLOW, 0, Vector( 0, 0, -10 ) );
			
		end
		
--[[ 		if( !self.FruitPunchPopSystem ) then
		
			CreateParticleSystem( self.Entity, "pfx_fruit_punch_pop", PATTACH_ABSORIGIN_FOLLOW, 0, Vector( math.random( -64, 64 ), math.random( -64, 64 ), 0 ) );
		
			self.FruitPunchPopSystem = true;
			self.FruitPunchPopSystemEndTime = CurTime() + 2;
		
		elseif( self.FruitPunchPopSystem and self.FruitPunchPopSystemEndTime < CurTime() ) then
		
			self.FruitPunchPopSystem = nil;
			self.FruitPunchPopSystemEndTime = nil;
		
		end
		 ]]
		for k, v in pairs( ents.FindInSphere( self.Entity:GetPos(), 300 ) ) do	
	
			if( v:IsPlayer() and v:IsValid() and v:GetPos( ):Distance( self:GetPos( ) ) <= 300 ) then
			
				if( !self.NextSoundPlay ) then self.NextSoundPlay = CurTime() end
				if( self.NextSoundPlay > CurTime() ) then return end
				
				self.NextSoundPlay = CurTime() + 0.5;
			
			end
			
		end
	
	end

end

function ENT:OnRemove()

	if( self.FruitPunchParticleSystem ) then
	
		self.FruitPunchParticleSystem:StopEmissionAndDestroyImmediately();
	
	end

end