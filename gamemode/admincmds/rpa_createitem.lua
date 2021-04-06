local function CreateItem( ply, args )
	
	local item = args[1] or "";
	
	if( item == "" ) then

		netstream.Start( ply, "nAListItems", "" );
		return;
		
	end
	
	if( GAMEMODE:GetItemByID( item ) ) then
		
		GAMEMODE:CreateItem( ply, item );
		
		GAMEMODE:LogAdmin( "[I] " .. ply:Nick() .. " spawned item \"" .. item .. "\" (" .. GAMEMODE:GetItemByID( item ).Name .. ").", ply );
		
	else

		netstream.Start( ply, "nAListItems", item );
		
	end
	
end
concommand.AddAdmin( "rpa_createitem", CreateItem );