ENT.Type 			= "anim"
ENT.Base 			= "base_anim"

ENT.PrintName		= "Radiation"
ENT.Author			= ""
ENT.Contact			= ""
ENT.Category 		= "Kingston"

ENT.Spawnable			= false
ENT.AdminSpawnable		= false

/*---------------------------------------------------------
   Name: Initialize
---------------------------------------------------------*/
function ENT:Initialize()
	
	self.Color = Color( 255, 255, 255, 255 )
	
end

function ENT:SetupDataTables()
	self:NetworkVar( "Float", 0, "SourceSize" )
	self:NetworkVar( "Float", 1, "SourceIntensity" )
	self:NetworkVar( "Float", 2, "ZoneSize" )
	
	if SERVER then
		self:SetSourceSize(10)
		self:SetSourceIntensity(100)
		self:SetZoneSize(256)
	end
end

/*---------------------------------------------------------
   Name: DrawPre
---------------------------------------------------------*/
function ENT:Draw()
	
	--self:DrawEntityOutline( 1 )
	self.Entity:DrawModel()
end