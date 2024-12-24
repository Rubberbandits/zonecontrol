local function PlayerModelChanged(len)
	local ply = net.ReadEntity()

	hook.Run("PlayerModelChanged", ply)
end
net.Receive("PlayerModelChanged", PlayerModelChanged)