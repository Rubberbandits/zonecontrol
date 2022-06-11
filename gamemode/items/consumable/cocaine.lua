ITEM.Name =  "Cocaine"
ITEM.Desc =  "A small baggy of cocaine, perfect for spreading out into several nose-friendly lines. This white powder is a damn luxury to have in the Zone!"
ITEM.Model =  "models/props_lab/box01a.mdl"
ITEM.Weight =  0.1
ITEM.FOV =  7
ITEM.CamPos =  Vector( 50, 50, 50 )
ITEM.LookAt =  Vector( 0, 0, 0 )
ITEM.BulkPrice =  3750
ITEM.ConsumeText = "You pop open the small container of white powder, tugging the grain of snow up into one of your nostrils. You feel a powerful headrush in no time, amped and pumped. You're ready to take on the world!"
ITEM.UseText = "snort"
ITEM.DrugType = "COCAINE"
GM:CreateDrugType("COCAINE", {
	Duration = 600,
	Hooks = {
		GetPlayerSpeeds = function(ply, w, r, j, c)
			if ply:HasDrug("COCAINE") then
				return w, r * 1.3, j, c
			end
		end,
		PlayerDrugApplied = function(ply, drug)
			if drug == "COCAINE" then
				hook.Run("SpeedThink", ply)
			end
		end,
		PlayerDrugRemoved = function(ply, drug)
			if drug == "COCAINE" then
				hook.Run("SpeedThink", ply)
			end
        GetInventoryMaxWeight = function(ply, weight)
            if ply:HasDrug("COCAINE") then
                return weight + 20
            end               
		end,
	},
})