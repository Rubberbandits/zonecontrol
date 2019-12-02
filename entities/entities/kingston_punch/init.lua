AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

function ENT:Initialize()

	self.Entity:SetModel( "models/props_junk/watermelon01.mdl" ) 
	//self.Entity:PhysicsInit( SOLID_NONE )     
	self.Entity:SetMoveType( MOVETYPE_NONE )
	self.Entity:SetSolid( SOLID_NONE )
	self.Entity:SetKeyValue("rendercolor", "150 255 150") 
	self.Entity:SetKeyValue("renderamt", "0") 
	self.Entity:SetMaterial("models/props_combine/portalball001_sheet")
	self.Entity:DrawShadow( false )	

    local phys = self.Entity:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
	end
end

function ENT:SpawnFunction( ply, tr )

	if ( !tr.Hit ) then return end
	local SpawnPos = tr.HitPos + tr.HitNormal * 12
	local ent = ents.Create( self.ClassName )
	ent:SetPos( SpawnPos )
	ent:Spawn()
	ent:Activate()
	return ent
end

function ENT:Think()

	if( !self.NextIdleSoundPlay ) then self.NextIdleSoundPlay = CurTime() end
	
	if( self.NextIdleSoundPlay <= CurTime() ) then
	
		self:EmitSound("stalker-kingston/anomaly/buzz_idle.wav", 80, 100, 1);
		self.NextIdleSoundPlay = CurTime() + 5;
		
	end

	for k, v in pairs( ents.FindInSphere( self.Entity:GetPos(), 80 ) ) do	
	
		if( v:IsPlayer() and v:IsValid() and v:GetPos( ):Distance( self:GetPos( ) ) <= 80 ) then

			if( !self.NextSoundPlay ) then self.NextSoundPlay = CurTime() end
			if( self.NextSoundPlay > CurTime() ) then return end
			
			if( math.random( 1, 2 ) == 2 ) then
			
				self:EmitSound("stalker-kingston/anomaly/buzz_hit.wav");
				
			else
			
				self:EmitSound("stalker-kingston/anomaly/bfuzz_hit.wav");
				
			end
			self.NextSoundPlay = CurTime() + 0.5;
			
			local d = DamageInfo();
			d:SetDamage( math.random( 15, 21 ) );
			d:SetAttacker( self.Entity );
			d:SetDamageType( DMG_ACID );
			v:TakeDamageInfo( d );
			
			local ed = EffectData()
			ed:SetOrigin( self.Entity:GetPos() + Vector( 0, 0, 5 ) )
			util.Effect( "dust_burst", ed, true, true )
			
		end	
		
	end
	
end

function ENT:Use( activator, caller, type, value )
end

function ENT:KeyValue( key, value )
end

function ENT:OnTakeDamage( dmginfo )
end

function ENT:StartTouch( entity )
end

function ENT:EndTouch( entity )
end

function ENT:Touch( entity )
end
