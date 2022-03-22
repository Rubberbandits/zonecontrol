

kingston.admin.registerCommand("plyexplode", {
	syntax = "<string target>",
	description = "Explode a target",
	arguments = {ARGTYPE_TARGET},
	onRun = function(ply, target)
		local nick = target:RPName();
		local explo = ents.Create( "env_explosion" );
		explo:SetOwner( ply );
		explo:SetPos( target:GetPos() );
		explo:SetKeyValue( "iMagnitude", 1000 );
		explo:SetKeyValue( "iRadiusOverride", 32 );
		explo:Spawn();
		explo:Activate();
		explo:Fire( "Explode" );
		
		target:SetVelocity( Vector( math.random( -200, 200 ), math.random( -200, 200 ), math.random( 300, 600 ) ) );
		
		GAMEMODE:LogAdmin( "[D] " .. ply:Nick() .. " exploded player " .. nick .. ".", ply );

		target:Notify(nil, COLOR_NOTIF, "%s exploded you.", ply:Nick())
	end,
})