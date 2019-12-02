AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include('shared.lua')

function ENT:SpawnFunction( ply, tr )
	if ( !tr.Hit ) then return end
	local SpawnPos = tr.HitPos + tr.HitNormal * 16
	local ent = ents.Create( self.ClassName )
	ent:SetPos( SpawnPos )
	ent:Spawn()
	ent:Activate()
	return ent
end

function ENT:Initialize()

	self.Entity:SetModel( "models/props_junk/watermelon01.mdl" ) --Set its model.
	//self.Entity:PhysicsInit( SOLID_NONE )      -- Make us work with physics,
	self.Entity:SetMoveType( MOVETYPE_NONE )   -- after all, gmod is a physics
	self.Entity:SetSolid( SOLID_NONE ) 	-- Toolbox
	
	self.Entity:SetKeyValue("rendercolor", "150 255 150") 
	self.Entity:SetKeyValue("renderamt", "0") 
	self.Entity:DrawShadow(false)
	
	self.DustSize = 200
	self:SetNW2Int( "DustChange", 0 );
	
	local phys = self.Entity:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
	end
end

function ENT:Think()

	if( self.DustSize > 350 )then 
		self.DustSize = 120
	end

    for k, v in pairs( ents.FindInSphere( self.Entity:GetPos(), 300 ) ) do	
		--If it is a valid entity and nearby
		if( v:IsValid() and v:GetPhysicsObject():IsValid() and v:GetPos( ):Distance( self:GetPos( ) ) <= 300 ) then
			
            local dir = v:GetPos() - self:GetPos()
			local force = 35	
			local distance = dir:Length()			// The distance the phys object is from the ent
			local maxdistance = 300				// The max distance 
		
			// Lessen the force from a distance
			
			local ratio = math.Clamp( (1 - (distance/maxdistance)), 0, 1 )
			
			// Set up the 'real' force and the offset of the force
			local vForce = -1*dir * (force * ratio)
			
			// Apply it!
			v:GetPhysicsObject():ApplyForceOffset( vForce, dir )
						
		end
		
		if( v:IsPlayer() and v:IsValid() and v:GetPos():Distance( self:GetPos() ) <= 64 ) then
		
			if( CurTime() >= self:GetNW2Int( "DamageTime", CurTime() ) ) then

				self:SetNW2Int( "DamageTime", CurTime() + 3 );

				--Let make it shake nearby players.
				local shake = ents.Create("env_shake")
				shake:SetKeyValue("duration", 1)
				shake:SetKeyValue("amplitude", 13)
				shake:SetKeyValue("radius", 400) 
				shake:SetKeyValue("frequency", 800)
				shake:SetPos(self.Entity:GetPos())
				shake:Spawn()
				shake:Fire("StartShake","","0.6") 
				shake:Fire("kill", "", 1)

				if( math.random( 1, 2 ) == 2 ) then
				
					self:EmitSound("stalker-kingston/anomaly/anomaly_gravy_blast1.wav");
					
				else
				
					self:EmitSound("stalker-kingston/anomaly/anomaly_gravy_hit1.wav");
					
				end
				
				local d = DamageInfo();
				d:SetDamage( math.random( 30, 40 ) );
				d:SetAttacker( self.Entity );
				d:SetDamageType( DMG_CRUSH );
				v:TakeDamageInfo( d );
				
			end
		
		end
		
		if( v:IsPlayer() and v:IsValid() and v:GetPos( ):Distance( self:GetPos( ) ) <= 300 ) then
		
			local dir = v:GetPos() - self:GetPos()
		
			v:SetVelocity(dir * -1.2)
		  
		end
		
	end
	
end
