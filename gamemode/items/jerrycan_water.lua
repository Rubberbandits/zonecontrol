
ITEM.Name =  "Jerry-Can of Water";
ITEM.Desc =  "A can filled with drinking water.";
ITEM.Model =  "models/z-o-m-b-i-e/st/balon/st_kanistra_01.mdl";
ITEM.Weight =  20;
ITEM.FOV =  20;
ITEM.CamPos =  Vector( 50, 50, 50 );
ITEM.LookAt =  Vector( 0, 0, 12 );
ITEM.BulkPrice =  10000;
ITEM.functions = {}
ITEM.functions.unpack = {
    SelectionName = "Portion",
    RemoveOnUse = true,
    CanRun = function(item)
        return true
    end,
    OnUse = function(item)
        if CLIENT then
            LocalPlayer():Notify(nil, COLOR_NOTIF, "You open the jerry can and begin carefully pouring portions into empty plastic bottles.")
        else
            item:Owner():GiveItem("cleanwater", {Stacked = 40})
        end

        return true
    end,
}