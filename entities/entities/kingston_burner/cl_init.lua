include('shared.lua')

function ENT:Initialize()
	
	local trace = {}
	trace.start = self.Entity:GetPos()
	trace.endpos = trace.start + Vector( 0, 0, -500 )
	trace.filter = self.Entity
	local tr = util.TraceLine( trace )
	
	self.Normal = tr.HitNormal
	self.Timer = 0
	self.BurnTime = 0
	self.Size = 50
	self.Emitter = ParticleEmitter( self.Entity:GetPos() )

end

function ENT:Think()

	if self.Entity:GetNWBool( "Burn", false ) and self.BurnTime < CurTime() then
		
		self.BurnTime = CurTime() + 5
	
	end
	
	local mypos = self:GetPos()
	local dist = LocalPlayer():GetPos():Distance(mypos)

	if self.Timer < CurTime() then

		if( !self.Emitter or !IsValid( self.Emitter ) ) then 
			
			self.Emitter = ParticleEmitter( self.Entity:GetPos() );
			return
			
		end

		local particle = self.Emitter:Add( "sprites/heatwave", self.Entity:GetPos() + VectorRand() * 10 )
		particle:SetVelocity( self.Normal * 50 + VectorRand() * 5 + Vector(0,0,20) ) 
		particle:SetLifeTime( 0 )  
		particle:SetDieTime( math.Rand( 1.0, 1.5 ) ) 
		particle:SetStartAlpha( 255 ) 
		particle:SetEndAlpha( 255 ) 
		particle:SetStartSize( math.random( 20, 40 ) ) 
		particle:SetEndSize( 0 ) 
		particle:SetColor( 255, 255, 255 )
		particle:SetAirResistance( 50 )
		particle:SetGravity( Vector( 0, 0, 100 ) )
		
		self.Timer = CurTime() + 0.5

	end
	
	if self.BurnTime > CurTime() and self.Entity:GetNWBool( "Burn", false ) and !self.BurnerParticleSystem then
		
		self.BurnerParticleSystem = CreateParticleSystem( self.Entity, "burner", PATTACH_ABSORIGIN_FOLLOW );
		
	end
	
	if( self.BurnTime > CurTime() and !self.Entity:GetNWBool( "Burn", false ) and self.BurnerParticleSystem ) then
	
		if( IsValid( self.BurnerParticleSystem ) ) then
		
			self.BurnerParticleSystem:StopEmission();
			self.BurnerParticleSystem = nil;
			
		end
	
	end

end	

function ENT:OnRemove()

	if self.Emitter and IsValid( self.Emitter ) then

		self.Emitter:Finish()
	
	end

end

local matRefract = Material( "sprites/heatwave" )

function ENT:Draw()

	if render.GetDXLevel() >= 80 then
		
		render.UpdateRefractTexture()
		render.SetMaterial( matRefract )
		
	end

end

