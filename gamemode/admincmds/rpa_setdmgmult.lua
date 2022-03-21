kingston.admin.registerCommand("setdmgmult", {
	syntax = "<number multipler>",
	description = "Set the global TFA damage multiplier",
	arguments = {ARGTYPE_NUMBER},
	onRun = function(ply, mult)
		local cvar = GetConVar("sv_tfa_damage_multiplier")

		if cvar then
			cvar:SetFloat(mult)
			
			ply:Notify(nil, Color(0,200,0), "Global damage multipler set to %d", mult)
			GAMEMODE:LogAdmin( Format("[F] %s set the global damage multiplier to %d.", ply:Nick(), mult), ply );
		else
			return false, "TFA damage multiplier CVar missing"
		end
	end,
})