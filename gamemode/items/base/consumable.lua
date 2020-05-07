BASE.W = 1
BASE.H = 1
BASE.Name =  "Consumable Base";
BASE.Desc =  "";
BASE.UseText = ""
BASE.ConsumeText = ""
BASE.Stackable = true
BASE.Vars = {
	Stacked = 1,
}
BASE.functions = {}
BASE.functions.Use = {
	SelectionName = function(item)
		return item.UseText
	end,
	OnUse = function(item)	
		if CLIENT then
			LocalPlayer():Notify(nil, COLOR_NOTIF, item.ConsumeText)
		end
		
		local amount = item:GetVar("Stacked", 0)
		if amount > 1 then
			item:SetVar("Stacked", amount - 1)
		else
			item:RemoveItem()
		end
		
		return true
	end,
	CanRun = function(item)
		return true
	end,
}