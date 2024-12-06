local function zcSendCustomPrices(len)
	local count = net.ReadUInt(32)
	for i = 1, count do
		GAMEMODE.ItemPrice[net.ReadString()] = net.ReadUInt(32)
	end
end
net.Receive("zcSendCustomPrices", zcSendCustomPrices)