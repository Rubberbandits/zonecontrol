local meta = FindMetaTable("Player")

function meta:GetCharFromID(id)
	for _, v in pairs(GAMEMODE.Characters) do
		if tonumber(v.id) == id then
			return v
		end
	end
end

local function PlayerModelChanged(len)
	local ply = net.ReadEntity()

	hook.Run("PlayerModelChanged", ply)
end
net.Receive("PlayerModelChanged", PlayerModelChanged)