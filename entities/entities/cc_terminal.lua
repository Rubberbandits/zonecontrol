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

function ENT:SetupDataTables()
	
--[[ 	self:NetworkVar( "Bool", 0, "StoveOn" );
	self:NetworkVar( "Bool", 1, "Invisible" );
	self:NetworkVar( "Bool", 2, "Broken" );
	self:NetworkVar( "String", 0, "Building" );]]
	self:NetworkVar( "Int", 0, "Deployer" ); 
	
end

function ENT:Initialize()
	
	if( CLIENT ) then return; end
	
	self:SetUseType( SIMPLE_USE );
	
--[[ 	self:SetStoveOn( false );
	self:SetBroken( false ); ]]
	
	self:SetModel( "models/props_combine/breenconsole.mdl" );
	self:PhysicsInit( SOLID_VPHYSICS );
	self:GetPhysicsObject():EnableMotion( false );
	
end

function ENT:CanPhysgun()
	
	return true;
	
end