ITEM.Name =  "Rubles";
ITEM.Desc =  "A bundle of rubles, the common currency.";
ITEM.Model =  "models/props/cs_assault/Dollar.mdl";
ITEM.Weight =  0.001;
ITEM.FOV =  13;
ITEM.CamPos =  Vector( 50, 50, 50 );
ITEM.LookAt =  Vector( 0, 0, 0 );
ITEM.Stackable = true
ITEM.W = 2
ITEM.H = 1
ITEM.Vars = {
	Stacked = 1,
}
ITEM.Rarity = 2
ITEM.AllowRandomSpawn = true
ITEM.functions = {}
BASE.functions.Use = {
	SelectionName = "unwrap",
	OnUse = function(item)	
		local owner = item:Owner()
		local amount = item:GetVar("Stacked", 0)
		item:RemoveItem()

		if SERVER then
			owner:AddMoney(amount)
			owner:UpdateCharacterField( "Money", owner:Money() );
		end
		
		return true
	end,
	CanRun = function(item)
		return true
	end,
}

function item:CanStack(item)
	if self.Stackable and item.Stackable and item.Base == self.Base and self.Class == item.Class then
		if self:GetVar("Stacked", 1) + item:GetVar("Stacked", 1) > 10000 then
			return false
		end

		return true
	end
end

