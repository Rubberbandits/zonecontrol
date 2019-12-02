
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )

ENT.PreSuck = Sound( "ambient/levels/labs/teleport_mechanism_windup5.wav" )
ENT.SuckExplode = Sound( "weapons/mortar/mortar_explode2.wav" )
ENT.SuckBang = Sound( "ambient/levels/labs/teleport_postblast_thunder1.wav" )

ENT.WaitTime = 5
ENT.SuckTime = 5
ENT.SuckRadius = 400
ENT.KillRadius = 200

function ENT:Initialize()
	
	self.Entity:SetMoveType( MOVETYPE_NONE )
	self.Entity:SetSolid( SOLID_NONE )
	
	self.Entity:SetCollisionGroup( COLLISION_GROUP_DEBRIS_TRIGGER )
	self.Entity:SetTrigger( true )
	self.Entity:SetNotSolid( true )
	self.Entity:DrawShadow( false )	
		
	self.Entity:SetCollisionBounds( Vector( -350, -350, -350 ), Vector( 350, 350, 350 ) )
	self.Entity:PhysicsInitBox( Vector( -350, -350, -350 ), Vector( 350, 350, 350 ) )
	
	self.VortexPos = self.Entity:GetPos() + Vector( 0, 0, 150 )
	
end

function ENT:SpawnFunction( ply, tr )
	if ( !tr.Hit ) then return end
	local SpawnPos = tr.HitPos + tr.HitNormal * 16
	local ent = ents.Create( self.ClassName )
	ent:SetPos( SpawnPos )
	ent:Spawn()
	ent:Activate()
	return ent
end

function ENT:Touch( ent ) 
	
	if self.SetOff then return end
	
	if ent:IsPlayer() or string.find( ent:GetClass(), "npc" ) or string.find( ent:GetClass(), "prop_phys" ) or ent:GetClass() == "sent_lootbag" then
	
		self.SetOff = CurTime() + self.WaitTime
		
		self.Entity:EmitSound( self.PreSuck )
		self.Entity:SetNWBool( "Suck", true )
		
	end
	
end 

function ENT:Think()

	if self.SetOff and self.SetOff < CurTime() and not self.VortexTime then
	
		self.VortexTime = CurTime() + self.SuckTime
		self.Entity:SetNWBool( "Suck", false )
	
	end
	
	if self.VortexTime and self.VortexTime > CurTime() then
	
		local tbl = ents.FindByClass( "prop_phys*" )
		tbl = table.Add( tbl, ents.FindByClass( "prop_veh*" ) )
		tbl = table.Add( tbl, ents.FindByClass( "npc*" ) )
		tbl = table.Add( tbl, player.GetAll() )
		
		for k,v in pairs( tbl ) do
			
			if v:GetPos():Distance( self.Entity:GetPos() ) < self.SuckRadius then
			
				local vel = ( self.VortexPos - v:GetPos() ):GetNormal()
			
				if ( v:IsPlayer() and v:Alive() ) or string.find( v:GetClass(), "npc" ) then
					
					local scale = math.Clamp( ( self.SuckRadius - v:GetPos():Distance( self.VortexPos ) ) / self.SuckRadius, 0.2, 1.0 )
					
					if v:GetPos():Distance( self.VortexPos ) > 200 then
						
						v:SetVelocity( vel * ( scale * 300 ) )
					
					else

						if( !v.Thrown ) then
		
							v:SetVelocity( Vector( 0, 0, 100 ) );
							v.Thrown = true;
							
						end
						v:SetLocalVelocity( vel * ( scale * 800 ) )
					
					end

				else
				
					local phys = v:GetPhysicsObject()
					
					if IsValid( phys ) then
					
						phys:ApplyForceCenter( vel * ( phys:GetMass() * 500 ) )
					
					end
				
				end
				
			end
			
		end
			
	elseif self.VortexTime and self.VortexTime < CurTime() then
	
		self.VortexTime = nil
		self.SetOff = nil
		
		self.Entity:EmitSound( self.SuckExplode, 100, math.random(100,120) )
		self.Entity:EmitSound( self.SuckBang, 100, math.random(120,140) )
		
		local ed = EffectData()
		ed:SetOrigin( self.VortexPos )
		util.Effect( "vortex_explode", ed, true, true )
		
		local tbl = ents.FindByClass( "prop_phys*" )
		tbl = table.Add( tbl, ents.FindByClass( "prop_veh*" ) )
		tbl = table.Add( tbl, ents.FindByClass( "npc*" ) )
		tbl = table.Add( tbl, player.GetAll() )
		
		for k,v in pairs( tbl ) do
		
			if v:GetPos():Distance( self.VortexPos ) < self.KillRadius then
			
				if v:IsPlayer() then
				
					if v:Alive() then
				
						local d = DamageInfo();
						d:SetDamage( 50 );
						d:SetAttacker( self );
						d:SetDamageType( DMG_CRUSH );
				
						v:TakeDamageInfo( d );
						
					end
					
				else
				
					v:Remove()
				
				end
			
			end
		
		end
	
	end
	
	self.Entity:NextThink( CurTime() )
	
    return true

end