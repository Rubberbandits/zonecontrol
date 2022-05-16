ITEM.Name =  "Coffee Beans"
ITEM.Desc =  "A box of coffee beans - rare to find these days. Boil some water and add these."
ITEM.Model =  "models/kek1ch/dev_caffeine.mdl"
ITEM.Weight =  0.5
ITEM.FOV =  9
ITEM.CamPos =  Vector( 50, 50, 50 )
ITEM.LookAt =  Vector( 0, 0, -1.26 )
ITEM.BulkPrice =  5
ITEM.License =  "F"
ITEM.W = 1
ITEM.H = 2
ITEM.ConsumeText = "You take a couple coffee beans and pop them in your mouth. The strong coffee flavor lingers in your mouth as you chew. An unconventional snack, these would be great with some chocolate."
ITEM.UseText = "Eat"
ITEM.HungerReduce = 1
ITEM.Rarity = 1
ITEM.AllowRandomSpawn = true
function ITEM:DynamicFunctions()
    return {
        eat = {
            CanRun = function()
                return true
            end,
            SelectionName = "make coffee",
            OnUse = function(item)
                if CLIENT then
                    LocalPlayer():Notify(nil, COLOR_NOTIF, "Whether you're at a campfire or have the luxury of a stove, you heat up some water for a pour over a la Zone. You grind your coffee beans up with the butt of your gun, layer them over a few folds of paper towel, and begin slowly pouring the hot water into an awaiting pot or vessel. It's far from a perfect process, but your determination to make something good in a shitty place rewards you with enough hot coffee to share with your fellow Stalkers.")
                end

                local amount = item:GetVar("Stacked", 0)
                if amount > 1 then
                    item:SetVar("Stacked", amount - 1)
                else
                    item:RemoveItem()
                end

				if SERVER then
                	item:Owner():GiveItem("coffee_hot", {Stacked = 4})
				end
			end
        }
    }
end
ITEM.Rarity = 2
ITEM.AllowRandomSpawn = true