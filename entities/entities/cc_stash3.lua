AddCSLuaFile();

ENT.Base = "base_anim";
ENT.Type = "anim";

ENT.PrintName		= "Stash - Wood Crate (Empty)";
ENT.Author			= "Kingston";
ENT.Contact			= "";
ENT.Purpose			= "";
ENT.Instructions	= "";

ENT.Spawnable			= true;
ENT.AdminSpawnable		= true;

	local loot_table = {
		{},
	}

	local loot_offsets = {
		["med_medkit"]	=	{Vector(0, 3, 2), Angle()},
		["med_armykit"]	=	{Vector(0, 3, 2), Angle()},
		["med_scikit"]	=	{Vector(0, 3, 2), Angle()},
		["antirad"]	=	{Vector(0, -3, 2), Angle()},
		["psypills"]	=	{Vector(0, -3, 2), Angle()},
		["radpills"]	=	{Vector(0, 0, 2), Angle()},
		["brick"]	=	{Vector(0, 0, 2), Angle( 0, 90, 0)},
		["anabiotic"] =	{Vector(0, 0, 2), Angle()},
		["antidote"] =	{Vector(0, 0, 2), Angle()},
		["sausage"] =	{Vector(0, 0, 2), Angle()},
		["bread"] =	{Vector(0, 0, 2), Angle()},
		["energydrink"] =	{Vector(0, -5, 4), Angle( 0, 90, 90)},
		["booster"] =	{Vector(5, 0, 3), Angle( 0, 90, 90)},
		["weapon_cc_makarov"] 	= {Vector(0, 0, 7), Angle()},
		["weapon_cc_fort12"] 	= {Vector(0, 0, 7), Angle()},
		["weapon_cc_tt33"] 		= {Vector(0, 0, 7), Angle()},
		["documents1"]			= {Vector(0, 0, 7), Angle()}
	}

function ENT:PostEntityPaste( ply, ent, tab )
	
	GAMEMODE:LogSecurity( ply:SteamID(), "n/a", ply:VisibleRPName(), "Tried to duplicate " .. ent:GetClass() .. "!" );
	ent:Remove();
	
end

function ENT:Initialize()
	
	if( CLIENT ) then return; end
	
	self:SetUseType( SIMPLE_USE );
	
	self:SetModel( "models/z-o-m-b-i-e/st/box/st_box_wood_01.mdl" );
	self:PhysicsInit( SOLID_VPHYSICS );
	self:GetPhysicsObject():EnableMotion( true );
	
	local phys = self:GetPhysicsObject();
	
	if( phys and phys:IsValid() ) then
		
		phys:Wake();
		
	end
	
end

function ENT:CanPhysgun()
	
	return true;
	
end

function ENT:Use( activator, caller, usetype, val )

	if ( self:IsPlayerHolding() ) then return end
	activator:PickupObject( self )

end

function ENT:OnTakeDamage( dmginfo )

	if self.HasOpened then return end
	self:Open();

end

function ENT:Loot()

	local loot = loot_table[math.random(#loot_table)]

	for i = 1, #loot do
		local item = loot[i]
		local offsets = loot_offsets[item]
		
		GAMEMODE:CreatePhysicalItem( item, self:GetPos() + ( self:GetUp() * 5 ) + offsets[1], self:GetAngles() + offsets[2] );
	end
	
	self:Remove()
	
end

local parts = {
	{"models/z-o-m-b-i-e/st/box/part/st_box_wood_01_1.mdl", Vector(0,0,0)},
	{"models/z-o-m-b-i-e/st/box/part/st_box_wood_01_2.mdl", Vector(2,0,0)},
	{"models/z-o-m-b-i-e/st/box/part/st_box_wood_01_3.mdl", Vector(0,2,0)},
	{"models/z-o-m-b-i-e/st/box/part/st_box_wood_01_4.mdl", Vector(-2,0,0)},
	{"models/z-o-m-b-i-e/st/box/part/st_box_wood_01_5.mdl", Vector(0,0,2)},
	{"models/z-o-m-b-i-e/st/box/part/st_box_wood_01_6.mdl", Vector(0,-2,0)},
	{"models/z-o-m-b-i-e/st/box/part/st_box_wood_01_7.mdl", Vector(0,-2,0)},
}

function ENT:Open()

	self:EmitSound( "physics/wood/wood_panel_break1.wav", 75 )
	self.HasOpened = true

	for k,v in next, parts do
		local ent = ents.Create( "prop_physics" )
		ent:SetModel( v[1] )
		ent:SetPos( self:GetPos() + v[2] )
		ent:SetAngles( self:GetAngles() )
		ent:Spawn()
		
		ent.KillTime = CurTime() + 600
		
		ent.Think = function()
		
			if ent.KillTime and ent.KillTime <= CurTime() then

				ent:Remove()
				
			end
		
		end
		hook.Add("Think", ent, ent.Think)
	end
	
	self:Loot()

end