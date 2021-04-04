
ITEM.Name =  "Cigarettes";
ITEM.Desc =  "A single cigarette.";
ITEM.Model =  "models/props_lab/box01a.mdl";
ITEM.Weight =  1;
ITEM.FOV =  7;
ITEM.CamPos =  Vector( 50, 50, 50 );
ITEM.LookAt =  Vector( 0, 0, 0.18 );
ITEM.ConsumeText = "You light and smoke a cigarette. You feel more relaxed at the expense of your lungs."
ITEM.UseText = "Smoke"
ITEM.RadiationHealAmount = 5
ITEM.HungerReduce = -5

function ITEM:DynamicFunctions()
    return {
        eat = {
            CanRun = function()
                return true
            end,
            SelectionName = "eat",
            OnUse = function(item)
                if CLIENT then
                    LocalPlayer():Notify(nil, COLOR_NOTIF, "Subconsciously, as you put the cigarette in your mouth to smoke, you instead begin to chew. Gulp. Smoky.")
                else
                    item:Owner():SetHealth(item:Owner():Health() - 5)
                end

                local amount = item:GetVar("Stacked", 0)
                if amount > 1 then
                    item:SetVar("Stacked", amount - 1)
                else
                    item:RemoveItem()
                end
            end
        }
    }
end