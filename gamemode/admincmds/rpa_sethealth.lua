kingston.admin.registerCommand("sethealth", {
	syntax = "<string target> <number health>",
	description = "Set the current health of a target",
	arguments = {ARGTYPE_TARGET, ARGTYPE_NUMBER},
	onRun = function(ply, target, health)
		target:SetHealth(health)
		ply:Notify(nil, COLOR_NOTIF, "You've set %s's health to %d.", target:RPName(), health)
	end,
})