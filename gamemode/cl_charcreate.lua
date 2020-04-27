function nCharacterList( tbl )
	
	GAMEMODE.Characters = tbl;
	
end
netstream.Hook( "nCharacterList", nCharacterList );

function GM:CharCreateThink()
	
	if( self.QueueCharCreate ) then
		
		if( !self.IntroCamStart or !self:InIntroCam() ) then
			
			if( !CCP.Quiz or !CCP.Quiz:IsValid() ) then
				
				self.QueueCharCreate = false;
				cookie.Set( "zc_doneintro", 2 );
				
				self:CreateCharEditor();
				
			end
			
		end
		
	end
	
end

function nOpenCharCreate( int )
	
	GAMEMODE.CCMode = int;
	GAMEMODE.QueueCharCreate = true;
	
end
netstream.Hook( "nOpenCharCreate", nOpenCharCreate );

GM.CCModel = GM.CCModel or "";

function GM:CreateCharEditor()
	
	self.CharCreate = true;
	self.CharCreateOpened = true;
	
 	if( self.CCMode == CC_CREATE ) then
		
		self:CreateCharCreate();
		
	elseif( self.CCMode == CC_CREATESELECT ) then
		
		self:CreateCharCreate();
		--self:CreateCharSelect();
		
	elseif( self.CCMode == CC_CREATESELECT_C ) then
		
		self:CreateCharCreate();
		--self:CreateCharSelect();
		--self:CreateCharDeleteCancel();
		
	elseif( self.CCMode == CC_SELECT ) then
		
		self:CreateCharCreate();
		--self:CreateCharSelect( true );
		
	elseif( self.CCMode == CC_SELECT_C ) then
		
		self:CreateCharCreate();
		--self:CreateCharSelect( true );
		--self:CreateCharDeleteCancel();
		
	end
	
end

GM.CharCreateSelectedModel = GM.CharCreateSelectedModel or "";

local matHover = Material( "gui/contenticon-hovered.png" );

local allowedChars = [[abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890 -|+=.,\/;:]];

function GM:CreateCharCreate()

	CCP.CharCreatePanel = vgui.Create( "DFrame" );
	CCP.CharCreatePanel:SetSize( 800, 500 );
	CCP.CharCreatePanel:Center();
	CCP.CharCreatePanel:SetTitle( "" );
	CCP.CharCreatePanel:SetSkin( "STALKER" );
	CCP.CharCreatePanel:ShowCloseButton( false );
	CCP.CharCreatePanel:SetDraggable( false );
	CCP.CharCreatePanel.lblTitle:SetFont( "CombineControl.Window" );
	CCP.CharCreatePanel:MakePopup();
	function CCP.CharCreatePanel:Paint( w, h )

		DisableClipping( true );
		surface.SetDrawColor( 255, 255, 255, 255 );
		surface.SetMaterial( matFrame );
		surface.DrawTexturedRectUV( 0, -10, w + 10, h + 10, 0.3, 0.42, 0.9, 0.82 );
		DisableClipping( false );
	
	end
	function CCP.CharCreatePanel:Think()
	
		if( input.IsKeyDown( KEY_F2 ) and !self.LastKeyState and self.HasOpened and LocalPlayer():CharID() > 0 ) then
		
			GAMEMODE:CloseCharCreate();
		
		end
		
		self.LastKeyState = input.IsKeyDown( KEY_F2 );
		if( !self.HasOpened ) then
		
			self.HasOpened = true;
			
		end
		
	end
	
	CCP.CharCreatePanel.TopBar = vgui.Create( "DPanel", CCP.CharCreatePanel );
	CCP.CharCreatePanel.TopBar:SetPos( 0, 32 );
	CCP.CharCreatePanel.TopBar:SetSize( 800, 50 );
	function CCP.CharCreatePanel.TopBar:Paint( w, h )
		
	end
	
	CCP.CharCreatePanel.TopBar.Buttons = { };
	
	CCP.CharCreatePanel.TopBar.Buttons[1] = vgui.Create( "DButton", CCP.CharCreatePanel.TopBar );
	CCP.CharCreatePanel.TopBar.Buttons[1]:SetFont( "STALKER.LabelMenu" );
	CCP.CharCreatePanel.TopBar.Buttons[1]:SetText( "Creation" );
	CCP.CharCreatePanel.TopBar.Buttons[1]:SetPos( 14, 10 );
	CCP.CharCreatePanel.TopBar.Buttons[1]:SetSize( 188, 35 );
	CCP.CharCreatePanel.TopBar.Buttons[1].m_bTitleButton = true;
	CCP.CharCreatePanel.TopBar.Buttons[1].m_bIsDown = true;
	CCP.CharCreatePanel.TopBar.Buttons[1].DoClick = function( self )
	
		if( self.m_bIsDown ) then return end
	
		for k,v in next, CCP.CharCreatePanel.TopBar.Buttons do
		
			v.m_bIsDown = false;
			
		end
		self.m_bIsDown = true;
		CCP.CharCreatePanel.ContentPane:Clear();
		GAMEMODE:CharCreatePage1();
		
	end
	CCP.CharCreatePanel.TopBar.Buttons[1]:PerformLayout();
	
	CCP.CharCreatePanel.TopBar.Buttons[2] = vgui.Create( "DButton", CCP.CharCreatePanel.TopBar );
	CCP.CharCreatePanel.TopBar.Buttons[2]:SetFont( "STALKER.LabelMenu" );
	CCP.CharCreatePanel.TopBar.Buttons[2]:SetText( "Selection" );
	CCP.CharCreatePanel.TopBar.Buttons[2]:SetPos( 206, 10 );
	CCP.CharCreatePanel.TopBar.Buttons[2]:SetSize( 188, 35 );
	CCP.CharCreatePanel.TopBar.Buttons[2].m_bTitleButton = true;
	CCP.CharCreatePanel.TopBar.Buttons[2].DoClick = function( self )
	
		if( self.m_bIsDown ) then return end
		if( !CCP.CharCreatePanel ) then return end
		
		for k,v in next, CCP.CharCreatePanel.TopBar.Buttons do
		
			v.m_bIsDown = false;
			
		end
		self.m_bIsDown = true;
		CCP.CharCreatePanel.ContentPane:Clear();
		GAMEMODE:CreateCharSelect();
		
	end
	CCP.CharCreatePanel.TopBar.Buttons[2]:PerformLayout();
	
	if( self.CCMode == CC_CREATE ) then
	
		CCP.CharCreatePanel.TopBar.Buttons[2]:SetDisabled( true );
		
	end
	
	CCP.CharCreatePanel.TopBar.Buttons[3] = vgui.Create( "DButton", CCP.CharCreatePanel.TopBar );
	CCP.CharCreatePanel.TopBar.Buttons[3]:SetFont( "STALKER.LabelMenu" );
	CCP.CharCreatePanel.TopBar.Buttons[3]:SetText( "Deletion" );
	CCP.CharCreatePanel.TopBar.Buttons[3]:SetPos( 398, 10 );
	CCP.CharCreatePanel.TopBar.Buttons[3]:SetSize( 188, 35 );
	CCP.CharCreatePanel.TopBar.Buttons[3].m_bTitleButton = true;
	CCP.CharCreatePanel.TopBar.Buttons[3].DoClick = function( self )
	
		if( self.m_bIsDown ) then return end
		
		for k,v in next, CCP.CharCreatePanel.TopBar.Buttons do
		
			v.m_bIsDown = false;
			
		end
		self.m_bIsDown = true;
		CCP.CharCreatePanel.ContentPane:Clear();
		GAMEMODE:CharCreateDelete();
		
	end
	CCP.CharCreatePanel.TopBar.Buttons[3]:PerformLayout();
	
	if( self.CCMode == CC_CREATE ) then
	
		CCP.CharCreatePanel.TopBar.Buttons[3]:SetDisabled( true );
		
	end
	
	local DoClick = function() end;
	
	CCP.CharCreatePanel.TopBar.Buttons[4] = vgui.Create( "DButton", CCP.CharCreatePanel.TopBar );
	CCP.CharCreatePanel.TopBar.Buttons[4]:SetFont( "STALKER.LabelMenu" );
	CCP.CharCreatePanel.TopBar.Buttons[4]:SetPos( 590, 10 );
	CCP.CharCreatePanel.TopBar.Buttons[4]:SetSize( 188, 35 );
	CCP.CharCreatePanel.TopBar.Buttons[4].m_bTitleButton = true;
	if( LocalPlayer():CharID() > 0 ) then
	
		CCP.CharCreatePanel.TopBar.Buttons[4]:SetText( "Return" );
		DoClick = function( self )
		
			GAMEMODE:CloseCharCreate();
		
		end
		
	else
	
		CCP.CharCreatePanel.TopBar.Buttons[4]:SetText( "Disconnect" );
		DoClick = function( self )
		
			Derma_Query( "Are you sure you want to disconnect from 100 Rads?", "Disconnect", "Yes", function( self )
			
				RunConsoleCommand( "disconnect" );
			
			end, "No" );
		
		end
		
	end
	CCP.CharCreatePanel.TopBar.Buttons[4].DoClick = function( self )
	
		DoClick( self );
		
	end
	CCP.CharCreatePanel.TopBar.Buttons[4]:PerformLayout();
	
	CCP.CharCreatePanel.ContentPane = vgui.Create( "DPanel", CCP.CharCreatePanel );
	CCP.CharCreatePanel.ContentPane:SetPos( 12, 90 );
	CCP.CharCreatePanel.ContentPane:SetSize( 764, 410 );
	function CCP.CharCreatePanel.ContentPane:Paint( w, h )
	
		// for debug
		--surface.SetDrawColor( 255, 255, 255, 255 );
		--surface.DrawOutlinedRect( 0, 0, w, h );
		
	end
	
	if( self.CCMode != CC_SELECT or self.CCMode != CC_SELECT_C ) then
	
		CCP.CharCreatePanel.m_nPage = 1;
		self:CharCreatePage1();
		
	else
	
		GAMEMODE:CreateCharSelect();
		
	end
	
	-- 33
	
	CCP.CharCreatePanel.BadChar = vgui.Create( "DLabel", CCP.CharCreatePanel );
	CCP.CharCreatePanel.BadChar:SetText( "" );
	CCP.CharCreatePanel.BadChar:SetPos( 16, 474 );
	CCP.CharCreatePanel.BadChar:SetFont( "CombineControl.LabelSmall" );
	CCP.CharCreatePanel.BadChar:SetSize( 720, 14 );
	CCP.CharCreatePanel.BadChar:PerformLayout();
	
end

function GM:CharCreateNextPage()

	if( !CCP.CharCreatePanel ) then return end

	if( self["CharCreatePage"..CCP.CharCreatePanel.m_nPage + 1] ) then

		CCP.CharCreatePanel.ContentPane:Clear();
		CCP.CharCreatePanel.m_nPage = CCP.CharCreatePanel.m_nPage + 1;
		self["CharCreatePage"..CCP.CharCreatePanel.m_nPage]( self );
		
	else
	
		CCP.CharCreatePanel.ContentPane:Clear();
		CCP.CharCreatePanel.m_nPage = 1;
		self["CharCreatePage"..CCP.CharCreatePanel.m_nPage]( self );
		
	end

end

function GM:CharCreatePrevPage()

	if( !CCP.CharCreatePanel ) then return end

	if( self["CharCreatePage"..CCP.CharCreatePanel.m_nPage - 1] ) then

		CCP.CharCreatePanel.ContentPane:Clear();
		CCP.CharCreatePanel.m_nPage = CCP.CharCreatePanel.m_nPage - 1;
		self["CharCreatePage"..CCP.CharCreatePanel.m_nPage]( self );
		
	else
	
		CCP.CharCreatePanel.ContentPane:Clear();
		CCP.CharCreatePanel.m_nPage = 1;
		self["CharCreatePage"..CCP.CharCreatePanel.m_nPage]( self );
		
	end

end

function GM:CharCreatePage1()

	CCP.CharCreatePanel.ModelLabel = vgui.Create( "DLabel", CCP.CharCreatePanel.ContentPane );
	CCP.CharCreatePanel.ModelLabel:SetText( "Model" );
	CCP.CharCreatePanel.ModelLabel:SetPos( 350, 4 );
	CCP.CharCreatePanel.ModelLabel:SetFont( "CombineControl.LabelGiant" );
	CCP.CharCreatePanel.ModelLabel:SizeToContents();
	CCP.CharCreatePanel.ModelLabel:PerformLayout();
	
	CCP.CharCreatePanel.ModelDisplay = vgui.Create( "CCharPanel", CCP.CharCreatePanel.ContentPane );
	CCP.CharCreatePanel.ModelDisplay:SetPos( 4, 4 );
	if( GAMEMODE.CharCreateSelectedModel == "" ) then
	
		GAMEMODE.CharCreateSelectedModel = self.CitizenModels[1];
		
	end
	CCP.CharCreatePanel.ModelDisplay:SetModel( GAMEMODE.CharCreateSelectedModel );
	CCP.CharCreatePanel.ModelDisplay.Entity:SetSkin( GAMEMODE.CharCreateSelectedSkin or 0 );
	CCP.CharCreatePanel.ModelDisplay:SetSize( 324, 370 );
	CCP.CharCreatePanel.ModelDisplay:SetFOV( 32 );
	CCP.CharCreatePanel.ModelDisplay:SetCamPos( Vector( 50, 0, 56 ) );
	CCP.CharCreatePanel.ModelDisplay:SetLookAt( Vector( 0, 0, 56 ) );
	function CCP.CharCreatePanel.ModelDisplay:DoClick()
		
		self:StartScene( "scenes/expressions/citizen_angry_idle_01.vcd" );
		
	end
	function CCP.CharCreatePanel.ModelDisplay.Entity:GetPlayerColor()
		
		if( !ent or !ent:IsValid() ) then return Vector( 1, 1, 1 ) end
		
		return ent:GetPlayerColor();
		
	end
	function CCP.CharCreatePanel.ModelDisplay:LayoutEntity( ent ) return end
	
	local body_mdl = self.BodyModels[1]
	if string.find( GAMEMODE.CharCreateSelectedModel, "female" ) then 
		body_mdl = string.StripExtension(GAMEMODE.BodyModels[1]).."_f.mdl"
	end
	local bonemerge_ent = CCP.CharCreatePanel.ModelDisplay:InitializeModel( body_mdl, CCP.CharCreatePanel.ModelDisplay.Entity )
	
	/*local oldPaint = CCP.CharCreatePanel.ModelDisplay.Paint;
	function CCP.CharCreatePanel.ModelDisplay:Paint( w, h ) -- for debug
	
		oldPaint( self, w, h );
		surface.SetDrawColor( 255, 255, 255, 255 );
		surface.DrawOutlinedRect( 0, 0, w, h );
		
	end*/
	
	CCP.CharCreatePanel.ModelSelectScroll = vgui.Create("DScrollPanel", CCP.CharCreatePanel.ContentPane)
	CCP.CharCreatePanel.ModelSelectScroll:SetSize(316, 300)
	CCP.CharCreatePanel.ModelSelectScroll:SetPos(448, 4)
	
	local x = 0;
	local y = 0;
	
	local si = { };
	
	for _, v in pairs( self.CitizenModels ) do
		
		local model = vgui.Create( "SpawnIcon", CCP.CharCreatePanel.ModelSelectScroll );
		model:SetPos( x, y );
		model:SetSize( 58, 58 );
		model:SetModel( v );
		model.ModelPath = v;
		function model:DoClick()
			
			for _, v in pairs( si ) do
				
				v.Selected = false;
				
			end
			
			self.Selected = true;
			CCP.CharCreatePanel.skinSelect:SetEnabled( true );
			
			GAMEMODE.CharCreateSelectedModel = self.ModelPath;
			CCP.CharCreatePanel.ModelDisplay:SetModel( self.ModelPath );
			if string.find( self.ModelPath, "female" ) then 
				bonemerge_ent:SetModel(string.StripExtension(GAMEMODE.BodyModels[1]).."_f.mdl")
			else
				bonemerge_ent:SetModel(GAMEMODE.BodyModels[1])
			end
			
		end
		function model:PaintOver( w, h )
			
			self:DrawSelections();
			
			if( self.Hovered or self.Selected ) then
				
				surface.SetDrawColor( 255, 255, 255, 0 );
				surface.SetMaterial( matHover );
				self:DrawTexturedRect();
				
			end
			
		end
		function model:Paint( w, h )
		
			if( self.Hovered or self.Selected ) then
				
				surface.SetDrawColor( 50, 50, 100, 255 );
				surface.DrawRect( 0, 0, w, h );
				
			else
			
				surface.SetDrawColor( 40, 40, 40, 255 );
				surface.DrawRect( 0, 0, w, h );
				
				surface.SetDrawColor( 30, 30, 30, 100 );
				surface.DrawOutlinedRect( 0, 0, w, h );
			
			end
			
		end
		model:SetTooltip( "" );
		
		table.insert( si, model );
		
		x = x + 60;
		
		if( x > 300 - 60 ) then
			
			x = 0;
			y = y + 60;
			
		end
		
	end 

 	local skingroup = vgui.Create( "DLabel", CCP.CharCreatePanel.ContentPane );
	skingroup:SetText( "Skin" );
	skingroup:SetPos( 350, 320 );
	skingroup:SetFont( "CombineControl.LabelGiant" );
	skingroup:SizeToContents();
	skingroup:PerformLayout();
	
	CCP.CharCreatePanel.skinSelect = vgui.Create( "DComboBox", CCP.CharCreatePanel.ContentPane );
	CCP.CharCreatePanel.skinSelect:SetPos( 448, 322 );
	CCP.CharCreatePanel.skinSelect:SetSize( 100, 20 );
	CCP.CharCreatePanel.skinSelect:SetValue( "Skin" );
	CCP.CharCreatePanel.skinSelect:AddChoice( "0" );
	CCP.CharCreatePanel.skinSelect:AddChoice( "1" );
	CCP.CharCreatePanel.skinSelect:AddChoice( "2" );
	CCP.CharCreatePanel.skinSelect:AddChoice( "3" );
	CCP.CharCreatePanel.skinSelect:SetEnabled( false );
	function CCP.CharCreatePanel.skinSelect:OnSelect( index, value, data )
	
		for k,v in next, si do
		
			if( v.Selected ) then
			
				v:SetModel( v.ModelPath, tonumber( value ) );
				
			end
			
		end
		
		CCP.CharCreatePanel.ModelDisplay.Entity:SetSkin( tonumber( value ) );
		CCP.CharCreatePanel.CharCreateSelectedSkin = tonumber( value );
	
	end 
	
	if( CCP.CharCreatePanel.CharCreateSelectedSkin ) then
	
		for k,v in next, si do
		
			if( v.ModelPath == GAMEMODE.CharCreateSelectedModel ) then
			
				v.Selected = true;
				v:SetModel( v.ModelPath, CCP.CharCreatePanel.CharCreateSelectedSkin );
				CCP.CharCreatePanel.ModelDisplay.Entity:SetSkin( CCP.CharCreatePanel.CharCreateSelectedSkin );
				CCP.CharCreatePanel.skinSelect:ChooseOption( CCP.CharCreatePanel.CharCreateSelectedSkin, CCP.CharCreatePanel.CharCreateSelectedSkin  );
				CCP.CharCreatePanel.skinSelect:SetEnabled( true );
				break;
				
			end
			
		end
		
	end
	
	if( self.CCMode == CC_CREATE ) then
		
		CCP.CharCreatePanel.NewbLabel = vgui.Create( "DLabel", CCP.CharCreatePanel.ContentPane );
		CCP.CharCreatePanel.NewbLabel:SetText( "Are you an inexperienced roleplayer?" );
		CCP.CharCreatePanel.NewbLabel:SetPos( 350, 350 );
		CCP.CharCreatePanel.NewbLabel:SetFont( "CombineControl.LabelSmall" );
		CCP.CharCreatePanel.NewbLabel:SetSize( 294, 16 );
		CCP.CharCreatePanel.NewbLabel:SetAutoStretchVertical( true );
		CCP.CharCreatePanel.NewbLabel:SetWrap( true );
		CCP.CharCreatePanel.NewbLabel:PerformLayout();
		
		netstream.Start( "nSetNewbieStatus", true );
		
		CCP.CharCreatePanel.Newbie = vgui.Create( "DCheckBoxLabel", CCP.CharCreatePanel.ContentPane );
		CCP.CharCreatePanel.Newbie:SetText( "" );
		CCP.CharCreatePanel.Newbie:SetPos( 570, 350 );
		CCP.CharCreatePanel.Newbie:SetValue( true );
		CCP.CharCreatePanel.Newbie:PerformLayout();
		function CCP.CharCreatePanel.Newbie:OnChange( val )
			
			netstream.Start( "nSetNewbieStatus", val );
			
		end
		
	end
	
	CCP.CharCreatePanel.Next = vgui.Create( "DButton", CCP.CharCreatePanel.ContentPane );
	CCP.CharCreatePanel.Next:SetFont( "STALKER.LabelMenu" );
	CCP.CharCreatePanel.Next:SetText( "Next" );
	CCP.CharCreatePanel.Next:SetSkin( "STALKER" );
	CCP.CharCreatePanel.Next:SetPos( 690, 378 );
	CCP.CharCreatePanel.Next:SetSize( 70, 30 );
	function CCP.CharCreatePanel.Next:DoClick()
		
		GAMEMODE:CharCreateNextPage();
		
	end
	CCP.CharCreatePanel.Next:PerformLayout();

end

function GM:CharCreatePage2()

	CCP.CharCreatePanel.ModelDisplay = vgui.Create( "CCharPanel", CCP.CharCreatePanel.ContentPane );
	CCP.CharCreatePanel.ModelDisplay:SetPos( 4, 4 );
	if( GAMEMODE.CharCreateSelectedModel == "" ) then
	
		GAMEMODE.CharCreateSelectedModel = self.CitizenModels[1];
		
	end
	CCP.CharCreatePanel.ModelDisplay:SetModel( GAMEMODE.CharCreateSelectedModel or self.CitizenModels[1] );
	CCP.CharCreatePanel.ModelDisplay.Entity:SetSkin( CCP.CharCreatePanel.CharCreateSelectedSkin or 0 );
	CCP.CharCreatePanel.ModelDisplay:SetSize( 324, 370 );
	CCP.CharCreatePanel.ModelDisplay:SetFOV( 32 );
	CCP.CharCreatePanel.ModelDisplay:SetCamPos( Vector( 50, 0, 56 ) );
	CCP.CharCreatePanel.ModelDisplay:SetLookAt( Vector( 0, 0, 56 ) );
	function CCP.CharCreatePanel.ModelDisplay:DoClick()
		
		self:StartScene( "scenes/expressions/citizen_angry_idle_01.vcd" );
		
	end
	function CCP.CharCreatePanel.ModelDisplay.Entity:GetPlayerColor()
		
		if( !ent or !ent:IsValid() ) then return Vector( 1, 1, 1 ) end
		
		return ent:GetPlayerColor();
		
	end
	function CCP.CharCreatePanel.ModelDisplay:LayoutEntity( ent ) return end
	
	local body_mdl = self.BodyModels[1]
	if string.find( GAMEMODE.CharCreateSelectedModel, "female" ) then 
		body_mdl = string.StripExtension(GAMEMODE.BodyModels[1]).."_f.mdl"
	end
	local bonemerge_ent = CCP.CharCreatePanel.ModelDisplay:InitializeModel( body_mdl, CCP.CharCreatePanel.ModelDisplay.Entity )

	CCP.CharCreatePanel.NameLabel = vgui.Create( "DLabel", CCP.CharCreatePanel.ContentPane );
	CCP.CharCreatePanel.NameLabel:SetText( "Name" );
	CCP.CharCreatePanel.NameLabel:SetPos( 350, 4 );
	CCP.CharCreatePanel.NameLabel:SetFont( "CombineControl.LabelGiant" );
	CCP.CharCreatePanel.NameLabel:SizeToContents();
	CCP.CharCreatePanel.NameLabel:PerformLayout();
	
	CCP.CharCreatePanel.NameEntry = vgui.Create( "DTextEntry", CCP.CharCreatePanel.ContentPane );
	CCP.CharCreatePanel.NameEntry:SetFont( "CombineControl.LabelBig" );
	CCP.CharCreatePanel.NameEntry:SetPos( 460, 6 );
	CCP.CharCreatePanel.NameEntry:SetSize( 300, 20 );
	CCP.CharCreatePanel.NameEntry:PerformLayout();
	function CCP.CharCreatePanel.NameEntry:AllowInput( val )
		
		if( !string.find( allowedChars, val, 1, true ) ) then
			
			return true
			
		end
		
		return false;
		
	end
	
	CCP.CharCreatePanel.TitleOneLabel = vgui.Create( "DLabel", CCP.CharCreatePanel.ContentPane );
	CCP.CharCreatePanel.TitleOneLabel:SetText( "Title One" );
	CCP.CharCreatePanel.TitleOneLabel:SetPos( 350, 60 );
	CCP.CharCreatePanel.TitleOneLabel:SetFont( "CombineControl.LabelGiant" );
	CCP.CharCreatePanel.TitleOneLabel:SizeToContents();
	CCP.CharCreatePanel.TitleOneLabel:PerformLayout();
	
	CCP.CharCreatePanel.TitleOneEntry = vgui.Create( "DTextEntry", CCP.CharCreatePanel.ContentPane );
	CCP.CharCreatePanel.TitleOneEntry:SetFont( "CombineControl.LabelBig" );
	CCP.CharCreatePanel.TitleOneEntry:SetPos( 460, 60 );
	CCP.CharCreatePanel.TitleOneEntry:SetSize( 300, 20 );
	CCP.CharCreatePanel.TitleOneEntry:PerformLayout();
	function CCP.CharCreatePanel.TitleOneEntry:AllowInput( val )
		
		if( !string.find( allowedChars, val, 1, true ) ) then
			
			return true
			
		end
		
		return false;
		
	end
	
	CCP.CharCreatePanel.TitleTwoLabel = vgui.Create( "DLabel", CCP.CharCreatePanel.ContentPane );
	CCP.CharCreatePanel.TitleTwoLabel:SetText( "Title Two" );
	CCP.CharCreatePanel.TitleTwoLabel:SetPos( 350, 90 );
	CCP.CharCreatePanel.TitleTwoLabel:SetFont( "CombineControl.LabelGiant" );
	CCP.CharCreatePanel.TitleTwoLabel:SizeToContents();
	CCP.CharCreatePanel.TitleTwoLabel:PerformLayout();
	
	CCP.CharCreatePanel.TitleTwoEntry = vgui.Create( "DTextEntry", CCP.CharCreatePanel.ContentPane );
	CCP.CharCreatePanel.TitleTwoEntry:SetFont( "CombineControl.LabelBig" );
	CCP.CharCreatePanel.TitleTwoEntry:SetPos( 460, 90 );
	CCP.CharCreatePanel.TitleTwoEntry:SetSize( 300, 20 );
	CCP.CharCreatePanel.TitleTwoEntry:PerformLayout();
	function CCP.CharCreatePanel.TitleTwoEntry:AllowInput( val )
		
		if( !string.find( allowedChars, val, 1, true ) ) then
			
			return true
			
		end
		
		return false;
		
	end
	
	CCP.CharCreatePanel.RandomMale = vgui.Create( "DButton", CCP.CharCreatePanel.ContentPane );
	CCP.CharCreatePanel.RandomMale:SetFont( "CombineControl.LabelSmall" );
	CCP.CharCreatePanel.RandomMale:SetText( "Random Male" );
	CCP.CharCreatePanel.RandomMale:SetPos( 460, 32 );
	CCP.CharCreatePanel.RandomMale:SetSize( 100, 20 );
	function CCP.CharCreatePanel.RandomMale:DoClick()
		
		CCP.CharCreatePanel.NameEntry:SetValue( table.Random( GAMEMODE.MaleFirstNames ) .. " " .. table.Random( GAMEMODE.MaleLastNames ) );
		
	end
	CCP.CharCreatePanel.RandomMale:PerformLayout();
	
	CCP.CharCreatePanel.RandomFemale = vgui.Create( "DButton", CCP.CharCreatePanel.ContentPane );
	CCP.CharCreatePanel.RandomFemale:SetFont( "CombineControl.LabelSmall" );
	CCP.CharCreatePanel.RandomFemale:SetText( "Random Female" );
	CCP.CharCreatePanel.RandomFemale:SetPos( 570, 32 );
	CCP.CharCreatePanel.RandomFemale:SetSize( 100, 20 );
	function CCP.CharCreatePanel.RandomFemale:DoClick()
		
		CCP.CharCreatePanel.NameEntry:SetValue( table.Random( GAMEMODE.FemaleFirstNames ) .. " " .. table.Random( GAMEMODE.FemaleLastNames ) );
		
	end
	CCP.CharCreatePanel.RandomFemale:PerformLayout();
	
	CCP.CharCreatePanel.DescLabel = vgui.Create( "DLabel", CCP.CharCreatePanel.ContentPane );
	CCP.CharCreatePanel.DescLabel:SetText( "Description" );
	CCP.CharCreatePanel.DescLabel:SetPos( 350, 120 );
	CCP.CharCreatePanel.DescLabel:SetFont( "CombineControl.LabelGiant" );
	CCP.CharCreatePanel.DescLabel:SizeToContents();
	CCP.CharCreatePanel.DescLabel:PerformLayout();
	
	CCP.CharCreatePanel.DescEntry = vgui.Create( "DTextEntry", CCP.CharCreatePanel.ContentPane );
	CCP.CharCreatePanel.DescEntry:SetFont( "CombineControl.LabelSmall" );
	CCP.CharCreatePanel.DescEntry:SetPos( 460, 122 );
	CCP.CharCreatePanel.DescEntry:SetSize( 300, 200 );
	CCP.CharCreatePanel.DescEntry:SetMultiline( true );
	CCP.CharCreatePanel.DescEntry:PerformLayout();
	
	local label = vgui.Create( "DLabel", CCP.CharCreatePanel.ContentPane );
	label:SetText( "Language" );
	label:SetPos( 350, 330 );
	label:SetFont( "CombineControl.LabelGiant" );
	label:SizeToContents();
	label:PerformLayout();
	
	CCP.CharCreatePanel.TraitLabel = vgui.Create( "DLabel", CCP.CharCreatePanel.ContentPane );
	CCP.CharCreatePanel.TraitLabel:SetText( GAMEMODE.Traits[TRAIT_NONE][1] );
	CCP.CharCreatePanel.TraitLabel:SetPos( 484, 334 );
	CCP.CharCreatePanel.TraitLabel:SetSize( 178, 16 );
	CCP.CharCreatePanel.TraitLabel:SetFont( "CombineControl.LabelSmall" );
	CCP.CharCreatePanel.TraitLabel:PerformLayout();
	CCP.CharCreatePanel.TraitLabel.Value = TRAIT_NONE;
	
	local a = vgui.Create( "DButton", CCP.CharCreatePanel.ContentPane );
	a:SetFont( "CombineControl.LabelSmall" );
	a:SetText( "<" );
	-- 214
	a:SetPos( 460, 334 );
	a:SetSize( 16, 16 );
	function a:DoClick()
		
		local n = CCP.CharCreatePanel.TraitLabel.Value / 2;
		
		-- for some god awful reason the # operator counts child tables as well.
		-- and subtract 1 because the first entry of the table is 1.
		if( n < TRAIT_NONE ) then
			
			n = 2 ^ ( #table.GetKeys( GAMEMODE.Traits ) - 1 );
			
		end
		
		CCP.CharCreatePanel.TraitLabel.Value = n;
		CCP.CharCreatePanel.TraitLabel:SetText( GAMEMODE.Traits[CCP.CharCreatePanel.TraitLabel.Value][1] );
		CCP.CharCreatePanel.TraitDesc:SetText( GAMEMODE.Traits[CCP.CharCreatePanel.TraitLabel.Value][2] );
		
	end
	a:PerformLayout();
	
	local b = vgui.Create( "DButton", CCP.CharCreatePanel.ContentPane );
	b:SetFont( "CombineControl.LabelSmall" );
	b:SetText( ">" );
	b:SetPos( 674, 334 );
	b:SetSize( 16, 16 );
	function b:DoClick()
		
		local n = CCP.CharCreatePanel.TraitLabel.Value * 2;
		
		-- for some god awful reason the # operator counts child tables as well.
		-- and -1 because the first entry of the table is 1.
		if( n > 2 ^ #table.GetKeys( GAMEMODE.Traits ) - 1 ) then
			
			n = TRAIT_NONE;
			
		end
		
		CCP.CharCreatePanel.TraitLabel.Value = n;
		CCP.CharCreatePanel.TraitLabel:SetText( GAMEMODE.Traits[CCP.CharCreatePanel.TraitLabel.Value][1] );
		CCP.CharCreatePanel.TraitDesc:SetText( GAMEMODE.Traits[CCP.CharCreatePanel.TraitLabel.Value][2] );
		
	end
	b:PerformLayout();
	
	CCP.CharCreatePanel.TraitDesc = vgui.Create( "DLabel", CCP.CharCreatePanel.ContentPane );
	CCP.CharCreatePanel.TraitDesc:SetText( GAMEMODE.Traits[TRAIT_NONE][2] );
	CCP.CharCreatePanel.TraitDesc:SetPos( 460, 354 );
	CCP.CharCreatePanel.TraitDesc:SetSize( 320, 14 );
	CCP.CharCreatePanel.TraitDesc:SetFont( "CombineControl.LabelTiny" );
	CCP.CharCreatePanel.TraitDesc:SetAutoStretchVertical( true );
	CCP.CharCreatePanel.TraitDesc:SetWrap( true );
	CCP.CharCreatePanel.TraitDesc:PerformLayout();
	
	-- lets just assume that the rest of the vars exist as well
	if( CCP.CharCreatePanel.m_szName ) then
	
		CCP.CharCreatePanel.NameEntry:SetValue( CCP.CharCreatePanel.m_szName );
		CCP.CharCreatePanel.TitleOneEntry:SetValue( CCP.CharCreatePanel.m_szTitleOne );
		CCP.CharCreatePanel.TitleTwoEntry:SetValue( CCP.CharCreatePanel.m_szTitleTwo );
		CCP.CharCreatePanel.DescEntry:SetValue( CCP.CharCreatePanel.m_szDescription );
		CCP.CharCreatePanel.TraitLabel.Value = CCP.CharCreatePanel.m_nTrait;
		CCP.CharCreatePanel.TraitLabel:SetText( GAMEMODE.Traits[CCP.CharCreatePanel.TraitLabel.Value][1] );
		CCP.CharCreatePanel.TraitDesc:SetText( GAMEMODE.Traits[CCP.CharCreatePanel.TraitLabel.Value][2] );
	
	end
	
	
	CCP.CharCreatePanel.Next = vgui.Create( "DButton", CCP.CharCreatePanel.ContentPane );
	CCP.CharCreatePanel.Next:SetFont( "STALKER.LabelMenu" );
	CCP.CharCreatePanel.Next:SetText( "Next" );
	CCP.CharCreatePanel.Next:SetSkin( "STALKER" );
	CCP.CharCreatePanel.Next:SetPos( 690, 378 );
	CCP.CharCreatePanel.Next:SetSize( 70, 30 );
	function CCP.CharCreatePanel.Next:DoClick()
	
		CCP.CharCreatePanel.m_szName = CCP.CharCreatePanel.NameEntry:GetValue();
		CCP.CharCreatePanel.m_szTitleOne = CCP.CharCreatePanel.TitleOneEntry:GetValue();
		CCP.CharCreatePanel.m_szTitleTwo = CCP.CharCreatePanel.TitleTwoEntry:GetValue();
		CCP.CharCreatePanel.m_szDescription = CCP.CharCreatePanel.DescEntry:GetValue();
		CCP.CharCreatePanel.m_nTrait = CCP.CharCreatePanel.TraitLabel.Value;
		CCP.CharCreatePanel.m_szModel = CCP.CharCreatePanel.ModelDisplay:GetModel();
		CCP.CharCreatePanel.m_nSkin = CCP.CharCreatePanel.ModelDisplay.Entity:GetSkin();
		
		GAMEMODE:CharCreateNextPage();
		
	end
	CCP.CharCreatePanel.Next:PerformLayout();
	
	CCP.CharCreatePanel.Back = vgui.Create( "DButton", CCP.CharCreatePanel.ContentPane );
	CCP.CharCreatePanel.Back:SetFont( "STALKER.LabelMenu" );
	CCP.CharCreatePanel.Back:SetText( "Back" );
	CCP.CharCreatePanel.Back:SetSkin( "STALKER" );
	CCP.CharCreatePanel.Back:SetPos( 610, 378 );
	CCP.CharCreatePanel.Back:SetSize( 70, 30 );
	function CCP.CharCreatePanel.Back:DoClick()
		
		GAMEMODE:CharCreatePrevPage();
		
	end
	CCP.CharCreatePanel.Back:PerformLayout();

end

function GM:CharCreatePage3()

	local panel = CCP.CharCreatePanel;
	
	CCP.CharCreatePanel.ModelDisplay = vgui.Create( "CCharPanel", CCP.CharCreatePanel.ContentPane );
	CCP.CharCreatePanel.ModelDisplay:SetPos( 4, 4 );
	CCP.CharCreatePanel.ModelDisplay:SetModel( panel.m_szModel or "" );
	CCP.CharCreatePanel.ModelDisplay.Entity:SetSkin( panel.m_nSkin );
	CCP.CharCreatePanel.ModelDisplay:SetSize( 324, 370 );
	CCP.CharCreatePanel.ModelDisplay:SetFOV( 32 );
	CCP.CharCreatePanel.ModelDisplay:SetCamPos( Vector( 50, 0, 56 ) );
	CCP.CharCreatePanel.ModelDisplay:SetLookAt( Vector( 0, 0, 56 ) );
	function CCP.CharCreatePanel.ModelDisplay:DoClick()
		
		self:StartScene( "scenes/expressions/citizen_angry_idle_01.vcd" );
		
	end
	function CCP.CharCreatePanel.ModelDisplay.Entity:GetPlayerColor()
		
		if( !ent or !ent:IsValid() ) then return Vector( 1, 1, 1 ) end
		
		return ent:GetPlayerColor();
		
	end
	function CCP.CharCreatePanel.ModelDisplay:LayoutEntity( ent ) return end

	local body_mdl = self.BodyModels[1]
	if string.find( GAMEMODE.CharCreateSelectedModel, "female" ) then 
		body_mdl = string.StripExtension(GAMEMODE.BodyModels[1]).."_f.mdl"
	end
	local bonemerge_ent = CCP.CharCreatePanel.ModelDisplay:InitializeModel( body_mdl, CCP.CharCreatePanel.ModelDisplay.Entity )
	
	CCP.CharCreatePanel.ItemsList = vgui.Create( "DScrollPanel", CCP.CharCreatePanel.ContentPane );
	CCP.CharCreatePanel.ItemsList:SetSize( 444, 326 );
	CCP.CharCreatePanel.ItemsList:SetPos( 340, 50 );
	function CCP.CharCreatePanel.ItemsList:Paint( w, h )
		
		surface.SetDrawColor( 0, 0, 0, 255 );
		surface.DrawOutlinedRect( 0, 0, w, h );
		
	end
	
	CCP.CharCreatePanel.Rubles = CCP.CharCreatePanel.Rubles or GAMEMODE.RubleBudget;
	CCP.CharCreatePanel.RublesLeft = vgui.Create( "DLabel", CCP.CharCreatePanel.ContentPane );
	CCP.CharCreatePanel.RublesLeft:SetPos( 360, 16 );
	CCP.CharCreatePanel.RublesLeft:SetText( "RU: "..CCP.CharCreatePanel.Rubles );
	CCP.CharCreatePanel.RublesLeft:SetFont( "STALKER.LabelMenu" );
	CCP.CharCreatePanel.RublesLeft:SizeToContents();
	CCP.CharCreatePanel.RublesLeft:PerformLayout();
	function CCP.CharCreatePanel.RublesLeft:Think()
	
		if( !CCP.CharCreatePanel ) then return end
	
		if( self.LastRubleCount != CCP.CharCreatePanel.Rubles ) then
		
			CCP.CharCreatePanel.RublesLeft:SetText( "WIP - Scroll with scroll wheel | RU: "..CCP.CharCreatePanel.Rubles );
			CCP.CharCreatePanel.RublesLeft:SizeToContents();
			
		end
		
		self.LastRubleCount = CCP.CharCreatePanel.Rubles;
	
	end
	
	CCP.CharCreatePanel.SelectedGear = CCP.CharCreatePanel.SelectedGear or {};
	
	local y = 0;
	
	for k, v in pairs( GAMEMODE.GearSelection ) do

		local metaitem = GAMEMODE:GetItemByID( k );
		if( !metaitem ) then
		
			continue;
			
		end
		
		local itempane = vgui.Create( "DPanel" );
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
		icon:SetModel( metaitem.Model );
		icon:SetSize( 64, 64 );
		icon.Entity:SetBodygroup( metaitem.BodygroupCategory or 1, metaitem.Bodygroup or 0 );
		
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
		if metaitem.Base == "clothes" then
			local suit = GAMEMODE.SuitVariants[metaitem.Vars["SuitClass"]]
			
			if suit.ItemSubmaterials then
				for k,v in next, suit.ItemSubmaterials do
					icon.Entity:SetSubMaterial( v[1], v[2] )
				end
			end
		else
			if metaitem.ItemSubmaterials then
				for k,v in next, metaitem.ItemSubmaterials do
					icon.Entity:SetSubMaterial( v[1], v[2] )
				end
			end
		end
		
		function icon:LayoutEntity() end
		
		local p = icon.Paint;
		
		function icon:Paint( w, h )
		
			if( !CCP.CharCreatePanel ) then return end
			
			local pnl = CCP.CharCreatePanel.ItemsList;
			local x2, y2 = pnl:LocalToScreen( 0, 0 );
			local w2, h2 = pnl:GetSize();
			render.SetScissorRect( x2, y2, x2 + w2, y2 + h2, true );
			
			p( self, w, h );
			
			render.SetScissorRect( 0, 0, 0, 0, false );
			
		end
		
		local name = vgui.Create( "DLabel", itempane );
		name:SetText( metaitem.Name );
		name:SetPos( 74, 10 );
		name:SetFont( "CombineControl.LabelSmall" );
		name:SizeToContents();
		name:PerformLayout();
		
		local cost = vgui.Create( "DLabel", itempane );
		cost:SetText( "RU: "..v );
		cost:SetPos( 350, 4 );
		cost:SetFont( "CombineControl.LabelSmall" );
		cost:SizeToContents();
		cost:PerformLayout();
		
		local scroll = vgui.Create( "DScrollPanel", itempane );
		scroll:SetSize( 286, 40 );
		scroll:SetPos( 74, 24 );
		function scroll:Paint( w, h )
		end
		
		surface.SetFont( "CombineControl.LabelSmall" );
		local a, b = surface.GetTextSize( metaitem.Name );
		
		local d, n = GAMEMODE:FormatLine( metaitem.Desc, "CombineControl.LabelTiny", 270 );
		
		local desc = vgui.Create( "DLabel", scroll );
		desc:SetText( d );
		desc:SetPos( 0, 0 );
		desc:SetFont( "CombineControl.LabelTiny" );
		desc:SizeToContents();
		desc:PerformLayout();
		
		local amount = vgui.Create( "DNumberWang", itempane );
		amount:SetSize( 70, 25 );
		amount:SetPos( 350, 20 );
		amount:SetDecimals( 0 );
		amount:SetMin( 0 );
		amount:SetValue( 0 );
		function amount:OnValueChanged( nValue )
		
			nValue = tonumber( nValue );
			
			if( !self.nLastValue ) then
			
				self.nLastValue = 0;
				
			end
		
			if( nValue < 0 ) then
			
				self.Value = 0;
				self:SetText( 0 );
				return;
				
			end
			
			if( nValue >= 0 and nValue != self.nLastValue ) then
			
				local delta = nValue - self.nLastValue;
				
				CCP.CharCreatePanel.Rubles = CCP.CharCreatePanel.Rubles - ( v * delta );
				
				if( !CCP.CharCreatePanel.SelectedGear[k] ) then
				
					CCP.CharCreatePanel.SelectedGear[k] = 1;
					
				else
				
					if( nValue != 0 ) then
				
						CCP.CharCreatePanel.SelectedGear[k] = CCP.CharCreatePanel.SelectedGear[k] + ( 1 * delta );
						
					else
					
						CCP.CharCreatePanel.SelectedGear[k] = nil;
						
					end
					
				end
				
			end
		
			self.nLastValue = nValue;
		
		end
		
		CCP.CharCreatePanel.ItemsList:Add( itempane );
		
		if( CCP.CharCreatePanel.SelectedGear[k] ) then
		
			amount.Value = CCP.CharCreatePanel.SelectedGear[k];
			amount.nLastValue = amount.Value;
			amount:SetText( amount.Value );
			
		end
		
		y = y + 64;
		
	end

	CCP.CharCreatePanel.Finish = vgui.Create( "DButton", CCP.CharCreatePanel.ContentPane );
	CCP.CharCreatePanel.Finish:SetFont( "STALKER.LabelMenu" );
	CCP.CharCreatePanel.Finish:SetText( "Finish" );
	CCP.CharCreatePanel.Finish:SetSkin( "STALKER" );
	CCP.CharCreatePanel.Finish:SetPos( 690, 378 );
	CCP.CharCreatePanel.Finish:SetSize( 70, 30 );
	function CCP.CharCreatePanel.Finish:DoClick()
	
		local name = CCP.CharCreatePanel.m_szName;
		local desc = CCP.CharCreatePanel.m_szDescription;
		local titleone = CCP.CharCreatePanel.m_szTitleOne;
		local titletwo = CCP.CharCreatePanel.m_szTitleTwo;
		local model = CCP.CharCreatePanel.m_szModel;
		local trait = CCP.CharCreatePanel.m_nTrait;
		local skin = CCP.CharCreatePanel.m_nSkin;
		skin = tonumber( skin );
		local gear = table.Copy( CCP.CharCreatePanel.SelectedGear );
		
		local r, err = GAMEMODE:CheckCharacterValidity( name, desc, titleone, titletwo, model, trait, skin, gear );
		
		if( r ) then
			
			GAMEMODE:CloseCharCreate();
			
			netstream.Start( "nCreateCharacter",
				name,
				desc,
				titleone,
				titletwo,
				model,
				trait,
				skin,
				gear
			);
			
		else
			
			CCP.CharCreatePanel.BadChar:SetText( err );
			
		end
		
	end
	CCP.CharCreatePanel.Finish:PerformLayout();
	
	CCP.CharCreatePanel.Back = vgui.Create( "DButton", CCP.CharCreatePanel.ContentPane );
	CCP.CharCreatePanel.Back:SetFont( "STALKER.LabelMenu" );
	CCP.CharCreatePanel.Back:SetText( "Back" );
	CCP.CharCreatePanel.Back:SetSkin( "STALKER" );
	CCP.CharCreatePanel.Back:SetPos( 610, 378 );
	CCP.CharCreatePanel.Back:SetSize( 70, 30 );
	function CCP.CharCreatePanel.Back:DoClick()
		
		GAMEMODE:CharCreatePrevPage();
		
	end
	CCP.CharCreatePanel.Back:PerformLayout();

end

function GM:CharSelectPopulateCharacters()

 	CCP.CharCreatePanel.Model = vgui.Create( "CCharPanel", CCP.CharCreatePanel.ContentPane );
	CCP.CharCreatePanel.Model:SetModel( "" );
	CCP.CharCreatePanel.Model:SetPos( 4, 4 );
	CCP.CharCreatePanel.Model:SetSize( 324, 370 );
	CCP.CharCreatePanel.Model:SetFOV( 32 );
	CCP.CharCreatePanel.Model:SetCamPos( Vector( 50, 0, 56 ) );
	CCP.CharCreatePanel.Model:SetLookAt( Vector( 0, 0, 56 ) );
	function CCP.CharCreatePanel.Model:DoClick()
		
		self:StartScene( "scenes/expressions/citizen_angry_idle_01.vcd" );
		
	end

	if( !self.CharSelectCharacterButtons ) then self.CharSelectCharacterButtons = { }; end
	
	for _, v in pairs( self.CharSelectCharacterButtons ) do
		
		v:Remove();
		
	end
	
	self.CharSelectCharacterButtons = { };
	
	local y = 0;
	
	CCP.CharCreatePanel.CharsList = vgui.Create( "DScrollPanel", CCP.CharCreatePanel.ContentPane );
	CCP.CharCreatePanel.CharsList:SetSize( 424, 370 );
	CCP.CharCreatePanel.CharsList:SetPos( 340, 4 );
	function CCP.CharCreatePanel.CharsList:Paint( w, h )
		
		surface.SetDrawColor( 0, 0, 0, 255 );
		surface.DrawOutlinedRect( 0, 0, w, h );
		
	end
	
	--CCP.CharSelect.ModelDisplay:SetModel( "" );
	
	for k, v in pairs( self.Characters ) do
	
		local charpane = vgui.Create( "DPanel" );
		charpane:SetSkin( "STALKER" );
		charpane:SetPos( 0, y );
		charpane:SetSize( 556, 64 );
		function charpane:Paint( w, h )
			
			surface.SetDrawColor( 0, 0, 0, 70 );
			surface.DrawRect( 0, 0, w, h );
			
			surface.SetDrawColor( 0, 0, 0, 100 );
			surface.DrawOutlinedRect( 0, 0, w, h );
			
		end
		function charpane:Think()
		
			if( self:IsHovered() and !self.m_bLastHovered ) then
			
				CCP.CharCreatePanel.Model:SetModel( v.Model );
				if !CCP.CharCreatePanel.Model.Body then
					CCP.CharCreatePanel.Model.Body = CCP.CharCreatePanel.Model:InitializeModel( v.Body, CCP.CharCreatePanel.Model.Entity );
				else
					CCP.CharCreatePanel.Model.Body:SetModel(v.Body)
				end
				CCP.CharCreatePanel.Model.Entity:SetSkin( tonumber( v.Skingroup ) );
				
			end
			
			self.m_bLastHovered = self:IsHovered();
		
		end
		
		local name = vgui.Create( "DLabel", charpane );
		name:SetText( v.RPName );
		name:SetPos( 10, 10 );
		name:SetFont( "STALKER.LabelMenu" );
		name:SizeToContents();
		name:PerformLayout();
		
		local b = vgui.Create( "DButton", charpane );
		b:SetFont( "CombineControl.LabelSmall" );
		b:SetText( "Select" );
		b:SetPos( 300, 22 );
		b:SetSize( 80, 20 );
		b.CharID = v.id;
		b.Location = v.Location;
		function b:DoClick()
				
			GAMEMODE:CloseCharCreate();
			
			netstream.Start( "nSelectCharacter", self.CharID );
			
		end
		b:PerformLayout();
		
		if( LocalPlayer().CharID and b.CharID == LocalPlayer():CharID() ) then
			
			b:SetDisabled( true );
			
		end
		
		if( GAMEMODE.CurrentLocation and b.Location != GAMEMODE.CurrentLocation and !LocalPlayer():IsAdmin() ) then
			
			b:SetDisabled( true );
			
		end
		
		table.insert( self.CharSelectCharacterButtons, charpane );
		
		CCP.CharCreatePanel.CharsList:Add( charpane );
		
		y = y + 64;
		
	end
	
	
end

function GM:CreateCharSelect()
	
	self:CharSelectPopulateCharacters();
	
end

function GM:CharCreateDelete()

 	CCP.CharCreatePanel.Model = vgui.Create( "CCharPanel", CCP.CharCreatePanel.ContentPane );
	CCP.CharCreatePanel.Model:SetModel( "" );
	CCP.CharCreatePanel.Model:SetPos( 4, 4 );
	CCP.CharCreatePanel.Model:SetSize( 324, 370 );
	CCP.CharCreatePanel.Model:SetFOV( 32 );
	CCP.CharCreatePanel.Model:SetCamPos( Vector( 50, 0, 56 ) );
	CCP.CharCreatePanel.Model:SetLookAt( Vector( 0, 0, 56 ) );
	function CCP.CharCreatePanel.Model:DoClick()
		
		self:StartScene( "scenes/expressions/citizen_angry_idle_01.vcd" );
		
	end

	if( !self.CharDeleteCharacterButtons ) then self.CharDeleteCharacterButtons = { }; end
	
	for _, v in pairs( self.CharDeleteCharacterButtons ) do
		
		v:Remove();
		
	end
	
	self.CharDeleteCharacterButtons = { };
	
	local y = 0;
	
	CCP.CharCreatePanel.CharsList = vgui.Create( "DScrollPanel", CCP.CharCreatePanel.ContentPane );
	CCP.CharCreatePanel.CharsList:SetSize( 424, 370 );
	CCP.CharCreatePanel.CharsList:SetPos( 340, 4 );
	function CCP.CharCreatePanel.CharsList:Paint( w, h )
		
		surface.SetDrawColor( 0, 0, 0, 255 );
		surface.DrawOutlinedRect( 0, 0, w, h );
		
	end
	
	for k, v in pairs( self.Characters ) do
	
		local charpane = vgui.Create( "DPanel" );
		charpane:SetSkin( "STALKER" );
		charpane:SetPos( 0, y );
		charpane:SetSize( 556, 64 );
		function charpane:Paint( w, h )
			
			surface.SetDrawColor( 0, 0, 0, 70 );
			surface.DrawRect( 0, 0, w, h );
			
			surface.SetDrawColor( 0, 0, 0, 100 );
			surface.DrawOutlinedRect( 0, 0, w, h );
			
		end
		function charpane:Think()
		
			if( self:IsHovered() and !self.m_bLastHovered ) then
			
				CCP.CharCreatePanel.Model:SetModel( v.Model );
				if !CCP.CharCreatePanel.Model.Body then
					CCP.CharCreatePanel.Model.Body = CCP.CharCreatePanel.Model:InitializeModel( v.Body, CCP.CharCreatePanel.Model.Entity );
				else
					CCP.CharCreatePanel.Model.Body:SetModel(v.Body)
				end
				CCP.CharCreatePanel.Model.Entity:SetSkin( tonumber( v.Skingroup ) );
				
			end
			
			self.m_bLastHovered = self:IsHovered();
		
		end
		
		local name = vgui.Create( "DLabel", charpane );
		name:SetText( v.RPName );
		name:SetPos( 10, 10 );
		name:SetFont( "STALKER.LabelMenu" );
		name:SizeToContents();
		name:PerformLayout();
		
		local b = vgui.Create( "DButton", charpane );
		b:SetFont( "CombineControl.LabelSmall" );
		b:SetText( "Delete" );
		b:SetPos( 300, 22 );
		b:SetSize( 80, 20 );
		b.CharID = v.id;
		b.Location = v.Location;
		function b:DoClick()

			Derma_Query( "Are you sure you want to delete this character?", "Delete", "Yes", function( self )
			
				netstream.Start( "nDeleteCharacter", b.CharID );
				
				for m, n in pairs( GAMEMODE.Characters ) do
					
					if( n.id == b.CharID ) then
						
						table.remove( GAMEMODE.Characters, m );
						
					end
					
				end
					
				CCP.CharCreatePanel.ContentPane:Clear();
				GAMEMODE:CharCreateDelete();
			
			end, "No" );
			
		end
		b:PerformLayout();
		
		if( LocalPlayer().CharID and b.CharID == LocalPlayer():CharID() ) then
			
			b:SetDisabled( true );
			
		end
		
		if( GAMEMODE.CurrentLocation and b.Location != GAMEMODE.CurrentLocation and !LocalPlayer():IsAdmin() ) then
			
			b:SetDisabled( true );
			
		end
		
		table.insert( self.CharDeleteCharacterButtons, charpane );
		
		CCP.CharCreatePanel.CharsList:Add( charpane );
		
		y = y + 64;
		
	end
	
end

function GM:CloseCharCreate()
	
	self.CharCreate = false;
	
	if( CCP.CharCreatePanel ) then
		
		CCP.CharCreatePanel:Remove();
		
	end
	
	if( CCP.CharSelectPanel ) then
		
		CCP.CharSelectPanel:Remove();
		
	end
	
	CCP.CharCreatePanel = nil;
	CCP.CharSelectPanel = nil;
	
end