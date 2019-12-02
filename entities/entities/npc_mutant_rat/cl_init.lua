include('shared.lua')

language.Add("npc_mutant_rodent", "Rodent")

function ENT:Initialize()	
end

function ENT:Draw()
	self.Entity:DrawModel()
end