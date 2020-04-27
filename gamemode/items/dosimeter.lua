ITEM.Name =  "Dosimeter";
ITEM.Desc =  "One of the many civilian dosimeters that were widely handed out when the world feared nuclear annihilation. Used to track exposure to radiation.";
ITEM.Model =  "models/props_c17/TrapPropeller_Lever.mdl";
ITEM.Weight =  0.1;
ITEM.FOV =  12;
ITEM.CamPos =  Vector( 50, 50, 50 );
ITEM.LookAt =  Vector( 0, 0, 0 );
ITEM.BulkPrice =  1000;
ITEM.License =  LICENSE_BLACK;
ITEM.Vars = {
	Activated = false,
	Radiation = 0,
}
ITEM.functions = {}
ITEM.functions.Activate = {
	SelectionName = "Activate",
	OnUse = function(item)

		item:SetVar("Activated", true)
		
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