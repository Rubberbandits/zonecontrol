function nSelectCharacter( ply, id )
	if ply:SQLCharExists( id ) then
		if ply:CharID() == id then return end
		if tonumber(ply:GetCharFromID(id).Banned) == 1 then return end
		if GAMEMODE.CurrentLocation and ply:GetCharFromID( id ).Location != GAMEMODE.CurrentLocation and !ply:IsAdmin() then return end

		ply:LoadCharacter( ply:GetCharFromID( id ) );
	end
end
netstream.Hook("nSelectCharacter", nSelectCharacter)

function nDeleteCharacter( ply, id )
	if ply:SQLCharExists( id ) then
		if ply:CharID() == id then return end

		local char = ply:GetCharFromID( id );
		if char.Money < 9500 then return end

		ply:DeleteCharacter( id, char.RPName );
	end
end
netstream.Hook("nDeleteCharacter", nDeleteCharacter);

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
			if item:GetVar("PDAName") then return end
			
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