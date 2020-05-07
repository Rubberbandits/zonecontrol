-- this is mostly for identification purposes.
BASE.W = 2
BASE.H = 1
BASE.Stackable = true
BASE.Vars = {
	Amount = 30,
}

function BASE:GetDesc()
	local amt = self:GetVar("Amount", 0)
	return Format(self.Desc, amt)
end

-- return true here to refresh the inventory
function BASE:OnStack(item)
	self:SetVar("Amount", self:GetVar("Amount", 0) + item:GetVar("Amount", 0), nil, true)
	item:RemoveItem(true)
	
	return true
end

function BASE:GetWeight()
	local meta = GAMEMODE:GetItemByID(self.Class)
	local start_amount = meta.Vars.Amount
	local start_weight = meta.Weight
	
	return math.Round(start_weight * (self:GetVar("Amount", 0) / start_amount), 2)
end

function BASE:Paint(pnl, w, h)
	surface.SetFont("CombineControl.ChatSmall")
	local amt = self:GetVar("Amount", 0)
	local tW, tH = surface.GetTextSize(amt)
	
	surface.SetTextColor(Color(100,200,100))
	surface.SetTextPos(w - tW, h - tH)
	surface.DrawText(amt)
end

function BASE:CanSplitStack(amt)
	if !amt then
		amt = math.Round(self:GetVar("Amount", 0) / 2)
	end

	return (amt > 0 and self:GetVar("Amount", 0) > 1) and (amt < self:GetVar("Amount", 0))
end

function BASE:SplitStack(amt, x, y)
	if !amt then
		amt = math.Round(self:GetVar("Amount", 0) / 2)
	end
	
	if amt >= self:GetVar("Amount", 0) then return end
	
	self:SetVar("Amount", self:GetVar("Amount", 0) - amt, false, true)
	
	local item = self:Owner():GiveItem(self.Class, {
		Amount = amt,
	}, x, y)
end

function BASE:AddItemToStack(item)
	if item then
		self:OnStack(item)
	else
		local metaitem = GAMEMODE:GetItemByID(self:GetClass())
		self:SetVar("Amount", self:GetVar("Amount", 0) + metaitem.Vars.Amount, nil, true)
	end
end