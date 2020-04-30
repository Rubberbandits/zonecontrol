include('shared.lua')

language.Add("npc_mutant_pseudogiant", "Pseudogiant")

function ENT:Initialize()	
end

function ENT:Draw()	
	self.Entity:DrawModel()
end