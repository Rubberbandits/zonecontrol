kingston.admin.registerCommand("chargivexp", {
	syntax = "<string target> <number amount>",
	description = "Give a player's primary PDA experience points.",
	arguments = {ARGTYPE_TARGET, ARGTYPE_NUMBER},
	onRun = function(ply, target, amt)
		local pda = target:GetPrimaryPDA()
		if !pda then
			return false, "player doesn't have a primary PDA"
		end

		pda:GiveExperience(amt)
		ply:Notify(nil, COLOR_NOTIF, "Player given %d experience points.", amt)
	end,
})