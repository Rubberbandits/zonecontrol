include('shared.lua')

language.Add("npc_mutant_classiczombie", "Classic Zombie")

function ENT:Initialize()	
end

function ENT:Draw()
	self.Entity:DrawModel()
end