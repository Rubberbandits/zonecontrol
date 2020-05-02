AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

function ENT:Initialize()
	self.Entity:SetModel( "models/props_junk/watermelon01.mdl" )     
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

function ENT:Think()
	if !self.LastThink then
		self.LastThink = CurTime()
	end
	
	if self.LastThink <= CurTime() then
		local ents = ents.FindInSphere(self:GetPos(), self:GetZoneSize())
		for k,v in next, ents do
			if !v:IsPlayer() then continue end
			if !v:Alive() then continue end
			
			local dist = v:GetPos():DistToSqr(self:GetPos())
			local intensity = self:GetSourceIntensity()
			local calc_amt = math.Clamp(math.Round((intensity * self:GetSourceSize()^2) / dist, 2), 0, intensity) * v:GetRadiationResistance()
			if calc_amt > 0 then
				v:ApplyRadiation(math.Round(calc_amt / 3600, 4))
			end
		end
		
		self.LastThink = CurTime() + 1
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
