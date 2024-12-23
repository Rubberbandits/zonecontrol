zonecontrol = zonecontrol or {}
zonecontrol.characters = zonecontrol.characters or {}
zonecontrol.characters.all = zonecontrol.characters.all or {}
zonecontrol.characters.by_steamid = zonecontrol.characters.by_steamid or {}

util.AddNetworkString("CharacterCreationStatus")

util.AddNetworkString("CharacterCreate")
local function CharacterCreate(len, ply)
	local name = net.ReadString()
	local desc = net.ReadString()
	local model = net.ReadString()
	local skin = net.ReadUInt(8)
	local items_count = net.ReadUInt(8)

	local items = {}
	for i = 1, items_count do
		table.insert(items, {item = net.ReadString(), count = net.ReadUInt(8)})
	end

	local valid = hook.Run("CheckCharacterValidity", name, desc, model, TRAIT_NONE, skin)
	if not valid then return end

	local date = os.date("!%m/%d/%y %H:%M:%S")

	local body_mdl = GAMEMODE.BodyModels[1]
	if string.find(model, "fmale") or string.find(model, "female") then
		body_mdl = string.StripExtension(GAMEMODE.BodyModels[1]) .. "_f.mdl"
	end

	local starting_items = {}
	local remaining_budget = GAMEMODE.RubleBudget
	for _,data in pairs(items) do
		local item_data = GAMEMODE.GearSelection[data.item]
		local count = data.count

		remaining_budget = remaining_budget - item_data.cost * count
		for i = 1, count do
			table.insert(starting_items, data.item)
		end
	end

	if remaining_budget < 0 then return end

	zonecontrol.characters.create({
		SteamID = ply:SteamID(),
		RPName = name,
		Description = desc,
		Model = model,
		Body = body_mdl,
		Skingroup = skin,
		Date = date,
		Money = remaining_budget,
		Location = GAMEMODE.MainServerLocation
	}, function(id)
		if not id then return end

		local character = {};
		character.SteamID = ply:SteamID()
		character.RPName = name
		character.Description = desc
		character.Model = model
		character.Body = body_mdl
		character.Trait = TRAIT_NONE
		character.Skingroup = skin
		character.Date = date
		character.LastOnline = date
		character.Money = remaining_budget
		character.Location = GAMEMODE.MainServerLocation
		character.id = tonumber(id)

		zonecontrol.inventory.create(character.id, function(inventory)
			character.inventory = inventory

			local transaction = CCSQL:createTransaction()
			for _,class in next, starting_items do
				local q = CCSQL:prepare("INSERT INTO cc_items (Inventory, ItemClass) VALUES (?, ?);")
					q:setNumber(1, id)
					q:setString(2, class)
				transaction:addQuery(q)
			end
	
			function transaction:onSuccess()
				net.Start("CharacterCreationStatus")
					net.WriteUInt(2, 8)
					net.WriteUInt(id, 32)
				net.Send(ply)
			end
			transaction:start()
		end)

		net.Start("CharacterCreationStatus")
			net.WriteUInt(1, 8)
		net.Send(ply)
	end)
end
net.Receive("CharacterCreate", CharacterCreate)

util.AddNetworkString("CharacterLoad")
local function CharacterLoad(len, ply)
	local id = net.ReadUInt(32)

	local character = zonecontrol.characters.all[id]
	if not character then return end
	if character.SteamID != ply:SteamID() then return end
	if character.Banned == 1 then return end
	if GAMEMODE.CurrentLocation and character.Location != GAMEMODE.CurrentLocation and not ply:IsAdmin() then return end

	ply:LoadCharacter(character)
end
net.Receive("CharacterLoad", CharacterLoad)

util.AddNetworkString("CharacterFetch")
local function CharacterFetch(len, ply)
	zonecontrol.characters.fetch_by_player(ply:SteamID(), function(results)
		if not results then results = {} end

		net.Start("CharacterFetch")
			net.WriteUInt(#results, 8)

			for _,row in pairs(results) do
				net.WriteUInt(row["id"], 32)
				net.WriteString(row["RPName"])
				net.WriteString(row["Model"])
				net.WriteString(row["Body"])
				net.WriteUInt(row["Skingroup"], 8)
			end
		net.Send(ply)
	end)
end
net.Receive("CharacterFetch", CharacterFetch)

util.AddNetworkString("CharacterDelete")
local function CharacterDelete(len, ply)
	local id = net.ReadUInt(32)

	if ply:SQLCharExists(id) then
		if ply:CharID() == id then return end

		local char = ply:GetCharFromID(id)
		if char.Money < 9500 then return end

		ply:DeleteCharacter(id, char.RPName)
	end
end
net.Receive("CharacterDelete", CharacterDelete)

local LOAD_CHARACTER = [[SELECT * FROM `cc_chars` WHERE `id` = ?;]];
local FETCH_CHARACTERS = [[SELECT `id`, `RPName`, `Model`, `Body`, `Skingroup` FROM `cc_chars` WHERE `SteamID` = ?;]];

function zonecontrol.characters.load(id, callback)
	local query = CCSQL:prepare(LOAD_CHARACTER)
	query.onSuccess = function(_, results)
		zonecontrol.characters.all[id] = results[1]
		callback(results[1])
	end
	query:setNumber(1, id)
	query:start()
end

function zonecontrol.characters.fetch_by_player(steamid, callback)
	local query = CCSQL:prepare(FETCH_CHARACTERS)
	query.onSuccess = function(_, results)
		callback(results)
	end
	query.onError = function(_, err)
		callback()
	end
	query:setString(1, steamid)
	query:start()
end

function zonecontrol.characters.delete(id, callback)
	local query = CCSQL:prepare("DELETE FROM `cc_chars` WHERE `id` = ?;")
	query.onSuccess = function(_)
		callback()
	end
	query:setNumber(1, id)
	query:start()
end

local CREATE_CHARACTER = [[INSERT INTO `cc_chars` (SteamID, RPName, Description, Model, Body, Skingroup, Date, Money, Location) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?);]]

function zonecontrol.characters.create(data, callback)
	local query = CCSQL:prepare(CREATE_CHARACTER)
	query.onSuccess = function(_, results)
		callback(query:lastInsert())
	end
		query:setString(1, data.SteamID)
		query:setString(2, data.RPName)
		query:setString(3, data.Description)
		query:setString(4, data.Model)
		query:setString(5, data.Body)
		query:setNumber(6, data.Skingroup)
		query:setString(7, data.Date)
		query:setNumber(8, data.Money)
		query:setNumber(9, data.Location)
	query:start()
end