local function CreateArtifact( ply, args )
	
	local item = args[1] or "";
	
	if( item == "" ) then
		
		netstream.Start( ply, "nAListArtifacts", "" );
		return;
		
	end
	
	if( GAMEMODE:GetItemByID( item ) ) then
	
		if( !GAMEMODE:GetItemByID( item ).Artifact ) then return end
		
		GAMEMODE:CreateArtifact( ply, item );
		
		GAMEMODE:LogAdmin( "[I] " .. ply:Nick() .. " spawned item \"" .. item .. "\" (" .. GAMEMODE:GetItemByID( item ).Name .. ").", ply );
		
	else
		
		netstream.Start( ply, "nAListArtifacts", item );
		
	end
	
end
concommand.AddAdmin( "rpa_createartifact", CreateArtifact );