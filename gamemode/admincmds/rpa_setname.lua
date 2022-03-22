kingston.admin.registerCommand("charsetname", {
	syntax = "<string target> <string name>",
	description = "Set a character's name",
	arguments = {ARGTYPE_TARGET, ARGTYPE_STRING},
	onRun = function(ply, target, name)
		if string.len( string.Trim( name ) ) <= GAMEMODE.MaxNameLength and string.len( string.Trim( name ) ) >= GAMEMODE.MinNameLength then
			if !string.find( name, "#", nil, true ) and !string.find( name, "~", nil, true ) and !string.find( name, "%", nil, true ) then
				local old = target:RPName();
				
				target:SetRPName( string.Trim( name ) );
				target:UpdateCharacterField( "RPName", name );
				
				GAMEMODE:LogAdmin( "[N] " .. ply:Nick() .. " changed player " .. old .. "'s name to \"" .. name .. "\".", ply );
				
				local rf = { ply, target };

				GAMEMODE:Notify(rf, nil, COLOR_NOTIF, "%s changed %s's roleplay name from %s to %s", ply:Nick(), target:Nick(), old, name)
			end
		end
	end,
})