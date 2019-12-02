include('shared.lua')

language.Add("npc_mutant_chimera", "Chimera")

function ENT:Initialize()	
end

function ENT:Draw()
	self.Entity:DrawModel()
end