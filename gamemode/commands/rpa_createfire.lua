

kingston.admin.registerCommand("gamecreatefire", {
	syntax = "<number duration>",
	description = "Create a timed fire where you are aiming.",
	arguments = {ARGTYPE_NUMBER},
	onRun = function(ply, num)
		if num < 1 then
			return false, "duration has to be greater than 1"
		end
		
		if( num > 60 * 60 * 24 ) then
			return false, Format("duration is too long, max duration: %d", 60 * 60 * 24)
		end
		
		local trace = {}
		trace.start = ply:EyePos()
		trace.endpos = trace.start + ply:GetAimVector() * 32768
		trace.filter = ply
		local tr = util.TraceLine( trace )
		
		local fire = ents.Create( "env_fire" )
		fire:SetPos( tr.HitPos )
		fire:SetKeyValue( "spawnflags", "1" )
		fire:SetKeyValue( "attack", "4" )
		fire:SetKeyValue( "firesize", "128" )
		fire:Spawn()
		fire:Activate()
		fire:Fire( "Enable", "" )
		fire:Fire( "StartFire", "" )
		
		SafeRemoveEntityDelayed(fire, num)
	end,
})