ITEM.Name =  "Morley Reds"
ITEM.Desc =  "A pack of cigarettes from the west with a stark red label. Such a stylish packaging, they belong in the blazer pocket of someone with black lungs."
ITEM.Model =  "models/kek1ch/drink_cigar0.mdl"
ITEM.Weight =  0.5
ITEM.FOV =  14
ITEM.CamPos =  Vector( 50, 50, 50 )
ITEM.LookAt =  Vector( 0, 0, 0 )
ITEM.BulkPrice =  600
ITEM.License =  "X"
ITEM.functions = {}
ITEM.functions.unpack = {
    SelectionName = "open",
    RemoveOnUse = true,
    CanRun = function(item)
        return true
    end,
    OnUse = function(item)
        if CLIENT then
            LocalPlayer():Notify(nil, COLOR_NOTIF, "You open the pack of cigarettes.")
        else
            item:Owner():GiveItem("cigarettes", {Stacked = 20})
        end

        return true
    end,
}
ITEM.Rarity = 3
ITEM.AllowRandomSpawn = true