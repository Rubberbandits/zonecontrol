local function OpenItemRequest( ply, args )
	ply:SendLua("vgui.Create('zc_itemrequest')") -- lmaooooo
end
concommand.AddGamemaster( "rpg_createitem", OpenItemRequest );