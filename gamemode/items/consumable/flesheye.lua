ITEM.Name =  "Flesh eye"
ITEM.Desc =  "The enlarged eyeball of a flesh, gouged from a corpse. Levels of radioactive isotopes contained in the eye can be analyzed for scientific purposes and therefore it is always in demand by scientists."
ITEM.Model =  "models/kek1ch/item_flesh_eye.mdl"
ITEM.Weight =  0.4
ITEM.FOV =  12
ITEM.CamPos =  Vector( 50, 50, 50 )
ITEM.LookAt =  Vector( 0, 0, 0 )
ITEM.ConsumeText = "Against your best intuition, you bite a chunk of the eye off and chew it. Your disgust only grows the more it's in your mouth. Eventually, you have to spit it out. Best to just give these to the eggheads."
ITEM.UseText = "Eat"
ITEM.Rarity = 2
ITEM.AllowRandomSpawn = false
ITEM.IsSellable = true
ITEM.Experience = 50
ITEM.BulkPrice = 1250
function ITEM:GetSellPrice()
    return 250
end