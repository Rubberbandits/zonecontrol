include('shared.lua')

language.Add("npc_mutant_snork", "Snork")

function ENT:Initialize()	
end

function ENT:Draw()
	self.Entity:DrawModel()
end