ITEM.Name =  "Tea Leaves"
ITEM.Desc =  "A box of tea leaves. Boil some water and add these."
ITEM.Model =  "models/props_lab/box01a.mdl"
ITEM.Weight =  0.5
ITEM.FOV =  9
ITEM.CamPos =  Vector( 50, 50, 50 )
ITEM.LookAt =  Vector( 0, 0, -1.26 )
ITEM.BulkPrice =  30
ITEM.License =  "F"
ITEM.W = 1
ITEM.H = 1
ITEM.Rarity = 1
ITEM.AllowRandomSpawn = true
ITEM.IsSellable = true
ITEM.UseText = "eat"
ITEM.ConsumeText = "For whatever reason, instead of soaking these in hot water like a normal person would, you kind of just cram the bags into your mouth and let your saliva steep them. Tastes like grass."
function ITEM:DynamicFunctions()
    return {
        eat = {
            CanRun = function()
                return true
            end,
            SelectionName = "make tea",
            OnUse = function(item)
                if CLIENT then
                    LocalPlayer():Notify(nil, COLOR_NOTIF, "Whether you're at a campfire or have the luxury of a stove, you heat up some water and add the entire box of tea bags into it. After steeping them for a while, you carefully pour up a few mugs of tea. Whether you keep them in thermoses or share them with some friends, the hot drink is another reminder of life's tiny treasures.")
                end

                local amount = item:GetVar("Stacked", 0)
                if amount > 1 then
                    item:SetVar("Stacked", amount - 1)
                else
                    item:RemoveItem()
                end

				if SERVER then
                	item:Owner():GiveItem("tea_hot", {Stacked = 4})
				end
            end
        }
    }
end
ITEM.Rarity = 2
ITEM.AllowRandomSpawn = true