

kingston.admin.registerCommand("gamecharroster", {
	syntax = "<number page>",
	description = "View a paginated list of characters",
	arguments = {ARGTYPE_NUMBER},
	onRun = function(ply)

	end,
})

if SERVER then
	util.AddNetworkString("zcGetCharacterList")

	local function zcGetCharacterList(len, ply)
		if !ply:HasPermission("gamecharroster") then return end

		local number = net.ReadUInt(32) - 1

		local function qS(ret)
			net.Start("zcGetCharacterList")
				net.WriteUInt(#ret, 32)
				for _,data in pairs(ret) do
					net.WriteUInt(data.id, 32)
					net.WriteString(data.SteamID)
					net.WriteString(data.RPName)
					net.WriteString(data.CharFlags)
					net.WriteString(data.Date)
					net.WriteString(data.LastOnline)
					net.WriteUInt(data.Money, 32)
				end
			net.Send(ply)
			
			GAMEMODE:LogSQL("Player " .. ply:Nick() .. " retrieved character roster.")
		end
		
		local function qF(err) print(err) end
		
		mysqloo.Query(Format("SELECT id, SteamID, RPName, CharFlags, Money, Date, LastOnline FROM cc_chars LIMIT %d, 25;", 25 * number), qS, qF)
	end
	net.Receive("zcGetCharacterList", zcGetCharacterList)
end