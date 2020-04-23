GM.TimedProgressBars = { };

function GM:CreateTimedProgressBar( time, text, ply, cb, no_cancel )
	
	table.insert( self.TimedProgressBars, {
		Start = CurTime(),
		End = CurTime() + time,
		Text = text,
		Player = ply,
		CB = cb,
		no_cancel = no_cancel,
	} );
	
end

function nCreateTimedProgressBar( t, text, targ, no_cancel )
	
	GAMEMODE:CreateTimedProgressBar( t, text, targ, function() end, no_cancel );
	
end
netstream.Hook( "nCreateTimedProgressBar", nCreateTimedProgressBar );

function nCPattedDown( inv )
	
	local panel = vgui.Create( "DFrame" );
	panel:SetSize( 800, 426 );
	panel:Center();
	panel:SetTitle( "Inventory" );
	panel.lblTitle:SetFont( "CombineControl.Window" );
	panel:MakePopup();
	panel.PerformLayout = CCFramePerformLayout;
	panel:PerformLayout();
	
	local model = vgui.Create( "DModelPanel", panel );
	model:SetPos( 420, 34 );
	model:SetModel( "" );
	model:SetSize( panel:GetWide() - 430, 200 );
	model:SetFOV( 20 );
	model:SetCamPos( Vector( 50, 50, 50 ) );
	model:SetLookAt( Vector( 0, 0, 0 ) );
	
	function model:LayoutEntity() end
	
	local p = model.Paint;
	
	function model:Paint( w, h )
		
		surface.SetDrawColor( 30, 30, 30, 150 );
		surface.DrawRect( 0, 0, w, h );
		
		surface.SetDrawColor( 20, 20, 20, 100 );
		surface.DrawOutlinedRect( 0, 0, w, h );
		
		p( self, w, h );
		
	end
	
	local title = vgui.Create( "DLabel", panel );
	title:SetText( "" );
	title:SetPos( 420, 244 );
	title:SetFont( "CombineControl.LabelGiant" );
	title:SetSize( panel:GetWide() - 430 - 110, 22 );
	title:PerformLayout();
	
	local desc = vgui.Create( "DLabel", panel );
	desc:SetText( "No item selected." );
	desc:SetPos( 420, 274 );
	desc:SetFont( "CombineControl.LabelSmall" );
	desc:SetSize( panel:GetWide() - 430, 14 );
	desc:SetAutoStretchVertical( true );
	desc:SetWrap( true );
	desc:PerformLayout();
	
	if( #inv == 0 ) then
		
		desc:SetText( "They don't have any items." );
		
	end
	
	local scroll = vgui.Create( "DScrollPanel", panel );
	scroll:SetPos( 10, 34 );
	scroll:SetSize( 400, panel:GetTall() - 50 );
	function scroll:Paint( w, h )
		
		surface.SetDrawColor( 30, 30, 30, 150 );
		surface.DrawRect( 0, 0, w, h );
		
		surface.SetDrawColor( 20, 20, 20, 100 );
		surface.DrawOutlinedRect( 0, 0, w, h );
		
	end
	
	local x = 0;
	local y = 0;
	
	for k, v in next, inv do
		
		local icon = vgui.Create( "DModelPanel", scroll );
		local metaitem = GAMEMODE:GetItemByID(v[1])
		local vars = v[2]
		
		icon:SetPos( x, y );
		icon:SetModel( vars["Model"] or metaitem.Model );
		icon:SetSize( 48, 48 );
		
		if( metaitem.LookAt ) then
			
			icon:SetFOV( metaitem.FOV );
			icon:SetCamPos( metaitem.CamPos );
			icon:SetLookAt( metaitem.LookAt );
			
		else
			
			local a, b = icon.Entity:GetModelBounds();
			
			icon:SetFOV( 20 );
			icon:SetCamPos( Vector( math.abs( a.x ), math.abs( a.y ), math.abs( a.z ) ) * 5 );
			icon:SetLookAt( ( a + b ) / 2 );
			
		end
		
		if( metaitem.IconMaterial ) then icon.Entity:SetMaterial( metaitem.IconMaterial ) end
		if( metaitem.IconColor ) then icon.Entity:SetColor( metaitem.IconColor ) end
		
		function icon:LayoutEntity() end
		
		x = x + 48 + 10;
		
		if( x > scroll:GetWide() - 48 ) then
			
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
			
			if( model.Entity and model.Entity:IsValid() ) then
				
				model.Entity:SetMaterial( "" );
				model.Entity:SetColor( Color( 255, 255, 255, 255 ) );
				
			end
			
			model:SetModel( vars["Model"] or metaitem.Model );
			title:SetText( vars["Name"] or metaitem.Name );
			desc:SetText( vars["Desc"] or metaitem.Desc );
			
			if( metaitem.LookAt ) then
				
				model:SetFOV( metaitem.FOV );
				model:SetCamPos( metaitem.CamPos );
				model:SetLookAt( metaitem.LookAt );
				
			else
				
				local a, b = model.Entity:GetModelBounds();
				
				model:SetFOV( 20 );
				model:SetCamPos( Vector( math.abs( a.x ), math.abs( a.y ), math.abs( a.z ) ) * 5 );
				model:SetLookAt( ( a + b ) / 2 );
				
			end
			
			if( metaitem.IconMaterial ) then model.Entity:SetMaterial( metaitem.IconMaterial ) end
			if( metaitem.IconColor ) then model.Entity:SetColor( metaitem.IconColor ) end
			
		end
		
	end
	
end
netstream.Hook( "nCPattedDown", nCPattedDown );

function GM:GetCCOptions( ent, dist )
	
	local tab = { };
	
	if( ent and ent:IsValid() and ent:GetClass() == "prop_ragdoll" ) then
		
		for _, v in pairs( player.GetAll() ) do
			
			if( v:Ragdoll() and v:Ragdoll():IsValid() and v:Ragdoll() == ent ) then
				
				ent = v;
				CCSelectedEnt = ent;
				
			end
			
		end
		
	end
	
	if( ent and ent:IsValid() ) then
		
		if( ent:IsDoor() ) then
			
			if( LocalPlayer():TiedUp() ) then return tab end
			if( LocalPlayer():PassedOut() ) then return tab end
			
			if( ( ent:DoorType() == DOOR_BUYABLE or ent:DoorType() == DOOR_BUYABLE_ASSIGNABLE ) and #ent:DoorOwners() == 0 and #ent:DoorAssignedOwners() == 0 and LocalPlayer():CombineBuyDoors() ) then
				
				local option = { "Buy", function()
					
					if( LocalPlayer():Money() >= ent:DoorPrice() ) then
						
						netstream.Start( "nCBuyDoor", ent );
						
					else
						
						self:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatNormal", "You need more money to do that!", { CB_ALL, CB_IC } );
						
					end
					
				end, nil, 100 };
				
				table.insert( tab, option );
				
			elseif( ( ent:DoorType() == DOOR_BUYABLE or ent:DoorType() == DOOR_BUYABLE_ASSIGNABLE ) and table.HasValue( ent:DoorOwners(), LocalPlayer():CharID() ) ) then
				
				local option = { "Sell", function()
					
					netstream.Start( "nCSellDoor", ent );
					
					self:AddChat( Color( 229, 201, 98, 255 ), "CombineControl.ChatNormal", "You sold the door for 80% of its original value (" .. tostring( math.floor( ent:DoorPrice() * 0.8 ) ) .. " rubles).", { CB_ALL, CB_IC } );
					
				end, nil, 100 };
				
				table.insert( tab, option );
				
			end
			
			if( table.HasValue( ent:DoorOwners(), LocalPlayer():CharID() ) ) then
				
				local option = { "Rename", function()
					
					self:CCCreateDoorNameEdit();
					
				end, nil, 100 };
				
				table.insert( tab, option );
				
				local option = { "Manage Owners", function()
					
					self:CCCreateDoorOwnersEdit();
					
				end, nil, 100 };
				
				table.insert( tab, option );
				
			end
			
			if( LocalPlayer():CanLock( ent ) ) then
				
				local option = { "Lock/Unlock", function()
					
					netstream.Start( "nCLockUnlock", ent );
					
				end, nil, 100 };
				
				table.insert( tab, option );
				
			end
			
		elseif( ent:IsPlayer() ) then
			
			local option = { "Examine", function()
				
				self:CCCreatePlayerViewer( CCSelectedEnt );
				netstream.Start( "nCExamine" );
				
			end, nil, self:GetPlayerSight() };
			
			table.insert( tab, option );
			
			if( LocalPlayer():TiedUp() ) then return tab end
			if( LocalPlayer():PassedOut() ) then return tab end
			
			if ent:Alive() then
				local option = { "Give Rubles", function()
					
					self:CCCreateGiveCredits();
					
				end, nil, 100 };
				
				table.insert( tab, option );
				
				local option = { "Pat Down", function()
					
					netstream.Start( "nCPatDownStart", ent );
					
					local mul = 1;
					
					GAMEMODE:CreateTimedProgressBar( 5 * mul, "Patting Down...", ent, function()
						
						netstream.Start( "nCPatDown", ent );
						
					end );
					
				end, nil, 100 };
				
				table.insert( tab, option );
				
				if( ent:TiedUp() and !ent:IsWounded() ) then
					
					local option = { "Untie", function()
						
						netstream.Start( "nCUntieStart", ent );
						
						GAMEMODE:CreateTimedProgressBar( 2, "Untying...", ent, function()
							
							netstream.Start( "nCUntie", ent );
							
						end );
						
					end, nil, 100 };
					
					table.insert( tab, option );
					
				elseif( LocalPlayer():HasItem( "zipties" ) ) then
					
					local option = { "Tie Up", function()
						
						netstream.Start( "nCTieUpStart", ent );
						
						GAMEMODE:CreateTimedProgressBar( 5, "Tying...", ent, function()
							
							netstream.Start( "nCTieUp", ent );
							
						end );
						
					end, nil, 100 };
					
					table.insert( tab, option );
					
				end
				
				if ent:IsWounded() then
					local option = { "Treat", function()
						
						netstream.Start( "nCTreatStart", ent );
						
						GAMEMODE:CreateTimedProgressBar( 10, "Treating...", ent, function()
							
							netstream.Start( "nCTreat", ent );
							
						end );
						
					end, nil, 100 };
					
					table.insert( tab, option );
				end
			elseif !ent:Alive() and ent:InDeathState() and (LocalPlayer():HasItem("med_medkit") or LocalPlayer():HasCharFlag("D")) then
				local option = { "Revive", function()
					
					netstream.Start( "nCReviveStart", ent );
					
					GAMEMODE:CreateTimedProgressBar( 10, "Reviving...", ent, function()
						
						netstream.Start( "nCRevive", ent );
						
					end );
					
				end, nil, 64 };
				
				table.insert( tab, option );
			end
			
			if( ent:PassedOut() and LocalPlayer():HasItem( "weapon_cc_knife" ) and ent:GetVelocity():Length2D() <= 5 ) then
				
				local option = { "Slit Throat", function()
					
					netstream.Start( "nCSlitThroat", ent );
					
				end, nil, 100 };
				
				table.insert( tab, option );
				
			end
			
		elseif( ent:GetClass() == "cc_item" ) then
			
			if( string.len( GAMEMODE:GetItemByID( ent:GetItemClass() ).Desc) > 0 ) then
				
				local option = { "Examine", function()
					
					self:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", GAMEMODE:GetItemByID( ent:GetItemClass() ).Desc, { CB_ALL, CB_IC } );
					
					netstream.Start( "nCExamine" );
					
				end, nil, 100 };
				
				table.insert( tab, option );
				
			end
			
		elseif( ent:GetClass() == "cc_radio" ) then
			
			if( LocalPlayer():CharID() == ent:GetDeployer() ) then
				
				local option = { "Take", function()
					
					netstream.Start( "nCTakeRadio", ent );
					
				end, nil, 100 };
				
				table.insert( tab, option );
				
			end
			
			local option = { "Channel", function()
				
				CCP.RadioSelector = vgui.Create( "DFrame" );
				CCP.RadioSelector:SetSize( 250, 114 );
				CCP.RadioSelector:Center();
				CCP.RadioSelector:SetTitle( "Change Channel (0-999)" );
				CCP.RadioSelector.lblTitle:SetFont( "CombineControl.Window" );
				CCP.RadioSelector:MakePopup();
				CCP.RadioSelector.PerformLayout = CCFramePerformLayout;
				CCP.RadioSelector:PerformLayout();
				
				CCP.RadioSelector.Entry = vgui.Create( "DTextEntry", CCP.RadioSelector );
				CCP.RadioSelector.Entry:SetFont( "CombineControl.LabelBig" );
				CCP.RadioSelector.Entry:SetPos( 10, 34 );
				CCP.RadioSelector.Entry:SetSize( 100, 30 );
				CCP.RadioSelector.Entry:PerformLayout();
				CCP.RadioSelector.Entry:RequestFocus();
				CCP.RadioSelector.Entry:SetNumeric( true );
				CCP.RadioSelector.Entry:SetValue( ent:GetChannel() );
				CCP.RadioSelector.Entry:SetCaretPos( string.len( CCP.RadioSelector.Entry:GetValue() ) );
				
				CCP.RadioSelector.OK = vgui.Create( "DButton", CCP.RadioSelector );
				CCP.RadioSelector.OK:SetFont( "CombineControl.LabelSmall" );
				CCP.RadioSelector.OK:SetText( "OK" );
				CCP.RadioSelector.OK:SetPos( 190, 74 );
				CCP.RadioSelector.OK:SetSize( 50, 30 );
				function CCP.RadioSelector.OK:DoClick()
					
					local val = tonumber( CCP.RadioSelector.Entry:GetValue() );
					
					if( val >= 0 ) then
						
						if( val <= 999 ) then
							
							CCP.RadioSelector:Remove();
							
							GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "You change the radio channel to " .. tostring( val ) .. ".", { CB_ALL, CB_IC } );
							
							netstream.Start( "nCRadioChannel", ent, val );
							
						else
							
							GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatNormal", "Highest channel is 999.", { CB_ALL, CB_IC } );
							
						end
						
					else
						
						GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatNormal", "Lowest channel is 0.", { CB_ALL, CB_IC } );
						
					end
					
				end
				CCP.RadioSelector.OK:PerformLayout();
				
				CCP.RadioSelector.Entry.OnEnter = CCP.RadioSelector.OK.DoClick;
				
			end, nil, 100 };
			
			table.insert( tab, option );
			
		elseif( ent:GetClass() == "cc_paper" ) then
			
			local option = { "Read", function()
				
				netstream.Start( "nCExamine" );
				
				local paper = vgui.Create( "DFrame" );
				paper:SetSize( 400, 600 );
				paper:Center();
				paper:SetTitle( "" );
				paper:MakePopup();
				paper.PerformLayout = CCFramePerformLayout;
				paper:PerformLayout();
				paper.Paint = function( panel, w, h )
					
					surface.SetDrawColor( 255, 255, 255, 255 );
					surface.DrawRect( 0, 0, w, h );
					
				end
				
				local entry = vgui.Create( "DTextEntry", paper );
				entry:SetFont( "CombineControl.Written" );
				entry:SetPos( 10, 34 );
				entry:SetSize( 380, 526 );
				entry:SetMultiline( true );
				entry:PerformLayout();
				entry:SetTextColor( Color( 0, 0, 0, 255 ) )
				entry:SetDrawBackground( false );
				entry:SetValue( ent:GetText() );
				entry:SetEditable( false );
				
			end, nil, 100 };
			
			table.insert( tab, option );
			
		end
		
	end
	
	if( GAMEMODE.VoicesEnabled and GAMEMODE.Voices[LocalPlayer():Gender()] ) then
		
		for k, v in pairs( GAMEMODE.Voices[LocalPlayer():Gender()] ) do
		
			if( isstring( v[1] ) and !istable( v[2] ) ) then
			
				local option = { "Voice: " .. v[1], function()
					
					netstream.Start( "nSayVoice", k, 0 );
					
				end, true };
				
				table.insert( tab, option );
				
			elseif( isstring( v[1] ) and istable( v[2] ) ) then
			
				local option = { "Category: " .. v[1], {}, true };
				
				for a,b in next, v[2] do 
				
					table.insert( option[2], { "Voice: " .. b[1], function()

						netstream.Start( "nSayVoice", k, a );
					
					end, true } );
				
				end
				
				table.insert( tab, option );
			
			end
			
		end
		
	end
	
	return tab;
	
end

function GM:CCCreateDoorNameEdit()
	
	CCP.DoorNameEdit = vgui.Create( "DFrame" );
	CCP.DoorNameEdit:SetSize( 300, 114 );
	CCP.DoorNameEdit:Center();
	CCP.DoorNameEdit:SetTitle( "Change Door Name" );
	CCP.DoorNameEdit.lblTitle:SetFont( "CombineControl.Window" );
	CCP.DoorNameEdit:MakePopup();
	CCP.DoorNameEdit.PerformLayout = CCFramePerformLayout;
	CCP.DoorNameEdit:PerformLayout();
	
	CCP.DoorNameEdit.Label = vgui.Create( "DLabel", CCP.DoorNameEdit );
	CCP.DoorNameEdit.Label:SetText( string.len( CCSelectedEnt:DoorName() ) .. "/50" );
	CCP.DoorNameEdit.Label:SetPos( 10, 74 );
	CCP.DoorNameEdit.Label:SetSize( 280, 22 );
	CCP.DoorNameEdit.Label:SetFont( "CombineControl.LabelGiant" );
	CCP.DoorNameEdit.Label:PerformLayout();
	
	CCP.DoorNameEdit.Entry = vgui.Create( "DTextEntry", CCP.DoorNameEdit );
	CCP.DoorNameEdit.Entry:SetFont( "CombineControl.LabelBig" );
	CCP.DoorNameEdit.Entry:SetPos( 10, 34 );
	CCP.DoorNameEdit.Entry:SetSize( 280, 30 );
	CCP.DoorNameEdit.Entry:PerformLayout();
	CCP.DoorNameEdit.Entry:SetValue( CCSelectedEnt:DoorName() );
	CCP.DoorNameEdit.Entry:RequestFocus();
	CCP.DoorNameEdit.Entry:SetCaretPos( string.len( CCP.DoorNameEdit.Entry:GetValue() ) );
	function CCP.DoorNameEdit.Entry:OnChange()
		
		if( CCP.DoorNameEdit.Label ) then
			
			local val = self:GetValue();
			
			local col = Color( 200, 200, 200, 255 );
			
			if( string.len( string.Trim( val ) ) > 50 or string.len( string.Trim( val ) ) < 1 ) then
				
				col = Color( 200, 0, 0, 255 );
				
			end
			
			CCP.DoorNameEdit.Label:SetText( string.len( string.Trim( val ) ) .. "/50" );
			CCP.DoorNameEdit.Label:SetTextColor( col );
			
		end
		
	end
	
	CCP.DoorNameEdit.OK = vgui.Create( "DButton", CCP.DoorNameEdit );
	CCP.DoorNameEdit.OK:SetFont( "CombineControl.LabelSmall" );
	CCP.DoorNameEdit.OK:SetText( "OK" );
	CCP.DoorNameEdit.OK:SetPos( 240, 74 );
	CCP.DoorNameEdit.OK:SetSize( 50, 30 );
	function CCP.DoorNameEdit.OK:DoClick()
		
		local val = string.Trim( CCP.DoorNameEdit.Entry:GetValue() );
		
		if( string.len( val ) <= 50 and string.len( val ) >= 1 ) then
			
			CCP.DoorNameEdit:Remove();
			netstream.Start( "nCNameDoor", CCSelectedEnt, val );
			
		else
			
			GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatNormal", "Error: Name must be between 1 and 50 characters.", { CB_ALL, CB_OOC } );
			
		end
		
	end
	CCP.DoorNameEdit.OK:PerformLayout();
	
	CCP.DoorNameEdit.Entry.OnEnter = CCP.DoorNameEdit.OK.DoClick;
	
end

function GM:CCCreateDoorOwnersEdit()
	
	CCP.DoorOwnersEdit = vgui.Create( "DFrame" );
	CCP.DoorOwnersEdit:SetSize( 400, 504 );
	CCP.DoorOwnersEdit:Center();
	CCP.DoorOwnersEdit:SetTitle( "Manage Door Owners" );
	CCP.DoorOwnersEdit.lblTitle:SetFont( "CombineControl.Window" );
	CCP.DoorOwnersEdit:MakePopup();
	CCP.DoorOwnersEdit.PerformLayout = CCFramePerformLayout;
	CCP.DoorOwnersEdit:PerformLayout();
	
	CCP.DoorOwnersEdit.AllPlayers = vgui.Create( "DListView", CCP.DoorOwnersEdit );
	CCP.DoorOwnersEdit.AllPlayers:SetPos( 10, 34 );
	CCP.DoorOwnersEdit.AllPlayers:SetSize( 185, 430 );
	CCP.DoorOwnersEdit.AllPlayers:AddColumn( "Characters" );
	
	for k, v in pairs( player.GetAll() ) do
		
		if( !table.HasValue( CCSelectedEnt:DoorOwners(), v:CharID() ) and !table.HasValue( CCSelectedEnt:DoorAssignedOwners(), v:CharID() ) ) then
			
			CCP.DoorOwnersEdit.AllPlayers:AddLine( v:VisibleRPName() ).Player = v;
			
		end
		
	end
	
	CCP.DoorOwnersEdit.Owners = vgui.Create( "DListView", CCP.DoorOwnersEdit );
	CCP.DoorOwnersEdit.Owners:SetPos( 205, 34 );
	CCP.DoorOwnersEdit.Owners:SetSize( 185, 430 );
	CCP.DoorOwnersEdit.Owners:AddColumn( "Owners" );
	
	for k, v in pairs( CCSelectedEnt:DoorOwners() ) do
		
		if( v != LocalPlayer():CharID() ) then
			
			if( player.GetByCharID( v ) and player.GetByCharID( v ):IsValid() ) then
				
				CCP.DoorOwnersEdit.Owners:AddLine( player.GetByCharID( v ):VisibleRPName() ).Player = player.GetByCharID( v );
				
			end
			
		end
		
	end
	
	CCP.DoorOwnersEdit.MakeOwner = vgui.Create( "DButton", CCP.DoorOwnersEdit );
	CCP.DoorOwnersEdit.MakeOwner:SetFont( "CombineControl.LabelSmall" );
	CCP.DoorOwnersEdit.MakeOwner:SetText( ">" );
	CCP.DoorOwnersEdit.MakeOwner:SetPos( 10, 474 );
	CCP.DoorOwnersEdit.MakeOwner:SetSize( 185, 20 );
	function CCP.DoorOwnersEdit.MakeOwner:DoClick()
		
		if( !CCP.DoorOwnersEdit.AllPlayers:GetSelected()[1] ) then return end
		
		local ply = CCP.DoorOwnersEdit.AllPlayers:GetSelected()[1].Player;
		
		netstream.Start( "nCMakeOwner", CCSelectedEnt, ply );
		
		CCP.DoorOwnersEdit.AllPlayers:RemoveLine( CCP.DoorOwnersEdit.AllPlayers:GetSelected()[1]:GetID() );
		CCP.DoorOwnersEdit.Owners:AddLine( ply:VisibleRPName() ).Player = ply;
		
	end
	CCP.DoorOwnersEdit.MakeOwner:PerformLayout();
	
	CCP.DoorOwnersEdit.RemoveOwner = vgui.Create( "DButton", CCP.DoorOwnersEdit );
	CCP.DoorOwnersEdit.RemoveOwner:SetFont( "CombineControl.LabelSmall" );
	CCP.DoorOwnersEdit.RemoveOwner:SetText( "<" );
	CCP.DoorOwnersEdit.RemoveOwner:SetPos( 205, 474 );
	CCP.DoorOwnersEdit.RemoveOwner:SetSize( 185, 20 );
	function CCP.DoorOwnersEdit.RemoveOwner:DoClick()
		
		if( !CCP.DoorOwnersEdit.Owners:GetSelected()[1] ) then return end
		
		local ply = CCP.DoorOwnersEdit.Owners:GetSelected()[1].Player;
		
		netstream.Start( "nCRemoveOwner", CCSelectedEnt, ply );
		
		CCP.DoorOwnersEdit.Owners:RemoveLine( CCP.DoorOwnersEdit.Owners:GetSelected()[1]:GetID() );
		CCP.DoorOwnersEdit.AllPlayers:AddLine( ply:VisibleRPName() ).Player = ply;
		
	end
	CCP.DoorOwnersEdit.RemoveOwner:PerformLayout();
	
end

function GM:CCCreateGiveCredits()
	
	CCP.GiveCredits = vgui.Create( "DFrame" );
	CCP.GiveCredits:SetSize( 250, 114 );
	CCP.GiveCredits:Center();
	CCP.GiveCredits:SetTitle( "Give Rubles" );
	CCP.GiveCredits.lblTitle:SetFont( "CombineControl.Window" );
	CCP.GiveCredits:MakePopup();
	CCP.GiveCredits.PerformLayout = CCFramePerformLayout;
	CCP.GiveCredits:PerformLayout();
	
	CCP.GiveCredits.Entry = vgui.Create( "DTextEntry", CCP.GiveCredits );
	CCP.GiveCredits.Entry:SetFont( "CombineControl.LabelBig" );
	CCP.GiveCredits.Entry:SetPos( 10, 34 );
	CCP.GiveCredits.Entry:SetSize( 100, 30 );
	CCP.GiveCredits.Entry:PerformLayout();
	CCP.GiveCredits.Entry:RequestFocus();
	CCP.GiveCredits.Entry:SetNumeric( true );
	CCP.GiveCredits.Entry:SetCaretPos( string.len( CCP.GiveCredits.Entry:GetValue() ) );
	
	CCP.GiveCredits.Label = vgui.Create( "DLabel", CCP.GiveCredits );
	CCP.GiveCredits.Label:SetText( "Rubles" );
	CCP.GiveCredits.Label:SetPos( 120, 34 );
	CCP.GiveCredits.Label:SetSize( 130, 30 );
	CCP.GiveCredits.Label:SetFont( "CombineControl.LabelBig" );
	CCP.GiveCredits.Label:PerformLayout();
	
	CCP.GiveCredits.OK = vgui.Create( "DButton", CCP.GiveCredits );
	CCP.GiveCredits.OK:SetFont( "CombineControl.LabelSmall" );
	CCP.GiveCredits.OK:SetText( "OK" );
	CCP.GiveCredits.OK:SetPos( 190, 74 );
	CCP.GiveCredits.OK:SetSize( 50, 30 );
	function CCP.GiveCredits.OK:DoClick()
		
		if( !CCSelectedEnt or !CCSelectedEnt:IsValid() ) then return end
		
		local val = tonumber( CCP.GiveCredits.Entry:GetValue() );
		
		if( !val or math.floor( val ) < 1 ) then
			
			CCP.GiveCredits:Remove();
			return;
			
		end
		
		if( LocalPlayer():GetPos():Distance( CCSelectedEnt:GetPos() ) > 100 ) then
			
			GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "They're too far away.", { CB_ALL, CB_OOC } );
			return;
			
		end
		
		val = math.floor( val );
		
		if( LocalPlayer():Money() >= val ) then
			
			CCP.GiveCredits:Remove();
			
			netstream.Start( "nCGiveCredits", val, CCSelectedEnt );
			
		else
			
			GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatNormal", "You don't have this many rubles!", { CB_ALL, CB_OOC } );
			
		end
		
	end
	CCP.GiveCredits.OK:PerformLayout();
	
	CCP.GiveCredits.Entry.OnEnter = CCP.GiveCredits.OK.DoClick;
	
end

function GM:CCCreatePlayerViewer( ent )
   
    if( !ent or !ent:IsValid() ) then return end
   
    CCP.PlayerViewer = vgui.Create( "DFrame" );
    CCP.PlayerViewer:SetSize( 700, 426 );
    CCP.PlayerViewer:Center();
    CCP.PlayerViewer:SetTitle( "" );
    CCP.PlayerViewer.lblTitle:SetFont( "CombineControl.Window" );
    CCP.PlayerViewer:MakePopup();
    CCP.PlayerViewer.PerformLayout = CCFramePerformLayout;
    CCP.PlayerViewer:PerformLayout();
    function CCP.PlayerViewer:Paint( w, h )
   
        DisableClipping( true );
        surface.SetDrawColor( 255, 255, 255, 255 );
        surface.SetMaterial( matFrame );
        surface.DrawTexturedRectUV( 0, -20, w + 10, h + 10, 0.3, 0.42, 0.9, 0.82 );
        DisableClipping( false );
   
    end
   
    CCP.PlayerViewer.CharacterModel = vgui.Create( "CCharPanel", CCP.PlayerViewer );
    CCP.PlayerViewer.CharacterModel:SetPos( 10, 66 );
    CCP.PlayerViewer.CharacterModel:SetModel( ent:GetModel() );
    CCP.PlayerViewer.CharacterModel.Entity:SetSkin( ent:GetSkin() );
    for i = 0,  20 do
        CCP.PlayerViewer.CharacterModel.Entity:SetBodygroup( i, ent:GetBodygroup( i ) );
        CCP.PlayerViewer.CharacterModel.Entity:SetSubMaterial( i, ent:GetSubMaterial( i ) );
    end
   
    CCP.PlayerViewer.CharacterModel:SetSize( 290, 320 );
    CCP.PlayerViewer.CharacterModel:SetFOV( 32 );
    CCP.PlayerViewer.CharacterModel:SetCamPos( Vector( 50, 0, 56 ) );
    CCP.PlayerViewer.CharacterModel:SetLookAt( Vector( 0, 0, 56 ) );
    function CCP.PlayerViewer.CharacterModel:DoClick()
       
        self:StartScene( "scenes/expressions/citizen_angry_idle_01.vcd" );
       
    end
    function CCP.PlayerViewer.CharacterModel.Entity:GetPlayerColor()
       
        if( !ent or !ent:IsValid() ) then return Vector( 1, 1, 1 ) end
       
        return ent:GetPlayerColor();
       
    end
	if self.BonemergeBodies[ent] then
		CCP.PlayerViewer.CharacterModel:InitializeModel(self.BonemergeBodies[ent]:GetModel(), CCP.PlayerViewer.CharacterModel.Entity)
	end
	for id,item in next, GAMEMODE.BonemergeItems do
		if item.Owner != ent then continue end
		if !item.Vars["Equipped"] then continue end
		local metaitem = GAMEMODE:GetItemByID(item.szClass)
		
		local mdl = CCP.PlayerViewer.CharacterModel:InitializeModel(metaitem.Bonemerge,CCP.PlayerViewer.CharacterModel.Entity)
		if metaitem.Bodygroups then
			for k,v in next, metaitem.Bodygroups do
				mdl:SetBodygroup(v[1], v[2])
			end
		end
		
		if metaitem.Submaterials then
			for _,submaterial in next, metaitem.Submaterials do
				mdl:SetSubMaterial( submaterial[1], submaterial[2] );
			end
		end
		
		if item.Vars["SuitClass"] and self.SuitVariants[item.Vars["SuitClass"]] then
			local suit = self.SuitVariants[item.Vars["SuitClass"]]
			if suit.Submaterial then
				for _,submaterial in next, suit.Submaterial do
					mdl:SetSubMaterial(submaterial[1], submaterial[2])
				end
			end
		end
		
		if metaitem.HelmetBodygroup then
			if item.Vars["HelmetEquipped"] then
				mdl:SetBodygroup(metaitem.HelmetBodygroup[1], metaitem.HelmetBodygroup[2])
			else
				if metaitem.Bodygroups then
					for _,bodygroup in next, metaitem.Bodygroups do
						mdl:SetBodygroup(bodygroup[1], bodygroup[2])
					end
				else
					mdl:SetBodygroup(0, 0)
				end
			end
		end
	end
   
    CCP.PlayerViewer.CharacterInfo = vgui.Create( "DPanel", CCP.PlayerViewer );
    CCP.PlayerViewer.CharacterInfo:SetPos( 320, 70 );
    CCP.PlayerViewer.CharacterInfo:SetSize( 360, 318 );
    function CCP.PlayerViewer.CharacterInfo:Paint( w, h )
       
    end
   
    CCP.PlayerViewer.CharacterName = vgui.Create( "DLabel", CCP.PlayerViewer.CharacterInfo );
    CCP.PlayerViewer.CharacterName:SetText( ent:VisibleRPName() );
    CCP.PlayerViewer.CharacterName:SetSize( 540, 22 );
    CCP.PlayerViewer.CharacterName:Dock( TOP );
    CCP.PlayerViewer.CharacterName:SetFont( "CombineControl.LabelGiant" );
    CCP.PlayerViewer.CharacterName:PerformLayout();
   
    CCP.PlayerViewer.CharacterTitleOne = vgui.Create( "CCLabel", CCP.PlayerViewer.CharacterInfo );
    CCP.PlayerViewer.CharacterTitleOne:SetSize( 350, 10 );
    CCP.PlayerViewer.CharacterTitleOne:Dock( TOP );
    CCP.PlayerViewer.CharacterTitleOne:SetFont( "CombineControl.LabelSmall" );
    CCP.PlayerViewer.CharacterTitleOne:SetWrap( true );
    CCP.PlayerViewer.CharacterTitleOne:SetText( ent:TitleOne() );
    CCP.PlayerViewer.CharacterTitleOne:SizeToContents();
    --CCP.PlayerViewer.CharacterTitleOne:SetAutoStretchVertical( true );
    CCP.PlayerViewer.CharacterTitleOne:PerformLayout();
   
    CCP.PlayerViewer.CharacterTitleTwo = vgui.Create( "CCLabel", CCP.PlayerViewer.CharacterInfo );
    CCP.PlayerViewer.CharacterTitleTwo:SetSize( 350, 10 );
    CCP.PlayerViewer.CharacterTitleTwo:Dock( TOP );
    CCP.PlayerViewer.CharacterTitleTwo:SetFont( "CombineControl.LabelSmall" );
    CCP.PlayerViewer.CharacterTitleTwo:SetWrap( true );
    CCP.PlayerViewer.CharacterTitleTwo:SetText( ent:TitleTwo() );
    --CCP.PlayerViewer.CharacterTitleTwo:SetAutoStretchVertical( true );
    CCP.PlayerViewer.CharacterTitleTwo:PerformLayout();
    CCP.PlayerViewer.CharacterTitleTwo:DockMargin( 0, 0, 0, 8 );
   
    CCP.PlayerViewer.CharacterDescScroll = vgui.Create( "DScrollPanel", CCP.PlayerViewer.CharacterInfo );
    CCP.PlayerViewer.CharacterDescScroll:SetSize( 540, 352 );
    CCP.PlayerViewer.CharacterDescScroll:Dock( TOP );
    function CCP.PlayerViewer.CharacterDescScroll:Paint( w, h )
   
    end
   
    CCP.PlayerViewer.CharacterDesc = vgui.Create( "CCLabel" );
    CCP.PlayerViewer.CharacterDesc:SetPos( 0, 0 );
    CCP.PlayerViewer.CharacterDesc:SetSize( 350, 10 );
    CCP.PlayerViewer.CharacterDesc:SetFont( "CombineControl.LabelSmall" );
    CCP.PlayerViewer.CharacterDesc:SetWrap( true );
    CCP.PlayerViewer.CharacterDesc:SetText( ent:Description() );
    --CCP.PlayerViewer.CharacterDesc:SetAutoStretchVertical( true );
    CCP.PlayerViewer.CharacterDesc:PerformLayout();
   
    CCP.PlayerViewer.CharacterDescScroll:AddItem( CCP.PlayerViewer.CharacterDesc );
   
end

function GM:CreateCCContext( ent )
	
	CloseDermaMenus();
	
	CCSelectedEnt = ent;
	local dist = 0;
	
	if( ent and ent:IsValid() ) then
		
		dist = LocalPlayer():GetPos():Distance( ent:GetPos() );
		
	end
	
	local options = self:GetCCOptions( CCSelectedEnt, dist );
	
	gui.EnableScreenClicker( true );
	
	local menu = DermaMenu();
	CCContextMenu = menu;
	menu:SetPos( gui.MousePos() );
	
	for _, v in pairs( options ) do
		
		if( !istable( v[2] ) ) then
		
			if( !v[4] or ( v[4] and dist <= v[4] ) ) then
				
				menu:AddOption( v[1], function()
					
					gui.EnableScreenClicker( false );
					
					if( ( !CCSelectedEnt or !CCSelectedEnt:IsValid() ) and !v[3] ) then return end
					
					if( !v[3] and CCSelectedEnt and CCSelectedEnt:IsValid() and LocalPlayer():GetPos():Distance( CCSelectedEnt:GetPos() ) > v[4] ) then return end
					
					v[2]( CCSelectedEnt );
					
				end );
				
			end
			
		else
			
			if( !v[4] or ( v[4] and dist <= v[4] ) ) then
			
				local submenu = menu:AddSubMenu( v[1] );
				
				for a,b in next, v[2] do

					submenu:AddOption( b[1], function()
						
						gui.EnableScreenClicker( false );
						
						if( ( !CCSelectedEnt or !CCSelectedEnt:IsValid() ) and !b[3] ) then return end
						
						if( !b[3] and CCSelectedEnt and CCSelectedEnt:IsValid() and LocalPlayer():GetPos():Distance( CCSelectedEnt:GetPos() ) > b[4] ) then return end
						
						b[2]( CCSelectedEnt );
						
					end );
				
				end
			
			end
			
		end
		
	end
	
	if CCSelectedEnt:IsPlayer() and LocalPlayer():IsAdmin() then
		local sub, parent = menu:AddSubMenu("Admin")
		parent:SetIcon("icon16/user_edit.png")
	
		sub.TargetPlayer = CCSelectedEnt
		CCSelectedEnt:ShowUserOptions(sub, true)
	end
	
	menu:Open();
	
end

function GM:RemoveCCContext( d )
	
	gui.EnableScreenClicker( false );
	CloseDermaMenus();
	
end