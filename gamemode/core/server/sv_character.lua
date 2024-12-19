zonecontrol = zonecontrol or {}
zonecontrol.characters = zonecontrol.characters or {}
zonecontrol.characters.all = zonecontrol.characters.all or {}
zonecontrol.characters.by_steamid = zonecontrol.characters.by_steamid or {}

function zonecontrol.characters.Create(ply, name, desc, model, skin, items)
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

	local query = CCSQL:prepare("INSERT INTO cc_chars (SteamID, RPName, Description, Model, Body, Skingroup, Date, Money, Location) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?);")
		query:setString(1, ply:SteamID())
		query:setString(2, name)
		query:setString(3, desc)
		query:setString(4, model)
		query:setString(5, body_mdl)
		query:setNumber(6, skin)
		query:setString(7, date)
		query:setNumber(8, remaining_budget)
		query:setNumber(9, GAMEMODE.MainServerLocation)
		function query:onSuccess(ret)
			GAMEMODE:LogSQL("Player " .. ply:Nick() .. " created character " .. name .. ".");

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
			character.id = tonumber(self:lastInsert())

			table.insert(ply.SQLCharData, character)

			local transaction = CCSQL:createTransaction()
			for _,class in next, starting_items do
				local metaitem = GAMEMODE.Items[class]
				local str = Format("INSERT INTO cc_items ( Owner, ItemClass, Vars ) VALUES ( '%d', '%s', '%s' );", self:lastInsert(), class, util.TableToJSON(metaitem.Vars or {}))
				local q = CCSQL:query(str)
				transaction:addQuery(q)
			end

			function transaction:onSuccess()
				ply:LoadCharacter(character)
			end
			transaction:start()

		end
		function query:onError( err )
			MsgC(Color(255, 0, 0), "MySQL query failed: " .. err)
		end
	query:start()
end

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

	zonecontrol.characters.Create(ply, name, desc, model, skin, items)
end
net.Receive("CharacterCreate", CharacterCreate)

util.AddNetworkString("CharacterLoad")
local function CharacterLoad(len, ply)
	local id = net.ReadUInt(32)

	if ply:SQLCharExists(id) then
		if ply:CharID() == id then return end
		if tonumber(ply:GetCharFromID(id).Banned) == 1 then return end
		if GAMEMODE.CurrentLocation and ply:GetCharFromID(id).Location != GAMEMODE.CurrentLocation and not ply:IsAdmin() then return end

		ply:LoadCharacter(ply:GetCharFromID(id))
	end
end
net.Receive("CharacterLoad", CharacterLoad)

util.AddNetworkString("CharacterFetch")
local function CharacterFetch(len, ply)
	local function qS(results)
		net.Start("CharacterFetch")
			net.WriteUInt(#results, 8)

			for _,data in pairs(results) do
				net.WriteUInt(data["id"], 32)
				net.WriteString(data["RPName"])
				net.WriteString(data["Model"])
				net.WriteString(data["Body"])
				net.WriteUInt(data["Skingroup"], 8)
			end
		net.Send(ply)
	end

	local function qF(err)
		net.Start("CharacterFetch")
			net.WriteUInt(0, 8)
		net.Send(ply)

		print("Some kind of error occurred loading characters: " .. err)
	end
	mysqloo.Query("SELECT * FROM cc_chars WHERE SteamID = '" .. ply:SteamID() .. "'", qS, qF)
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