ITEM.Name =  "Psi-band";
ITEM.Desc =  "Constructed by the Ecologists' top scientists with the intent to protect the user from psi-emissions. In theory, the user's cranium is shielded by a bubble of energised particles released from an electrical artifact. The band can be worn in combination with most other head gear, as its design is rather form fitting.";
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