local function zcGetGroups(len)
	local uniqueID = net.ReadString()
	local priority = net.ReadUInt(8)
	local isAdmin = net.ReadBool()
	local isSuperAdmin = net.ReadBool()

	local permissions = {}
	local permissionCount = net.ReadUInt(8)
	for i = 1, permissionCount do
		permissions[net.ReadString()] = true
	end

	local data = {
		uniqueID = uniqueID,
		priority = priority,
		isAdmin = isAdmin,
		isSuperAdmin = isSuperAdmin,
		permissions = permissions
	}

	kingston.admin.createGroup(uniqueID, data)
end
net.Receive("zcGetGroups", zcGetGroups)

local GROUP_ADDPERM 	= 0
local GROUP_TAKEPERM 	= 1
local GROUP_PRIORITY 	= 2
local GROUP_UNIQUEID	= 3
local GROUP_SETADMIN	= 4
local GROUP_SETSA		= 5

local GROUP_ACTION = {
	[GROUP_ADDPERM] = function(group)
		group:givePermission(net.ReadString())
	end,
	[GROUP_TAKEPERM] = function(group)
		group:takePermission(net.ReadString())
	end,
	[GROUP_PRIORITY] = function(group)
		group.priority = net.ReadUInt(8)
	end,
	[GROUP_UNIQUEID] = function(group)
		// deep copy or new object?
	end,
	[GROUP_SETADMIN] = function(group)
		group.isAdmin = net.ReadBool()
	end,
	[GROUP_SETSA] = function(group)
		group.isSuperAdmin = net.ReadBool()
	end
}

local function zcUpdateGroup(len)
	local uniqueID = net.ReadString()
	local group = kingston.admin.groups[uniqueID]

	if !group then return end

	local action = net.ReadUInt(8)
	local actionFunction = GROUP_ACTION[action]
	actionFunction(group)
end
net.Receive("zcUpdateGroup", zcUpdateGroup)

local function zcDeleteGroup(len)
	local uniqueID = net.ReadString()
	local group = kingston.admin.groups[uniqueID]

	if !group then return end

	group:delete()
end
net.Receive("zcDeleteGroup", zcDeleteGroup)

local function zcRequestUsergroups()
	net.Start("zcGetGroups")
	net.SendToServer()
end
hook.Add("InitPostEntity", "STALKER.RequestUsergroups", zcRequestUsergroups)

local function nAInvalidMap( tab )
	
	GAMEMODE:AddChat( {[CB_ALL] = true, [CB_OOC] = true}, "CombineControl.ChatNormal", Color( 200, 0, 0, 255 ), "Error: Invalid map specified." );
	chat.OldAddText( Color( 128, 128, 128, 255 ), "Valid Maps:" );
	
	for _, v in pairs( tab ) do
		
		chat.OldAddText( Color( 128, 128, 128, 255 ), "\t", Color( 229, 201, 98, 255 ), v );
		
	end
	
end
netstream.Hook( "nAInvalidMap", nAInvalidMap );

local function zcCommandList(len)
	local commands = net.ReadTable()

	GAMEMODE:AddChat( {[CB_ALL] = true, [CB_OOC] = true}, "CombineControl.ChatNormal", Color( 0, 200, 0, 255 ), "All registered commands have been printed to console." );
	chat.OldAddText( Color( 128, 128, 128, 255 ), "Valid commands:" );
	
	for _, v in pairs( commands ) do
		
		chat.OldAddText( Color( 128, 128, 128, 255 ), "\t", Color( 229, 201, 98, 255 ), v );
		
	end
end
net.Receive("zcCommandList", zcCommandList)

local function nASeeAll()
	
	GAMEMODE.SeeAll = !GAMEMODE.SeeAll;
	
end
netstream.Hook( "nASeeAll", nASeeAll );

local function nASeeAllProps()

	GAMEMODE.SeeAllSavedProps = !GAMEMODE.SeeAllSavedProps;
	
end
netstream.Hook( "nASeeAllProps", nASeeAllProps );

local function nAPlayMusic( song )

	GAMEMODE:PlayMusic( song );
	
end
netstream.Hook( "nAPlayMusic", nAPlayMusic );

local function nAStopMusic()
	
	GAMEMODE:FadeOutMusic();
	
end
netstream.Hook( "nAStopMusic", nAStopMusic );

local function nAListItems( filter )
	
	if( filter == "" ) then
		chat.OldAddText( Color( 128, 128, 128, 255 ), "ITEM LIST:" );
	else
		chat.OldAddText( Color( 128, 128, 128, 255 ), "ITEM LIST (FILTER \"" .. filter .. "\"):" );
	end
	
	for k, v in SortedPairs( GAMEMODE.Items ) do
		
		if( !v.EasterEgg ) then
			
			if( string.find( k, filter ) or filter == "" ) then
				
				MsgC( Color( 229, 201, 98, 255 ), k.."\t" )
				MsgC( Color( 128, 128, 128, 255 ), v.Name.."\n" )
				
			end
			
		end
		
	end
	
end
netstream.Hook( "nAListItems", nAListItems );

local function nAListArtifacts( filter )
	
	if( filter == "" ) then
		chat.OldAddText( Color( 128, 128, 128, 255 ), "ITEM LIST:" );
	else
		chat.OldAddText( Color( 128, 128, 128, 255 ), "ITEM LIST (FILTER \"" .. filter .. "\"):" );
	end
	
	for k, v in SortedPairs( GAMEMODE.Items ) do
		
		if( !v.EasterEgg and v.Base == "artifact" ) then
			
			if( string.find( k, filter ) or filter == "" ) then
				
				MsgC( Color( 229, 201, 98, 255 ), k.."\t" )
				MsgC( Color( 128, 128, 128, 255 ), v.Name.."\n" )
				
			end
			
		end
		
	end
	
end
netstream.Hook( "nAListArtifacts", nAListArtifacts );
  
function GM:UpdateAdminInventory( inv, targ )
	
	if( !CCP.AdminInv or !CCP.AdminInv:IsValid() ) then return end
	
	CCP.AdminInv.Scroll:Clear();
	
	local x = 0;
	local y = 0;
	
	for k, v in pairs( inv ) do
		
		local i = GAMEMODE:GetItemByID( v.ItemClass );
		
		local icon = vgui.Create( "DModelPanel", CCP.AdminInv.Scroll );
		local vars = v.Vars
		icon.Item = v.ItemClass;
		icon.InventoryID = k;
		
		icon:SetPos( x, y );
		if( i and i.Model ) then
			icon:SetModel( vars.Model or i.Model );
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
		
		if( i.IconMaterial ) then icon.Entity:SetMaterial( vars.IconMaterial or i.IconMaterial ) end
		if( i.IconColor ) then icon.Entity:SetColor( vars.IconMaterial or i.IconColor ) end
		
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
			
			CCP.AdminInv.Model:SetModel( vars.Model or i.Model );
			CCP.AdminInv.Title:SetText( vars.Name or i.Name );
			CCP.AdminInv.Desc:SetText( vars.Desc or i.Desc );
			
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
			
			if( i.IconMaterial ) then CCP.AdminInv.Model.Entity:SetMaterial( vars.IconMaterial or i.IconMaterial ) end
			if( i.IconColor ) then CCP.AdminInv.Model.Entity:SetColor( vars.IconColor or i.IconColor ) end
			
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

local function nAEditInventory( targ, inv )

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

local function nAUpdateInventory( ply, tab )
	
	if( !LocalPlayer():IsAdmin() ) then
		
		return;
		
	end
	
	GAMEMODE:UpdateAdminInventory( tab, ply );
	
end
netstream.Hook( "nAUpdateInventory", nAUpdateInventory );

local function nAStopSound()
	
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

local function AdminRequestedItems(data)
	GAMEMODE:AdminPopulateItemRequests(data)
end
netstream.Hook("AdminRequestedItems", AdminRequestedItems)

local function WhatIsThis()
	local ent = LocalPlayer():GetEyeTraceNoCursor().Entity

	if IsValid(ent) and ent:GetClass() == "prop_physics" then
		print("Model: ".. ent:GetModel())
		print("Creator: "..ent:PropCreator().." ("..ent:PropSteamID()..")")
	end
end
concommand.Add("whatisthis", WhatIsThis)

// maximum irritation

local function zctts(len)
	local text = net.ReadString()

	sound.PlayURL("https://tts.cyzon.us/tts/?text=" .. text,"",function(station)
		if ( IsValid( station ) ) then
			station:Play()
		end
	end)
end
net.Receive("zctts", zctts)