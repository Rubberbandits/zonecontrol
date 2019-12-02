ENT.Type 			= "anim"
ENT.Base 			= "base_anim"

ENT.PrintName		= "Fruit Punch Anomaly"
ENT.Author			= ""
ENT.Contact			= ""
ENT.Category 		= "Kingston"

ENT.Spawnable			= true
ENT.AdminSpawnable		= true

/*---------------------------------------------------------
   Name: Initialize
---------------------------------------------------------*/
function ENT:Initialize()
	
	self.Color = Color( 255, 255, 255, 255 )
	
end

/*---------------------------------------------------------
   Name: DrawPre
---------------------------------------------------------*/
function ENT:Draw()
	
	--self:DrawEntityOutline( 1 )
	self.Entity:DrawModel()
end