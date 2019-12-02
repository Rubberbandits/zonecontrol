include('shared.lua')


function ENT:Initialize()
	self.RealModel = "models/GSC/S.T.A.L.K.E.R/Monsters/Burer.mdl"
	
	self.Shield = ClientsideModel( "models/maxofs2d/hover_rings.mdl", RENDERGROUP_OTHER )
	self.Shield:SetMaterial("models/shadertest/predator")
	self.Shield:SetModelScale(5)
	self.Shield:SetPos(self:GetPos()+Vector(0,0,30))
	self.Shield:SetAngles(self:GetAngles())
	self.Shield:SetNoDraw(true)
end

function ENT:Draw()
	self:DrawModel()
	
	if(self:GetSequence()==self:LookupSequence("S_Shield_Idle")) then
		if(IsValid(self.Shield)) then
			self.Shield:SetNoDraw(false)
			self.Shield:SetPos(self:GetPos()+(self:GetForward()*-10)+Vector(0,0,30))
			self.Shield:SetAngles(self:GetAngles())
			self.Shield:DrawModel()
			self.Shield:SetNoDraw(true)
		end
	end
end

function ENT:OnRemove()
	if(IsValid(self.Shield)) then
		self.Shield:Remove()
	end
end