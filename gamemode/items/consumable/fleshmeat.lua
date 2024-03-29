ITEM.Name =  "Fleshmeat"
ITEM.Desc =  "A hearty hunk of fatty meat cut from the carcass of a flesh. Slightly irradiated and dangerous to consume, not to mention the worms."
ITEM.Model =  "models/kek1ch/meat_boar.mdl"
ITEM.Weight =  0.8
ITEM.FOV =  12
ITEM.CamPos =  Vector( 50, 50, 50 )
ITEM.LookAt =  Vector( 0, 0, 0 )
ITEM.ConsumeText = "You take a big, hungry bite out of the hunk of meat. It's chewy and hard to get down, but it's packed with deliciously meaty protein and fills you up nicely. AFter a while, though, your tummy is unsettled; you pay the price for eating irradiated meat, getting pretty sick."
ITEM.UseText = "Eat"
ITEM.HungerReduce = 30
ITEM.RadiationHealAmount = -20
ITEM.Rarity = 2
ITEM.AllowRandomSpawn = false
ITEM.BulkPrice = 1250
ITEM.IsSellable = true
function ITEM:GetSellPrice()
    return 250
end