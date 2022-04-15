BASE.Vars = {
	Torn = false,
}
BASE.W = 1
BASE.H = 1
BASE.functions = {};
BASE.functions.Wear = {
	RemoveOnUse = true,
	SelectionName = "wear",
	OnUse = function(item)
		for _, otherItem in pairs(item:Owner().Inventory)
			if otherItem.Base == "clothes" and otherItem:GetVar("Equipped", false) then
				otherItem:SetVar("Patch", item:GetClass())

				break
			end
		end
		
		return true
	end,
	CanRun = function(item)
		return !item:GetVar("Torn")
	end,
}