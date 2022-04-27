ITEM.Name =  "Toilet Paper"
ITEM.Desc =  "A slightly dirty, slightly damp roll of thin-as-shit service station toilet paper. The preferred alternative to leaves and rawdogging it."
ITEM.Model =  "models/props_interiors/toiletpaperdispenser_residential.mdl"  
ITEM.Weight =  0.1;
ITEM.FOV =  13;
ITEM.CamPos =  Vector( 50, 50, 50 );
ITEM.LookAt =  Vector( 0, 0, 0 );
ITEM.BulkPrice =  100
ITEM.License =  "X";
ITEM.ConsumeText = "Whether you're bunching it up to pack a wound, struggling to carve into it with a pencil for note taking, or temporarily alleviating your chronic swamp ass, the toilet paper roll is put to good use."
ITEM.UseText = "Use"

function ITEM:DynamicFunctions()
    return {
        eat = {
            CanRun = function()
                return true
            end,
            SelectionName = "eat",
            OnUse = function(item)
                if CLIENT then
                    LocalPlayer():Notify(nil, COLOR_NOTIF, "Something in your brain clicks when you set eyes on the valuable roll of asswipe. Without hesitation, and with animalistic vigor, you begin filling your mouth with seemingly endless lines of toilet paper. As you attempt to regurgitate them from your mouth the way a clown does with colorful handkerchiefs, you instead spit a sad plop of damp, slobbery tissue back into your hands.")
                end
                    item:RemoveItem()
            end
        }
    }
end
ITEM.Stackable = false
ITEM.Rarity = 1
ITEM.AllowRandomSpawn = true