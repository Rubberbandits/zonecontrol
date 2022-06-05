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
	util.AddNetworkString("zcStopSound")
else
	local currentSounds = {}

	local function zcPlayURL(len)
		local url = net.ReadString()

		sound.PlayURL(url,"",function(station)
			if IsValid(station) then
				station:Play()

				local index = table.insert(currentSounds, {obj: station, name: url})

				timer.Simple(station:GetLength(), function()
					station:Stop()
					table.remove(currentSounds, index)
				end)
			else
				print("Attempt to play an invalid sound URL:", url)
			end
		end)
	end
	net.Receive("zcPlayURL", zcPlayURL)

	local function zcStopSound(len)
		local index = net.ReadUInt(8)
		local station = currentSounds[index]
		if station and IsValid(station.obj) then
			station.obj:Stop()
		end

		table.remove(currentSounds, index)
	end
	net.Receive("zcStopSound", zcStopSound)

	local function PrintCurrentSounds(ply, cmd, args)
		print("Printing all currently playing sounds")
		for index,soundData in pairs(currentSounds) do
			print(Format("\tIndex %d, URL: %s", index, soundData.name))
		end
	end
	concommand.Add("list_sounds", PrintCurrentSounds)
end