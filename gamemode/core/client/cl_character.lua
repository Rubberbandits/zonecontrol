zonecontrol = zonecontrol or {}
zonecontrol.characters = zonecontrol.characters or {}

local function CharacterLoad()
	local id = net.ReadUInt(32)
	// name
	// model
	// body
	// skin

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

	if status == 2 then
		local id = net.ReadUInt(32)
		hook.Run("CharacterCreated", id)
	end

	hook.Run("CharacterCreationStatus", status)
end
net.Receive("CharacterCreationStatus", CharacterCreationStatus)

local function zcNetworkCharVarChange(len)
	local charID = net.ReadUInt(32)
	local key = net.ReadString()
	local value = net.ReadString()

	LocalPlayer():GetCharFromID(charID)[key] = value
end
net.Receive("zcNetworkCharVarChange", zcNetworkCharVarChange)