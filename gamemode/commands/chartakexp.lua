kingston.admin.registerCommand("chartakexp", {
	syntax = "<string target> <number amount>",
	description = "Take experience points from a player's primary PDA",
	arguments = {ARGTYPE_TARGET, ARGTYPE_NUMBER},
	onRun = function(ply, target, amt)
		local pda = target:GetPrimaryPDA()
		if !pda then
			return false, "player doesn't have a primary PDA"
		end

		pda:TakeExperience(amt)
		ply:Notify(nil, COLOR_NOTIF, "%d experience points taken from player.", amt)
	end,
})