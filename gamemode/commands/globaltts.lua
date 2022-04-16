kingston.admin.registerCommand("tts", {
	syntax = "<string message>",
	description = "Broadcast a message over Dectalk TTS to the server",
	arguments = {ARGTYPE_STRING},
	onRun = function(ply, message)
		net.Start("zctts")
			net.WriteString(message)
		net.Broadcast()
	end,
})