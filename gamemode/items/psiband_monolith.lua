ITEM.Name =  "Monolith Psi-band";
ITEM.Desc =  "A bizarre contraption of copper wiring intended to sheath the user's cranium. It calls you to put it on, that you might then achieve mastery of the zone no other man has before.";
ITEM.Model =  "models/psihelem.mdl";
ITEM.Weight =  .5;
ITEM.FOV =  6;
ITEM.CamPos =  Vector( 50, 50, 50 );
ITEM.LookAt =  Vector( 1, -1, 0 );
ITEM.W = 1
ITEM.H = 2
ITEM.functions = {}
ITEM.functions.Equip = {
	SelectionName = "Equip",
	OnUse = function(self)
		self:SetVar("Equipped", true)
		
		return true
	end,
	CanRun = function(item)
		return !self:GetVar("Equipped", false)
	end,
}
ITEM.functions.Unequip = {
	SelectionName = "Unequip",
	OnUse = function(self)
		self:SetVar("Equipped", false)
		
		return true
	end,
	CanRun = function(item)
		return self:GetVar("Equipped", false)
	end,
}
