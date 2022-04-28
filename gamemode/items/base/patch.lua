BASE.Vars = {
	Torn = false,
}
BASE.W = 1
BASE.H = 1
BASE.Experience = 150
BASE.functions = {}
BASE.functions.Wear = {
	RemoveOnUse = true,
	SelectionName = "wear",
	OnUse = function(item)
		for _, otherItem in pairs(item:Owner().Inventory) do
			if otherItem.Base == "clothes" and otherItem:GetVar("Equipped", false) then
				otherItem:SetVar("Patch", item:GetClass())

				break
			end
		end
		
		return true
	end,
	CanRun = function(item)
		local suitEquipped = false
		for k,v in next, item:Owner().Inventory do
			if v == item then continue end
			if v.Base == "clothes" and v:GetVar("Equipped") then
				if v:GetVar("Patch") then
					return false
				end

				suitEquipped = true
			end
		end

		return !item:GetVar("Torn") and suitEquipped
	end,
}