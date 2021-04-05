
ITEM.Name =  "Energy Drink";
ITEM.Desc =  "Canned energy drink. One of many things that keep a stalker awake during the night.";
ITEM.Model =  "models/stalker/item/food/drink.mdl";
ITEM.Weight =  0.33;
ITEM.FOV =  6;
ITEM.CamPos =  Vector( 50, 50, 50 );
ITEM.LookAt =  Vector( 0, 0, 3 );
ITEM.PhysicalMass	= 1;
ITEM.BulkPrice =  500;
ITEM.License =  "X";
ITEM.ConsumeText = "The energy drink has a sugary, acidic taste. It doesn't feel like battery acid, but it does taste like it. Zing!"
ITEM.UseText = "Drink"
ITEM.HungerReduce = 15
ITEM.DrugType = "ENERGYDRINK"

GM:CreateDrugType("ENERGYDRINK", {
	Duration = 120,
	Hooks = {
		GetPlayerSpeeds = function(ply, w, r, j, c)
			if ply:HasDrug("ENERGYDRINK") then
				return r * 1.2
			end
		end,
		PlayerDrugApplied = function(ply, drug)
			if drug == "ENERGYDRINK" then
				hook.Run("SpeedThink", ply)
			end
		end,
		PlayerDrugRemoved = function(ply, drug)
			if drug == "ENERGYDRINK" then
				hook.Run("SpeedThink", ply)
			end
		end,
	},
})