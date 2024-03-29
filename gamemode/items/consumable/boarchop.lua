ITEM.Name =  "Boar chop"
ITEM.Desc =  "A hearty hunk of fatty meat cut from the carcass of a boar. Slightly irradiated, but not especially dangerous to consume, other than the worms."
ITEM.Model =  "models/kek1ch/raw_dog.mdl"
ITEM.Weight =  1
ITEM.FOV =  12
ITEM.CamPos =  Vector( 50, 50, 50 )
ITEM.LookAt =  Vector( 0, 0, 0 )
ITEM.ConsumeText = "You take a big, hungry bite out of the hunk of meat. It's chewy and hard to get down, but it's packed with deliciously meaty protein and fills you up nicely. You understand why this meat is rarely eaten, however; ingesting the highly irradiated flesh makes you extremely sick."
ITEM.UseText = "Eat"
ITEM.HungerReduce = 50
ITEM.RadiationHealAmount = -25
ITEM.Rarity = 2
ITEM.AllowRandomSpawn = false
ITEM.BulkPrice = 1250
ITEM.IsSellable = true
function ITEM:GetSellPrice()
    return 250
end