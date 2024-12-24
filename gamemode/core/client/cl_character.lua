zonecontrol = zonecontrol or {}
zonecontrol.characters = zonecontrol.characters or {}
zonecontrol.characters.list = zonecontrol.characters.list or {}

local function CharacterLoad()
	print("CharacterLoad")
	local id = net.ReadUInt(32)
	local name = net.ReadString()
	local model = net.ReadString()
	local body = net.ReadString()
	local skin = net.ReadUInt(8)
	local money = net.ReadUInt(32)

	zonecontrol.characters.list[id] = {
		id = id,
		RPName = name,
		Model = model,
		Body = body,
		Skin = skin,
		Money = money
	}

	PrintTable(zonecontrol.characters.list)

	hook.Run("CharacterLoaded", id)
end
net.Receive("CharacterLoad", CharacterLoad)

local function CharacterFetch()
	local characters = {}

	local count = net.ReadUInt(8)
	for i = 1, count do
		local id = net.ReadUInt(32)
		local name = net.ReadString()
		local model = net.ReadString()
		local body = net.ReadString()
		local skin = net.ReadUInt(8)

		table.insert(characters, {id = id, name = name, model = model, body = body, skin = skin})
	end

	zonecontrol.characters.minimal = characters

	hook.Run("CharacterFetch", characters)
end
net.Receive("CharacterFetch", CharacterFetch)

local function CharacterCreationStatus(len)
	local status = net.ReadUInt(8)

	print("CharacterCreationStatus", status)

	if status == 2 then
		local id = net.ReadUInt(32)
		print("Load newly created character")
		print(id)

		net.Start("CharacterLoad")
			net.WriteUInt(id, 32)
		net.SendToServer()

		hook.Run("CharacterCreated", id)
	end

	hook.Run("CharacterCreationStatus", status)
end
net.Receive("CharacterCreationStatus", CharacterCreationStatus)

local function zcNetworkCharVarChange(len)
	print("zcNetworkCharVarChange")
	local charID = net.ReadUInt(32)
	local key = net.ReadString()
	local value = net.ReadString()

	print(charID, key, value)

	local character = zonecontrol.characters.list[charID]
	if not character then return end

	character[key] = value
	print("Value set")
end
net.Receive("zcNetworkCharVarChange", zcNetworkCharVarChange)