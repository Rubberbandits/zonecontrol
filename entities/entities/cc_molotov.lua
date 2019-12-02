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
	
	self:SetModel( "models/props_junk/garbage_glassbottle003a.mdl" );
	self:PhysicsInit( SOLID_VPHYSICS );
	
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON );
	
	self.Damage = 1;
	self.Radius = 2;
	
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
	
	self:Detonate()

end

function ENT:Detonate()
	
	self:EmitSound( "physics/glass/glass_bottle_break" .. math.random( 1, 2 ) .. ".wav" );
	self:EmitSound( "ambient/fire/ignite.wav" );
	self:MakeFire();
	
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
	self:Explode( tr );
	self:Remove();
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
	explo:SetKeyValue( "spawnflags", 256 );
	explo:SetKeyValue( "iMagnitude", self.Damage );
	explo:SetKeyValue( "iRadiusOverride", self.Radius );
	explo:Spawn();
	explo:Activate();
	explo:Fire( "Explode" );
	explo:EmitSound( "ambient/fire/ignite.wav", 400, 400 )
	
end

function ENT:MakeFire()
	
	for i = 1, 15 do
		
		local a = math.Rand( 0, 2 * math.pi );
		local s = math.sin( a );
		local c = math.cos( a );
		local r = math.random( 0, 256 );
		
		local x = c * r;
		local y = s * r;
		
		local trace = { };
		trace.start = self:GetPos();
		trace.endpos = trace.start + Vector( x, y, 48 );
		trace.filter = self;
		local tr = util.TraceLine( trace );
		
		if( !tr.Hit ) then
			
			local trace = { };
			trace.start = tr.HitPos;
			trace.endpos = trace.start + Vector( 0, 0, -32768 );
			trace.filter = self;
			tr = util.TraceLine( trace );
			
		end
		
		local del = math.Rand( 0, 1 );

	CreateVFireBall(math.Rand( 1, 5 ), math.Rand( 50, 150), tr.HitPos, Vector(0, 50, 0), Entity(1));
	
	end
	
end

function ENT:CanPhysgun()
	
	return false;
	
end
