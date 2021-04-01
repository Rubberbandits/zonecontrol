ITEM.Name =  "Geiger Counter";
ITEM.Desc =  "An old geiger counter, seems to work well enough if not entirely accurate.";
ITEM.Model =  "models/kali/miscstuff/stalker/sensor_a.mdl";
ITEM.Weight =  0.5;
ITEM.FOV 			= 20;
ITEM.CamPos 		= Vector( -4.93, -0.06, 22.74 );
ITEM.LookAt 		= Vector( 1.67, 0, -8.4 );
ITEM.BulkPrice =  1000;
ITEM.License =  "X";
ITEM.W = 1
ITEM.H = 2
ITEM.functions = {}
ITEM.functions.Equip = {
	SelectionName = "Equip",
	OnUse = function(item)	
		if CLIENT then
			GAMEMODE.GeigerCounterEquipped = true
		end
		
		item:SetVar("Equipped", true)
		
		return true
	end,
	CanRun = function(item)
		return !item:GetVar("Equipped", false)
	end,
}
ITEM.functions.Unequip = {
	SelectionName = "Unequip",
	OnUse = function(item)	
		if CLIENT then
			GAMEMODE.GeigerCounterEquipped = false
		end
		
		item:SetVar("Equipped", false)
		
		return true
	end,
	CanRun = function(item)
		return item:GetVar("Equipped", false)
	end,
}

function ITEM:Initialize()
	if self:GetVar("Equipped", false) then
		self.functions["Equip"].OnUse(self)
	end
end

function ITEM:CanDrop()
	return !self:GetVar( "Equipped", false );
end

function ITEM:OnUnloadItem()
	GAMEMODE.GeigerCounterEquipped = false
end

function ITEM:QuickUse()
	if self:GetVar("Equipped", false) then
		self:CallFunction("Unequip", true)
	else
		self:CallFunction("Equip", true)
	end
end