/*
	Networking
*/

/*
	nested garbage
	thanks disseminate
*/

local function nBuyItem( ply, id, single )
	if !InStockpileRange(ply) then return end

	local item = GAMEMODE:GetItemByID( id );

	if item and item.License then
		local hasFlag

		for i = 1, #item.License do
			if ply:HasCharFlag(item.License[i]) then
				hasFlag = true
			end
		end

		if !hasFlag then ply:Notify(nil, COLOR_ERROR, "You don't have the connections to buy this.") return end

		local price = hook.Run("GetBuyPrice", ply, id, single)
		if !price or price == 0 then return end

		if single then
			if ply:Money() >= price then
				if ply:InventoryWeight() < ply:InventoryMaxWeight() then
					ply:AddMoney( -1 * price );
					ply:UpdateCharacterField( "Money", tostring( ply:Money() ) );
					
					ply:GiveItem( id, item.Vars or {} );

					ply:Notify(nil, COLOR_NOTIF, "You've purchased this single item.")
				else
					ply:Notify(nil, COLOR_ERROR, "You're overencumbered and can't make purchases.")
				end
			else
				ply:Notify(nil, COLOR_ERROR, "You can't afford to buy this.")
			end
		else
			if ply:Money() >= price then
				if ply:InventoryWeight() < ply:InventoryMaxWeight() then
					ply:AddMoney( -1 * price );
					ply:UpdateCharacterField( "Money", tostring( ply:Money() ) );
					
					ply:GiveItem( id, item.Vars or {} );
					ply:GiveItem( id, item.Vars or {} );
					ply:GiveItem( id, item.Vars or {} );
					ply:GiveItem( id, item.Vars or {} );
					ply:GiveItem( id, item.Vars or {} );

					ply:Notify(nil, COLOR_NOTIF, "You've purchased five of this item.")
				else
					ply:Notify(nil, COLOR_ERROR, "You're overencumbered and can't make purchases.")
				end
			else
				ply:Notify(nil, COLOR_ERROR, "You can't afford to buy this.")
			end
		end
	end
end
netstream.Hook( "nBuyItem", nBuyItem );

util.AddNetworkString("zcSendCustomPrices")
local function zcSendCustomPrices(len, ply)
	if ply.RetrievedItemPrices then return end

	net.Start("zcSendCustomPrices")
		net.WriteUInt(table.Count(GAMEMODE.ItemPrice), 32)
		for id,price in next, GAMEMODE.ItemPrice do
			net.WriteString(id)
			net.WriteUInt(price, 32)
		end
	net.Send(ply)

	ply.RetrievedItemPrices = true
end
net.Receive("zcSendCustomPrices", zcSendCustomPrices)

/*
	Hooks
*/

hook.Add("Initialize", "LoadItemPrices", function()
	local data = file.Read("zonecontrol/itemprices.txt", "DATA")

	GAMEMODE.ItemPrice = data and util.JSONToTable(data) or {}
end)

function GM:LoadStockpiles()
	local data = file.Read("zonecontrol/"..game.GetMap().."/stockpiles.txt", "DATA")

	if !data or #data == 0 then return end

	local stockpiles = util.JSONToTable(data)
	if stockpiles then
		for _,data in ipairs(stockpiles) do
			local stockpile = ents.Create("cc_stockpile")
			stockpile:SetPos(data.Pos)
			stockpile:SetAngles(data.Angles)
			stockpile:Spawn()
		end
	end
end

function GM:SaveStockpiles()
	if !file.IsDir("zonecontrol", "DATA") then
		file.CreateDir("zonecontrol")
	end

	if !file.IsDir("zonecontrol/"..game.GetMap(), "DATA") then
		file.CreateDir("zonecontrol/"..game.GetMap())
	end

	local data = {}
	for _,stockpile in ipairs(ents.FindByClass("cc_stockpile")) do
		table.insert(
			data,
			{
				Pos = stockpile:GetPos(),
				Angles = stockpile:GetAngles(),
			}
		)
	end

	file.Write("zonecontrol/"..game.GetMap().."/stockpiles.txt", util.TableToJSON(data))
end

hook.Add("InitPostEntity", "STALKER.LoadStockpiles", function()
	hook.Run("LoadStockpiles")
end)

hook.Add("ShutDown", "STALKER.SaveStockpiles", function()
	hook.Run("SaveStockpiles")
end)

/*
	Functions
*/

kingston = kingston or {}
kingston.shipment = kingston.shipment or {}
kingston.shipment.in_progress = kingston.shipment.in_progress or {}

kingston.shipment.min_delivery_time = 600
kingston.shipment.max_delivery_time = 1200

kingston.shipment.use_spawn_ent = true
-- if false, uses locations defined in table below
kingston.shipment.spawns = {
	rp_rostok_cmb = {
		Vector(0,0,0),
	}
}

kingston.shipment.threat_price_ranges = {
	[14000] = {
		chance = 10,
		threats = {
			{
				"npc_wick_mutant_dog",
				"npc_wick_mutant_dog",
				"npc_wick_mutant_dog",
				"npc_wick_mutant_dog",
				"npc_wick_mutant_dog",
			},
			{
				"kingston_electro",
			},
		},
	},
}

function kingston.shipment.roll_chance(id)

end

function kingston.shipment.deliver(id)

end

function kingston.shipment.fail_delivery(id)

end

local function PointOnCircle(ang, radius, offX, offY)
	ang =  math.rad(ang)
	local x = math.cos(ang) * radius + offX
	local y = math.sin(ang) * radius + offY
	return x, y
end

function kingston.shipment.spawn_threat(id)
	local shipment = kingston.shipment.in_progress[id]
	if !shipment then return


	local totalNPCs = {}
	local interval = 360 / #npcGroup
	local pos = self:GetPos()
	local radius = 200

	for i,npcClass in ipairs(npcGroup) do
		local x, y = PointOnCircle(i * interval, math.random(50,200), pos.x, pos.y)

		local npc = ents.Create(npcClass)
		npc:SetPos(Vector(x, y, pos.z + 10))
		npc:Spawn()
end

function kingston.shipment.create(ply, items)
	local shipment = {
		StartTime = CurTime(),
		Owner = ply:CharID(),
		Items = items,
		DeliveryTime = CurTime() + math.random(kingston.shipment.min_delivery_time, kingston.shipment.max_delivery_time)
	}

	for _, itemClass in ipairs(items) do
		local price = hook.Run("GetBuyPrice", ply, itemClass)
	end

	table.insert(kingston.shipment.in_progress, shipment)

	hook.Run("ShipmentCreated", ply, shipment)
end

function kingston.shipment.remove(id)
	table.remove(kingston.shipment.in_progress, shipment)
	hook.Run("ShipmentRemoved")
end

local function ShipmentThink()

end
hook.Add("Think", "STALKER.Shipments", ShipmentThink)