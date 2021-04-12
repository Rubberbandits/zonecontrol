local function SetDamageMultiplier( ply, args )
	local mult = args[1] and tonumber(args[1])
	if !mult then
		ply:Notify(nil, Color(200,0,0), "Error: Invalid multiplier specified.")
		return
	end

	local cvar = GetConVar("sv_tfa_damage_multiplier")
	if cvar then
		cvar:SetFloat(mult)
		
		ply:Notify(nil, Color(0,200,0), "Global damage multipler set to %s", args[1])
		GAMEMODE:LogAdmin( Format("[F] %s set the global damage multiplier to %s.", ply:Nick(), args[1]), ply );
	else
		ply:Notify(nil, Color(200,0,0), "Error: Somehow the TFA damage multipler CVar is missing!")
	end
end	
concommand.AddAdmin( "rpa_setdmgmult", SetDamageMultiplier, true );