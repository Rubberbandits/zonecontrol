function GM:CreateAdminMenu()
	
	CCP.AdminMenu = vgui.Create( "DFrame" );
	CCP.AdminMenu:SetSize( 800, 500 );
	CCP.AdminMenu:Center();
	CCP.AdminMenu:SetTitle( "Admin Menu" );
	CCP.AdminMenu.lblTitle:SetFont( "CombineControl.Window" );
	CCP.AdminMenu:MakePopup();
	CCP.AdminMenu.PerformLayout = CCFramePerformLayout;
	CCP.AdminMenu:PerformLayout();
	function CCP.AdminMenu:Paint( w, h )
	
		draw.RoundedBox( 0, 0, 0, w, h, Color( 30, 30, 30, 230 ) );
		draw.RoundedBox( 0, 0, 0, w, 24, Color( 20, 20, 20, 255 ) );
		surface.DrawOutlinedRect( 0, 0, w, h );
	
	end
	function CCP.AdminMenu:Think()
	
		if( input.IsKeyDown( KEY_F4 ) and !self.LastKeyState and self.HasOpened ) then
		
			self:Close();
		
		end
		
		self.LastKeyState = input.IsKeyDown( KEY_F4 );
		if( !self.HasOpened ) then
		
			self.HasOpened = true;
			
		end
	
	end
	
	CCP.AdminMenu.TopBar = vgui.Create( "DPanel", CCP.AdminMenu );
	CCP.AdminMenu.TopBar:SetPos( 0, 24 );
	CCP.AdminMenu.TopBar:SetSize( 800, 50 );
	function CCP.AdminMenu.TopBar:Paint( w, h )
		
		surface.SetDrawColor( 0, 0, 0, 70 );
		surface.DrawRect( 0, 0, w, h );
		
		surface.SetDrawColor( 0, 0, 0, 100 );
		surface.DrawOutlinedRect( 0, 0, w, h );
		
	end
	
	CCP.AdminMenu.TopBar.Buttons = { };
	
	CCP.AdminMenu.TopBar.Buttons[1] = vgui.Create( "DButton", CCP.AdminMenu.TopBar );
	CCP.AdminMenu.TopBar.Buttons[1]:SetFont( "CombineControl.LabelSmall" );
	CCP.AdminMenu.TopBar.Buttons[1]:SetText( "Tools" );
	CCP.AdminMenu.TopBar.Buttons[1]:SetPos( 11, 10 );
	CCP.AdminMenu.TopBar.Buttons[1]:SetSize( 100, 26 );
	CCP.AdminMenu.TopBar.Buttons[1].DoClick = function( self )
		
		CCP.AdminMenu.ContentPane:Clear();
		GAMEMODE:AdminCreateToolsMenu();
		
	end
	CCP.AdminMenu.TopBar.Buttons[1]:PerformLayout();
	
	CCP.AdminMenu.TopBar.Buttons[2] = vgui.Create( "DButton", CCP.AdminMenu.TopBar );
	CCP.AdminMenu.TopBar.Buttons[2]:SetFont( "CombineControl.LabelSmall" );
	CCP.AdminMenu.TopBar.Buttons[2]:SetText( "Players" );
	CCP.AdminMenu.TopBar.Buttons[2]:SetPos( 124, 10 );
	CCP.AdminMenu.TopBar.Buttons[2]:SetSize( 100, 26 );
	CCP.AdminMenu.TopBar.Buttons[2].DoClick = function( self )
		
		CCP.AdminMenu.ContentPane:Clear();
		GAMEMODE:AdminCreatePlayersMenu();
		
	end
	CCP.AdminMenu.TopBar.Buttons[2]:PerformLayout();
	
	CCP.AdminMenu.TopBar.Buttons[3] = vgui.Create( "DButton", CCP.AdminMenu.TopBar );
	CCP.AdminMenu.TopBar.Buttons[3]:SetFont( "CombineControl.LabelSmall" );
	CCP.AdminMenu.TopBar.Buttons[3]:SetText( "Bans" );
	CCP.AdminMenu.TopBar.Buttons[3]:SetPos( 237, 10 );
	CCP.AdminMenu.TopBar.Buttons[3]:SetSize( 100, 26 );
	CCP.AdminMenu.TopBar.Buttons[3].DoClick = function( self )
		
		CCP.AdminMenu.ContentPane:Clear();
		GAMEMODE:AdminCreateBansMenu();
		
	end
	CCP.AdminMenu.TopBar.Buttons[3]:PerformLayout();
	
	CCP.AdminMenu.TopBar.Buttons[4] = vgui.Create( "DButton", CCP.AdminMenu.TopBar );
	CCP.AdminMenu.TopBar.Buttons[4]:SetFont( "CombineControl.LabelSmall" );
	CCP.AdminMenu.TopBar.Buttons[4]:SetText( "Logs" );
	CCP.AdminMenu.TopBar.Buttons[4]:SetPos( 350, 10 );
	CCP.AdminMenu.TopBar.Buttons[4]:SetSize( 100, 26 );
	CCP.AdminMenu.TopBar.Buttons[4].DoClick = function( self )
		
		CCP.AdminMenu.ContentPane:Clear();
		GAMEMODE:AdminCreateLogsMenu();
		
	end
	CCP.AdminMenu.TopBar.Buttons[4]:PerformLayout();
	
	CCP.AdminMenu.TopBar.Buttons[5] = vgui.Create( "DButton", CCP.AdminMenu.TopBar );
	CCP.AdminMenu.TopBar.Buttons[5]:SetFont( "CombineControl.LabelSmall" );
	CCP.AdminMenu.TopBar.Buttons[5]:SetText( "Rosters" );
	CCP.AdminMenu.TopBar.Buttons[5]:SetPos( 463, 10 );
	CCP.AdminMenu.TopBar.Buttons[5]:SetSize( 100, 26 );
	CCP.AdminMenu.TopBar.Buttons[5].DoClick = function( self )
		
		CCP.AdminMenu.ContentPane:Clear();
		GAMEMODE:AdminCreateRostersMenu();
		
	end
	CCP.AdminMenu.TopBar.Buttons[5]:PerformLayout();
	
	CCP.AdminMenu.TopBar.Buttons[6] = vgui.Create( "DButton", CCP.AdminMenu.TopBar );
	CCP.AdminMenu.TopBar.Buttons[6]:SetFont( "CombineControl.LabelSmall" );
	CCP.AdminMenu.TopBar.Buttons[6]:SetText( "Roleplay" );
	CCP.AdminMenu.TopBar.Buttons[6]:SetPos( 576, 10 );
	CCP.AdminMenu.TopBar.Buttons[6]:SetSize( 100, 26 );
	CCP.AdminMenu.TopBar.Buttons[6].DoClick = function( self )
		
		CCP.AdminMenu.ContentPane:Clear();
		GAMEMODE:AdminCreateRoleplayMenu();
		
	end
	CCP.AdminMenu.TopBar.Buttons[6]:PerformLayout();
	
	CCP.AdminMenu.TopBar.Buttons[7] = vgui.Create( "DButton", CCP.AdminMenu.TopBar );
	CCP.AdminMenu.TopBar.Buttons[7]:SetFont( "CombineControl.LabelSmall" );
	CCP.AdminMenu.TopBar.Buttons[7]:SetText( "Mastermind" );
	CCP.AdminMenu.TopBar.Buttons[7]:SetDisabled( true );
	CCP.AdminMenu.TopBar.Buttons[7]:SetPos( 689, 10 );
	CCP.AdminMenu.TopBar.Buttons[7]:SetSize( 100, 26 );
	CCP.AdminMenu.TopBar.Buttons[7].DoClick = function( self )
		
	end
	CCP.AdminMenu.TopBar.Buttons[7]:PerformLayout();
	
	CCP.AdminMenu.ContentPane = vgui.Create( "DPanel", CCP.AdminMenu );
	CCP.AdminMenu.ContentPane:SetPos( 0, 74 );
	CCP.AdminMenu.ContentPane:SetSize( 800, 426 );
	function CCP.AdminMenu.ContentPane:Paint( w, h ) end
	
	self:AdminCreateToolsMenu();
	
end

function GM:AdminCreateStockpilesMenu()

	CCP.StockpilesMenu = vgui.Create( "DFrame" );
	CCP.StockpilesMenu:SetSize( 220, 500 );
	CCP.StockpilesMenu:Center();
	CCP.StockpilesMenu:SetTitle( "Stockpiles" );
	CCP.StockpilesMenu.lblTitle:SetFont( "CombineControl.Window" );
	CCP.StockpilesMenu:MakePopup();
	CCP.StockpilesMenu.PerformLayout = CCFramePerformLayout;
	CCP.StockpilesMenu:PerformLayout();
	
	CCP.StockpilesMenu.Container = vgui.Create( "DScrollPanel", CCP.StockpilesMenu );
	CCP.StockpilesMenu.Container:Dock( FILL );
	CCP.StockpilesMenu.Container:PerformLayout();
	
end

function GM:AdminPopulateStockpilesMenu( tbl, cb )

	if( CCP.StockpilesMenu.Stockpile and #CCP.StockpilesMenu.Stockpile > 0 ) then
	
		for k,v in next, CCP.StockpilesMenu.Stockpile do
		
			v:Remove();
			
		end
		
	end
	
	local y = 0;

	for k,v in next, tbl do
	
		CCP.StockpilesMenu.Stockpile = {};
		CCP.StockpilesMenu.Stockpile[k] = vgui.Create( "DButton", CCP.StockpilesMenu.Container );
		CCP.StockpilesMenu.Stockpile[k].Inventory = v.Inventory;
		CCP.StockpilesMenu.Stockpile[k].Accessors = v.Accessors;
		CCP.StockpilesMenu.Stockpile[k].Name = v.Name;
		CCP.StockpilesMenu.Stockpile[k].id = k;
		CCP.StockpilesMenu.Stockpile[k]:SetFont( "CombineControl.LabelSmall" );
		CCP.StockpilesMenu.Stockpile[k]:SetText( v.Name );
		CCP.StockpilesMenu.Stockpile[k]:SetPos( 5, y );
		CCP.StockpilesMenu.Stockpile[k]:SetSize( 200, 20 );
		CCP.StockpilesMenu.Stockpile[k].DoClick = function( self )
			cb(v.Name, v.Inventory, k, self)
		end
		CCP.StockpilesMenu.Stockpile[k]:PerformLayout()
		
		y = y + 24;
	
	end

end

local function nAdminRequestPopulateStockpile(name, inv, id)

	GAMEMODE:AdminCreateStockpileMenu(name, inv, id)
	CCP.StockpilesMenu:Close();
	
end
netstream.Hook("nAdminRequestPopulateStockpile", nAdminRequestPopulateStockpile)

function GM:AdminCreateStockpileMenu( name, inv, id )

	CCP.StockpileMenu = vgui.Create( "DFrame" );
	CCP.StockpileMenu:SetSize( 800, 500 );
	CCP.StockpileMenu:Center();
	CCP.StockpileMenu:SetTitle( name );
	CCP.StockpileMenu.lblTitle:SetFont( "CombineControl.Window" );
	CCP.StockpileMenu:MakePopup();
	CCP.StockpileMenu.PerformLayout = CCFramePerformLayout;
	CCP.StockpileMenu:PerformLayout();
	
	CCP.StockpileMenu.InvModel = vgui.Create( "DModelPanel", CCP.StockpileMenu );
	CCP.StockpileMenu.InvModel:SetPos( 420, 30 );
	CCP.StockpileMenu.InvModel:SetModel( "" );
	CCP.StockpileMenu.InvModel:SetSize( CCP.StockpileMenu:GetWide() - 430, 200 );
	CCP.StockpileMenu.InvModel:SetFOV( 20 );
	CCP.StockpileMenu.InvModel:SetCamPos( Vector( 50, 50, 50 ) );
	CCP.StockpileMenu.InvModel:SetLookAt( Vector( 0, 0, 0 ) );
	
	local p = CCP.StockpileMenu.InvModel.Paint;
	
	function CCP.StockpileMenu.InvModel:Paint( w, h )
		
		surface.SetDrawColor( 0, 0, 0, 70 );
		surface.DrawRect( 0, 0, w, h );
		
		surface.SetDrawColor( 0, 0, 0, 100 );
		surface.DrawOutlinedRect( 0, 0, w, h );
		
		p( self, w, h );
		
	end
	
	function CCP.StockpileMenu.InvModel:LayoutEntity( ent ) end
	
	CCP.StockpileMenu.InvTitle = vgui.Create( "DLabel", CCP.StockpileMenu );
	CCP.StockpileMenu.InvTitle:SetText( "" );
	CCP.StockpileMenu.InvTitle:SetPos( 420, 240 );
	CCP.StockpileMenu.InvTitle:SetFont( "CombineControl.LabelGiant" );
	CCP.StockpileMenu.InvTitle:SetSize( CCP.StockpileMenu:GetWide() - 430 - 110, 22 );
	CCP.StockpileMenu.InvTitle:PerformLayout();
	
	CCP.StockpileMenu.InvWeight = vgui.Create( "DLabel", CCP.StockpileMenu );
	CCP.StockpileMenu.InvWeight:SetText( "" );
	CCP.StockpileMenu.InvWeight:SetPos( 420, CCP.StockpileMenu:GetTall() - 30 );
	CCP.StockpileMenu.InvWeight:SetFont( "CombineControl.LabelSmall" );
	CCP.StockpileMenu.InvWeight:SetSize( CCP.StockpileMenu:GetWide() - 430 - 110, 22 );
	CCP.StockpileMenu.InvWeight:PerformLayout();
	
	CCP.StockpileMenu.InvDesc = vgui.Create( "DLabel", CCP.StockpileMenu );
	CCP.StockpileMenu.InvDesc:SetText( "No item selected." );
	CCP.StockpileMenu.InvDesc:SetPos( 420, 270 );
	CCP.StockpileMenu.InvDesc:SetFont( "CombineControl.LabelSmall" );
	CCP.StockpileMenu.InvDesc:SetSize( CCP.StockpileMenu:GetWide() - 430 - 110, 14 );
	CCP.StockpileMenu.InvDesc:SetAutoStretchVertical( true );
	CCP.StockpileMenu.InvDesc:SetWrap( true );
	CCP.StockpileMenu.InvDesc:PerformLayout();
	
	CCP.StockpileMenu.InvScroll = vgui.Create( "DScrollPanel", CCP.StockpileMenu );
	CCP.StockpileMenu.InvScroll:SetPos( 10, 30 );
	CCP.StockpileMenu.InvScroll:SetSize( 400, CCP.StockpileMenu:GetTall() - 50 );
	function CCP.StockpileMenu.InvScroll:Paint( w, h )
		
		surface.SetDrawColor( 0, 0, 0, 70 );
		surface.DrawRect( 0, 0, w, h );
		
		surface.SetDrawColor( 0, 0, 0, 100 );
		surface.DrawOutlinedRect( 0, 0, w, h );
		
	end
	
	local x = 0;
	local y = 0;
	
	CCP.StockpileMenu.InvButtons = {};
	CCP.StockpileMenu.ID = id;

	for k,v in SortedPairsByMemberValue(inv, "ItemClass") do
	
		local i = GAMEMODE:GetItemByID( v.ItemClass );
		local vars = util.JSONToTable(v.Vars)
		
		if( i ) then
			
			local icon = vgui.Create( "DModelPanel", CCP.StockpileMenu.InvScroll );
			icon.Item = v.ItemClass;
			icon.InventoryID = v.id;
			
			icon:SetPos( x, y );
			icon:SetModel( vars.Model or i.Model );
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
			
			if( x > CCP.StockpileMenu.InvScroll:GetWide() - 48 ) then
				
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
				
				CCP.StockpileMenu.SelectedItem = self.InventoryID;
				
				if( CCP.StockpileMenu.InvModel.Entity and CCP.StockpileMenu.InvModel:IsValid() ) then
					
					CCP.StockpileMenu.InvModel.Entity:SetMaterial( "" );
					CCP.StockpileMenu.InvModel.Entity:SetColor( Color( 255, 255, 255, 255 ) );
					
				end
				
				CCP.StockpileMenu.InvModel:SetModel( vars.Model or i.Model );
				CCP.StockpileMenu.InvTitle:SetText( vars.Name or i.Name );
				CCP.StockpileMenu.InvWeight:SetText( "Weight: " .. tostring( vars.Weight or i.Weight ) );
				CCP.StockpileMenu.InvDesc:SetText( vars.Desc or i.Desc );
				
				local y = 0;
				
				if( CCP.StockpileMenu.ButTake and CCP.StockpileMenu.ButTake:IsValid() ) then
					
					CCP.StockpileMenu.ButTake:Remove();
					
				end
				
				CCP.StockpileMenu.ButTake = vgui.Create( "DButton", CCP.StockpileMenu );
				CCP.StockpileMenu.ButTake:SetFont( "CombineControl.LabelSmall" );
				CCP.StockpileMenu.ButTake:SetText( "Take" );
				CCP.StockpileMenu.ButTake:SetPos( CCP.StockpileMenu:GetWide() - 110, CCP.StockpileMenu:GetTall() - 30 + y );
				CCP.StockpileMenu.ButTake:SetSize( 100, 20 );
				function CCP.StockpileMenu.ButTake:DoClick()
					
					RunConsoleCommand( "rpa_stockpiletakeitem", CCP.StockpileMenu.ID, self.InventoryID );
					GAMEMODE:PMResetStockpileText();
					icon:Remove();
					
				end
				CCP.StockpileMenu.ButTake:PerformLayout();
				CCP.StockpileMenu.ButTake.InventoryID = self.InventoryID;
				table.insert( CCP.StockpileMenu.InvButtons, CCP.StockpileMenu.ButTake );
				y = y - 30;
				
				if( GAMEMODE:GetItemByID( self.Item ).LookAt ) then
					
					CCP.StockpileMenu.InvModel:SetFOV( GAMEMODE:GetItemByID( self.Item ).FOV );
					CCP.StockpileMenu.InvModel:SetCamPos( GAMEMODE:GetItemByID( self.Item ).CamPos );
					CCP.StockpileMenu.InvModel:SetLookAt( GAMEMODE:GetItemByID( self.Item ).LookAt );
					
				else
					
					local a, b = CCP.StockpileMenu.InvModel.Entity:GetModelBounds();
					
					CCP.StockpileMenu.InvModel:SetFOV( 20 );
					CCP.StockpileMenu.InvModel:SetCamPos( Vector( math.abs( a.x ), math.abs( a.y ), math.abs( a.z ) ) * 5 );
					CCP.StockpileMenu.InvModel:SetLookAt( ( a + b ) / 2 );
					
				end
				
				if( GAMEMODE:GetItemByID( self.Item ).IconMaterial ) then CCP.StockpileMenu.InvModel.Entity:SetMaterial( GAMEMODE:GetItemByID( self.Item ).IconMaterial ) end
				if( GAMEMODE:GetItemByID( self.Item ).IconColor ) then CCP.StockpileMenu.InvModel.Entity:SetColor( GAMEMODE:GetItemByID( self.Item ).IconColor ) end
				
			end
			
		end
	
	end

	
end

local function nAdminPopulateStockpilesMenu( stockpiles )

	GAMEMODE:AdminPopulateStockpilesMenu( stockpiles, GAMEMODE.CurrentStockpileCallback );

end
netstream.Hook( "nAdminPopulateStockpilesMenu", nAdminPopulateStockpilesMenu );

function GM:AdminCreateToolsMenu()
	
	CCP.AdminMenu.RestartBut = vgui.Create( "DButton", CCP.AdminMenu.ContentPane );
	CCP.AdminMenu.RestartBut:SetFont( "CombineControl.LabelSmall" );
	CCP.AdminMenu.RestartBut:SetText( "Restart Server" );
	CCP.AdminMenu.RestartBut:SetPos( 10, 10 );
	CCP.AdminMenu.RestartBut:SetSize( 100, 20 );
	function CCP.AdminMenu.RestartBut:DoClick()
		
		RunConsoleCommand( "rpa_gamerestart" );
		CCP.AdminMenu.RestartBut:SetDisabled( true );
		
	end
	CCP.AdminMenu.RestartBut:PerformLayout();
	
	CCP.AdminMenu.StopSoundBut = vgui.Create( "DButton", CCP.AdminMenu.ContentPane );
	CCP.AdminMenu.StopSoundBut:SetFont( "CombineControl.LabelSmall" );
	CCP.AdminMenu.StopSoundBut:SetText( "Stop Sounds" );
	CCP.AdminMenu.StopSoundBut:SetPos( 120, 10 );
	CCP.AdminMenu.StopSoundBut:SetSize( 100, 20 );
	function CCP.AdminMenu.StopSoundBut:DoClick()
		
		RunConsoleCommand( "rpa_stopsound" );
		
	end
	CCP.AdminMenu.StopSoundBut:PerformLayout();
	
	CCP.AdminMenu.RemoveVFire = vgui.Create( "DButton", CCP.AdminMenu.ContentPane );
	CCP.AdminMenu.RemoveVFire:SetFont( "CombineControl.LabelSmall" );
	CCP.AdminMenu.RemoveVFire:SetText( "Remove All Fire" );
	CCP.AdminMenu.RemoveVFire:SetPos( 230, 10 );
	CCP.AdminMenu.RemoveVFire:SetSize( 100, 20 );
	function CCP.AdminMenu.RemoveVFire:DoClick()
		
		RunConsoleCommand("vfire_remove_all")
		
	end
	CCP.AdminMenu.RemoveVFire:PerformLayout();
	
	CCP.AdminMenu.StockpilesBut = vgui.Create( "DButton", CCP.AdminMenu.ContentPane );
	CCP.AdminMenu.StockpilesBut:SetFont( "CombineControl.LabelSmall" );
	CCP.AdminMenu.StockpilesBut:SetText( "Stockpiles" );
	CCP.AdminMenu.StockpilesBut:SetPos( 340, 10 );
	CCP.AdminMenu.StockpilesBut:SetSize( 100, 20 );
	function CCP.AdminMenu.StockpilesBut:DoClick()
		
		GAMEMODE:AdminCreateStockpilesMenu();
		GAMEMODE.CurrentStockpileCallback = function( szName, szInventory, nID )
		
			netstream.Start("nAdminRequestPopulateStockpile", nID)
			
		end
		netstream.Start( "nAdminRequestStockpilesMenu" );
		
	end
	CCP.AdminMenu.StockpilesBut:PerformLayout();
	
	CCP.AdminMenu.DeleteStockpilesBut = vgui.Create( "DButton", CCP.AdminMenu.ContentPane );
	CCP.AdminMenu.DeleteStockpilesBut:SetFont( "CombineControl.LabelSmall" );
	CCP.AdminMenu.DeleteStockpilesBut:SetText( "Delete Stockpiles" );
	CCP.AdminMenu.DeleteStockpilesBut:SetPos( 450, 10 );
	CCP.AdminMenu.DeleteStockpilesBut:SetSize( 100, 20 );
	function CCP.AdminMenu.DeleteStockpilesBut:DoClick()
		
		GAMEMODE:AdminCreateStockpilesMenu();
		GAMEMODE.CurrentStockpileCallback = function( szName, szInventory, nID )
		
			netstream.Start( "nAdminRemoveStockpile", nID );
			CCP.StockpilesMenu:Close()
		
		end
		netstream.Start( "nAdminRequestStockpilesMenu" );
		
	end
	CCP.AdminMenu.DeleteStockpilesBut:PerformLayout();
	
	CCP.AdminMenu.ItemRequestsBut = vgui.Create( "DButton", CCP.AdminMenu.ContentPane );
	CCP.AdminMenu.ItemRequestsBut:SetFont( "CombineControl.LabelSmall" );
	CCP.AdminMenu.ItemRequestsBut:SetText( "Item Requests" );
	CCP.AdminMenu.ItemRequestsBut:SetPos( 560, 10 );
	CCP.AdminMenu.ItemRequestsBut:SetSize( 100, 20 );
	function CCP.AdminMenu.ItemRequestsBut:DoClick()
		GAMEMODE:CreateItemRequestMenu()
	end
	CCP.AdminMenu.ItemRequestsBut:PerformLayout();

	CCP.AdminMenu.ItemCreatorBut = vgui.Create( "DButton", CCP.AdminMenu.ContentPane );
	CCP.AdminMenu.ItemCreatorBut:SetFont( "CombineControl.LabelSmall" );
	CCP.AdminMenu.ItemCreatorBut:SetText( "Item Creator" );
	CCP.AdminMenu.ItemCreatorBut:SetPos( 670, 10 );
	CCP.AdminMenu.ItemCreatorBut:SetSize( 100, 20 );
	function CCP.AdminMenu.ItemCreatorBut:DoClick()
		CCP.AdminMenu:Close()

		vgui.Create("zc_itemrequest")
	end
	CCP.AdminMenu.ItemCreatorBut:PerformLayout();

	CCP.AdminMenu.RankManageBut = vgui.Create( "DButton", CCP.AdminMenu.ContentPane );
	CCP.AdminMenu.RankManageBut:SetFont( "CombineControl.LabelSmall" );
	CCP.AdminMenu.RankManageBut:SetText( "Item Creator" );
	CCP.AdminMenu.RankManageBut:SetPos( 670, 10 );
	CCP.AdminMenu.RankManageBut:SetSize( 100, 20 );
	function CCP.AdminMenu.RankManageBut:DoClick()
		CCP.AdminMenu:Close()

		vgui.Create("zc_rank_manage")
	end
	CCP.AdminMenu.RankManageBut:PerformLayout();
	
	CCP.AdminMenu.SeeAllL = vgui.Create( "DLabel", CCP.AdminMenu.ContentPane );
	CCP.AdminMenu.SeeAllL:SetText( "SeeAll Enabled" );
	CCP.AdminMenu.SeeAllL:SetPos( 10, 40 );
	CCP.AdminMenu.SeeAllL:SetFont( "CombineControl.LabelMedium" );
	CCP.AdminMenu.SeeAllL:SizeToContents();
	CCP.AdminMenu.SeeAllL:PerformLayout();
	
	CCP.AdminMenu.SeeAll = vgui.Create( "DCheckBoxLabel", CCP.AdminMenu.ContentPane );
	CCP.AdminMenu.SeeAll:SetText( "" );
	CCP.AdminMenu.SeeAll:SetPos( 200, 40 );
	CCP.AdminMenu.SeeAll:SetValue( self.SeeAll );
	CCP.AdminMenu.SeeAll:PerformLayout();
	function CCP.AdminMenu.SeeAll:OnChange( val )
		
		RunConsoleCommand("rpa_adminseeall")
		
	end
	
	CCP.AdminMenu.SeeAll:PerformLayout();
	CCP.AdminMenu.SeeAll:SizeToContents();
	
	CCP.AdminMenu.AdminESP = vgui.Create( "DLabel", CCP.AdminMenu.ContentPane );
	CCP.AdminMenu.AdminESP:SetText( "Admin ESP" );
	CCP.AdminMenu.AdminESP:SetPos( 10, 210 );
	CCP.AdminMenu.AdminESP:SetFont( "CombineControl.LabelMedium" );
	CCP.AdminMenu.AdminESP:SizeToContents();
	CCP.AdminMenu.AdminESP:PerformLayout();
	
	CCP.AdminMenu.SeeAllChamsL = vgui.Create( "DLabel", CCP.AdminMenu.ContentPane );
	CCP.AdminMenu.SeeAllChamsL:SetText( "SeeAll Chams Enabled" );
	CCP.AdminMenu.SeeAllChamsL:SetPos( 10, 230 );
	CCP.AdminMenu.SeeAllChamsL:SetFont( "CombineControl.LabelMedium" );
	CCP.AdminMenu.SeeAllChamsL:SizeToContents();
	CCP.AdminMenu.SeeAllChamsL:PerformLayout();
	
	CCP.AdminMenu.SeeAllChams = vgui.Create( "DCheckBoxLabel", CCP.AdminMenu.ContentPane );
	CCP.AdminMenu.SeeAllChams:SetText( "" );
	CCP.AdminMenu.SeeAllChams:SetPos( 200, 230 );
	CCP.AdminMenu.SeeAllChams:SetValue( self.SeeAllChams );
	CCP.AdminMenu.SeeAllChams:PerformLayout();
	function CCP.AdminMenu.SeeAllChams:OnChange( val )
		
		GAMEMODE.SeeAllChams = val;
		
	end
	CCP.AdminMenu.SeeAllChams:PerformLayout();
	CCP.AdminMenu.SeeAllChams:SizeToContents();
	
	CCP.AdminMenu.SeeAllBonesL = vgui.Create( "DLabel", CCP.AdminMenu.ContentPane );
	CCP.AdminMenu.SeeAllBonesL:SetText( "SeeAll Bones Enabled" );
	CCP.AdminMenu.SeeAllBonesL:SetPos( 10, 250 );
	CCP.AdminMenu.SeeAllBonesL:SetFont( "CombineControl.LabelMedium" );
	CCP.AdminMenu.SeeAllBonesL:SizeToContents();
	CCP.AdminMenu.SeeAllBonesL:PerformLayout();
	
	CCP.AdminMenu.SeeAllBones = vgui.Create( "DCheckBoxLabel", CCP.AdminMenu.ContentPane );
	CCP.AdminMenu.SeeAllBones:SetText( "" );
	CCP.AdminMenu.SeeAllBones:SetPos( 200, 250 );
	CCP.AdminMenu.SeeAllBones:SetValue( self.SeeAllBones );
	CCP.AdminMenu.SeeAllBones:PerformLayout();
	function CCP.AdminMenu.SeeAllBones:OnChange( val )
		
		GAMEMODE.SeeAllBones = val;
		
	end
	CCP.AdminMenu.SeeAllBones:PerformLayout();
	CCP.AdminMenu.SeeAllBones:SizeToContents();
	
	CCP.AdminMenu.SeeAllPropsL = vgui.Create( "DLabel", CCP.AdminMenu.ContentPane );
	CCP.AdminMenu.SeeAllPropsL:SetText( "SeeAll Saved Props Enabled" );
	CCP.AdminMenu.SeeAllPropsL:SetPos( 10, 270 );
	CCP.AdminMenu.SeeAllPropsL:SetFont( "CombineControl.LabelMedium" );
	CCP.AdminMenu.SeeAllPropsL:SizeToContents();
	CCP.AdminMenu.SeeAllPropsL:PerformLayout();
	
	CCP.AdminMenu.SeeAllSavedProps = vgui.Create( "DCheckBoxLabel", CCP.AdminMenu.ContentPane );
	CCP.AdminMenu.SeeAllSavedProps:SetText( "" );
	CCP.AdminMenu.SeeAllSavedProps:SetPos( 200, 270 );
	CCP.AdminMenu.SeeAllSavedProps:SetValue( self.SeeAllSavedProps );
	CCP.AdminMenu.SeeAllSavedProps:PerformLayout();
	function CCP.AdminMenu.SeeAllSavedProps:OnChange( val )
		
		GAMEMODE.SeeAllSavedProps = val;
		
	end
	CCP.AdminMenu.SeeAllSavedProps:PerformLayout();
	CCP.AdminMenu.SeeAllSavedProps:SizeToContents();
	
	
	CCP.AdminMenu.HiddenL = vgui.Create( "DLabel", CCP.AdminMenu.ContentPane );
	CCP.AdminMenu.HiddenL:SetText( "Hidden Enabled" );
	CCP.AdminMenu.HiddenL:SetPos( 10, 70 );
	CCP.AdminMenu.HiddenL:SetFont( "CombineControl.LabelMedium" );
	CCP.AdminMenu.HiddenL:SizeToContents();
	CCP.AdminMenu.HiddenL:PerformLayout();
	
	CCP.AdminMenu.Hidden = vgui.Create( "DCheckBoxLabel", CCP.AdminMenu.ContentPane );
	CCP.AdminMenu.Hidden:SetText( "" );
	CCP.AdminMenu.Hidden:SetPos( 200, 70 );
	CCP.AdminMenu.Hidden:SetValue( LocalPlayer():HideAdmin() );
	CCP.AdminMenu.Hidden:PerformLayout();
	function CCP.AdminMenu.Hidden:OnChange( val )
		
		RunConsoleCommand( "rpa_plyhidden", val and 1 or 0 );
		
	end
	
	CCP.AdminMenu.Hidden:PerformLayout();
	CCP.AdminMenu.Hidden:SizeToContents();
	
	CCP.AdminMenu.AIDisabledL = vgui.Create( "DLabel", CCP.AdminMenu.ContentPane );
	CCP.AdminMenu.AIDisabledL:SetText( "AI Disabled" );
	CCP.AdminMenu.AIDisabledL:SetPos( 10, 100 );
	CCP.AdminMenu.AIDisabledL:SetFont( "CombineControl.LabelMedium" );
	CCP.AdminMenu.AIDisabledL:SizeToContents();
	CCP.AdminMenu.AIDisabledL:PerformLayout();
	
	CCP.AdminMenu.AIDisabled = vgui.Create( "DCheckBoxLabel", CCP.AdminMenu.ContentPane );
	CCP.AdminMenu.AIDisabled:SetText( "" );
	CCP.AdminMenu.AIDisabled:SetPos( 200, 100 );
	CCP.AdminMenu.AIDisabled:SetValue( GetConVarNumber( "ai_disabled" ) );
	CCP.AdminMenu.AIDisabled:PerformLayout();
	function CCP.AdminMenu.AIDisabled:OnChange( val )
		
		RunConsoleCommand( "rpa_gameaidisabled", val and 1 or 0 );
		
	end
	
	CCP.AdminMenu.AIDisabled:PerformLayout();
	CCP.AdminMenu.AIDisabled:SizeToContents();
	
	CCP.AdminMenu.OOCDelayLabel = vgui.Create( "DLabel", CCP.AdminMenu.ContentPane );
	CCP.AdminMenu.OOCDelayLabel:SetText( "OOC Delay" );
	CCP.AdminMenu.OOCDelayLabel:SetPos( 10, 130 );
	CCP.AdminMenu.OOCDelayLabel:SetFont( "CombineControl.LabelMedium" );
	CCP.AdminMenu.OOCDelayLabel:SizeToContents();
	CCP.AdminMenu.OOCDelayLabel:PerformLayout();
	
	CCP.AdminMenu.OOCDelay = vgui.Create( "DTextEntry", CCP.AdminMenu.ContentPane );
	CCP.AdminMenu.OOCDelay:SetFont( "CombineControl.LabelMedium" );
	CCP.AdminMenu.OOCDelay:SetPos( 200, 130 );
	CCP.AdminMenu.OOCDelay:SetSize( 40, 20 );
	CCP.AdminMenu.OOCDelay:SetNumeric( true );
	CCP.AdminMenu.OOCDelay:SetValue( GAMEMODE:OOCDelay() );
	CCP.AdminMenu.OOCDelay:PerformLayout();
	
	CCP.AdminMenu.OOCDelayBut = vgui.Create( "DButton", CCP.AdminMenu.ContentPane );
	CCP.AdminMenu.OOCDelayBut:SetFont( "CombineControl.LabelSmall" );
	CCP.AdminMenu.OOCDelayBut:SetText( "Apply" );
	CCP.AdminMenu.OOCDelayBut:SetPos( 250, 130 );
	CCP.AdminMenu.OOCDelayBut:SetSize( 100, 20 );
	function CCP.AdminMenu.OOCDelayBut:DoClick()
		
		RunConsoleCommand( "rpa_oocdelay", CCP.AdminMenu.OOCDelay:GetValue() );
		
	end
	CCP.AdminMenu.OOCDelayBut:PerformLayout();
	
	CCP.AdminMenu.ChangeLevelLabel = vgui.Create( "DLabel", CCP.AdminMenu.ContentPane );
	CCP.AdminMenu.ChangeLevelLabel:SetText( "Change Map" );
	CCP.AdminMenu.ChangeLevelLabel:SetPos( 10, 160 );
	CCP.AdminMenu.ChangeLevelLabel:SetFont( "CombineControl.LabelMedium" );
	CCP.AdminMenu.ChangeLevelLabel:SizeToContents();
	CCP.AdminMenu.ChangeLevelLabel:PerformLayout();
	
	CCP.AdminMenu.ChangeLevel = vgui.Create( "DTextEntry", CCP.AdminMenu.ContentPane );
	CCP.AdminMenu.ChangeLevel:SetFont( "CombineControl.LabelMedium" );
	CCP.AdminMenu.ChangeLevel:SetPos( 200, 160 );
	CCP.AdminMenu.ChangeLevel:SetSize( 100, 20 );
	CCP.AdminMenu.ChangeLevel:PerformLayout();
	
	CCP.AdminMenu.ChangeLevelBut = vgui.Create( "DButton", CCP.AdminMenu.ContentPane );
	CCP.AdminMenu.ChangeLevelBut:SetFont( "CombineControl.LabelSmall" );
	CCP.AdminMenu.ChangeLevelBut:SetText( "Go" );
	CCP.AdminMenu.ChangeLevelBut:SetPos( 310, 160 );
	CCP.AdminMenu.ChangeLevelBut:SetSize( 100, 20 );
	function CCP.AdminMenu.ChangeLevelBut:DoClick()
		
		RunConsoleCommand( "rpa_gamechangelevel", CCP.AdminMenu.ChangeLevel:GetValue() );
		
	end
	CCP.AdminMenu.ChangeLevelBut:PerformLayout();
	
end

function GM:AdminPlayerMenuDisable()
	
	CCP.AdminMenu.KickReason:SetValue( "" );
	CCP.AdminMenu.KickBut:SetDisabled( true );
	CCP.AdminMenu.BanReason:SetValue( "" );
	CCP.AdminMenu.BanDuration:SetValue( "60" );
	CCP.AdminMenu.BanBut:SetDisabled( true );
	CCP.AdminMenu.PBanBut:SetDisabled( true );
	CCP.AdminMenu.BringBut:SetDisabled( true );
	CCP.AdminMenu.GotoBut:SetDisabled( true );
	CCP.AdminMenu.KillBut:SetDisabled( true );
	CCP.AdminMenu.SlapBut:SetDisabled( true );
	CCP.AdminMenu.KOBut:SetDisabled( true );
	CCP.AdminMenu.WakeBut:SetDisabled( true );
	CCP.AdminMenu.GiveMoney:SetValue( 0 );
	CCP.AdminMenu.GiveMoneyBut:SetDisabled( true );
	CCP.AdminMenu.CharFlag:SetValue( "" );
	CCP.AdminMenu.CharFlagBut:SetDisabled( true );
	CCP.AdminMenu.ModelBut:SetDisabled( true );
	CCP.AdminMenu.PhysTrust0:SetDisabled( true );
	CCP.AdminMenu.PhysTrust1:SetDisabled( true );
	CCP.AdminMenu.PropTrust0:SetDisabled( true );
	CCP.AdminMenu.PropTrust1:SetDisabled( true );
	CCP.AdminMenu.TT0:SetDisabled( true );
	CCP.AdminMenu.TT1:SetDisabled( true );
	CCP.AdminMenu.TT2:SetDisabled( true );
	CCP.AdminMenu.SetRankUser:SetDisabled( true );
	CCP.AdminMenu.SetRankGM:SetDisabled( true );
	CCP.AdminMenu.SetRankAdmin:SetDisabled( true );
	CCP.AdminMenu.EditInventory:SetDisabled( true );
	CCP.AdminMenu.WarnName:SetDisabled( true );
	CCP.AdminMenu.GiveAccessToStockpile:SetDisabled( true );
	CCP.AdminMenu.TakeAccessFromStockpile:SetDisabled( true );
	CCP.AdminMenu.ToggleWatched:SetDisabled( true );
	
end

function GM:AdminPlayerMenuEnable( ply )
	
	CCP.AdminMenu.KickBut:SetDisabled( false );
	CCP.AdminMenu.BanBut:SetDisabled( false );
	CCP.AdminMenu.PBanBut:SetDisabled( false );
	CCP.AdminMenu.BringBut:SetDisabled( false );
	CCP.AdminMenu.GotoBut:SetDisabled( false );
	CCP.AdminMenu.KillBut:SetDisabled( false );
	CCP.AdminMenu.SlapBut:SetDisabled( false );
	CCP.AdminMenu.KOBut:SetDisabled( false );
	CCP.AdminMenu.WakeBut:SetDisabled( false );
	CCP.AdminMenu.GiveMoneyBut:SetDisabled( false );
	CCP.AdminMenu.CharFlagBut:SetDisabled( false );
	CCP.AdminMenu.ModelBut:SetDisabled( false );
	CCP.AdminMenu.CharFlag:SetValue( ply:CharFlags() );
	
	if( ply:PhysTrust() == 0 ) then
		CCP.AdminMenu.PhysTrust0:SetDisabled( true );
		CCP.AdminMenu.PhysTrust1:SetDisabled( false );
	else
		CCP.AdminMenu.PhysTrust0:SetDisabled( false );
		CCP.AdminMenu.PhysTrust1:SetDisabled( true );
	end
	
	if( ply:PropTrust() == 0 ) then
		CCP.AdminMenu.PropTrust0:SetDisabled( true );
		CCP.AdminMenu.PropTrust1:SetDisabled( false );
	else
		CCP.AdminMenu.PropTrust0:SetDisabled( false );
		CCP.AdminMenu.PropTrust1:SetDisabled( true );
	end
	
	if( ply:ToolTrust() == 0 ) then
		CCP.AdminMenu.TT0:SetDisabled( true );
		CCP.AdminMenu.TT1:SetDisabled( false );
		CCP.AdminMenu.TT2:SetDisabled( false );
	elseif( ply:ToolTrust() == 1 ) then
		CCP.AdminMenu.TT0:SetDisabled( false );
		CCP.AdminMenu.TT1:SetDisabled( true );
		CCP.AdminMenu.TT2:SetDisabled( false );
	else
		CCP.AdminMenu.TT0:SetDisabled( false );
		CCP.AdminMenu.TT1:SetDisabled( false );
		CCP.AdminMenu.TT2:SetDisabled( true );
	end
	
	if LocalPlayer():IsSuperAdmin() and !ply:IsSuperAdmin() then
		if ply:IsUserGroup("user") then
			CCP.AdminMenu.SetRankUser:SetDisabled( true );
			CCP.AdminMenu.SetRankGM:SetDisabled( false );
			CCP.AdminMenu.SetRankAdmin:SetDisabled( false );
		elseif ply:IsUserGroup("gamemaster") then
			CCP.AdminMenu.SetRankUser:SetDisabled( false );
			CCP.AdminMenu.SetRankGM:SetDisabled( true );
			CCP.AdminMenu.SetRankAdmin:SetDisabled( false );
		else
			CCP.AdminMenu.SetRankUser:SetDisabled( false );
			CCP.AdminMenu.SetRankGM:SetDisabled( false );
			CCP.AdminMenu.SetRankAdmin:SetDisabled( true );
		end
	end
	
	CCP.AdminMenu.EditInventory:SetDisabled( false );
	CCP.AdminMenu.WarnName:SetDisabled( false );
	CCP.AdminMenu.GiveAccessToStockpile:SetDisabled( false );
	CCP.AdminMenu.TakeAccessFromStockpile:SetDisabled( false );
	CCP.AdminMenu.ToggleWatched:SetDisabled( false );
	
end

function GM:AdminPopulateGiveAccessMenu( tbl )

	if( CCP.StockpilesMenu.Stockpile and #CCP.StockpilesMenu.Stockpile > 0 ) then
	
		for k,v in next, CCP.StockpilesMenu.Stockpile do
		
			v:Remove();
			
		end
		
	end
	
	local y = 0;

	for k,v in next, tbl do
	
		CCP.StockpilesMenu.Stockpile = {};
		CCP.StockpilesMenu.Stockpile[k] = vgui.Create( "DButton", CCP.StockpilesMenu.Container );
		CCP.StockpilesMenu.Stockpile[k].Inventory = v.Inventory;
		CCP.StockpilesMenu.Stockpile[k].Accessors = v.Accessors;
		CCP.StockpilesMenu.Stockpile[k].Name = v.Name;
		CCP.StockpilesMenu.Stockpile[k].id = k;
		CCP.StockpilesMenu.Stockpile[k]:SetFont( "CombineControl.LabelSmall" );
		CCP.StockpilesMenu.Stockpile[k]:SetText( v.Name );
		CCP.StockpilesMenu.Stockpile[k]:SetPos( 5, y );
		CCP.StockpilesMenu.Stockpile[k]:SetSize( 200, 20 );
		CCP.StockpilesMenu.Stockpile[k].DoClick = function( self )
			
			RunConsoleCommand( "rpa_stockpileaccessgive", CCP.AdminMenu.PlayerList:GetLine( CCP.AdminMenu.SelectedID ).Player:RPName(), self.id ) ;
			CCP.StockpilesMenu:Close();
			
		end
		CCP.StockpilesMenu.Stockpile[k]:PerformLayout()
		
		y = y + 24;
	
	end

end

local function nAdminPopulateGiveAccessMenu( tbl )

	GAMEMODE:AdminPopulateGiveAccessMenu( tbl );

end
netstream.Hook( "nAdminPopulateGiveAccessMenu", nAdminPopulateGiveAccessMenu );

function GM:AdminPopulateTakeAccessMenu( tbl )

	if( CCP.StockpilesMenu.Stockpile and #CCP.StockpilesMenu.Stockpile > 0 ) then
	
		for k,v in next, CCP.StockpilesMenu.Stockpile do
		
			v:Remove();
			
		end
		
	end
	
	local y = 0;

	for k,v in next, tbl do
	
		CCP.StockpilesMenu.Stockpile = {};
		CCP.StockpilesMenu.Stockpile[k] = vgui.Create( "DButton", CCP.StockpilesMenu.Container );
		CCP.StockpilesMenu.Stockpile[k].Inventory = v.Inventory;
		CCP.StockpilesMenu.Stockpile[k].Accessors = v.Accessors;
		CCP.StockpilesMenu.Stockpile[k].Name = v.Name;
		CCP.StockpilesMenu.Stockpile[k].id = k;
		CCP.StockpilesMenu.Stockpile[k]:SetFont( "CombineControl.LabelSmall" );
		CCP.StockpilesMenu.Stockpile[k]:SetText( v.Name );
		CCP.StockpilesMenu.Stockpile[k]:SetPos( 5, y );
		CCP.StockpilesMenu.Stockpile[k]:SetSize( 200, 20 );
		CCP.StockpilesMenu.Stockpile[k].DoClick = function( self )
			
			RunConsoleCommand( "rpa_stockpiletakeaccess", CCP.AdminMenu.PlayerList:GetLine( CCP.AdminMenu.SelectedID ).Player:RPName(), self.id ) ;
			CCP.StockpilesMenu:Close();
			
		end
		CCP.StockpilesMenu.Stockpile[k]:PerformLayout()
		
		y = y + 24;
	
	end

end

local function nAdminPopulateTakeAccessMenu( tbl )

	GAMEMODE:AdminPopulateTakeAccessMenu( tbl );

end
netstream.Hook( "nAdminPopulateTakeAccessMenu", nAdminPopulateTakeAccessMenu );

function GM:AdminCreatePlayersMenu()
	
	CCP.AdminMenu.PlayerList = vgui.Create( "DListView", CCP.AdminMenu.ContentPane );
	CCP.AdminMenu.PlayerList:SetPos( 10, 10 );
	CCP.AdminMenu.PlayerList:SetSize( 200, 403 );
	CCP.AdminMenu.PlayerList:AddColumn( "Character Name" );
	CCP.AdminMenu.PlayerList:AddColumn( "Player" );
	
	for _, v in pairs( player.GetAll() ) do
		
		local line = CCP.AdminMenu.PlayerList:AddLine( v:VisibleRPName(), v:Nick() );
		line.Player = v;
		line.SteamID = v:SteamID();
		
	end
	
	CCP.AdminMenu.SelectedID = nil;
	
	function CCP.AdminMenu.PlayerList:OnRowSelected( id, line )
		
		CCP.AdminMenu.SelectedID = id;
		
		GAMEMODE:AdminPlayerMenuEnable( line.Player );
		
	end
	
	CCP.AdminMenu.KickLabel = vgui.Create( "DLabel", CCP.AdminMenu.ContentPane );
	CCP.AdminMenu.KickLabel:SetText( "Kick Reason" );
	CCP.AdminMenu.KickLabel:SetPos( 220, 10 );
	CCP.AdminMenu.KickLabel:SetFont( "CombineControl.LabelMedium" );
	CCP.AdminMenu.KickLabel:SizeToContents();
	CCP.AdminMenu.KickLabel:PerformLayout();
	
	CCP.AdminMenu.KickReason = vgui.Create( "DTextEntry", CCP.AdminMenu.ContentPane );
	CCP.AdminMenu.KickReason:SetFont( "CombineControl.LabelMedium" );
	CCP.AdminMenu.KickReason:SetPos( 340, 10 );
	CCP.AdminMenu.KickReason:SetSize( 340, 20 );
	CCP.AdminMenu.KickReason:SetFocusTopLevel();
	CCP.AdminMenu.KickReason:PerformLayout();
	
	CCP.AdminMenu.KickBut = vgui.Create( "DButton", CCP.AdminMenu.ContentPane );
	CCP.AdminMenu.KickBut:SetFont( "CombineControl.LabelSmall" );
	CCP.AdminMenu.KickBut:SetText( "Kick" );
	CCP.AdminMenu.KickBut:SetPos( 690, 10 );
	CCP.AdminMenu.KickBut:SetSize( 100, 20 );
	function CCP.AdminMenu.KickBut:DoClick()
		
		RunConsoleCommand( "rpa_plykick", CCP.AdminMenu.PlayerList:GetLine( CCP.AdminMenu.SelectedID ).SteamID, CCP.AdminMenu.KickReason:GetValue() );
		
		CCP.AdminMenu.PlayerList:RemoveLine( CCP.AdminMenu.SelectedID );
		
		GAMEMODE:AdminPlayerMenuDisable();
		
	end
	CCP.AdminMenu.KickBut:SetDisabled( true );
	CCP.AdminMenu.KickBut:PerformLayout();
	
	CCP.AdminMenu.BanLabel = vgui.Create( "DLabel", CCP.AdminMenu.ContentPane );
	CCP.AdminMenu.BanLabel:SetText( "Ban Reason" );
	CCP.AdminMenu.BanLabel:SetPos( 220, 40 );
	CCP.AdminMenu.BanLabel:SetFont( "CombineControl.LabelMedium" );
	CCP.AdminMenu.BanLabel:SizeToContents();
	CCP.AdminMenu.BanLabel:PerformLayout();
	
	CCP.AdminMenu.BanReason = vgui.Create( "DTextEntry", CCP.AdminMenu.ContentPane );
	CCP.AdminMenu.BanReason:SetFont( "CombineControl.LabelMedium" );
	CCP.AdminMenu.BanReason:SetPos( 340, 40 );
	CCP.AdminMenu.BanReason:SetSize( 450, 20 );
	CCP.AdminMenu.BanReason:PerformLayout();
	
	CCP.AdminMenu.BanDLabel = vgui.Create( "DLabel", CCP.AdminMenu.ContentPane );
	CCP.AdminMenu.BanDLabel:SetText( "Ban Duration" );
	CCP.AdminMenu.BanDLabel:SetPos( 220, 70 );
	CCP.AdminMenu.BanDLabel:SetFont( "CombineControl.LabelMedium" );
	CCP.AdminMenu.BanDLabel:SizeToContents();
	CCP.AdminMenu.BanDLabel:PerformLayout();
	
	CCP.AdminMenu.BanDuration = vgui.Create( "DTextEntry", CCP.AdminMenu.ContentPane );
	CCP.AdminMenu.BanDuration:SetFont( "CombineControl.LabelMedium" );
	CCP.AdminMenu.BanDuration:SetPos( 340, 70 );
	CCP.AdminMenu.BanDuration:SetSize( 40, 20 );
	CCP.AdminMenu.BanDuration:PerformLayout();
	CCP.AdminMenu.BanDuration:SetValue( "60" );
	
	CCP.AdminMenu.BanBut = vgui.Create( "DButton", CCP.AdminMenu.ContentPane );
	CCP.AdminMenu.BanBut:SetFont( "CombineControl.LabelSmall" );
	CCP.AdminMenu.BanBut:SetText( "Ban" );
	CCP.AdminMenu.BanBut:SetPos( 580, 70 );
	CCP.AdminMenu.BanBut:SetSize( 100, 20 );
	function CCP.AdminMenu.BanBut:DoClick()
		
		RunConsoleCommand( "rpa_plyban", CCP.AdminMenu.PlayerList:GetLine( CCP.AdminMenu.SelectedID ).SteamID, CCP.AdminMenu.BanDuration:GetValue(), CCP.AdminMenu.BanReason:GetValue() );
		
		CCP.AdminMenu.PlayerList:RemoveLine( CCP.AdminMenu.SelectedID );
		
		GAMEMODE:AdminPlayerMenuDisable();
		
	end
	CCP.AdminMenu.BanBut:SetDisabled( true );
	CCP.AdminMenu.BanBut:PerformLayout();
	
	CCP.AdminMenu.PBanBut = vgui.Create( "DButton", CCP.AdminMenu.ContentPane );
	CCP.AdminMenu.PBanBut:SetFont( "CombineControl.LabelSmall" );
	CCP.AdminMenu.PBanBut:SetText( "Permaban" );
	CCP.AdminMenu.PBanBut:SetPos( 690, 70 );
	CCP.AdminMenu.PBanBut:SetSize( 100, 20 );
	function CCP.AdminMenu.PBanBut.DoClick()
		
		RunConsoleCommand( "rpa_plyban", CCP.AdminMenu.PlayerList:GetLine( CCP.AdminMenu.SelectedID ).SteamID, "0", CCP.AdminMenu.BanReason:GetValue() );
		
		CCP.AdminMenu.PlayerList:RemoveLine( CCP.AdminMenu.SelectedID );
		
		GAMEMODE:AdminPlayerMenuDisable();
		
	end
	CCP.AdminMenu.PBanBut:SetDisabled( true );
	CCP.AdminMenu.PBanBut:PerformLayout();
	
	CCP.AdminMenu.BringBut = vgui.Create( "DButton", CCP.AdminMenu.ContentPane );
	CCP.AdminMenu.BringBut:SetFont( "CombineControl.LabelSmall" );
	CCP.AdminMenu.BringBut:SetText( "Bring" );
	CCP.AdminMenu.BringBut:SetPos( 220, 100 );
	CCP.AdminMenu.BringBut:SetSize( 100, 20 );
	function CCP.AdminMenu.BringBut:DoClick()
		
		RunConsoleCommand( "rpa_plybring", CCP.AdminMenu.PlayerList:GetLine( CCP.AdminMenu.SelectedID ).SteamID );
		
	end
	CCP.AdminMenu.BringBut:SetDisabled( true );
	CCP.AdminMenu.BringBut:PerformLayout();
	
	CCP.AdminMenu.GotoBut = vgui.Create( "DButton", CCP.AdminMenu.ContentPane );
	CCP.AdminMenu.GotoBut:SetFont( "CombineControl.LabelSmall" );
	CCP.AdminMenu.GotoBut:SetText( "Goto" );
	CCP.AdminMenu.GotoBut:SetPos( 340, 100 );
	CCP.AdminMenu.GotoBut:SetSize( 100, 20 );
	function CCP.AdminMenu.GotoBut:DoClick()
		
		RunConsoleCommand( "rpa_plygoto", CCP.AdminMenu.PlayerList:GetLine( CCP.AdminMenu.SelectedID ).SteamID );
		
	end
	CCP.AdminMenu.GotoBut:SetDisabled( true );
	CCP.AdminMenu.GotoBut:PerformLayout();
	
	CCP.AdminMenu.KillBut = vgui.Create( "DButton", CCP.AdminMenu.ContentPane );
	CCP.AdminMenu.KillBut:SetFont( "CombineControl.LabelSmall" );
	CCP.AdminMenu.KillBut:SetText( "Kill" );
	CCP.AdminMenu.KillBut:SetPos( 460, 100 );
	CCP.AdminMenu.KillBut:SetSize( 100, 20 );
	function CCP.AdminMenu.KillBut:DoClick()
		
		RunConsoleCommand( "rpa_plykill", CCP.AdminMenu.PlayerList:GetLine( CCP.AdminMenu.SelectedID ).SteamID );
		
	end
	CCP.AdminMenu.KillBut:SetDisabled( true );
	CCP.AdminMenu.KillBut:PerformLayout();
	
	CCP.AdminMenu.SlapBut = vgui.Create( "DButton", CCP.AdminMenu.ContentPane );
	CCP.AdminMenu.SlapBut:SetFont( "CombineControl.LabelSmall" );
	CCP.AdminMenu.SlapBut:SetText( "Slap" );
	CCP.AdminMenu.SlapBut:SetPos( 580, 100 );
	CCP.AdminMenu.SlapBut:SetSize( 100, 20 );
	function CCP.AdminMenu.SlapBut:DoClick()
		
		RunConsoleCommand( "rpa_plyslap", CCP.AdminMenu.PlayerList:GetLine( CCP.AdminMenu.SelectedID ).SteamID );
		
	end
	CCP.AdminMenu.SlapBut:SetDisabled( true );
	CCP.AdminMenu.SlapBut:PerformLayout();
	
	CCP.AdminMenu.KOBut = vgui.Create( "DButton", CCP.AdminMenu.ContentPane );
	CCP.AdminMenu.KOBut:SetFont( "CombineControl.LabelSmall" );
	CCP.AdminMenu.KOBut:SetText( "KO" );
	CCP.AdminMenu.KOBut:SetPos( 690, 100 );
	CCP.AdminMenu.KOBut:SetSize( 40, 20 );
	function CCP.AdminMenu.KOBut:DoClick()
		
		RunConsoleCommand( "rpa_plyknockout", CCP.AdminMenu.PlayerList:GetLine( CCP.AdminMenu.SelectedID ).SteamID );
		
	end
	CCP.AdminMenu.KOBut:SetDisabled( true );
	CCP.AdminMenu.KOBut:PerformLayout();
	
	CCP.AdminMenu.WakeBut = vgui.Create( "DButton", CCP.AdminMenu.ContentPane );
	CCP.AdminMenu.WakeBut:SetFont( "CombineControl.LabelSmall" );
	CCP.AdminMenu.WakeBut:SetText( "Wake" );
	CCP.AdminMenu.WakeBut:SetPos( 740, 100 );
	CCP.AdminMenu.WakeBut:SetSize( 50, 20 );
	function CCP.AdminMenu.WakeBut:DoClick()
		
		RunConsoleCommand( "rpa_plywake", CCP.AdminMenu.PlayerList:GetLine( CCP.AdminMenu.SelectedID ).SteamID );
		
	end
	CCP.AdminMenu.WakeBut:SetDisabled( true );
	CCP.AdminMenu.WakeBut:PerformLayout();
	
	CCP.AdminMenu.GiveMoneyLabel = vgui.Create( "DLabel", CCP.AdminMenu.ContentPane );
	CCP.AdminMenu.GiveMoneyLabel:SetText( "Give Rubles" );
	CCP.AdminMenu.GiveMoneyLabel:SetPos( 220, 130 );
	CCP.AdminMenu.GiveMoneyLabel:SetFont( "CombineControl.LabelMedium" );
	CCP.AdminMenu.GiveMoneyLabel:SizeToContents();
	CCP.AdminMenu.GiveMoneyLabel:PerformLayout();
	
	CCP.AdminMenu.GiveMoney = vgui.Create( "DTextEntry", CCP.AdminMenu.ContentPane );
	CCP.AdminMenu.GiveMoney:SetFont( "CombineControl.LabelMedium" );
	CCP.AdminMenu.GiveMoney:SetPos( 340, 130 );
	CCP.AdminMenu.GiveMoney:SetSize( 40, 20 );
	CCP.AdminMenu.GiveMoney:SetNumeric( true );
	CCP.AdminMenu.GiveMoney:SetValue( 0 );
	CCP.AdminMenu.GiveMoney:PerformLayout();
	
	CCP.AdminMenu.GiveMoneyBut = vgui.Create( "DButton", CCP.AdminMenu.ContentPane );
	CCP.AdminMenu.GiveMoneyBut:SetFont( "CombineControl.LabelSmall" );
	CCP.AdminMenu.GiveMoneyBut:SetText( "Give" );
	CCP.AdminMenu.GiveMoneyBut:SetPos( 390, 130 );
	CCP.AdminMenu.GiveMoneyBut:SetSize( 100, 20 );
	function CCP.AdminMenu.GiveMoneyBut:DoClick()
		
		RunConsoleCommand( "rpa_chargivemoney", CCP.AdminMenu.PlayerList:GetLine( CCP.AdminMenu.SelectedID ).SteamID, CCP.AdminMenu.GiveMoney:GetValue() );
		
	end
	CCP.AdminMenu.GiveMoneyBut:SetDisabled( true );
	CCP.AdminMenu.GiveMoneyBut:PerformLayout();
	
	CCP.AdminMenu.CharFlagLabel = vgui.Create( "DLabel", CCP.AdminMenu.ContentPane );
	CCP.AdminMenu.CharFlagLabel:SetText( "Character Flag" );
	CCP.AdminMenu.CharFlagLabel:SetPos( 220, 160 );
	CCP.AdminMenu.CharFlagLabel:SetFont( "CombineControl.LabelMedium" );
	CCP.AdminMenu.CharFlagLabel:SizeToContents();
	CCP.AdminMenu.CharFlagLabel:PerformLayout();
	
	CCP.AdminMenu.CharFlag = vgui.Create( "DTextEntry", CCP.AdminMenu.ContentPane );
	CCP.AdminMenu.CharFlag:SetFont( "CombineControl.LabelMedium" );
	CCP.AdminMenu.CharFlag:SetPos( 340, 160 );
	CCP.AdminMenu.CharFlag:SetSize( 40, 20 );
	CCP.AdminMenu.CharFlag:PerformLayout();
	
	CCP.AdminMenu.CharFlagBut = vgui.Create( "DButton", CCP.AdminMenu.ContentPane );
	CCP.AdminMenu.CharFlagBut:SetFont( "CombineControl.LabelSmall" );
	CCP.AdminMenu.CharFlagBut:SetText( "Apply" );
	CCP.AdminMenu.CharFlagBut:SetPos( 390, 160 );
	CCP.AdminMenu.CharFlagBut:SetSize( 100, 20 );
	function CCP.AdminMenu.CharFlagBut:DoClick()
		
		RunConsoleCommand( "rpa_charsetflag", CCP.AdminMenu.PlayerList:GetLine( CCP.AdminMenu.SelectedID ).SteamID, CCP.AdminMenu.CharFlag:GetValue() );
		
	end
	CCP.AdminMenu.CharFlagBut:SetDisabled( true );
	CCP.AdminMenu.CharFlagBut:PerformLayout();
	
	CCP.AdminMenu.ModelLabel = vgui.Create( "DLabel", CCP.AdminMenu.ContentPane );
	CCP.AdminMenu.ModelLabel:SetText( "Character Model" );
	CCP.AdminMenu.ModelLabel:SetPos( 220, 190 );
	CCP.AdminMenu.ModelLabel:SetFont( "CombineControl.LabelMedium" );
	CCP.AdminMenu.ModelLabel:SizeToContents();
	CCP.AdminMenu.ModelLabel:PerformLayout();
	
	CCP.AdminMenu.Model = vgui.Create( "DTextEntry", CCP.AdminMenu.ContentPane );
	CCP.AdminMenu.Model:SetFont( "CombineControl.LabelMedium" );
	CCP.AdminMenu.Model:SetPos( 340, 190 );
	CCP.AdminMenu.Model:SetSize( 300, 20 );
	CCP.AdminMenu.Model:PerformLayout();
	
	CCP.AdminMenu.ModelBut = vgui.Create( "DButton", CCP.AdminMenu.ContentPane );
	CCP.AdminMenu.ModelBut:SetFont( "CombineControl.LabelSmall" );
	CCP.AdminMenu.ModelBut:SetText( "Apply" );
	CCP.AdminMenu.ModelBut:SetPos( 650, 190 );
	CCP.AdminMenu.ModelBut:SetSize( 100, 20 );
	function CCP.AdminMenu.ModelBut:DoClick()
		
		RunConsoleCommand( "rpa_charsetmodel", CCP.AdminMenu.PlayerList:GetLine( CCP.AdminMenu.SelectedID ).SteamID, CCP.AdminMenu.Model:GetValue() );
		
	end
	CCP.AdminMenu.ModelBut:SetDisabled( true );
	CCP.AdminMenu.ModelBut:PerformLayout();
	
	CCP.AdminMenu.PhysTrust0 = vgui.Create( "DButton", CCP.AdminMenu.ContentPane );
	CCP.AdminMenu.PhysTrust0:SetFont( "CombineControl.LabelSmall" );
	CCP.AdminMenu.PhysTrust0:SetText( "Remove Physgun" );
	CCP.AdminMenu.PhysTrust0:SetPos( 220, 220 );
	CCP.AdminMenu.PhysTrust0:SetSize( 100, 20 );
	function CCP.AdminMenu.PhysTrust0:DoClick()
		
		RunConsoleCommand( "rpa_plysetphystrust", CCP.AdminMenu.PlayerList:GetLine( CCP.AdminMenu.SelectedID ).SteamID, 0 );
		CCP.AdminMenu.PhysTrust0:SetDisabled( true );
		CCP.AdminMenu.PhysTrust1:SetDisabled( false );
		
	end
	CCP.AdminMenu.PhysTrust0:SetDisabled( true );
	CCP.AdminMenu.PhysTrust0:PerformLayout();
	
	CCP.AdminMenu.PhysTrust1 = vgui.Create( "DButton", CCP.AdminMenu.ContentPane );
	CCP.AdminMenu.PhysTrust1:SetFont( "CombineControl.LabelSmall" );
	CCP.AdminMenu.PhysTrust1:SetText( "Give Physgun" );
	CCP.AdminMenu.PhysTrust1:SetPos( 330, 220 );
	CCP.AdminMenu.PhysTrust1:SetSize( 100, 20 );
	function CCP.AdminMenu.PhysTrust1:DoClick()
		
		RunConsoleCommand( "rpa_plysetphystrust", CCP.AdminMenu.PlayerList:GetLine( CCP.AdminMenu.SelectedID ).SteamID, 1 );
		CCP.AdminMenu.PhysTrust0:SetDisabled( false );
		CCP.AdminMenu.PhysTrust1:SetDisabled( true );
		
	end
	CCP.AdminMenu.PhysTrust1:SetDisabled( true );
	CCP.AdminMenu.PhysTrust1:PerformLayout();
	
	CCP.AdminMenu.PropTrust0 = vgui.Create( "DButton", CCP.AdminMenu.ContentPane );
	CCP.AdminMenu.PropTrust0:SetFont( "CombineControl.LabelSmall" );
	CCP.AdminMenu.PropTrust0:SetText( "Remove Proptrust" );
	CCP.AdminMenu.PropTrust0:SetPos( 220, 250 );
	CCP.AdminMenu.PropTrust0:SetSize( 100, 20 );
	function CCP.AdminMenu.PropTrust0:DoClick()
		
		RunConsoleCommand( "rpa_plysetproptrust", CCP.AdminMenu.PlayerList:GetLine( CCP.AdminMenu.SelectedID ).SteamID, 0 );
		CCP.AdminMenu.PropTrust0:SetDisabled( true );
		CCP.AdminMenu.PropTrust1:SetDisabled( false );
		
	end
	CCP.AdminMenu.PropTrust0:SetDisabled( true );
	CCP.AdminMenu.PropTrust0:PerformLayout();
	
	CCP.AdminMenu.PropTrust1 = vgui.Create( "DButton", CCP.AdminMenu.ContentPane );
	CCP.AdminMenu.PropTrust1:SetFont( "CombineControl.LabelSmall" );
	CCP.AdminMenu.PropTrust1:SetText( "Give Proptrust" );
	CCP.AdminMenu.PropTrust1:SetPos( 330, 250 );
	CCP.AdminMenu.PropTrust1:SetSize( 100, 20 );
	function CCP.AdminMenu.PropTrust1:DoClick()
		
		RunConsoleCommand( "rpa_plysetproptrust", CCP.AdminMenu.PlayerList:GetLine( CCP.AdminMenu.SelectedID ).SteamID, 1 );
		CCP.AdminMenu.PropTrust0:SetDisabled( false );
		CCP.AdminMenu.PropTrust1:SetDisabled( true );
		
	end
	CCP.AdminMenu.PropTrust1:SetDisabled( true );
	CCP.AdminMenu.PropTrust1:PerformLayout();
	
	CCP.AdminMenu.TT0 = vgui.Create( "DButton", CCP.AdminMenu.ContentPane );
	CCP.AdminMenu.TT0:SetFont( "CombineControl.LabelSmall" );
	CCP.AdminMenu.TT0:SetText( "TT: None" );
	CCP.AdminMenu.TT0:SetPos( 220, 280 );
	CCP.AdminMenu.TT0:SetSize( 100, 20 );
	function CCP.AdminMenu.TT0:DoClick()
		
		RunConsoleCommand( "rpa_plysettooltrust", CCP.AdminMenu.PlayerList:GetLine( CCP.AdminMenu.SelectedID ).SteamID, 0 );
		CCP.AdminMenu.TT0:SetDisabled( true );
		CCP.AdminMenu.TT1:SetDisabled( false );
		CCP.AdminMenu.TT2:SetDisabled( false );
		
	end
	CCP.AdminMenu.TT0:SetDisabled( true );
	CCP.AdminMenu.TT0:PerformLayout();
	
	CCP.AdminMenu.TT1 = vgui.Create( "DButton", CCP.AdminMenu.ContentPane );
	CCP.AdminMenu.TT1:SetFont( "CombineControl.LabelSmall" );
	CCP.AdminMenu.TT1:SetText( "TT: Basic" );
	CCP.AdminMenu.TT1:SetPos( 330, 280 );
	CCP.AdminMenu.TT1:SetSize( 100, 20 );
	function CCP.AdminMenu.TT1:DoClick()
		
		RunConsoleCommand( "rpa_plysettooltrust", CCP.AdminMenu.PlayerList:GetLine( CCP.AdminMenu.SelectedID ).SteamID, 1 );
		CCP.AdminMenu.TT0:SetDisabled( false );
		CCP.AdminMenu.TT1:SetDisabled( true );
		CCP.AdminMenu.TT2:SetDisabled( false );
		
	end
	CCP.AdminMenu.TT1:SetDisabled( true );
	CCP.AdminMenu.TT1:PerformLayout();
	
	CCP.AdminMenu.TT2 = vgui.Create( "DButton", CCP.AdminMenu.ContentPane );
	CCP.AdminMenu.TT2:SetFont( "CombineControl.LabelSmall" );
	CCP.AdminMenu.TT2:SetText( "TT: Advanced" );
	CCP.AdminMenu.TT2:SetPos( 440, 280 );
	CCP.AdminMenu.TT2:SetSize( 100, 20 );
	function CCP.AdminMenu.TT2:DoClick()
		
		RunConsoleCommand( "rpa_plysettooltrust", CCP.AdminMenu.PlayerList:GetLine( CCP.AdminMenu.SelectedID ).SteamID, 2 );
		CCP.AdminMenu.TT0:SetDisabled( false );
		CCP.AdminMenu.TT1:SetDisabled( false );
		CCP.AdminMenu.TT2:SetDisabled( true );
		
	end
	CCP.AdminMenu.TT2:SetDisabled( true );
	CCP.AdminMenu.TT2:PerformLayout();
	
	CCP.AdminMenu.SetRankUser = vgui.Create( "DButton", CCP.AdminMenu.ContentPane );
	CCP.AdminMenu.SetRankUser:SetFont( "CombineControl.LabelSmall" );
	CCP.AdminMenu.SetRankUser:SetText( "User" );
	CCP.AdminMenu.SetRankUser:SetPos( 220, 310 );
	CCP.AdminMenu.SetRankUser:SetSize( 100, 20 );
	function CCP.AdminMenu.SetRankUser:DoClick()
		
		RunConsoleCommand( "rpa_plysetrank", CCP.AdminMenu.PlayerList:GetLine( CCP.AdminMenu.SelectedID ).SteamID, "user" );
		CCP.AdminMenu.SetRankUser:SetDisabled( true );
		CCP.AdminMenu.SetRankGM:SetDisabled( false );
		CCP.AdminMenu.SetRankAdmin:SetDisabled( false );
		
	end
	CCP.AdminMenu.SetRankUser:SetDisabled( true );
	CCP.AdminMenu.SetRankUser:PerformLayout();
	
	CCP.AdminMenu.SetRankGM = vgui.Create( "DButton", CCP.AdminMenu.ContentPane );
	CCP.AdminMenu.SetRankGM:SetFont( "CombineControl.LabelSmall" );
	CCP.AdminMenu.SetRankGM:SetText( "Global GM" );
	CCP.AdminMenu.SetRankGM:SetPos( 330, 310 );
	CCP.AdminMenu.SetRankGM:SetSize( 100, 20 );
	function CCP.AdminMenu.SetRankGM:DoClick()
		
		RunConsoleCommand( "rpa_plysetrank", CCP.AdminMenu.PlayerList:GetLine( CCP.AdminMenu.SelectedID ).SteamID, "gamemaster" );
		CCP.AdminMenu.SetRankUser:SetDisabled( false );
		CCP.AdminMenu.SetRankGM:SetDisabled( true );
		CCP.AdminMenu.SetRankAdmin:SetDisabled( false );
		
	end
	CCP.AdminMenu.SetRankGM:SetDisabled( true );
	CCP.AdminMenu.SetRankGM:PerformLayout();
	
	CCP.AdminMenu.SetRankAdmin = vgui.Create( "DButton", CCP.AdminMenu.ContentPane );
	CCP.AdminMenu.SetRankAdmin:SetFont( "CombineControl.LabelSmall" );
	CCP.AdminMenu.SetRankAdmin:SetText( "Admin" );
	CCP.AdminMenu.SetRankAdmin:SetPos( 440, 310 );
	CCP.AdminMenu.SetRankAdmin:SetSize( 100, 20 );
	function CCP.AdminMenu.SetRankAdmin:DoClick()
		
		RunConsoleCommand( "rpa_plysetrank", CCP.AdminMenu.PlayerList:GetLine( CCP.AdminMenu.SelectedID ).SteamID, "admin" );
		CCP.AdminMenu.SetRankUser:SetDisabled( false );
		CCP.AdminMenu.SetRankGM:SetDisabled( false );
		CCP.AdminMenu.SetRankAdmin:SetDisabled( true );
		
	end
	CCP.AdminMenu.SetRankAdmin:SetDisabled( true );
	CCP.AdminMenu.SetRankAdmin:PerformLayout();
	
	CCP.AdminMenu.GiveAccessToStockpile = vgui.Create( "DButton", CCP.AdminMenu.ContentPane );
	CCP.AdminMenu.GiveAccessToStockpile:SetFont( "CombineControl.LabelSmall" );
	CCP.AdminMenu.GiveAccessToStockpile:SetText( "Give Access" );
	CCP.AdminMenu.GiveAccessToStockpile:SetPos( 220, 340 );
	CCP.AdminMenu.GiveAccessToStockpile:SetSize( 100, 20 );
	function CCP.AdminMenu.GiveAccessToStockpile:DoClick()
		
		GAMEMODE:AdminCreateStockpilesMenu()
		netstream.Start( "nAdminPopulateGiveAccessMenu" );
		
	end
	CCP.AdminMenu.GiveAccessToStockpile:SetDisabled( true );
	CCP.AdminMenu.GiveAccessToStockpile:PerformLayout();
	
	CCP.AdminMenu.TakeAccessFromStockpile = vgui.Create( "DButton", CCP.AdminMenu.ContentPane );
	CCP.AdminMenu.TakeAccessFromStockpile:SetFont( "CombineControl.LabelSmall" );
	CCP.AdminMenu.TakeAccessFromStockpile:SetText( "Take Access" );
	CCP.AdminMenu.TakeAccessFromStockpile:SetPos( 330, 340 );
	CCP.AdminMenu.TakeAccessFromStockpile:SetSize( 100, 20 );
	function CCP.AdminMenu.TakeAccessFromStockpile:DoClick()
		
		GAMEMODE:AdminCreateStockpilesMenu()
		netstream.Start( "nAdminPopulateTakeAccessMenu" );
		
	end
	CCP.AdminMenu.TakeAccessFromStockpile:SetDisabled( true );
	CCP.AdminMenu.TakeAccessFromStockpile:PerformLayout();
	
	CCP.AdminMenu.EditInventory = vgui.Create( "DButton", CCP.AdminMenu.ContentPane );
	CCP.AdminMenu.EditInventory:SetFont( "CombineControl.LabelSmall" );
	CCP.AdminMenu.EditInventory:SetText( "Edit inventory..." );
	CCP.AdminMenu.EditInventory:SetPos( 220, 370 );
	CCP.AdminMenu.EditInventory:SetSize( 100, 20 );
	function CCP.AdminMenu.EditInventory:DoClick()
		
		RunConsoleCommand( "rpa_chareditinventory", CCP.AdminMenu.PlayerList:GetLine( CCP.AdminMenu.SelectedID ).SteamID );
		
	end
	CCP.AdminMenu.EditInventory:SetDisabled( true );
	CCP.AdminMenu.EditInventory:PerformLayout();
	
	CCP.AdminMenu.WarnName = vgui.Create( "DButton", CCP.AdminMenu.ContentPane );
	CCP.AdminMenu.WarnName:SetFont( "CombineControl.LabelSmall" );
	CCP.AdminMenu.WarnName:SetText( "Name Warning" );
	CCP.AdminMenu.WarnName:SetPos( 330, 370 );
	CCP.AdminMenu.WarnName:SetSize( 100, 20 );
	function CCP.AdminMenu.WarnName:DoClick()
		
		RunConsoleCommand( "rpa_charnamewarn", CCP.AdminMenu.PlayerList:GetLine( CCP.AdminMenu.SelectedID ).SteamID );
		
	end
	CCP.AdminMenu.WarnName:SetDisabled( true );
	CCP.AdminMenu.WarnName:PerformLayout();
	
	CCP.AdminMenu.ToggleWatched = vgui.Create( "DButton", CCP.AdminMenu.ContentPane );
	CCP.AdminMenu.ToggleWatched:SetFont( "CombineControl.LabelSmall" );
	CCP.AdminMenu.ToggleWatched:SetText( "Watch" );
	CCP.AdminMenu.ToggleWatched:SetPos( 220, 400 );
	CCP.AdminMenu.ToggleWatched:SetSize( 100, 20 );
	function CCP.AdminMenu.ToggleWatched:DoClick()
		
		RunConsoleCommand( "rpa_togglewatched", CCP.AdminMenu.PlayerList:GetLine( CCP.AdminMenu.SelectedID ).SteamID );
		if !CCP.AdminMenu.PlayerList:GetLine( CCP.AdminMenu.SelectedID ).Player:Watched() then
			self:SetText("Unwatch")
		else
			self:SetText("Watch")
		end
		
	end
	CCP.AdminMenu.ToggleWatched:SetDisabled( true );
	CCP.AdminMenu.ToggleWatched:PerformLayout();
	
end

function GM:AdminCreateBansMenu()
	
	CCP.AdminMenu.BansList = vgui.Create( "DListView", CCP.AdminMenu.ContentPane );
	CCP.AdminMenu.BansList:SetPos( 10, 10 );
	CCP.AdminMenu.BansList:SetSize( 780, 366 );
	CCP.AdminMenu.BansList:AddColumn( "SteamID" );
	CCP.AdminMenu.BansList:AddColumn( "Length" );
	CCP.AdminMenu.BansList:AddColumn( "Reason" );
	CCP.AdminMenu.BansList:AddColumn( "Date" );
	CCP.AdminMenu.BansList:AddColumn( "Time Remaining" );
	
	CCP.AdminMenu.SelectedBanID = nil;
	
	function CCP.AdminMenu.BansList:OnRowSelected( id, line )
		
		CCP.AdminMenu.SelectedBanID = id;
		CCP.AdminMenu.UnbanBut:SetDisabled( false );
		
	end
	
	CCP.AdminMenu.BanBut = vgui.Create( "DButton", CCP.AdminMenu.ContentPane );
	CCP.AdminMenu.BanBut:SetFont( "CombineControl.LabelSmall" );
	CCP.AdminMenu.BanBut:SetText( "Ban SteamID" );
	CCP.AdminMenu.BanBut:SetPos( 10, 386 );
	CCP.AdminMenu.BanBut:SetSize( 100, 30 );
	function CCP.AdminMenu.BanBut:DoClick()
		
		GAMEMODE:AMCreateBanEntry();
		
	end
	CCP.AdminMenu.BanBut:PerformLayout();
	
	CCP.AdminMenu.UnbanBut = vgui.Create( "DButton", CCP.AdminMenu.ContentPane );
	CCP.AdminMenu.UnbanBut:SetFont( "CombineControl.LabelSmall" );
	CCP.AdminMenu.UnbanBut:SetText( "Unban" );
	CCP.AdminMenu.UnbanBut:SetPos( 690, 386 );
	CCP.AdminMenu.UnbanBut:SetSize( 100, 30 );
	function CCP.AdminMenu.UnbanBut:DoClick()
		
		RunConsoleCommand( "rpa_plyunban", CCP.AdminMenu.BansList:GetLine( CCP.AdminMenu.SelectedBanID ).SteamID );
		
	end
	CCP.AdminMenu.UnbanBut:SetDisabled( true );
	CCP.AdminMenu.UnbanBut:PerformLayout();
	
	netstream.Start( "nGetBansList" );
	
end

function GM:AMCreateBanEntry()
	
	CCP.AdminMenu.BanEntry = vgui.Create( "DFrame" );
	CCP.AdminMenu.BanEntry:SetSize( 300, 194 );
	CCP.AdminMenu.BanEntry:Center();
	CCP.AdminMenu.BanEntry:SetTitle( "Ban SteamID" );
	CCP.AdminMenu.BanEntry.lblTitle:SetFont( "CombineControl.Window" );
	CCP.AdminMenu.BanEntry:MakePopup();
	CCP.AdminMenu.BanEntry.PerformLayout = CCFramePerformLayout;
	CCP.AdminMenu.BanEntry:PerformLayout();
	
	CCP.AdminMenu.BanEntry.Label1 = vgui.Create( "DLabel", CCP.AdminMenu.BanEntry );
	CCP.AdminMenu.BanEntry.Label1:SetText( "SteamID: " );
	CCP.AdminMenu.BanEntry.Label1:SetPos( 10, 34 );
	CCP.AdminMenu.BanEntry.Label1:SetSize( 280, 30 );
	CCP.AdminMenu.BanEntry.Label1:SetFont( "CombineControl.LabelGiant" );
	CCP.AdminMenu.BanEntry.Label1:PerformLayout();
	
	CCP.AdminMenu.BanEntry.Entry1 = vgui.Create( "DTextEntry", CCP.AdminMenu.BanEntry );
	CCP.AdminMenu.BanEntry.Entry1:SetFont( "CombineControl.LabelBig" );
	CCP.AdminMenu.BanEntry.Entry1:SetPos( 100, 34 );
	CCP.AdminMenu.BanEntry.Entry1:SetSize( 190, 30 );
	CCP.AdminMenu.BanEntry.Entry1:PerformLayout();
	CCP.AdminMenu.BanEntry.Entry1:SetValue( "" );
	CCP.AdminMenu.BanEntry.Entry1:RequestFocus();
	
	CCP.AdminMenu.BanEntry.Label2 = vgui.Create( "DLabel", CCP.AdminMenu.BanEntry );
	CCP.AdminMenu.BanEntry.Label2:SetText( "Duration: " );
	CCP.AdminMenu.BanEntry.Label2:SetPos( 10, 74 );
	CCP.AdminMenu.BanEntry.Label2:SetSize( 280, 30 );
	CCP.AdminMenu.BanEntry.Label2:SetFont( "CombineControl.LabelGiant" );
	CCP.AdminMenu.BanEntry.Label2:PerformLayout();
	
	CCP.AdminMenu.BanEntry.Entry2 = vgui.Create( "DTextEntry", CCP.AdminMenu.BanEntry );
	CCP.AdminMenu.BanEntry.Entry2:SetFont( "CombineControl.LabelBig" );
	CCP.AdminMenu.BanEntry.Entry2:SetPos( 100, 74 );
	CCP.AdminMenu.BanEntry.Entry2:SetSize( 190, 30 );
	CCP.AdminMenu.BanEntry.Entry2:PerformLayout();
	CCP.AdminMenu.BanEntry.Entry2:SetValue( "" );
	CCP.AdminMenu.BanEntry.Entry2:SetNumeric( true );
	
	CCP.AdminMenu.BanEntry.Label3 = vgui.Create( "DLabel", CCP.AdminMenu.BanEntry );
	CCP.AdminMenu.BanEntry.Label3:SetText( "Reason: " );
	CCP.AdminMenu.BanEntry.Label3:SetPos( 10, 114 );
	CCP.AdminMenu.BanEntry.Label3:SetSize( 280, 30 );
	CCP.AdminMenu.BanEntry.Label3:SetFont( "CombineControl.LabelGiant" );
	CCP.AdminMenu.BanEntry.Label3:PerformLayout();
	
	CCP.AdminMenu.BanEntry.Entry3 = vgui.Create( "DTextEntry", CCP.AdminMenu.BanEntry );
	CCP.AdminMenu.BanEntry.Entry3:SetFont( "CombineControl.LabelBig" );
	CCP.AdminMenu.BanEntry.Entry3:SetPos( 100, 114 );
	CCP.AdminMenu.BanEntry.Entry3:SetSize( 190, 30 );
	CCP.AdminMenu.BanEntry.Entry3:PerformLayout();
	CCP.AdminMenu.BanEntry.Entry3:SetValue( "" );
	
	CCP.AdminMenu.BanEntry.OK = vgui.Create( "DButton", CCP.AdminMenu.BanEntry );
	CCP.AdminMenu.BanEntry.OK:SetFont( "CombineControl.LabelSmall" );
	CCP.AdminMenu.BanEntry.OK:SetText( "OK" );
	CCP.AdminMenu.BanEntry.OK:SetPos( 240, 154 );
	CCP.AdminMenu.BanEntry.OK:SetSize( 50, 30 );
	function CCP.AdminMenu.BanEntry.OK:DoClick()
		
		local sid = string.Trim( CCP.AdminMenu.BanEntry.Entry1:GetValue() );
		local dur = string.Trim( CCP.AdminMenu.BanEntry.Entry2:GetValue() );
		local reason = string.Trim( CCP.AdminMenu.BanEntry.Entry3:GetValue() );
		
		if( string.find( sid, "STEAM_" ) ) then
			
			if( tonumber( dur ) ) then
				
				if( math.ceil( tonumber( dur ) ) > -1 ) then
					
					CCP.AdminMenu.BanEntry:Remove();
					
					RunConsoleCommand( "rpa_plyban", sid, math.ceil( tonumber( dur ) ), reason );
					
				else

					LocalPlayer():Notify(nil, COLOR_ERROR, "Error: Negative duration specified.")
					
				end
				
			else

				LocalPlayer():Notify(nil, COLOR_ERROR, "Error: Invalid duration specified.")
				
			end
			
		else
			
			LocalPlayer():Notify(nil, COLOR_ERROR, "Error: Invalid SteamID specified.")
			
		end
		
	end
	CCP.AdminMenu.BanEntry.OK:PerformLayout();
	
	CCP.AdminMenu.BanEntry.Entry3.OnEnter = CCP.AdminMenu.BanEntry.OK.DoClick;
	
end

function nBansList( tbl )
	
	GAMEMODE.BanTable = tbl;
	
	if( CCP.AdminMenu and CCP.AdminMenu.BansList and CCP.AdminMenu.BansList:IsValid() ) then
		
		CCP.AdminMenu.BansList:Clear();
		
		for _, v in pairs( GAMEMODE.BanTable ) do
			
			local tr = math.max( v.Length - util.TimeSinceDate( v.Date ), 0 );
			
			if( tonumber( v.Length ) == 0 ) then
				
				v.Length = "Permanent";
				tr = "";
				
			end
			
			local line = CCP.AdminMenu.BansList:AddLine( v.SteamID, v.Length, v.Reason, v.Date, tr );
			line.SteamID = v.SteamID;
			
		end
		
	end
	
end
netstream.Hook( "nBansList", nBansList );

function GM:AdminCreateLogsMenu()
	CCP.AdminMenu.LogList = vgui.Create( "DListView", CCP.AdminMenu.ContentPane );
	CCP.AdminMenu.LogList:SetPos( 120, 10 );
	CCP.AdminMenu.LogList:SetSize( 670, 406 );
	CCP.AdminMenu.LogList:AddColumn( "Date" ):SetFixedWidth(128)
	CCP.AdminMenu.LogList:AddColumn( "Category" ):SetFixedWidth(64)
	CCP.AdminMenu.LogList:AddColumn( "Log" );
	CCP.AdminMenu.LogList:AddLine( "No logs to display." );
	CCP.AdminMenu.LogList.Position = 0
	CCP.AdminMenu.LogList.Category = "chat"
	CCP.AdminMenu.LogList.Date = os.date("!%Y-%m-%d")
	CCP.AdminMenu.LogList.Content = ""
	
	function CCP.AdminMenu.LogList:DoDoubleClick( lineID, line )
		if line.PreviousPage then
			CCP.AdminMenu.LogList.Position = math.Clamp(CCP.AdminMenu.LogList.Position + 50, 0, CCP.AdminMenu.LogList.Position)
			netstream.Start("RequestLogSearch", CCP.AdminMenu.LogList.Date, CCP.AdminMenu.LogList.Category, CCP.AdminMenu.LogList.Content, CCP.AdminMenu.LogList.Position)
			
			return
		end
		
		if line.NextPage then
			CCP.AdminMenu.LogList.Position = CCP.AdminMenu.LogList.Position - 50
			netstream.Start("RequestLogSearch", CCP.AdminMenu.LogList.Date, CCP.AdminMenu.LogList.Category, CCP.AdminMenu.LogList.Content, CCP.AdminMenu.LogList.Position)
			
			return
		end
		
		
		MsgC(Color(255, 0, 0), line:GetColumnText(3), "\n")
		SetClipboardText(line:GetColumnText(3))
	end
	
	CCP.AdminMenu.LogContent = vgui.Create( "DTextEntry", CCP.AdminMenu.ContentPane )
	CCP.AdminMenu.LogContent:SetFont( "CombineControl.LabelMedium" )
	CCP.AdminMenu.LogContent:SetPos( 10, 10 )
	CCP.AdminMenu.LogContent:SetSize( 100, 20 )
	CCP.AdminMenu.LogContent:SetValue("")
	CCP.AdminMenu.LogContent:SetPlaceholderText("Log content (e.g. 'obtained item')")
	CCP.AdminMenu.LogContent:PerformLayout()
	function CCP.AdminMenu.LogContent:OnChange()
		CCP.AdminMenu.LogList.Content = self:GetValue()
	end
	
	CCP.AdminMenu.LogCategory = vgui.Create( "DComboBox", CCP.AdminMenu.ContentPane );
	CCP.AdminMenu.LogCategory:SetFont( "CombineControl.LabelMedium" );
	CCP.AdminMenu.LogCategory:SetPos( 10, 34 );
	CCP.AdminMenu.LogCategory:SetSize( 100, 20 );
	CCP.AdminMenu.LogCategory:SetValue( "chat" );
	CCP.AdminMenu.LogCategory:AddChoice( "sql" );
	CCP.AdminMenu.LogCategory:AddChoice( "bugs" );
	CCP.AdminMenu.LogCategory:AddChoice( "console" );
	CCP.AdminMenu.LogCategory:AddChoice( "admin" );
	CCP.AdminMenu.LogCategory:AddChoice( "security" );
	CCP.AdminMenu.LogCategory:AddChoice( "chat" );
	CCP.AdminMenu.LogCategory:AddChoice( "sandbox" );
	CCP.AdminMenu.LogCategory:AddChoice( "items" );
	CCP.AdminMenu.LogCategory:AddChoice( "command" );
	CCP.AdminMenu.LogCategory:PerformLayout();
	function CCP.AdminMenu.LogCategory:OnSelect( index, val )
		CCP.AdminMenu.LogList.Category = val
	end
	
	CCP.AdminMenu.LogDate = vgui.Create( "DTextEntry", CCP.AdminMenu.ContentPane );
	CCP.AdminMenu.LogDate:SetFont( "CombineControl.LabelMedium" );
	CCP.AdminMenu.LogDate:SetPos( 10, 60 );
	CCP.AdminMenu.LogDate:SetSize( 100, 20 );
	CCP.AdminMenu.LogDate:SetValue( os.date("!%Y-%m-%d") );
	CCP.AdminMenu.LogDate:PerformLayout();
	function CCP.AdminMenu.LogDate:OnChange()
		CCP.AdminMenu.LogList.Date = self:GetValue()
	end
	
	CCP.AdminMenu.Search = vgui.Create( "DButton", CCP.AdminMenu.ContentPane );
	CCP.AdminMenu.Search:SetFont( "CombineControl.LabelSmall" );
	CCP.AdminMenu.Search:SetText( "Search" );
	CCP.AdminMenu.Search:SetPos( 10, 84 );
	CCP.AdminMenu.Search:SetSize( 100, 30 );
	function CCP.AdminMenu.Search:DoClick()
		CCP.AdminMenu.LogList.Position = 0
		
		netstream.Start("RequestLogSearch", CCP.AdminMenu.LogList.Date, CCP.AdminMenu.LogList.Category, CCP.AdminMenu.LogList.Content, CCP.AdminMenu.LogList.Position)
	end
	CCP.AdminMenu.Search:PerformLayout();
end

function GM:PopulateAdminLogs(tbl)
	if CCP.AdminMenu.LogList and CCP.AdminMenu.LogList:IsValid() and #tbl > 0 then
		CCP.AdminMenu.LogList:Clear()
		
		CCP.AdminMenu.LogList.Position = tbl[1].id
		
		if CCP.AdminMenu.LogList.Position > 0 then
			local line = CCP.AdminMenu.LogList:AddLine("Previous page", "", "")
			line.PreviousPage = true
		end
		
		for _,log in next, tbl do
			CCP.AdminMenu.LogList:AddLine(os.date("!%Y-%m-%d %X", log.Date), log.Category, log.Log)
		end
		
		if #tbl == 50 then
			local line = CCP.AdminMenu.LogList:AddLine("Next page", "", "")
			line.NextPage = true
		end
	end
	
	timer.Simple(0.01, function()
		if CCP.AdminMenu and CCP.AdminMenu.LogList and CCP.AdminMenu.LogList.VBar and CCP.AdminMenu.LogList.VBar:IsValid() then
			CCP.AdminMenu.LogList.VBar:SetScroll(math.huge)
		end
	end)
end

function GM:AdminCreateRostersMenu()
	
	CCP.AdminMenu.Roster = vgui.Create( "DListView", CCP.AdminMenu.ContentPane );
	CCP.AdminMenu.Roster:SetPos( 120, 10 );
	CCP.AdminMenu.Roster:SetSize( 670, 406 );
	CCP.AdminMenu.Roster:AddColumn( "SteamID" );
	CCP.AdminMenu.Roster:AddColumn( "Character" );
	CCP.AdminMenu.Roster:AddColumn( "Money" );
	CCP.AdminMenu.Roster:AddColumn( "Flags" );
	CCP.AdminMenu.Roster:AddColumn( "Date Created" );
	CCP.AdminMenu.Roster:AddColumn( "Last Online" );

	function CCP.AdminMenu.Roster:DoDoubleClick(lineID, line)
		local newPage
		if line.previous then
			CCP.AdminMenu.Roster.CurrentPage = CCP.AdminMenu.Roster.CurrentPage - 1
			newPage = true
		end

		if line.next then
			CCP.AdminMenu.Roster.CurrentPage = CCP.AdminMenu.Roster.CurrentPage + 1
			newPage = true
		end

		if newPage then
			CCP.AdminMenu.Roster:Clear()

			net.Start("zcGetCharacterList")
				net.WriteUInt(CCP.AdminMenu.Roster.CurrentPage, 32)
			net.SendToServer()

			CCP.AdminMenu.RosterChars:SetDisabled( true );
		end
	end
	
	CCP.AdminMenu.RosterChars = vgui.Create( "DButton", CCP.AdminMenu.ContentPane );
	CCP.AdminMenu.RosterChars:SetFont( "CombineControl.LabelSmall" );
	CCP.AdminMenu.RosterChars:SetText( "Characters" );
	CCP.AdminMenu.RosterChars:SetPos( 10, 10 );
	CCP.AdminMenu.RosterChars:SetSize( 100, 30 );
	function CCP.AdminMenu.RosterChars:DoClick()
		
		net.Start("zcGetCharacterList")
			net.WriteUInt(1, 32)
		net.SendToServer()

		CCP.AdminMenu.RosterChars:SetDisabled( true );
		CCP.AdminMenu.Roster:Clear();
		CCP.AdminMenu.Roster.CurrentPage = 1;
		
	end
	CCP.AdminMenu.RosterChars:PerformLayout();
	
end

local function zcGetCharacterList(len)
	if( CCP.AdminMenu.Roster and CCP.AdminMenu.Roster:IsValid() ) then
		
		CCP.AdminMenu.Roster:Clear();

		if CCP.AdminMenu.Roster.CurrentPage > 1 then
			CCP.AdminMenu.Roster:AddLine("Previous page").previous = true
		end

		for i = 1, net.ReadUInt(32) do
			local data = {
				steamID = net.ReadString(),
				name = net.ReadString(),
				flags = net.ReadString(),
				created = net.ReadString(),
				lastOnline = net.ReadString(),
				money = net.ReadUInt(32)
			}

			CCP.AdminMenu.Roster:AddLine(data.steamID, data.name, data.money, data.flags, data.created, data.lastOnline)
		end

		CCP.AdminMenu.Roster:AddLine("Next page").next = true
	end
	
	if( CCP.AdminMenu.RosterChars and CCP.AdminMenu.RosterChars:IsValid() ) then
		
		CCP.AdminMenu.RosterChars:SetDisabled( false );
		
	end
	
	timer.Simple( 0.01, function()
		
		if( CCP.AdminMenu and CCP.AdminMenu.Roster and CCP.AdminMenu.Roster.VBar and CCP.AdminMenu.Roster.VBar:IsValid() ) then
			
			CCP.AdminMenu.Roster.VBar:SetScroll( math.huge );
			
		end
		
	end );
end
net.Receive("zcGetCharacterList", zcGetCharacterList)

function GM:AdminCreateRoleplayMenu()
	
	CCP.AdminMenu.PlayMusicLabel = vgui.Create( "DLabel", CCP.AdminMenu.ContentPane );
	CCP.AdminMenu.PlayMusicLabel:SetText( "Music" );
	CCP.AdminMenu.PlayMusicLabel:SetPos( 10, 10 );
	CCP.AdminMenu.PlayMusicLabel:SetFont( "CombineControl.LabelMedium" );
	CCP.AdminMenu.PlayMusicLabel:SizeToContents();
	CCP.AdminMenu.PlayMusicLabel:PerformLayout();
	
	CCP.AdminMenu.PlayMusic = vgui.Create( "DListView", CCP.AdminMenu.ContentPane );
	CCP.AdminMenu.PlayMusic:SetPos( 150, 10 );
	CCP.AdminMenu.PlayMusic:SetSize( 420, 200 );
	CCP.AdminMenu.PlayMusic:AddColumn( "Song Type" ):SetWidth( 100 );
	CCP.AdminMenu.PlayMusic:AddColumn( "Song Name" ):SetWidth( 220 );
	CCP.AdminMenu.PlayMusic:AddColumn( "Length" ):SetWidth( 100 );
	
	for k, v in pairs( GAMEMODE.Music ) do
		
		local type = "Idle";
		
		if( v[3] == SONG_ALERT ) then type = "Alert" end
		if( v[3] == SONG_ACTION ) then type = "Action" end
		if( v[3] == SONG_STINGER ) then type = "Stinger" end
		
		CCP.AdminMenu.PlayMusic:AddLine( type, v[4], string.ToMinutesSeconds( v[2] ) ).Path = v[1];
		
	end
	
	function CCP.AdminMenu.PlayMusic:OnRowSelected( id, line )
		
		CCP.AdminMenu.PlayMusicBut:SetDisabled( false );
		CCP.AdminMenu.PreviewBut:SetDisabled( false );
		CCP.AdminMenu.TargetBut:SetDisabled( false );
		
	end
	
	CCP.AdminMenu.PlayMusicBut = vgui.Create( "DButton", CCP.AdminMenu.ContentPane );
	CCP.AdminMenu.PlayMusicBut:SetFont( "CombineControl.LabelSmall" );
	CCP.AdminMenu.PlayMusicBut:SetText( "Play" );
	CCP.AdminMenu.PlayMusicBut:SetPos( 580, 10 );
	CCP.AdminMenu.PlayMusicBut:SetSize( 100, 20 );
	function CCP.AdminMenu.PlayMusicBut:DoClick()
		
		RunConsoleCommand( "rpa_musicplay", CCP.AdminMenu.PlayMusic:GetSelected()[1].Path );
		
	end
	CCP.AdminMenu.PlayMusicBut:SetDisabled( true );
	CCP.AdminMenu.PlayMusicBut:PerformLayout();
	
	CCP.AdminMenu.StopMusicBut = vgui.Create( "DButton", CCP.AdminMenu.ContentPane );
	CCP.AdminMenu.StopMusicBut:SetFont( "CombineControl.LabelSmall" );
	CCP.AdminMenu.StopMusicBut:SetText( "Stop All Music" );
	CCP.AdminMenu.StopMusicBut:SetPos( 580, 40 );
	CCP.AdminMenu.StopMusicBut:SetSize( 100, 20 );
	function CCP.AdminMenu.StopMusicBut:DoClick()
		
		RunConsoleCommand( "rpa_musicstop" );
		
	end
	CCP.AdminMenu.StopMusicBut:PerformLayout();
	
	CCP.AdminMenu.StopMusicBut = vgui.Create( "DButton", CCP.AdminMenu.ContentPane );
	CCP.AdminMenu.StopMusicBut:SetFont( "CombineControl.LabelSmall" );
	CCP.AdminMenu.StopMusicBut:SetText( "Stop Your Music" );
	CCP.AdminMenu.StopMusicBut:SetPos( 580, 70 );
	CCP.AdminMenu.StopMusicBut:SetSize( 100, 20 );
	function CCP.AdminMenu.StopMusicBut:DoClick()
		
		GAMEMODE:FadeOutMusic();
		
	end
	CCP.AdminMenu.StopMusicBut:PerformLayout();
	
	CCP.AdminMenu.PreviewBut = vgui.Create( "DButton", CCP.AdminMenu.ContentPane );
	CCP.AdminMenu.PreviewBut:SetFont( "CombineControl.LabelSmall" );
	CCP.AdminMenu.PreviewBut:SetText( "Preview" );
	CCP.AdminMenu.PreviewBut:SetPos( 580, 100 );
	CCP.AdminMenu.PreviewBut:SetSize( 100, 20 );
	function CCP.AdminMenu.PreviewBut:DoClick()
		
		GAMEMODE:PlayMusic( CCP.AdminMenu.PlayMusic:GetSelected()[1].Path );
		
	end
	CCP.AdminMenu.PreviewBut:SetDisabled( true );
	CCP.AdminMenu.PreviewBut:PerformLayout();
	
	CCP.AdminMenu.TargetBut = vgui.Create( "DButton", CCP.AdminMenu.ContentPane );
	CCP.AdminMenu.TargetBut:SetFont( "CombineControl.LabelSmall" );
	CCP.AdminMenu.TargetBut:SetText( "Targets..." );
	CCP.AdminMenu.TargetBut:SetPos( 580, 130 );
	CCP.AdminMenu.TargetBut:SetSize( 100, 20 );
	function CCP.AdminMenu.TargetBut:DoClick()
		
		CCP.MusicTargets = vgui.Create( "DFrame" );
		CCP.MusicTargets:SetSize( 400, 534 );
		CCP.MusicTargets:Center();
		CCP.MusicTargets:SetTitle( "Targeted Music" );
		CCP.MusicTargets.lblTitle:SetFont( "CombineControl.Window" );
		CCP.MusicTargets:MakePopup();
		CCP.MusicTargets.PerformLayout = CCFramePerformLayout;
		CCP.MusicTargets:PerformLayout();
		
		CCP.MusicTargets.AllPlayers = vgui.Create( "DListView", CCP.MusicTargets );
		CCP.MusicTargets.AllPlayers:SetPos( 10, 34 );
		CCP.MusicTargets.AllPlayers:SetSize( 185, 430 );
		CCP.MusicTargets.AllPlayers:AddColumn( "Players" );
		
		for k, v in pairs( player.GetAll() ) do
			
			CCP.MusicTargets.AllPlayers:AddLine( v:VisibleRPName() ).Player = v;
			
		end
		
		CCP.MusicTargets.Targets = vgui.Create( "DListView", CCP.MusicTargets );
		CCP.MusicTargets.Targets:SetPos( 205, 34 );
		CCP.MusicTargets.Targets:SetSize( 185, 430 );
		CCP.MusicTargets.Targets:AddColumn( "Targets" );
		
		CCP.MusicTargets.MakeTarget = vgui.Create( "DButton", CCP.MusicTargets );
		CCP.MusicTargets.MakeTarget:SetFont( "CombineControl.LabelSmall" );
		CCP.MusicTargets.MakeTarget:SetText( ">" );
		CCP.MusicTargets.MakeTarget:SetPos( 10, 474 );
		CCP.MusicTargets.MakeTarget:SetSize( 185, 20 );
		function CCP.MusicTargets.MakeTarget:DoClick()
			
			if( !CCP.MusicTargets.AllPlayers:GetSelected()[1] ) then return end
			
			local ply = CCP.MusicTargets.AllPlayers:GetSelected()[1].Player;
			CCP.MusicTargets.AllPlayers:RemoveLine( CCP.MusicTargets.AllPlayers:GetSelected()[1]:GetID() );
			CCP.MusicTargets.Targets:AddLine( ply:VisibleRPName() ).Player = ply;
			
		end
		CCP.MusicTargets.MakeTarget:PerformLayout();
		
		CCP.MusicTargets.MakePlayer = vgui.Create( "DButton", CCP.MusicTargets );
		CCP.MusicTargets.MakePlayer:SetFont( "CombineControl.LabelSmall" );
		CCP.MusicTargets.MakePlayer:SetText( "<" );
		CCP.MusicTargets.MakePlayer:SetPos( 205, 474 );
		CCP.MusicTargets.MakePlayer:SetSize( 185, 20 );
		function CCP.MusicTargets.MakePlayer:DoClick()
			
			if( !CCP.MusicTargets.Targets:GetSelected()[1] ) then return end
			
			local ply = CCP.MusicTargets.Targets:GetSelected()[1].Player;
			CCP.MusicTargets.Targets:RemoveLine( CCP.MusicTargets.Targets:GetSelected()[1]:GetID() );
			CCP.MusicTargets.AllPlayers:AddLine( ply:VisibleRPName() ).Player = ply;
			
		end
		CCP.MusicTargets.MakePlayer:PerformLayout();
		
		CCP.MusicTargets.PlayBut = vgui.Create( "DButton", CCP.MusicTargets );
		CCP.MusicTargets.PlayBut:SetFont( "CombineControl.LabelSmall" );
		CCP.MusicTargets.PlayBut:SetText( "Play Music" );
		CCP.MusicTargets.PlayBut:SetPos( 10, 504 );
		CCP.MusicTargets.PlayBut:SetSize( 100, 20 );
		function CCP.MusicTargets.PlayBut:DoClick()
			
			if( CCP.AdminMenu and CCP.AdminMenu:IsValid() ) then
				
				local tab = { };
				
				for k, v in pairs( CCP.MusicTargets.Targets:GetLines() ) do
					
					table.insert( tab, v.Player:SteamID() );
					
				end
				
				RunConsoleCommand( "rpa_musicplaytarget", CCP.AdminMenu.PlayMusic:GetSelected()[1].Path, unpack( tab ) );
				
			end
			
		end
		CCP.MusicTargets.PlayBut:PerformLayout();
		
		CCP.MusicTargets.VisibleBut = vgui.Create( "DButton", CCP.MusicTargets );
		CCP.MusicTargets.VisibleBut:SetFont( "CombineControl.LabelSmall" );
		CCP.MusicTargets.VisibleBut:SetText( "Select Visible" );
		CCP.MusicTargets.VisibleBut:SetPos( 120, 504 );
		CCP.MusicTargets.VisibleBut:SetSize( 100, 20 );
		function CCP.MusicTargets.VisibleBut:DoClick()
			
			CCP.MusicTargets.AllPlayers:Clear();
			CCP.MusicTargets.Targets:Clear();
			
			for _, v in pairs( player.GetAll() ) do
				
				if( LocalPlayer():CanSee( v ) ) then
					
					CCP.MusicTargets.Targets:AddLine( v:VisibleRPName() ).Player = v;
					
				else
					
					CCP.MusicTargets.AllPlayers:AddLine( v:VisibleRPName() ).Player = v;
					
				end
				
			end
			
		end
		CCP.MusicTargets.VisibleBut:PerformLayout();
		
		CCP.MusicTargets.RadialBut = vgui.Create( "DButton", CCP.MusicTargets );
		CCP.MusicTargets.RadialBut:SetFont( "CombineControl.LabelSmall" );
		CCP.MusicTargets.RadialBut:SetText( "Select Radius..." );
		CCP.MusicTargets.RadialBut:SetPos( 230, 504 );
		CCP.MusicTargets.RadialBut:SetSize( 100, 20 );
		function CCP.MusicTargets.RadialBut:DoClick()
			
			CCP.MusicTargets.RadialWin = vgui.Create( "DFrame" );
			CCP.MusicTargets.RadialWin:SetSize( 250, 114 );
			CCP.MusicTargets.RadialWin:Center();
			CCP.MusicTargets.RadialWin:SetTitle( "Select Radius" );
			CCP.MusicTargets.RadialWin.lblTitle:SetFont( "CombineControl.Window" );
			CCP.MusicTargets.RadialWin:MakePopup();
			CCP.MusicTargets.RadialWin.PerformLayout = CCFramePerformLayout;
			CCP.MusicTargets.RadialWin:PerformLayout();
			
			CCP.MusicTargets.RadialWin.Entry = vgui.Create( "DTextEntry", CCP.MusicTargets.RadialWin );
			CCP.MusicTargets.RadialWin.Entry:SetFont( "CombineControl.LabelBig" );
			CCP.MusicTargets.RadialWin.Entry:SetPos( 10, 34 );
			CCP.MusicTargets.RadialWin.Entry:SetSize( 100, 30 );
			CCP.MusicTargets.RadialWin.Entry:PerformLayout();
			CCP.MusicTargets.RadialWin.Entry:RequestFocus();
			CCP.MusicTargets.RadialWin.Entry:SetNumeric( true );
			CCP.MusicTargets.RadialWin.Entry:SetCaretPos( string.len( CCP.MusicTargets.RadialWin.Entry:GetValue() ) );
			
			CCP.MusicTargets.RadialWin.Label = vgui.Create( "DLabel", CCP.MusicTargets.RadialWin );
			CCP.MusicTargets.RadialWin.Label:SetText( "meters" );
			CCP.MusicTargets.RadialWin.Label:SetPos( 120, 34 );
			CCP.MusicTargets.RadialWin.Label:SetSize( 130, 30 );
			CCP.MusicTargets.RadialWin.Label:SetFont( "CombineControl.LabelBig" );
			CCP.MusicTargets.RadialWin.Label:PerformLayout();
			
			CCP.MusicTargets.RadialWin.OK = vgui.Create( "DButton", CCP.MusicTargets.RadialWin );
			CCP.MusicTargets.RadialWin.OK:SetFont( "CombineControl.LabelSmall" );
			CCP.MusicTargets.RadialWin.OK:SetText( "OK" );
			CCP.MusicTargets.RadialWin.OK:SetPos( 190, 74 );
			CCP.MusicTargets.RadialWin.OK:SetSize( 50, 30 );
			function CCP.MusicTargets.RadialWin.OK:DoClick()
				
				local val = tonumber( CCP.MusicTargets.RadialWin.Entry:GetValue() );
				
				if( val < 1 ) then
					
					CCP.MusicTargets.RadialWin:Remove();
					return;
					
				end
				
				CCP.MusicTargets.AllPlayers:Clear();
				CCP.MusicTargets.Targets:Clear();
				
				for _, v in pairs( player.GetAll() ) do
					
					if( math.ceil( LocalPlayer():EyePos():Distance( v:EyePos() ) * 0.01905 ) <= val ) then
						
						CCP.MusicTargets.Targets:AddLine( v:VisibleRPName() ).Player = v;
						
					else
						
						CCP.MusicTargets.AllPlayers:AddLine( v:VisibleRPName() ).Player = v;
						
					end
					
				end
				
				CCP.MusicTargets.RadialWin:Remove();
				
			end
			CCP.MusicTargets.RadialWin.OK:PerformLayout();
			
			CCP.MusicTargets.RadialWin.Entry.OnEnter = CCP.MusicTargets.RadialWin.OK.DoClick;
			
		end
		CCP.MusicTargets.RadialBut:PerformLayout();
		
	end
	CCP.AdminMenu.TargetBut:SetDisabled( true );
	CCP.AdminMenu.TargetBut:PerformLayout();
	
	CCP.AdminMenu.PlayMusicIdle = vgui.Create( "DButton", CCP.AdminMenu.ContentPane );
	CCP.AdminMenu.PlayMusicIdle:SetFont( "CombineControl.LabelSmall" );
	CCP.AdminMenu.PlayMusicIdle:SetText( "Random Idle" );
	CCP.AdminMenu.PlayMusicIdle:SetPos( 690, 10 );
	CCP.AdminMenu.PlayMusicIdle:SetSize( 100, 20 );
	function CCP.AdminMenu.PlayMusicIdle:DoClick()
		
		RunConsoleCommand( "rpa_musicplay", SONG_IDLE );
		
	end
	CCP.AdminMenu.PlayMusicIdle:PerformLayout();
	
	CCP.AdminMenu.PlayMusicAlert = vgui.Create( "DButton", CCP.AdminMenu.ContentPane );
	CCP.AdminMenu.PlayMusicAlert:SetFont( "CombineControl.LabelSmall" );
	CCP.AdminMenu.PlayMusicAlert:SetText( "Random Alert" );
	CCP.AdminMenu.PlayMusicAlert:SetPos( 690, 40 );
	CCP.AdminMenu.PlayMusicAlert:SetSize( 100, 20 );
	function CCP.AdminMenu.PlayMusicAlert:DoClick()
		
		RunConsoleCommand( "rpa_musicplay", SONG_ALERT );
		
	end
	CCP.AdminMenu.PlayMusicAlert:PerformLayout();
	
	CCP.AdminMenu.PlayMusicAction = vgui.Create( "DButton", CCP.AdminMenu.ContentPane );
	CCP.AdminMenu.PlayMusicAction:SetFont( "CombineControl.LabelSmall" );
	CCP.AdminMenu.PlayMusicAction:SetText( "Random Action" );
	CCP.AdminMenu.PlayMusicAction:SetPos( 690, 70 );
	CCP.AdminMenu.PlayMusicAction:SetSize( 100, 20 );
	function CCP.AdminMenu.PlayMusicAction:DoClick()
		
		RunConsoleCommand( "rpa_musicplay", SONG_ACTION );
		
	end
	CCP.AdminMenu.PlayMusicAction:PerformLayout();
	
	CCP.AdminMenu.PlayMusicStinger = vgui.Create( "DButton", CCP.AdminMenu.ContentPane );
	CCP.AdminMenu.PlayMusicStinger:SetFont( "CombineControl.LabelSmall" );
	CCP.AdminMenu.PlayMusicStinger:SetText( "Random Stinger" );
	CCP.AdminMenu.PlayMusicStinger:SetPos( 690, 100 );
	CCP.AdminMenu.PlayMusicStinger:SetSize( 100, 20 );
	function CCP.AdminMenu.PlayMusicStinger:DoClick()
		
		RunConsoleCommand( "rpa_musicplay", SONG_STINGER );
		
	end
	CCP.AdminMenu.PlayMusicStinger:PerformLayout();
	
	CCP.AdminMenu.SpawnItemLabel = vgui.Create( "DLabel", CCP.AdminMenu.ContentPane );
	CCP.AdminMenu.SpawnItemLabel:SetText( "Spawn Item" );
	CCP.AdminMenu.SpawnItemLabel:SetPos( 10, 250 );
	CCP.AdminMenu.SpawnItemLabel:SetFont( "CombineControl.LabelMedium" );
	CCP.AdminMenu.SpawnItemLabel:SizeToContents();
	CCP.AdminMenu.SpawnItemLabel:PerformLayout();
	
	CCP.AdminMenu.SpawnItem = vgui.Create( "DTextEntry", CCP.AdminMenu.ContentPane );
	CCP.AdminMenu.SpawnItem:SetFont( "CombineControl.LabelMedium" );
	CCP.AdminMenu.SpawnItem:SetPos( 150, 250 );
	CCP.AdminMenu.SpawnItem:SetSize( 140, 20 );
	CCP.AdminMenu.SpawnItem:PerformLayout();
	
	CCP.AdminMenu.SpawnItemBut = vgui.Create( "DButton", CCP.AdminMenu.ContentPane );
	CCP.AdminMenu.SpawnItemBut:SetFont( "CombineControl.LabelSmall" );
	CCP.AdminMenu.SpawnItemBut:SetText( "Spawn" );
	CCP.AdminMenu.SpawnItemBut:SetPos( 300, 250 );
	CCP.AdminMenu.SpawnItemBut:SetSize( 100, 20 );
	function CCP.AdminMenu.SpawnItemBut:DoClick()
		
		if( CCP.AdminMenu.SpawnItem:GetValue() != "" ) then
			
			RunConsoleCommand( "rpa_itemcreate", CCP.AdminMenu.SpawnItem:GetValue() );
			
		end
		
	end
	CCP.AdminMenu.SpawnItemBut:PerformLayout();
	
	CCP.AdminMenu.ListItemsBut = vgui.Create( "DButton", CCP.AdminMenu.ContentPane );
	CCP.AdminMenu.ListItemsBut:SetFont( "CombineControl.LabelSmall" );
	CCP.AdminMenu.ListItemsBut:SetText( "Item List..." );
	CCP.AdminMenu.ListItemsBut:SetPos( 410, 250 );
	CCP.AdminMenu.ListItemsBut:SetSize( 100, 20 );
	function CCP.AdminMenu.ListItemsBut:DoClick()
		
		CCP.ItemsList = vgui.Create( "DFrame" );
		CCP.ItemsList:SetSize( 590, 450 );
		CCP.ItemsList:Center();
		CCP.ItemsList:SetTitle( "Item List" );
		CCP.ItemsList.lblTitle:SetFont( "CombineControl.Window" );
		CCP.ItemsList:MakePopup();
		CCP.ItemsList.PerformLayout = CCFramePerformLayout;
		CCP.ItemsList:PerformLayout();
		
		CCP.ItemsList.Pane = vgui.Create( "DScrollPanel", CCP.ItemsList );
		CCP.ItemsList.Pane:SetSize( 570, 406 );
		CCP.ItemsList.Pane:SetPos( 10, 34 );
		function CCP.ItemsList.Pane:Paint( w, h )
			
			surface.SetDrawColor( 30, 30, 30, 255 );
			surface.DrawRect( 0, 0, w, h );
			
			surface.SetDrawColor( 20, 20, 20, 100 );
			surface.DrawOutlinedRect( 0, 0, w, h );
			
		end
		
		local y = 0;
		
		for k, v in SortedPairs( GAMEMODE.Items ) do
			
			if( !v.EasterEgg ) then
				
				local itempane = vgui.Create( "DPanel", CCP.ItemsList.Pane );
				itempane:SetPos( 0, y );
				itempane:SetSize( 556, 64 );
				function itempane:Paint( w, h )
					
					surface.SetDrawColor( 0, 0, 0, 70 );
					surface.DrawRect( 0, 0, w, h );
					
					surface.SetDrawColor( 0, 0, 0, 100 );
					surface.DrawOutlinedRect( 0, 0, w, h );
					
				end
				
				local icon = vgui.Create( "DModelPanel", itempane );
				icon:SetPos( 0, 0 );
				icon:SetModel( v.Model );
				icon:SetSize( 64, 64 );
				
				if( v.LookAt ) then
					
					icon:SetFOV( v.FOV );
					icon:SetCamPos( v.CamPos );
					icon:SetLookAt( v.LookAt );
					
				else
					
					local a, b = icon.Entity:GetModelBounds();
					
					icon:SetFOV( 20 );
					icon:SetCamPos( Vector( math.abs( a.x ), math.abs( a.y ), math.abs( a.z ) ) * 5 );
					icon:SetLookAt( ( a + b ) / 2 );
					
				end
				
				if( v.IconMaterial ) then icon.Entity:SetMaterial( v.IconMaterial ) end
				if( v.IconColor ) then icon.Entity:SetColor( v.IconColor ) end
				
				function icon:LayoutEntity() end
				
				local p = icon.Paint;
				
				function icon:Paint( w, h )
					
					local pnl = CCP.ItemsList.Pane;
					if !pnl then return end
					local x2, y2 = pnl:LocalToScreen( 0, 0 );
					local w2, h2 = pnl:GetSize();
					render.SetScissorRect( x2, y2, x2 + w2, y2 + h2, true );
					
					p( self, w, h );
					
					render.SetScissorRect( 0, 0, 0, 0, false );
					
				end
				
				local name = vgui.Create( "DLabel", itempane );
				name:SetText( v.Name );
				name:SetPos( 74, 10 );
				name:SetFont( "CombineControl.LabelSmall" );
				name:SizeToContents();
				name:PerformLayout();
				
				surface.SetFont( "CombineControl.LabelSmall" );
				local a, b = surface.GetTextSize( v.Name );
				
				local id = vgui.Create( "DLabel", itempane );
				id:SetText( "ID: " .. k );
				id:SetPos( 74 + a + 10, 10 );
				id:SetFont( "CombineControl.LabelTiny" );
				id:SetTextColor( Color( 200, 200, 100, 255 ) );
				id:SizeToContents();
				id:PerformLayout();
				
				local d, n = GAMEMODE:FormatLine( v.Desc, "CombineControl.LabelTiny", 472 );
				
				local desc = vgui.Create( "DLabel", itempane );
				desc:SetText( d );
				desc:SetPos( 74, 24 );
				desc:SetFont( "CombineControl.LabelTiny" );
				desc:SizeToContents();
				desc:PerformLayout();
				
				y = y + 64;
				
			end
			
		end
		
	end
	CCP.AdminMenu.ListItemsBut:PerformLayout();
	
end

function GM:CreateItemRequestMenu()
	self.AdminItemRequests = vgui.Create("DFrame")
	self.AdminItemRequests:SetSize(ScrW() / 3, ScrH() / 1.5)
	self.AdminItemRequests:SetTitle("Item Requests")
	self.AdminItemRequests:Center()
	self.AdminItemRequests:MakePopup()
	
	local pnl = self.AdminItemRequests
	
	pnl.Requests = vgui.Create("DListView", pnl)
	pnl.Requests:SetSize(pnl:GetWide(), pnl:GetTall() / 2 - 24)
	pnl.Requests:SetPos(0,24)
	pnl.Requests:AddColumn("Requester")
	pnl.Requests:AddColumn("Item Class")
	pnl.Requests.SortByColumn = function() end
	pnl.Requests.OnRowSelected = function(panel, id, line)
		pnl.ItemInfo:Clear()
		
		local data = line.data
		if data then
			for k,v in next, data do 
				pnl.ItemInfo:AddLine(k, tostring(v))
			end
		end
	end
	pnl.Requests.OnRowRightClick = function(panel, id, line)
		local menu = DermaMenu(panel)
		menu:AddOption("Approve", function()
			RunConsoleCommand("rpa_itemrequestapprove", line.id)
			pnl.Requests:RemoveLine(id)
			pnl.ItemInfo:Clear()
		end)
		menu:AddOption("Deny", function()
			RunConsoleCommand("rpa_itemrequestdeny", line.id)
			pnl.Requests:RemoveLine(id)
			pnl.ItemInfo:Clear()
		end)
		menu:Open()
	end
	
	pnl.ItemInfo = vgui.Create("DListView", pnl)
	pnl.ItemInfo:SetSize(pnl:GetWide(), pnl:GetTall() / 2 - 8)
	pnl.ItemInfo:SetPos(0, pnl:GetTall() / 2 + 4)
	pnl.ItemInfo:AddColumn("Key")
	pnl.ItemInfo:AddColumn("Value")
	
	netstream.Start("AdminRequestedItems")
end

function GM:AdminPopulateItemRequests(data)
	for k,v in next, data do
		local line = self.AdminItemRequests.Requests:AddLine(v.requester:Nick(), v.class)
		line.data = v.vars
		line.id = k
	end
end