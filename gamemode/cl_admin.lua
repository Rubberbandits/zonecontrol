function nANotAdmin()
	
	GAMEMODE:AddChat( { CB_ALL, CB_OOC }, "CombineControl.ChatNormal", Color( 200, 0, 0, 255 ), "You need to be an admin to do this." );
	
end
netstream.Hook( "nANotAdmin", nANotAdmin );

function nANotGamemaster()
	
	GAMEMODE:AddChat( { CB_ALL, CB_OOC }, "CombineControl.ChatNormal", Color( 200, 0, 0, 255 ), "You need to be a gamemaster to do this." );
	
end
netstream.Hook( "nANotGamemaster", nANotGamemaster );

function nANotSuperAdmin()
	
	GAMEMODE:AddChat( { CB_ALL, CB_OOC }, "CombineControl.ChatNormal", Color( 200, 0, 0, 255 ), "You need to be a superadmin to do this." );
	
end
netstream.Hook( "nANotSuperAdmin", nANotSuperAdmin );

function nANoTargetSpecified()
	
	GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatNormal", "Error: No target specified.", { CB_ALL, CB_OOC } );
	
end
netstream.Hook( "nANoTargetSpecified", nANoTargetSpecified );

function nANoTargetFound()
	
	GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatNormal", "Error: No target found.", { CB_ALL, CB_OOC } );
	
end
netstream.Hook( "nANoTargetFound", nANoTargetFound );

function nAAdminTarget()
	
	GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatNormal", "Error: You can't do that to admins.", { CB_ALL, CB_OOC } );
	
end
netstream.Hook( "nAAdminTarget", nAAdminTarget );

function nANoDurationSpecified()
	
	GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatNormal", "Error: No duration specified.", { CB_ALL, CB_OOC } );
	
end
netstream.Hook( "nANoDurationSpecified", nANoDurationSpecified );

function nANoValueSpecified()
	
	GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatNormal", "Error: No value specified.", { CB_ALL, CB_OOC } );
	
end
netstream.Hook( "nANoValueSpecified", nANoValueSpecified );

function nANoSecondTargetFound()

	GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatNormal", "Error: Second target not found.", { CB_ALL, CB_OOC } );

end
netstream.Hook( "nANoSecondTargetFound", nANoSecondTargetFound );

function nANegativeDuration()
	
	GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatNormal", "Error: Duration must be greater than or equal to zero.", { CB_ALL, CB_OOC } );
	
end
netstream.Hook( "nANegativeDuration", nANegativeDuration );

function nAInvalidValue()
	
	GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatNormal", "Error: Invalid value specified.", { CB_ALL, CB_OOC } );
	
end
netstream.Hook( "nAInvalidValue", nAInvalidValue );

function nARestart( ply )
	
	GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatHuge", ply:Nick() .. " is restarting the server in five seconds.", { CB_ALL, CB_IC, CB_OOC } );
	
end
netstream.Hook( "nARestart", nARestart );

function nAInvalidMap( tab )
	
	GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatNormal", "Error: Invalid map specified.", { CB_ALL, CB_OOC } );
	
	chat.OldAddText( Color( 128, 128, 128, 255 ), "Valid Maps:" );
	
	for _, v in pairs( tab ) do
		
		chat.OldAddText( Color( 128, 128, 128, 255 ), "\t", Color( 229, 201, 98, 255 ), v );
		
	end
	
end
netstream.Hook( "nAInvalidMap", nAInvalidMap );

function nAChangeMap( ply, map )
	
	GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatHuge", ply:Nick() .. " is changing the map to " .. map .. " in five seconds.", { CB_ALL, CB_IC, CB_OOC } );
	
end
netstream.Hook( "nAChangeMap", nAChangeMap );

function nAKill( nick, ply )

	GAMEMODE:AddChat( Color( 229, 201, 98, 255 ), "CombineControl.ChatNormal", ply:Nick() .. " killed you.", { CB_ALL, CB_OOC } );
	
end
netstream.Hook( "nAKill", nAKill );

function nAExplode( nick, ply )

	GAMEMODE:AddChat( Color( 229, 201, 98, 255 ), "CombineControl.ChatNormal", ply:Nick() .. " exploded you.", { CB_ALL, CB_OOC } );
	
end
netstream.Hook( "nAExplode", nAExplode );

function nASlap( nick, ply )

	GAMEMODE:AddChat( Color( 229, 201, 98, 255 ), "CombineControl.ChatNormal", ply:Nick() .. " slapped you.", { CB_ALL, CB_OOC } );
	
end
netstream.Hook( "nASlap", nASlap );

function nAKO( nick, ply )

	GAMEMODE:AddChat( Color( 229, 201, 98, 255 ), "CombineControl.ChatNormal", ply:Nick() .. " knocked you out.", { CB_ALL, CB_OOC } );
	
end
netstream.Hook( "nAKO", nAKO );

function nAWake( nick, ply )

	GAMEMODE:AddChat( Color( 229, 201, 98, 255 ), "CombineControl.ChatNormal", ply:Nick() .. " woke you up.", { CB_ALL, CB_OOC } );
	
end
netstream.Hook( "nAWake", nAWake );

function nAKick( nick, ply, reason )
	
	if( string.len( reason ) > 0 ) then
		
		GAMEMODE:AddChat( Color( 229, 201, 98, 255 ), "CombineControl.ChatNormal", ply:Nick() .. " kicked " .. nick .. " (" .. reason .. ").", { CB_ALL, CB_OOC } );
		
	else
		
		GAMEMODE:AddChat( Color( 229, 201, 98, 255 ), "CombineControl.ChatNormal", ply:Nick() .. " kicked " .. nick .. ".", { CB_ALL, CB_OOC } );
		
	end
	
end
netstream.Hook( "nAKick", nAKick );

function nARemove( nick, ply )
	
	GAMEMODE:AddChat( Color( 229, 201, 98, 255 ), "CombineControl.ChatNormal", ply:Nick() .. " removed " .. nick .. ".", { CB_ALL, CB_OOC } );
	
end
netstream.Hook( "nARemove", nARemove );

function nASetModel( ply, targ, model )

	if( LocalPlayer() == ply ) then
		
		GAMEMODE:AddChat( Color( 229, 201, 98, 255 ), "CombineControl.ChatNormal", "You set " .. targ:RPName() .. "'s character model to \"" .. model .. "\".", { CB_ALL, CB_OOC } );
		
	else
		
		GAMEMODE:AddChat( Color( 229, 201, 98, 255 ), "CombineControl.ChatNormal", ply:Nick() .. " set your character model to \"" .. model .. "\".", { CB_ALL, CB_OOC } );
		
	end
	
end
netstream.Hook( "nASetModel", nASetModel );

function nAChangeName( ply, targ, old, name )
	
	if( LocalPlayer() == ply ) then
		
		GAMEMODE:AddChat( Color( 229, 201, 98, 255 ), "CombineControl.ChatNormal", "You set " .. old .. "'s character name to \"" .. name .. "\".", { CB_ALL, CB_OOC } );
		
	else
		
		GAMEMODE:AddChat( Color( 229, 201, 98, 255 ), "CombineControl.ChatNormal", ply:Nick() .. " set your character name to \"" .. name .. "\".", { CB_ALL, CB_OOC } );
		
	end
	
end
netstream.Hook( "nAChangeName", nAChangeName );

function nABan( nick, ply, len, reason )
	
	local bantext = "banned";
	
	if( tonumber( len ) == 0 ) then
		
		bantext = "permabanned";
		
	end
	
	local banlen = " for " .. len .. " minutes";
	
	if( tonumber( len ) == 0 ) then
		
		banlen = "";
		
	end
	
	if( string.len( reason ) > 0 ) then
		
		GAMEMODE:AddChat( Color( 229, 201, 98, 255 ), "CombineControl.ChatNormal", ply:Nick() .. " " .. bantext .. " " .. nick .. banlen .. " (" .. reason .. ").", { CB_ALL, CB_OOC } );
		
	else
		
		GAMEMODE:AddChat( Color( 229, 201, 98, 255 ), "CombineControl.ChatNormal", ply:Nick() .. " " .. bantext .. " " .. nick .. banlen .. ".", { CB_ALL, CB_OOC } );
		
	end
	
end
netstream.Hook( "nABan", nABan );

function nAOBan( steam, ply, len, reason )

	local bantext = "Banned";
	
	if( tonumber( len ) == 0 ) then
		
		bantext = "Permabanned";
		
	end
	
	local banlen = " for " .. len .. " minutes";
	
	if( tonumber( len ) == 0 ) then
		
		banlen = "";
		
	end
	
	if( string.len( reason ) > 0 ) then
		
		GAMEMODE:AddChat( Color( 229, 201, 98, 255 ), "CombineControl.ChatNormal", bantext .. " " .. steam .. banlen .. " (" .. reason .. ").", { CB_ALL, CB_OOC } );
		
	else
		
		GAMEMODE:AddChat( Color( 229, 201, 98, 255 ), "CombineControl.ChatNormal", bantext .. " " .. steam .. banlen .. ".", { CB_ALL, CB_OOC } );
		
	end
	
end
netstream.Hook( "nAOBan", nAOBan );

function nAUnBan( steam )

	GAMEMODE:AddChat( Color( 229, 201, 98, 255 ), "CombineControl.ChatNormal", "Unbanned SteamID " .. steam .. ".", { CB_ALL, CB_OOC } );
	
end
netstream.Hook( "nAUnBan", nAUnBan );

function nASeeAll()
	
	GAMEMODE.SeeAll = !GAMEMODE.SeeAll;
	
end
netstream.Hook( "nASeeAll", nASeeAll );

function nASeeAllProps()

	GAMEMODE.SeeAllSavedProps = !GAMEMODE.SeeAllSavedProps;
	
end
netstream.Hook( "nASeeAllProps", nASeeAllProps );

function nASetCharFlags( ply, targ, flag )
	
	if( LocalPlayer() == ply ) then
		
		GAMEMODE:AddChat( Color( 229, 201, 98, 255 ), "CombineControl.ChatNormal", "You set " .. targ:RPName() .. "'s character flag to " .. flag .. " (" .. GAMEMODE:CharFlagPrintName( flag ) .. ").", { CB_ALL, CB_OOC } );
		
	else
		
		GAMEMODE:AddChat( Color( 229, 201, 98, 255 ), "CombineControl.ChatNormal", ply:Nick() .. " set your character flag to " .. flag .. " (" .. GAMEMODE:CharFlagPrintName( flag ) .. ").", { CB_ALL, CB_OOC } );
		
	end
	
end
netstream.Hook( "nASetCharFlags", nASetCharFlags );

function nARemoveCharFlags( ply, targ, flag )
	
	if( LocalPlayer() == ply ) then
		
		GAMEMODE:AddChat( Color( 229, 201, 98, 255 ), "CombineControl.ChatNormal", "You removed " .. targ:RPName() .. "'s character flag.", { CB_ALL, CB_OOC } );
		
	else
		
		GAMEMODE:AddChat( Color( 229, 201, 98, 255 ), "CombineControl.ChatNormal", ply:Nick() .. " removed your character flag.", { CB_ALL, CB_OOC } );
		
	end
	
end
netstream.Hook( "nARemoveCharFlags", nARemoveCharFlags );

function nASetToolTrust( ply, targ, trust )

	local str = "";
	
	if( trust == 0 ) then
		
		str = "basic";
		
	elseif( trust == 1 ) then
		
		str = "advanced";
		
	end
	
	if( LocalPlayer() == ply ) then
		
		GAMEMODE:AddChat( Color( 229, 201, 98, 255 ), "CombineControl.ChatNormal", "You set " .. targ:RPName() .. "'s tooltrust to " .. str .. ".", { CB_ALL, CB_OOC } );
		
	else
		
		GAMEMODE:AddChat( Color( 229, 201, 98, 255 ), "CombineControl.ChatNormal", ply:Nick() .. " set your character flag to " .. str .. ".", { CB_ALL, CB_OOC } );
		
	end
	
end
netstream.Hook( "nASetToolTrust", nASetToolTrust );

function nARemoveToolTrust( ply, targ )

	if( LocalPlayer() == ply ) then
		
		GAMEMODE:AddChat( Color( 229, 201, 98, 255 ), "CombineControl.ChatNormal", "You removed " .. targ:RPName() .. "'s tooltrust.", { CB_ALL, CB_OOC } );
		
	else
		
		GAMEMODE:AddChat( Color( 229, 201, 98, 255 ), "CombineControl.ChatNormal", ply:Nick() .. " removed your tooltrust.", { CB_ALL, CB_OOC } );
		
	end
	
end
netstream.Hook( "nARemoveToolTrust", nARemoveToolTrust );

function nASetPhysTrust( ply, targ )
	
	if( LocalPlayer() == ply ) then
		
		GAMEMODE:AddChat( Color( 229, 201, 98, 255 ), "CombineControl.ChatNormal", "You gave " .. targ:RPName() .. " phystrust.", { CB_ALL, CB_OOC } );
		
	else
		
		GAMEMODE:AddChat( Color( 229, 201, 98, 255 ), "CombineControl.ChatNormal", ply:Nick() .. " gave you phystrust.", { CB_ALL, CB_OOC } );
		
	end
	
end
netstream.Hook( "nASetPhysTrust", nASetPhysTrust );

function nARemovePhysTrust( ply, targ )
	
	if( LocalPlayer() == ply ) then
		
		GAMEMODE:AddChat( Color( 229, 201, 98, 255 ), "CombineControl.ChatNormal", "You removed " .. targ:RPName() .. "'s phystrust.", { CB_ALL, CB_OOC } );
		
	else
		
		GAMEMODE:AddChat( Color( 229, 201, 98, 255 ), "CombineControl.ChatNormal", ply:Nick() .. " removed your phystrust.", { CB_ALL, CB_OOC } );
		
	end
	
end
netstream.Hook( "nARemovePhysTrust", nARemovePhysTrust );

function nASetPropTrust( ply, targ )
	
	if( LocalPlayer() == ply ) then
		
		GAMEMODE:AddChat( Color( 229, 201, 98, 255 ), "CombineControl.ChatNormal", "You gave " .. targ:RPName() .. " proptrust.", { CB_ALL, CB_OOC } );
		
	else
		
		GAMEMODE:AddChat( Color( 229, 201, 98, 255 ), "CombineControl.ChatNormal", ply:Nick() .. " gave you proptrust.", { CB_ALL, CB_OOC } );
		
	end
	
end
netstream.Hook( "nASetPropTrust", nASetPropTrust );

function nARemovePropTrust( ply, targ )
	
	if( LocalPlayer() == ply ) then
		
		GAMEMODE:AddChat( Color( 229, 201, 98, 255 ), "CombineControl.ChatNormal", "You removed " .. targ:RPName() .. "'s proptrust.", { CB_ALL, CB_OOC } );
		
	else
		
		GAMEMODE:AddChat( Color( 229, 201, 98, 255 ), "CombineControl.ChatNormal", ply:Nick() .. " removed your proptrust.", { CB_ALL, CB_OOC } );
		
	end
	
end
netstream.Hook( "nARemovePropTrust", nARemovePropTrust );

function nAPlayMusic( song )

	GAMEMODE:PlayMusic( song );
	
end
netstream.Hook( "nAPlayMusic", nAPlayMusic );

function nAStopMusic()
	
	GAMEMODE:FadeOutMusic();
	
end
netstream.Hook( "nAStopMusic", nAStopMusic );

function nAListItems( filter )
	
	if( filter == "" ) then
		chat.OldAddText( Color( 128, 128, 128, 255 ), "ITEM LIST:" );
	else
		chat.OldAddText( Color( 128, 128, 128, 255 ), "ITEM LIST (FILTER \"" .. filter .. "\"):" );
	end
	
	for k, v in pairs( GAMEMODE.Items ) do
		
		if( !v.EasterEgg ) then
			
			if( string.find( k, filter ) or filter == "" ) then
				
				MsgC( Color( 229, 201, 98, 255 ), k.."\t" )
				MsgC( Color( 128, 128, 128, 255 ), v.Name.."\n" )
				
			end
			
		end
		
	end
	
end
netstream.Hook( "nAListItems", nAListItems );

function nAListArtifacts( filter )
	
	if( filter == "" ) then
		chat.OldAddText( Color( 128, 128, 128, 255 ), "ITEM LIST:" );
	else
		chat.OldAddText( Color( 128, 128, 128, 255 ), "ITEM LIST (FILTER \"" .. filter .. "\"):" );
	end
	
	for k, v in pairs( GAMEMODE.Items ) do
		
		if( !v.EasterEgg and v.Base == "artifact" ) then
			
			if( string.find( k, filter ) or filter == "" ) then
				
				MsgC( Color( 229, 201, 98, 255 ), k.."\t" )
				MsgC( Color( 128, 128, 128, 255 ), v.Name.."\n" )
				
			end
			
		end
		
	end
	
end
netstream.Hook( "nAListArtifacts", nAListArtifacts );

function nARemoveItem( ply, item )

	GAMEMODE:AddChat( Color( 229, 201, 98, 255 ), "CombineControl.ChatNormal", ply:Nick() .. " removed your item \"" .. GAMEMODE:GetItemByID( item ).Name .. "\".", { CB_ALL, CB_OOC } );
	
end
netstream.Hook( "nARemoveItem", nARemoveItem );

function GM:UpdateAdminInventory( inv, targ )
	
	if( !CCP.AdminInv or !CCP.AdminInv:IsValid() ) then return end
	
	CCP.AdminInv.Scroll:Clear();
	
	local x = 0;
	local y = 0;
	
	for k, v in pairs( inv ) do
		
		local i = GAMEMODE:GetItemByID( v.ItemClass );
		
		local icon = vgui.Create( "DModelPanel", CCP.AdminInv.Scroll );
		icon.Item = v.ItemClass;
		icon.InventoryID = k;
		
		icon:SetPos( x, y );
		if( i and i.Model ) then
			icon:SetModel( i.Model );
		end
		icon:SetSize( 48, 48 );
		
		if( i.LookAt ) then
			
			icon:SetFOV( i.FOV );
			icon:SetCamPos( i.CamPos );
			icon:SetLookAt( i.LookAt );
			
		else
			
			local a, b = icon.Entity:GetModelBounds();
			
			icon:SetFOV( 20 );
			icon:SetCamPos( Vector( math.abs( a.x ), math.abs( a.y ), math.abs( a.z ) ) * 5 );
			icon:SetLookAt( ( a + b ) / 2 );
			
		end
		
		if( i.IconMaterial ) then icon.Entity:SetMaterial( i.IconMaterial ) end
		if( i.IconColor ) then icon.Entity:SetColor( i.IconColor ) end
		
		function icon:LayoutEntity() end
		
		x = x + 48 + 10;
		
		if( x > CCP.AdminInv.Scroll:GetWide() - 48 ) then
			
			x = 0;
			y = y + 48 + 10;
			
		end
		
		local p = icon.Paint;
		
		function icon:Paint( w, h )
			
			local pnl = self:GetParent():GetParent();
			local x2, y2 = pnl:LocalToScreen( 0, 0 );
			local w2, h2 = pnl:GetSize();
			render.SetScissorRect( x2, y2, x2 + w2, y2 + h2, true );
			
			p( self, w, h );
			
			render.SetScissorRect( 0, 0, 0, 0, false );
			
		end
		
		function icon:DoClick()
			
			if( CCP.AdminInv.Model.Entity and CCP.AdminInv.Model.Entity:IsValid() ) then
				
				CCP.AdminInv.Model.Entity:SetMaterial( "" );
				CCP.AdminInv.Model.Entity:SetColor( Color( 255, 255, 255, 255 ) );
				
			end
			
			CCP.AdminInv.Model:SetModel( i.Model );
			CCP.AdminInv.Title:SetText( i.Name );
			CCP.AdminInv.Desc:SetText( i.Desc );
			
			if( i.LookAt ) then
				
				CCP.AdminInv.Model:SetFOV( i.FOV );
				CCP.AdminInv.Model:SetCamPos( i.CamPos );
				CCP.AdminInv.Model:SetLookAt( i.LookAt );
				
			else
				
				local a, b = CCP.AdminInv.Model.Entity:GetModelBounds();
				
				CCP.AdminInv.Model:SetFOV( 20 );
				CCP.AdminInv.Model:SetCamPos( Vector( math.abs( a.x ), math.abs( a.y ), math.abs( a.z ) ) * 5 );
				CCP.AdminInv.Model:SetLookAt( ( a + b ) / 2 );
				
			end
			
			if( i.IconMaterial ) then CCP.AdminInv.Model.Entity:SetMaterial( i.IconMaterial ) end
			if( i.IconColor ) then CCP.AdminInv.Model.Entity:SetColor( i.IconColor ) end
			
			local y = 0;
			
			if( CCP.AdminInv.ButThrow and CCP.AdminInv.ButThrow:IsValid() ) then
				
				CCP.AdminInv.ButThrow:Remove();
				
			end
			
			CCP.AdminInv.ButThrow = vgui.Create( "DButton", CCP.AdminInv );
			CCP.AdminInv.ButThrow:SetFont( "CombineControl.LabelSmall" );
			CCP.AdminInv.ButThrow:SetText( "Remove" );
			CCP.AdminInv.ButThrow:SetPos( CCP.AdminInv:GetWide() - 110, CCP.AdminInv:GetTall() - 30 + y );
			CCP.AdminInv.ButThrow:SetSize( 100, 20 );
			function CCP.AdminInv.ButThrow:DoClick()
				
				netstream.Start( "nARemoveItem", targ, self.InventoryID );
				
				if( CCP.AdminInv.InvButtons ) then
					
					for _, v in pairs( CCP.AdminInv.InvButtons ) do
						
						v:Remove();
						
					end
					
				end
				
				if( !CCP.AdminInv.Model or !CCP.AdminInv.Title or !CCP.AdminInv.Desc ) then return end
				
				CCP.AdminInv.Model:SetModel( "" );
				CCP.AdminInv.Title:SetText( "" );
				CCP.AdminInv.Desc:SetText( "No item selected." );
				
				if( #inv == 0 ) then
					
					CCP.AdminInv.Desc:SetText( "They don't have any items." );
					
				end
				
			end
			CCP.AdminInv.ButThrow:PerformLayout();
			CCP.AdminInv.ButThrow.InventoryID = self.InventoryID;
			table.insert( CCP.AdminInv.InvButtons, CCP.AdminInv.ButThrow );
			
		end
		
	end
	
end

function nAEditInventory( targ, inv )
	
	if( !LocalPlayer():IsAdmin() ) then
		
		return;
		
	end
	
	CCP.AdminInv = vgui.Create( "DFrame" );
	CCP.AdminInv:SetSize( 800, 426 );
	CCP.AdminInv:Center();
	CCP.AdminInv:SetTitle( targ:VisibleRPName() .. "'s Inventory" );
	CCP.AdminInv.lblTitle:SetFont( "CombineControl.Window" );
	CCP.AdminInv:MakePopup();
	CCP.AdminInv.PerformLayout = CCFramePerformLayout;
	CCP.AdminInv:PerformLayout();
	CCP.AdminInv.InvButtons = { };
	
	CCP.AdminInv.Model = vgui.Create( "DModelPanel", CCP.AdminInv );
	CCP.AdminInv.Model:SetPos( 420, 34 );
	CCP.AdminInv.Model:SetModel( "" );
	CCP.AdminInv.Model:SetSize( CCP.AdminInv:GetWide() - 430, 200 );
	CCP.AdminInv.Model:SetFOV( 20 );
	CCP.AdminInv.Model:SetCamPos( Vector( 50, 50, 50 ) );
	CCP.AdminInv.Model:SetLookAt( Vector( 0, 0, 0 ) );
	
	function CCP.AdminInv.Model:LayoutEntity() end
	
	local p = CCP.AdminInv.Model.Paint;
	
	function CCP.AdminInv.Model:Paint( w, h )
		
		surface.SetDrawColor( 30, 30, 30, 150 );
		surface.DrawRect( 0, 0, w, h );
		
		surface.SetDrawColor( 20, 20, 20, 100 );
		surface.DrawOutlinedRect( 0, 0, w, h );
		
		p( self, w, h );
		
	end
	
	CCP.AdminInv.Title = vgui.Create( "DLabel", CCP.AdminInv );
	CCP.AdminInv.Title:SetText( "" );
	CCP.AdminInv.Title:SetPos( 420, 244 );
	CCP.AdminInv.Title:SetFont( "CombineControl.LabelGiant" );
	CCP.AdminInv.Title:SetSize( CCP.AdminInv:GetWide() - 430 - 110, 22 );
	CCP.AdminInv.Title:PerformLayout();
	
	CCP.AdminInv.Desc = vgui.Create( "DLabel", CCP.AdminInv );
	CCP.AdminInv.Desc:SetText( "No item selected." );
	CCP.AdminInv.Desc:SetPos( 420, 274 );
	CCP.AdminInv.Desc:SetFont( "CombineControl.LabelSmall" );
	CCP.AdminInv.Desc:SetSize( CCP.AdminInv:GetWide() - 430, 14 );
	CCP.AdminInv.Desc:SetAutoStretchVertical( true );
	CCP.AdminInv.Desc:SetWrap( true );
	CCP.AdminInv.Desc:PerformLayout();
	
	if( #inv == 0 ) then
		
		CCP.AdminInv.Desc:SetText( "They don't have any items." );
		
	end
	
	CCP.AdminInv.Scroll = vgui.Create( "DScrollPanel", CCP.AdminInv );
	CCP.AdminInv.Scroll:SetPos( 10, 34 );
	CCP.AdminInv.Scroll:SetSize( 400, CCP.AdminInv:GetTall() - 50 );
	function CCP.AdminInv.Scroll:Paint( w, h )
		
		surface.SetDrawColor( 30, 30, 30, 150 );
		surface.DrawRect( 0, 0, w, h );
		
		surface.SetDrawColor( 20, 20, 20, 100 );
		surface.DrawOutlinedRect( 0, 0, w, h );
		
	end
	
	GAMEMODE:UpdateAdminInventory( inv, targ );
	
end
netstream.Hook( "nAEditInventory", nAEditInventory );

function nAUpdateInventory( ply, tab )
	
	if( !LocalPlayer():IsAdmin() ) then
		
		return;
		
	end
	
	GAMEMODE:UpdateAdminInventory( tab, ply );
	
end
netstream.Hook( "nAUpdateInventory", nAUpdateInventory );

function nAStopSound()
	
	RunConsoleCommand( "stopsound" );
	
end
netstream.Hook( "nAStopSound", nAStopSound );

local function nPrintUsingSeeAll(tbl)
	print("Players using SeeAll:")
	for k,v in next, tbl do
		print(v:GetName())
	end
end
netstream.Hook("nPrintUsingSeeAll", nPrintUsingSeeAll)