include('shared.lua')

language.Add("npc_mutant_dog", "Dog")

function ENT:Initialize()	
end

function ENT:Draw()
	self.Entity:DrawModel()
end