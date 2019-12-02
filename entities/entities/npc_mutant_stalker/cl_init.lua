include('shared.lua')

language.Add("npc_mutant_bloodsucker", "Bloodsucker")

function ENT:Initialize()	
end

function ENT:Draw()
	self.Entity:DrawModel()
end