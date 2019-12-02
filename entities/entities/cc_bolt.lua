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
	
	self:SetModel( "models/kali/miscstuff/stalker/bolt.mdl" );
	self:PhysicsInit( SOLID_VPHYSICS );
	
	self:SetCollisionGroup( COLLISION_GROUP_PASSABLE_DOOR );
	
	self.Damage = 0;
	self.Radius = 0;
	
	local phys = self:GetPhysicsObject();
	
	if( phys and phys:IsValid() ) then
		
		phys:Wake();
		phys:SetDragCoefficient( 80 )
		phys:SetMaterial( "brakingrubbertire" )
		
	end
	
		self.KillTime = CurTime() + 5
		
		self.Think = function()
		
			if self.KillTime and self.KillTime <= CurTime() then

				self:Remove()
				
			end
		
		end
		hook.Add("Think", self, self.Think)
	end

function ENT:CanPhysgun()
	
	return false;
	
end
