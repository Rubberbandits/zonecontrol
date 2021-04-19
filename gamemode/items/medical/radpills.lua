ITEM.Name =  "Radio-protectant";
ITEM.Desc =  "Two coin-like pills. Intended to be consumed before exposure, as they only partly shield the effects of radiation on live tissue, and have no effect on absorption prior to use.";
ITEM.Model =  "models/stalker/item/medical/rad_pills.mdl";
ITEM.Weight =  .1;
ITEM.FOV =  8;
ITEM.CamPos =  Vector( 50, 50, 50 );
ITEM.LookAt =  Vector( 0, 0, 0 );
ITEM.PhysicalMass	= 1;
ITEM.ConsumeText = "You swallow the pills."
ITEM.UseText = "Swallow"
ITEM.BulkPrice =  2500;
ITEM.License = "D"
ITEM.DrugType = "RADIOPROTECT"

GM:CreateDrugType("RADIOPROTECT", {
	Duration = 300,
	Hooks = {
		GetPlayerRadiationResistance = function(ply, mult)
			if ply:HasDrug("RADIOPROTECT") then
				return 0.75
			end
		end,
	},
})
ITEM.Rarity = 3
ITEM.AllowRandomSpawn = true