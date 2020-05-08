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
ITEM.W = 2
ITEM.H = 1
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
			GAMEMODE.Inventory:Close()
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

-- this can be passed a metaitem so dont use funcs
function ITEM:CanStack(item)
	if item.Base == self.Base and self.Class == item.Class and !self.Vars.Activated and !item.Vars.Activated then
		return true
	end
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