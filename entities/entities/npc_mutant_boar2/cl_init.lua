include('shared.lua')

language.Add("npc_mutant_boar", "Boar")

function ENT:Initialize()	
end

function ENT:Draw()
	self.Entity:DrawModel()
end