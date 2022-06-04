kingston.admin.registerCommand("gameplayurl", {
	syntax = "<string url>",
	description = "Play a sound file from the internet across all players.",
	arguments = {ARGTYPE_STRING},
	onRun = function(ply, url)
		net.Start("zcPlayURL")
			net.WriteString(url)
		net.Broadcast()

		ply:Notify(nil, COLOR_NOTIF, "URL broadcasted to all players.")
	end,
})

if SERVER then
	util.AddNetworkString("zcPlayURL")
else
	local function zcPlayURL(len)
		local url = net.ReadString()

		sound.PlayURL(url,"",function(station)
			if IsValid(station) then
				station:Play()
			else
				print("Attempt to play an invalid sound URL:", url)
			end
		end)
	end
	net.Receive("zcPlayURL", zcPlayURL)
end