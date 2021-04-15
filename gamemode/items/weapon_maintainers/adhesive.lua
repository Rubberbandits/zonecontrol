ITEM.Name =  "Adhesive";
ITEM.Desc =  "A bottle of glue to stick things together.";
ITEM.Model =  "models/props_junk/garbage_plasticbottle001a.mdl";
ITEM.Weight =  0.33;
ITEM.FOV =  14;
ITEM.CamPos =  Vector( 50, 50, 50 );
ITEM.LookAt =  Vector( 0, 0, 0 );
ITEM.BulkPrice =  500   ;
ITEM.License =  "TX"
ITEM.RaiseCondition = 5
function ITEM:DynamicFunctions()
    return {
        eat = {
            CanRun = function()
                return true
            end,
            SelectionName = "eat",
            ConsumeOnUse = true,
            OnUse = function(item)
                if CLIENT then
                    LocalPlayer():Notify(nil, COLOR_NOTIF, "After a moment of struggle, you force the childproof lid off and dribble the liquid glue into your mouth. Are you okay?")
                else
                    item:Owner():SetHunger(item:Owner():Hunger() - 5)
                end
                return true
            end
        }
    }
end