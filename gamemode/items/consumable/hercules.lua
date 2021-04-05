ITEM.Name =  "Hercules";
ITEM.Desc =  "The main component of this product is an anabolic androgen, an artificial steroid, the chemical composition of which resembles testosterone. Often used by stalkers during long raids to reduce muscle fatigue. Significantly increases weight-carrying capacity. The effects of the drug are long-lasting.";
ITEM.Model =  "models/stalker/item/medical/booster.mdl";
ITEM.Weight =  0.25;
ITEM.FOV =  7;
ITEM.CamPos =  Vector( 50, 50, 50 );
ITEM.LookAt =  Vector( 0, 0, 0 );
ITEM.PhysicalMass	= 1;
ITEM.BulkPrice =  500;
ITEM.License =  "D";
ITEM.ConsumeText = "You take a cautious sip from the bottle despite your best instincts. After a few swigs from the odd concoction, you feel an odd sense of serenity with the Zone. Your senses are dulled but you're full of energy."
ITEM.UseText = "Drink"
ITEM.HungerReduce = 15
ITEM.DrugType = "HERCULES"

GM:CreateDrugType("HERCULES", {
	Duration = 300,
	Hooks = {
		GetInventoryMaxWeight = function(ply, weight)
			if ply:HasDrug("HERCULES") then
				return weight + 20
			end
		end,
	}
})