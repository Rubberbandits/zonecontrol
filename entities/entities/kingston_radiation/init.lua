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
				v:ApplyRadiation(math.Round(calc_amt / 60, 4))
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

local GM = gmod.GetGamemode()

function GM:LoadRadiationZones()
	local data = file.Read("zonecontrol/"..game.GetMap().."/radiation.txt", "DATA")

	if !data or #data == 0 then return end

	local spawns = util.JSONToTable(data)
	if spawns then
		for _,data in ipairs(spawns) do
			local rad = ents.Create("kingston_radiation")
			rad:SetPos(data.Pos)
			rad:SetSourceSize(data.SourceSize)
			rad:SetSourceIntensity(data.SourceIntensity)
			rad:SetZoneSize(data.ZoneSize)
			rad:Spawn()
		end
	end
end

function GM:SaveRadiationZones()
	if !file.IsDir("zonecontrol", "DATA") then
		file.CreateDir("zonecontrol")
	end

	if !file.IsDir("zonecontrol/"..game.GetMap(), "DATA") then
		file.CreateDir("zonecontrol/"..game.GetMap())
	end

	local data = {}
	for _,rad in ipairs(ents.FindByClass("kingston_radiation")) do
		table.insert(
			data,
			{
				Pos = rad:GetPos(),
				SourceSize = rad:GetSourceSize(),
				SourceIntensity = rad:GetSourceIntensity(),
				ZoneSize = rad:GetZoneSize(),
			}
		)
	end

	file.Write("zonecontrol/"..game.GetMap().."/radiation.txt", util.TableToJSON(data))
end

hook.Add("InitPostEntity", "STALKER.LoadRadiationZones", function()
	hook.Run("LoadRadiationZones")
end)

hook.Add("ShutDown", "STALKER.SaveRadiationZones", function()
	hook.Run("SaveRadiationZones")
end)