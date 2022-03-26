-- this is where the old dono code used to be

local function zcNetworkCharVarChange(len)
	local charID = net.ReadUInt(32)
	local key = net.ReadString()
	local value = net.ReadString()

	LocalPlayer:GetCharFromID(charID)[field] = value
end
net.Receive("zcNetworkCharVarChange", zcNetworkCharVarChange)