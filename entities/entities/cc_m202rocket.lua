AddCSLuaFile();

ENT.Base = "base_anim";
ENT.Type = "anim";

ENT.PrintName		= "";
ENT.Author			= "";
ENT.Contact			= "";
ENT.Purpose			= "";
ENT.Instructions	= "";

ENT.Spawnable			= false;
ENT.AdminSpawnable		= false;

function ENT:PostEntityPaste( ply, ent, tab )
	
	GAMEMODE:LogSecurity( ply:SteamID(), "n/a", ply:VisibleRPName(), "Tried to duplicate " .. ent:GetClass() .. "!" );
	ent:Remove();
	
end

function ENT:Initialize()
	
	if( CLIENT ) then return; end
	
	self:SetModel( "models/weapons/w_missile_launch.mdl" );
	self:PhysicsInit( SOLID_VPHYSICS );
	
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON );
	
	self.Damage = 150;
	self.Radius = 250;
	
	local phys = self:GetPhysicsObject();
	
	if( phys and phys:IsValid() ) then
		
		phys:Wake();
		
	end
	
end

function ENT:OnTakeDamage( dmginfo )

	if self.HasExploded then return end
	self:Detonate();
	
end

function ENT:PhysicsCollide( data, phys )
	
	if self.HasExploded then return end
	if( data.HitEntity and data.HitEntity:IsValid() ) then
		
		if( data.HitEntity:GetClass() == "func_breakable" or data.HitEntity:GetClass() == "func_breakable_surf" ) then
			
			data.HitEntity:Fire( "Break" );
			data.HitEntity.Broken = true;
			phys:SetVelocity( data.OurOldVelocity );
			return;
			
		end
		
		if( data.HitEntity.Broken ) then return end
		
	end
	
	self:Detonate();
end

function ENT:Detonate()
	
	self:NextThink( CurTime() + 1 );
	
	self:EmitSound( "ambient/explosions/explode_9.wav" );
	self:EmitSound( "ambient/fire/ignite.wav" );
	self:MakeM202Fire();
	
end

function ENT:Explode( tr )
	
	self.HasExploded = true
	if( tr.Fraction != 1.0 ) then
		
		self:SetPos( tr.HitPos + tr.Normal * 0.6 );
		
	end
	
	util.ScreenShake( self:GetPos(), 25, 150, 1, 750 );
	
	local explo = ents.Create( "env_explosion" );
	explo:SetOwner( self.Thrower );
	explo:SetPos( self:GetPos() );
	explo:SetKeyValue( "iMagnitude", self.Damage );
	explo:SetKeyValue( "iRadiusOverride", self.Radius );
	explo:Spawn();
	explo:Activate();
	explo:Fire( "Explode" );

	CreateVFireBall( 1000, 1000, ( tr.HitPos + Vector(0, 0, 65) ), Vector(0, 50, 500), Entity(1));
	
	self:Remove();
	
end

function ENT:MakeM202Fire()
	
	self:NextThink( CurTime() + 1 );
	
	local spot = self:GetPos() + Vector( 0, 0, 8 );
	
	local trace = { };
	trace.start = self:GetPos();
	trace.endpos = spot + Vector( 0, 0, -32 );
	trace.filter = self;
	
	local tr = util.TraceLine( trace );
	
	if( tr.StartSolid ) then
		
		local trace = { };
		trace.start = self:GetPos();
		trace.endpos = self:GetPos() + Vector( 0, 0, -32 );
		trace.filter = self;
		
		tr = util.TraceLine( trace );
		
	end
	
	self:Explode(tr);
	
end

function ENT:CanPhysgun()
	
	return false;
	
end
