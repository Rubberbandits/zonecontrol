ITEM.Name =  "Dosimeter";
ITEM.Desc =  "One of the many civilian dosimeters that were widely handed out when the world feared nuclear annihilation. Used to track exposure to radiation.";
ITEM.Model =  "models/props_c17/TrapPropeller_Lever.mdl";
ITEM.Weight =  0.1;
ITEM.FOV =  12;
ITEM.CamPos =  Vector( 50, 50, 50 );
ITEM.LookAt =  Vector( 0, 0, 0 );
ITEM.BulkPrice =  1000;
ITEM.License =  LICENSE_BLACK;
ITEM.Stackable = true
ITEM.Vars = {
	Activated = false,
	Radiation = 0,
	Stacked = 1,
}
ITEM.functions = {}
ITEM.functions.Activate = {
	SelectionName = "Activate",
	OnUse = function(item)
		
		if item:GetVar("Stacked", 0) > 1 then
			if SERVER then
				item:Owner():GiveItem(item.Class, {
					Activated = true,
				})
			end
			
			item:SetVar("Stacked", item:GetVar("Stacked", 0) - 1)
		else
			item:SetVar("Activated", true)
		end
		
		return true
	end,
	CanRun = function(item)
		return !item:GetVar("Activated", false)
	end,
}
ITEM.functions.View = {
	SelectionName = "View",
	OnUse = function(item)	
		if CLIENT then
			GAMEMODE.ReadingDosimeter = item
			CCP.PlayerMenu:Close()
		end
		
		return true
	end,
	CanRun = function(item)
		return item:GetVar("Activated", false)
	end,
}

function ITEM:GetName()
	local text = "Inactive"
	if self:GetVar("Activated", false) then
		text = "Active"
	end
	
	return Format("%s %s", text, self.Name)
end

-- return true here to refresh the inventory
function ITEM:OnStack(item)
	self:SetVar("Stacked", self:GetVar("Stacked", 0) + item:GetVar("Stacked", 0), nil, true)
	item:RemoveItem(true)
	
	return true
end

-- this can be passed a metaitem so dont use funcs
function ITEM:CanStack(item)
	if item.Base == self.Base and self.Class == item.Class and !self.Vars.Activated and !item.Vars.Activated then
		return true
	end
end

function ITEM:GetWeight()
	local meta = GAMEMODE:GetItemByID(self.Class)
	local start_amount = meta.Vars.Stacked
	local start_weight = meta.Weight
	
	return start_weight * (self:GetVar("Stacked", 0) / start_amount)
end

function ITEM:Paint(pnl, w, h)
	if !self:GetVar("Activated", false) then
		surface.SetFont("CombineControl.ChatSmall")
		local amt = self:GetVar("Stacked", 0)
		local tW, tH = surface.GetTextSize(amt)
		
		surface.SetTextColor(Color(100,200,100))
		surface.SetTextPos(w - tW, h - tH)
		surface.DrawText(amt)
	end
end

function ITEM:CanSplitStack(amt)
	if !amt then
		amt = math.Round(self:GetVar("Stacked", 0) / 2)
	end

	return (self:GetVar("Stacked", 0) > 1) and (amt < self:GetVar("Stacked", 0))
end

function ITEM:SplitStack(amt, x, y)
	if !amt then
		amt = math.Round(self:GetVar("Stacked", 0) / 2)
	end
	
	if amt >= self:GetVar("Stacked", 0) then return end

	self:SetVar("Stacked", self:GetVar("Stacked", 0) - amt, false, true)
	
	local item = self:Owner():GiveItem(self.Class, {
		Stacked = amt,
	}, x, y)
end

function ITEM:AddItemToStack(item)
	if item then
		self:OnStack(item)
	else
		local metaitem = GAMEMODE:GetItemByID(self:GetClass())
		self:SetVar("Stacked", self:GetVar("Stacked", 0) + metaitem.Vars.Stacked, nil, true)
	end
end