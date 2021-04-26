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
					
					kingston.shipment.create(ply, {id})

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
					
					local items = {}
					for i = 1, 5 do
						table.insert(items, id)
					end

					kingston.shipment.create(ply, items)

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
		chance = 50,
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
	[250000] = {
		chance = 100,
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
	}
}

function kingston.shipment.roll_fail_chance(id)
	local shipment = kingston.shipment.in_progress[id]
	if !shipment then return end

	local priceData
	for price,data in next, kingston.shipment.threat_price_ranges do
		if price <= shipment.TotalValue then
			priceData = data
		end
	end

	if !priceData then return false end

	local chance = math.random(0, 100)
	if chance <= priceData.chance then
		return priceData.threats
	end
	
	return false
end

function kingston.shipment.deliver(id)
	local shipment = kingston.shipment.in_progress[id]
	if !shipment then return end

	local owner = player.GetByCharID(shipment.Owner)
	if !IsValid(owner) then return end

	for _,itemClass in ipairs(shipment.Items) do
		owner:GiveItem(itemClass)
	end

	hook.Run("ShipmentDelivered", shipment)

	kingston.shipment.remove(id)
end

local function FindShipmentSpawn()
	local ent = table.Random(ents.FindByClass("shipment_spawner"))
	if !IsValid(ent) then print("cant find spawn!") return false end

	return ent:GetPos() + ent:GetUp() * 10
end

function kingston.shipment.fail_delivery(id, threats)
	local shipment = kingston.shipment.in_progress[id]
	if !shipment then return end

	local owner = player.GetByCharID(shipment.Owner)
	if !IsValid(owner) then return end

	local spawnPos = FindShipmentSpawn()
	if spawnPos then
		local object = item(nil, "item_crate", nil, {Items = shipment.Items, Buyer = owner:CharID()}, 0, 0)
		local function cb()
			local ent = ents.Create( "cc_item" );
			ent:SetVarString(util.TableToJSON(object:GetVars()))
			object.owner = ent
			object:SetCharID(0)
			ent.ItemObj = object
			object:UpdateSave()
			ent:SetItemClass(object:GetClass())
			ent:SetPos(spawnPos)
			ent:SetAngles(Angle(0,0,0))
			ent:Spawn()
			ent:Activate()
		end
		object:SaveNewObject(cb)

		kingston.shipment.spawn_threat(spawnPos, threats)

		hook.Run("ShipmentDeliveryFailed", shipment, spawnPos)
	end

	kingston.shipment.remove(id)
end

local function PointOnCircle(ang, radius, offX, offY)
	ang =  math.rad(ang)
	local x = math.cos(ang) * radius + offX
	local y = math.sin(ang) * radius + offY
	return x, y
end

function kingston.shipment.spawn_threat(pos, threats)
	local threatGroup = table.Random(threats)
	local totalNPCs = {}
	local interval = 360 / #threatGroup
	local radius = 200

	for i,entClass in ipairs(threatGroup) do
		local x, y = PointOnCircle(i * interval, math.random(100,300), pos.x, pos.y)

		local npc = ents.Create(entClass)
		npc:SetPos(Vector(x, y, pos.z + 10))
		npc:Spawn()
	end
end

function kingston.shipment.create(ply, items)
	local shipment = {
		StartTime = CurTime(),
		Owner = ply:CharID(),
		Items = items,
		TotalValue = 0,
		DeliveryTime = CurTime() + math.random(kingston.shipment.min_delivery_time, kingston.shipment.max_delivery_time)
	}

	for _, itemClass in ipairs(items) do
		local price = hook.Run("GetBuyPrice", ply, itemClass, true)
		shipment.TotalValue = shipment.TotalValue + price
	end

	table.insert(kingston.shipment.in_progress, shipment)

	hook.Run("ShipmentCreated", ply, shipment)
end

function kingston.shipment.remove(id)
	table.remove(kingston.shipment.in_progress, shipment)
	hook.Run("ShipmentRemoved", id)
end

local function ShipmentThink()
	if !GAMEMODE.NextShipmentThink then
		GAMEMODE.NextShipmentThink = CurTime()
	end

	if GAMEMODE.NextShipmentThink <= CurTime() then
		for id,shipment in ipairs(kingston.shipment.in_progress) do
			if shipment.DeliveryTime <= CurTime() then
				local threats = kingston.shipment.roll_fail_chance(id)
				if threats then
					kingston.shipment.fail_delivery(id, threats)
				else
					kingston.shipment.deliver(id)
				end
			end
		end

		GAMEMODE.NextShipmentThink = CurTime() + 10
	end
end
hook.Add("Think", "STALKER.Shipments", ShipmentThink)

local function ShipmentFailed(shipment, pos)
	local ply = player.GetByCharID(shipment.Owner)
	if !IsValid(ply) then return end

	ply:PDANotify("Courier -> you", "I ran into a lot of trouble and had to drop your stuff! Here's the fee back for the delivery. It's somewhere out there... you best send someone to get it! I've fired a flare into the air, good luck!", 6, 3)

	local amount = shipment.TotalValue / 20
	ply:AddMoney(amount);
	ply:UpdateCharacterField("Money", tostring(ply:Money()))

	timer.Simple(5, function()
		local receiver_msg = Format("You've received %d RU from %s", amount, "Courier")
		ply:PDANotify("Message", receiver_msg, 5, 8)
	end)

	local flare = ents.Create("tfa_mats_flare_shipment")
	flare:SetPos(pos + Vector(0,0,100))
	flare:Spawn()

	-- next tick
	timer.Simple(0, function()
		local phys = flare:GetPhysicsObject()
		if IsValid(phys) then
			phys:ApplyForceCenter(Vector(0,0,6000))
		end
	end)
end
hook.Add("ShipmentDeliveryFailed", "STALKER.ShipmentFailed", ShipmentFailed)

local function SuccessfulShipment(shipment)
	local ply = player.GetByCharID(shipment.Owner)
	if !IsValid(ply) then return end

	ply:PDANotify("Courier -> you", "Here you are, all your stuff!", 6, 3)
end
hook.Add("ShipmentDelivered", "STALKER.ShipmentSuccess", SuccessfulShipment)

local function ShipmentStarted(ply, shipment)
	ply:PDANotify("Courier -> you", "I'll make sure to get all this stuff to you as fast as I can!", 6, 3)
end
hook.Add("ShipmentCreated", "STALKER.ShipmentStarted", ShipmentStarted)