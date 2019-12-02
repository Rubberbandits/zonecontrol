
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )

ENT.Damage = 1
ENT.Blast = Sound( "physics/nearmiss/whoosh_huge2.wav" )
ENT.Blast2 = Sound( "ambient/levels/citadel/portal_beam_shoot5.wav" )

function ENT:Initialize()
	
	self.Entity:SetMoveType( MOVETYPE_NONE )
	self.Entity:SetSolid( SOLID_NONE )
	
	self.Entity:SetCollisionGroup( COLLISION_GROUP_DEBRIS_TRIGGER )
	self.Entity:SetTrigger( true )
	self.Entity:SetNotSolid( true )
	self.Entity:DrawShadow( false )	
		
	self.Entity:SetCollisionBounds( Vector( -50, -50, -50 ), Vector( 50, 50, 50 ) )
	self.Entity:PhysicsInitBox( Vector( -50, -50, -50 ), Vector( 50, 50, 50 ) )
		
	self.LastHit = 0
	
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

function ENT:GetRadiationRadius()

	return 100

end

function ENT:Think()

	if self.BounceTime and self.BounceTime < CurTime() then
	
		self.BounceTime = nil
		
		local tbl = player.GetAll()
		tbl = table.Add( tbl, ents.FindByClass( "prop_phys*" ) ) 
		tbl = table.Add( tbl, ents.FindByClass( "prop_veh*" ) )
		tbl = table.Add( tbl, ents.FindByClass( "npc*" ) )
		
		local ed = EffectData()
		ed:SetOrigin( self.Entity:GetPos() + Vector( 0, 0, 5 ) )
		util.Effect( "dust_burst", ed, true, true )
		
		self.Entity:EmitSound( self.Blast2, 100, 70 )
		
		for k,ent in pairs( tbl ) do
		
			if ent:GetPos():Distance( self.Entity:GetPos() ) < 100 then
		
				if ent:IsPlayer() then
				
					local dir = ( ent:GetPos() - self.Entity:GetPos()  ):GetNormal()
					
					ent:SetVelocity( dir * 2000 )
					ent:TakeDamage( self.Damage )
				
				elseif string.find( ent:GetClass(), "npc" ) then
				
					ent:TakeDamage( self.Damage )
					
				elseif string.find( ent:GetClass(), "prop" ) then
				
					local phys = ent:GetPhysicsObject()
					
					if IsValid( phys ) then
				
						local dir = ( self.Entity:GetPos() - ent:GetPos() ):GetNormal()
					
						phys:ApplyForceCenter( dir * phys:GetMass() * 500 )
							
					end
					
				end
				
			end
		
		end
	
	end

end

function ENT:Touch( ent ) 

	if self.LastHit > CurTime() then return end
	
	self.LastHit = CurTime() + 2
	self.BounceTime = CurTime() + 0.5
	
	self.Entity:EmitSound( self.Blast, 150, 150 )
	
end 
