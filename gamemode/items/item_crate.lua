ITEM.Name =  "Delivery Crate";
ITEM.Desc =  "A heavy duty delivery crate, dropped into the Zone by god-knows-who for some unknown purpose. Locked electronically, requires proper tools and know-how to crack open.";
ITEM.Model =  "models/kek1ch/safe_container.mdl";
ITEM.Weight =  1;
ITEM.FOV =  13;
ITEM.CamPos =  Vector( 50, 50, 50 );
ITEM.LookAt =  Vector( 0, 0, 0 );
ITEM.W = 4
ITEM.H = 4
ITEM.Vars = {
	Items = {},
	Buyer = 0,
}
ITEM.functions = {}
ITEM.functions.Open = {
	SelectionName = "Open",
	OnUse = function(item)
		if item:GetVar("Buyer", 0) != item:Owner():CharID() then
			if CLIENT then
				GAMEMODE:CreateTimedProgressBar(120, "Cracking safe code...", LocalPlayer(), function()
					netstream.Start("OpenShipmentItem", item:GetID())
				end)
			end
			
			item:Owner().StartSafeOpen = CurTime()
		else
			for _,itemClass in ipairs(item:GetVar("Items", {})) do
				item:Owner():GiveItem(itemClass)
			end
			item:RemoveItem()
		end

		return true
	end,
	CanRun = function(item)
		return (item:Owner():IsPDATech() and item:Owner():HasItem("pda_decryption")) or item:GetVar("Buyer", 0) == item:Owner():CharID()
	end,
}

function ITEM:GetWeight()
	local weight = 1
	for _,v in ipairs(self:GetVar("Items", {})) do
		local metaitem = GAMEMODE:GetItemByID(v)
		if metaitem.Weight then
			weight = weight + metaitem.Weight
		end
	end

	return weight
end

if SERVER then
	local function OpenShipmentItem(ply, id)
		local item = ply.Inventory[id]
		if !item then return end
		if !ply:IsPDATech() or !ply:HasItem("pda_decryption") then return end
		if ply.StartSafeOpen + 199 > CurTime() then return end
		
		local items = ply:HasItem("pda_decryption")
		if istable(items) and !items.IsItem then
			items = items[1]
		end
		items:RemoveItem(true)
		
		for _,itemClass in ipairs(item:GetVar("Items", {})) do
			ply:GiveItem(itemClass)
		end
		item:RemoveItem(true)
		
		ply.StartSafeOpen = nil
	end
	netstream.Hook("OpenShipmentItem", OpenShipmentItem)
end