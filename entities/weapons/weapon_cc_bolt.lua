AddCSLuaFile();

SWEP.Base			= "weapon_cc_base";

SWEP.PrintName 		= "Bolt";
SWEP.Slot 			= 1;
SWEP.SlotPos 		= 15;

SWEP.UseHands		= true;
SWEP.ViewModel 		= "";
SWEP.WorldModel 	= "models/kali/miscstuff/stalker/bolt.mdl";

SWEP.RepositionToHand = true;

SWEP.HoldType = "slam";
SWEP.HoldTypeHolster = "slam";

SWEP.Holsterable = false;

SWEP.AimPos = Vector();
SWEP.AimAng = Vector();

function SWEP:CheckThrowPosition( eye, src )
	
	local trace = { };
	trace.start = eye;
	trace.endpos = src;
	trace.mins = Vector( -4, -4, -4 );
	trace.maxs = Vector( 4, 4, 4 );
	trace.filter = ply;
	local tr = util.TraceHull( trace );
	
	if( tr.Hit ) then
		
		return tr.HitPos;
		
	end
	
	return src;
	
end

function SWEP:PrimaryUnholstered()
	
	if( SERVER ) then
	
		local vecEye = self.Owner:EyePos();
		local vForward = self.Owner:GetForward();
		local vRight = self.Owner:GetRight();
		
		local vecSrc = vecEye + vForward * 20 + vRight * 8;
		
		vecSrc = self:CheckThrowPosition( vecEye, vecSrc );
		vForward.z = vForward.z + 0.1;
		
		local vecThrow = self.Owner:GetVelocity();
		vecThrow = vecThrow + vForward * 1000
		
		local grenade = ents.Create( "cc_bolt" );
		grenade:SetPos( vecSrc - Vector( 0, 0, 15 ) );
		grenade:SetAngles( Angle() );
		grenade:SetVelocity( vecThrow );
		grenade:Spawn();
		grenade:Activate();
		grenade.Thrower = self.Owner;
		
		if( grenade and grenade:IsValid() ) then
			
			local phys = grenade:GetPhysicsObject();
			
			if( phys and phys:IsValid() ) then
				
				phys:SetVelocity( vecThrow );
				phys:AddAngleVelocity( Vector( 600, math.random( -1200, 1200 ), 0 ) );
				
			end
			
		end
		
		self.Redraw = true;
		
	end
	
	self:SetNextPrimaryFire( CurTime() + self:SequenceDuration() + 1 );
	self:SetNextSecondaryFire( CurTime() + self:SequenceDuration() + 1 );
	self.Owner:SetAnimation( PLAYER_ATTACK1 );
	
	self.RemoveTime = CurTime();
	
	self:PlaySound( "WeaponFrag.Throw" );
	
end

--[[ function SWEP:ThinkChild()
	
	if( SERVER ) then
		
		if( self.RemoveTime and CurTime() >= self.RemoveTime ) then
			
			self.RemoveTime = nil;
			self.Owner:RemoveItem( self.Owner:GetInventoryItem( self:GetClass() ) );
			
		end
		
	end
	
end
]]--