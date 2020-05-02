ITEM.Name =  "US Dollars";
ITEM.Desc =  "A fistful of dollars. Nobody will accept this around here.";
ITEM.Model =  "models/props/cs_assault/Dollar.mdl";
ITEM.Weight =  0.001;
ITEM.FOV =  13;
ITEM.CamPos =  Vector( 50, 50, 50 );
ITEM.LookAt =  Vector( 0, 0, 0 );
ITEM.BulkPrice =  300;
ITEM.Stackable = true
ITEM.Vars = {
	Stacked = 1,
}

function ITEM:OnStack(item)
	self:SetVar("Stacked", self:GetVar("Stacked", 0) + item:GetVar("Stacked", 0), nil, true)
	item:RemoveItem(true)
	
	return true
end

function ITEM:CanStack(item)
	if item.Base == self.Base and self.Class == item.Class then
		return true
	end
end

function ITEM:GetWeight()
	local meta = GAMEMODE:GetItemByID(self.Class)
	local start_amount = meta.Vars.Stacked or 1
	local start_weight = meta.Weight
	
	return math.Round(start_weight * (self:GetVar("Stacked", 0) / start_amount), 2)
end

function ITEM:Paint(pnl, w, h)
	surface.SetFont("CombineControl.ChatSmall")
	local amt = self:GetVar("Stacked", 0)
	local tW, tH = surface.GetTextSize(amt)
	
	surface.SetTextColor(Color(100,200,100))
	surface.SetTextPos(w - tW, h - tH)
	surface.DrawText(amt)
end

function ITEM:CanSplitStack(amt)
	if !amt then
		amt = math.Round(self:GetVar("Stacked", 0) / 2)
	end

	return (self:GetVar("Stacked", 0) > 1) and (amt < self:GetVar("Stacked", 0))
end

function ITEM:SplitStack(amt)
	if !amt then
		amt = math.Round(self:GetVar("Stacked", 0) / 2)
	end
	
	if amt >= self:GetVar("Stacked", 0) then return end

	self:SetVar("Stacked", self:GetVar("Stacked", 0) - amt, false, true)
	
	local item = self:Owner():GiveItem(self.Class, {
		Stacked = amt,
	})
end

function ITEM:AddItemToStack(item)
	if item then
		self:OnStack(item)
	else
		local metaitem = GAMEMODE:GetItemByID(self:GetClass())
		self:SetVar("Stacked", self:GetVar("Stacked", 0) + metaitem.Vars.Stacked, nil, true)
	end
end