ITEM.Name =  "Blind dog tail"
ITEM.Desc =  "The tail of a mutated mutt, chopped clean from the base. Makes for a less-than-impressive trophy."
ITEM.Model =  "models/dogtail.mdl"
ITEM.Weight =  0.2
ITEM.FOV =  15
ITEM.CamPos =  Vector( 51, 51, 51 )
ITEM.LookAt =  Vector( 0, 0, 0 )
ITEM.W = 1
ITEM.H = 1
ITEM.Rarity = 2
ITEM.AllowRandomSpawn = false
ITEM.BulkPrice = 1250
ITEM.IsSellable = true
ITEM.Experience = 50
function ITEM:GetSellPrice()
	return 250
end