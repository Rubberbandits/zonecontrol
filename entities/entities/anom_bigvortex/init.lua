
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )

ENT.PreSuck = Sound( "ambient/levels/labs/teleport_mechanism_windup5.wav" )
ENT.SuckExplode = Sound( "weapons/mortar/mortar_explode2.wav" )
ENT.SuckBang = Sound( "ambient/levels/labs/teleport_postblast_thunder1.wav" )

ENT.WaitTime = 3
ENT.SuckTime = 6
ENT.SuckRadius = 3000
ENT.KillRadius = 750

ENT.NPCs = { "npc_zombie_fast", "npc_zombie_poison", "npc_zombie_normal", "npc_rogue" }

function ENT:Initialize()
	
	self.Entity:SetMoveType( MOVETYPE_NONE )
	self.Entity:SetSolid( SOLID_NONE )
	
	self.Entity:SetCollisionGroup( COLLISION_GROUP_DEBRIS_TRIGGER )
	self.Entity:SetTrigger( true )
	self.Entity:SetNotSolid( true )
	self.Entity:DrawShadow( false )	
		
	self.Entity:SetCollisionBounds( Vector( -4800, -4800, -4800 ), Vector( 4800, 4800, 4800 ) )
	self.Entity:PhysicsInitBox( Vector( -4800, -4800, -4800 ), Vector( 4800, 4800, 4800 ) )
	
	self.VortexPos = self.Entity:GetPos() + Vector( 0, 0, 2000 )
	self.NextVortexThink = 0
	
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
	
	if not IsValid( ent ) then return end
	
	if ent:IsPlayer() and not ent:Alive() then return end
	
	if ent:IsPlayer() or string.find( ent:GetClass(), "npc" ) or string.find( ent:GetClass(), "prop_phys" ) then
	
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
	
	if self.VortexTime and self.VortexTime > CurTime() and self.NextVortexThink < CurTime() then
		
		self.NextVortexThink = CurTime() + 0.2
	
		local tbl = ents.FindByClass( "prop_phys*" )
		tbl = table.Add( tbl, ents.FindByClass( "prop_veh*" ) )
		tbl = table.Add( tbl, ents.FindByClass( "npc*" ) )
		tbl = table.Add( tbl, ents.FindByClass( "sent_lootbag" ) )
		tbl = table.Add( tbl, player.GetAll() )
		
		for k,v in pairs( tbl ) do
			
			if v:GetPos():Distance( self.Entity:GetPos() ) < self.SuckRadius then
			
				local vel = ( self.VortexPos - v:GetPos() ):GetNormal()
			
				if ( v:IsPlayer() and v:Alive() ) or table.HasValue( self.NPCs, v:GetClass() ) then
					
					local scale = math.Clamp( ( self.SuckRadius - v:GetPos():Distance( self.VortexPos ) ) / self.SuckRadius, 0.25, 1.00 )
					
					if v:GetPos():Distance( self.VortexPos ) > self.KillRadius then
					
						v:SetVelocity( vel * ( scale * 700 ) )
					
					else
						
						if ( v:IsPlayer() and v:Alive() ) then
						
						elseif table.HasValue( self.NPCs, v:GetClass() ) then
						
							v:DoDeath()
						
						end
					
					end

				else
				
					if v:GetPos():Distance( self.VortexPos ) > self.KillRadius / 2 then
				
						local phys = v:GetPhysicsObject()
						
						if IsValid( phys ) then
						
							phys:ApplyForceCenter( vel * ( phys:GetMass() * 500 ) )
						
						end
						
					elseif not v:IsPlayer() then
					
						v:Remove()
					
					end
				
				end
				
			end
			
		end
			
	elseif self.VortexTime and self.VortexTime < CurTime() then
	
		self.VortexTime = nil
		self.SetOff = nil
		
		self.Entity:EmitSound( self.SuckExplode, 500, math.random(100,120) )
		self.Entity:EmitSound( self.SuckBang, 500, math.random(120,140) )
		
		local ed = EffectData()
		ed:SetOrigin( self.VortexPos )
		util.Effect( "vortex_bigexplode", ed, true, true )
		
		local tbl = ents.FindByClass( "prop_phys*" )
		tbl = table.Add( tbl, ents.FindByClass( "prop_veh*" ) )
		tbl = table.Add( tbl, ents.FindByClass( "npc*" ) )
		tbl = table.Add( tbl, ents.FindByClass( "sent_lootbag" ) )
		tbl = table.Add( tbl, player.GetAll() )
		
		for k,v in pairs( tbl ) do
		
			if v:GetPos():Distance( self.VortexPos ) < self.KillRadius then
			
				if v:IsPlayer() then
				
					if v:Alive() then
				
						local d = DamageInfo();
						d:SetDamage( 75 );
						d:SetAttacker( self );
						d:SetDamageType( DMG_CRUSH );
				
						v:TakeDamageInfo( d );
						
					end
					
				else
				
					v:Remove()
				
				end
			
			end
		
		end
		
		self.Entity:Remove()
	
	end
	
	self.Entity:NextThink( CurTime() )
	
    return true

end
