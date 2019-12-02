include('shared.lua')

local Heatwave = Material("effects/strider_bulge_dudv")
local Size = 100

function ENT:Draw()
	local mypos = self:GetPos()
	local dist = LocalPlayer():GetPos():Distance(mypos)
	
	if(dist < 3000) then

		
	
	end
end 
	
function ENT:IsTranslucent()
	return false
end

function ENT:Think()
	
	if( !self.VortexParticleSystem and !self.VortexSuckParticleSystem and !self.VortexRepulseParticleSystem ) then
	
		self.VortexParticleSystem = CreateParticleSystem( self.Entity, "vortex_inactive", PATTACH_ABSORIGIN_FOLLOW, 0, Vector( 0, 0, 0 ) );
		
	end

    for k, v in next, ents.FindInSphere( self.Entity:GetPos(), 300 ) do	
		--If it is a valid entity and nearby
		if( v:IsValid() and v:IsPlayer() and v:GetPos( ):Distance( self:GetPos( ) ) <= 300 ) then
			
            -- do suck particle system
			if( self.VortexParticleSystem and IsValid( self.VortexParticleSystem ) ) then
			
				self.VortexParticleSystem:StopEmissionAndDestroyImmediately();
				self.VortexParticleSystem = nil;
			
			end
			
			if( !self.VortexSuckParticleSystem ) then
			
				self.VortexSuckParticleSystem = CreateParticleSystem( self.Entity, "vortex_armed", PATTACH_ABSORIGIN_FOLLOW, 0, Vector( 0, 0, -16 ) );
				
			end
		
		end
		
	end
	
	if( CurTime() >= self:GetNW2Int( "DamageTime", CurTime() + 1 ) and !self.VortexRepulseParticleSystem ) then
		
		-- do explosion particle system
		
		if( self.VortexSuckParticleSystem and IsValid( self.VortexSuckParticleSystem ) ) then
		
			self.VortexSuckParticleSystem:StopEmissionAndDestroyImmediately();
			self.VortexSuckParticleSystem = nil;
		
		end
		
		self.VortexRepulseParticleSystem = CreateParticleSystem( self.Entity, "vortex_repulse", PATTACH_ABSORIGIN_FOLLOW, 0, Vector( 0, 0, 0 ) );
		timer.Simple( 1, function()
		
			if( IsValid( self.VortexRepulseParticleSystem ) ) then
		
				self.VortexRepulseParticleSystem:StopEmissionAndDestroyImmediately();
				self.VortexRepulseParticleSystem = nil;
				
			end
		
		end );
		
	end
	
	for k,v in next, ents.FindInSphere( self.Entity:GetPos(), 300 ) do
	
		if( v:IsPlayer() ) then break end
		
		if( k == #ents.FindInSphere( self.Entity:GetPos(), 300 ) ) then
		
			if( !self.VortexParticleSystem ) then

				self.VortexParticleSystem = CreateParticleSystem( self.Entity, "vortex_inactive", PATTACH_ABSORIGIN_FOLLOW, 0, Vector( 0, 0, 0 ) );
				
			end
			
			if( self.VortexRepulseParticleSystem and IsValid( self.VortexRepulseParticleSystem ) ) then
			
				self.VortexRepulseParticleSystem:StopEmissionAndDestroyImmediately();
				self.VortexRepulseParticleSystem = nil;
		
			end
			
			if( self.VortexSuckParticleSystem and IsValid( self.VortexSuckParticleSystem ) ) then
			
				self.VortexSuckParticleSystem:StopEmissionAndDestroyImmediately();
				self.VortexSuckParticleSystem = nil;
				
			end
		
		end
	
	end
	
end