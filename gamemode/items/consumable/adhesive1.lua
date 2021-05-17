ITEM.Name =  "Zviezda Glue";
ITEM.Desc =  "A half-empty tube of glue most commonly used for suit and weapon repairs.";
ITEM.Model =  "models/kek1ch/glue_e.mdl";
ITEM.Weight =  0.1;
ITEM.FOV =  9;
ITEM.CamPos =  Vector( 50, 50, 50 );
ITEM.LookAt =  Vector( 0, 0, 0 );
ITEM.BulkPrice =  100
ITEM.License =  "TX"
ITEM.UseText = "Use"
ITEM.RaiseCondition = 2
ITEM.Rarity = 1
ITEM.AllowRandomSpawn = true
function ITEM:DynamicFunctions()
    return {
        eat = {
            CanRun = function()
                return true
            end,
            SelectionName = "eat",
            OnUse = function(item)
                if CLIENT then
                    LocalPlayer():Notify(nil, COLOR_NOTIF, "You squeeze out what perfectly fine, serviceable glue is left in the tube into your mouth and eat it. Freak.")
                else
                    item:Owner():SetHealth(item:Owner():Health() - 5)
                end
			end
        }
    }
end