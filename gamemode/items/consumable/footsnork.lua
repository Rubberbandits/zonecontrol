ITEM.Name =  "Snork leg"
ITEM.Desc =  "Snork feet and legs contain a huge number of highly elastic tendons. This explains the beast's ability to perform its characteristic long leaps at its prey. Fresh specimens may be of interest to those with scientific pursuits."
ITEM.Model =  "models/lagsnork.mdl"
ITEM.Weight =  0.8
ITEM.FOV =  12
ITEM.CamPos =  Vector( 50, 50, 50 )
ITEM.LookAt =  Vector( 0, 0, 0 )
ITEM.W = 1
ITEM.H = 1
ITEM.ConsumeText = "Your morality is pushed aside for the moment as you sink your teeth into the calf of the snork leg. It's way too chewy and full of sinew to get anything down, but the little bit you can manage to taste makes you think of a leaner boar chop. You're a bit disgusted with yourself for even trying it."
ITEM.UseText = "Eat"
ITEM.HungerReduce = -10
ITEM.RadiationHealAmount = -20
ITEM.Rarity = 3
ITEM.AllowRandomSpawn = false
ITEM.IsSellable = true
ITEM.Experience = 100
ITEM.BulkPrice = 2500
function ITEM:GetSellPrice()
    return 500
end