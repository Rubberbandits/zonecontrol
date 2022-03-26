function nCreateCharacter( ply, name, desc, titleone, titletwo, model, trait, skin, gear )
	
	if( ply:SQLGetNumChars() >= GAMEMODE.MaxCharacters ) then return end
	
	local r, err = GAMEMODE:CheckCharacterValidity( name, desc, titleone, titletwo, model, trait, skin, gear );
	
	if( r ) then
		
		ply:SaveNewCharacter( name, desc, titleone, titletwo, model, trait, skin, gear );
		
	end
	
end
netstream.Hook( "nCreateCharacter", nCreateCharacter );

function nSelectCharacter( ply, id )

	if( ply:SQLCharExists( id ) ) then
		
		if( ply:CharID() == id ) then return end

		if tonumber(ply:GetCharFromID(id).Banned) == 1 then return end
		
		if( GAMEMODE.CurrentLocation and ply:GetCharFromID( id ).Location != GAMEMODE.CurrentLocation and !ply:IsAdmin() ) then return end
		
		ply:LoadCharacter( ply:GetCharFromID( id ) );
		
	end
	
end
netstream.Hook( "nSelectCharacter", nSelectCharacter );

function nDeleteCharacter( ply, id )

	if( ply:SQLCharExists( id ) ) then
		
		if( ply:CharID() == id ) then return end
		
		local char = ply:GetCharFromID( id );
		
		ply:DeleteCharacter( id, char.RPName );
		
	end
	
end
netstream.Hook( "nDeleteCharacter", nDeleteCharacter );

local allowedChars = [[abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890 -|+=.,\/;:'"]];

function nChangeRPName( ply, name )

	if( string.len( string.Trim( name ) ) <= GAMEMODE.MaxNameLength and string.len( string.Trim( name ) ) >= GAMEMODE.MinNameLength ) then
		
		if( !string.find( allowedChars, name, 1, true ) ) then
			
			ply:SetRPName( string.Trim( name ) );
			ply:UpdateCharacterField( "RPName", name );
			
		end
		
	end
	
end
netstream.Hook( "nChangeRPName", nChangeRPName );

function nChangePDAName( ply, name, id )
	
	if( string.len( string.Trim( name ) ) <= GAMEMODE.MaxNameLength and string.len( string.Trim( name ) ) >= GAMEMODE.MinNameLength ) then
		
		if( !string.find( allowedChars, name, 1, true ) ) then
		
			local item = ply.Inventory[id]
			mysqloo.Query("SELECT Vars FROM cc_items WHERE ItemClass = 'pda'", function(ret)
				for k,v in next, ret do
					local vars = util.JSONToTable(v.Vars)
					if string.Trim(vars["PDAName"] or "") == string.Trim(name) then
						netstream.Start( ply, "nPDANameTaken" );
						
						break
					end
					
					if k == #ret then
						item:SetVar("PDAName", string.Trim(name), false, true)
					end
				end
			end)
			
		end
		
	end
	
end
netstream.Hook( "nChangePDAName", nChangePDAName );

function nChangeTitle( ply, desc )
	
	if( string.len( string.Trim( desc ) ) <= GAMEMODE.MaxDescLength ) then
		
		local charData = ply:GetCharFromID( ply:CharID() );
		local Description = util.JSONToTable( charData.Title );
		Description["offduty"] = string.Trim( desc );

		ply:SetDescription( string.Trim( desc ) );
		ply:UpdateCharacterField( "Title", util.TableToJSON( Description ), nil, true );
		
	end
	
end
netstream.Hook( "nChangeTitle", nChangeTitle );

function nChangeTitleOne( ply, title )

	if( string.len( string.Trim( title ) ) <= 128 ) then
		
		local charData = ply:GetCharFromID( ply:CharID() );
		local TitleOne = util.JSONToTable( charData.TitleOne );
		TitleOne["offduty"] = string.Trim( title );
		
		ply:SetTitleOne( string.Trim( title ) );
		ply:UpdateCharacterField( "TitleOne", util.TableToJSON( TitleOne ), nil, true );
		
	end

end
netstream.Hook( "nChangeTitleOne", nChangeTitleOne );

function nChangeTitleTwo( ply, title )

	if( string.len( string.Trim( title ) ) <= 128 ) then
		
		local charData = ply:GetCharFromID( ply:CharID() );
		local TitleTwo = util.JSONToTable( charData.TitleTwo );
		TitleTwo["offduty"] = string.Trim( title );
		
		ply:SetTitleTwo( string.Trim( title ) );
		ply:UpdateCharacterField( "TitleTwo", util.TableToJSON( TitleTwo ), nil, true );
		
	end

end
netstream.Hook( "nChangeTitleTwo", nChangeTitleTwo );

local oldtonumber = tonumber;
function _G.tonumber( val )

	if( isbool( val ) ) then
	
		if( val ) then
		
			return 1;
		
		else
		
			return 0;
			
		end
	
	end
	
	return oldtonumber( val );

end

function nSetNewbieStatus( ply, nStatus )
	
	ply:SetNewbieStatus( nStatus );
	ply:UpdatePlayerField( "NewbieStatus", tonumber( nStatus ) );
	
end
netstream.Hook( "nSetNewbieStatus", nSetNewbieStatus );