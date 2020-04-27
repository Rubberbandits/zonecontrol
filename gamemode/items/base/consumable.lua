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

-- return true here to refresh the inventory
function BASE:OnStack(item)
	self:SetVar("Stacked", self:GetVar("Stacked", 0) + item:GetVar("Stacked", 0))
	item:RemoveItem()
	
	if CLIENT then
		self:Owner():Notify(nil, COLOR_NOTIF, "You stacked the two items together.")
	end
	
	return true
end

function BASE:CanStack(item)
	if item.Base == self.Base and self.Class == item.Class then
		return true
	end
end

function BASE:GetWeight()
	local meta = GAMEMODE:GetItemByID(self.Class)
	local start_amount = meta.Vars.Stacked
	local start_weight = meta.Weight
	
	return math.Round(start_weight * (self:GetVar("Stacked", 0) / start_amount), 2)
end

function BASE:Paint(pnl, w, h)
	surface.SetFont("CombineControl.ChatSmall")
	local amt = self:GetVar("Stacked", 0)
	local tW, tH = surface.GetTextSize(amt)
	
	surface.SetTextColor(Color(100,200,100))
	surface.SetTextPos(w - tW, h - tH)
	surface.DrawText(amt)
end

function BASE:CanSplitStack(amt)
	if !amt then
		amt = math.Round(self:GetVar("Stacked", 0) / 2)
	end

	return (self:GetVar("Stacked", 0) > 1) and (amt < self:GetVar("Stacked", 0))
end

function BASE:SplitStack(amt)
	if !amt then
		amt = math.Round(self:GetVar("Stacked", 0) / 2)
	end
	
	if amt >= self:GetVar("Stacked", 0) then return end

	self:SetVar("Stacked", self:GetVar("Stacked", 0) - amt, false, true)
	
	local item = self:Owner():GiveItem(self.Class, {
		Stacked = amt,
	})
end