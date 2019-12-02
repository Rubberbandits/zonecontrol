BASE.Item = ""
BASE.SuitVariant = ""
BASE.functions = {};
BASE.functions.Use = {
	SelectionName = "Use",
	OnUse = function(item)
		if CLIENT then
			local menu = vgui.Create("CBDUMenu")
			menu:SetItem(item:GetClass(), item:GetID())
		end
		
		return true
	end,
	CanRun = function(item)
		return true
	end,
}

if SERVER then
	netstream.Hook("ChangeClothesBDU", function(ply, item_id, clothing_id)
		local item = GAMEMODE.g_ItemTable[item_id]
		local clothing = GAMEMODE.g_ItemTable[clothing_id]
		
		if !item or !clothing then return end
		if item.Item != clothing:GetClass() then return end
		if clothing:GetVar("SuitClass","") == item.SuitVariant then return end
		if clothing:GetVar("Equipped", false) then return end
		
		if GAMEMODE.GiveOldBDUBack then
			ply:GiveItem(clothing:GetVar("SuitClass", "").."_bdu", {})
		end
		clothing:SetVar("SuitClass", item.SuitVariant, nil, true)
		
		item:RemoveItem(true)
	end)
end