function GM:CreatePlayerMenu()
	
	CCP.PlayerMenu = vgui.Create( "DFrame" );
	CCP.PlayerMenu:SetSize( 800, 500 );
	CCP.PlayerMenu:Center();
	CCP.PlayerMenu:SetTitle( "" );
	CCP.PlayerMenu.lblTitle:SetFont( "CombineControl.Window" );
	CCP.PlayerMenu:MakePopup();
	CCP.PlayerMenu:SetSkin( "STALKER" );
	function CCP.PlayerMenu:Think()
	
		if( input.IsKeyDown( KEY_F2 ) and !self.LastKeyState and self.HasOpened ) then
		
			self:Close();
		
		end
		
		self.LastKeyState = input.IsKeyDown( KEY_F2 );
		if( !self.HasOpened ) then
		
			self.HasOpened = true;
			
		end
	
	end
	CCP.PlayerMenu.PerformLayout = CCFramePerformLayout;
	CCP.PlayerMenu:PerformLayout();
	
	CCP.PlayerMenu.TopBar = vgui.Create( "DPanel", CCP.PlayerMenu );
	CCP.PlayerMenu.TopBar:SetPos( 0, 20 );
	CCP.PlayerMenu.TopBar:SetSize( 800, 50 );
	function CCP.PlayerMenu.TopBar:Paint( w, h )
		
	end
	
	CCP.PlayerMenu.TopBar.Buttons = { };
	
	CCP.PlayerMenu.TopBar.Buttons[1] = vgui.Create( "DButton", CCP.PlayerMenu.TopBar );
	CCP.PlayerMenu.TopBar.Buttons[1]:SetFont( "STALKER.LabelMenu" );
	CCP.PlayerMenu.TopBar.Buttons[1]:SetText( "Biography" );
	CCP.PlayerMenu.TopBar.Buttons[1]:SetPos( 14, 10 );
	CCP.PlayerMenu.TopBar.Buttons[1]:SetSize( 188, 35 );
	CCP.PlayerMenu.TopBar.Buttons[1].m_bTitleButton = true;
	CCP.PlayerMenu.TopBar.Buttons[1].m_bIsDown = true;
	CCP.PlayerMenu.TopBar.Buttons[1].DoClick = function( self )
	
		for k,v in next, CCP.PlayerMenu.TopBar.Buttons do
		
			v.m_bIsDown = false;
			
		end
		self.m_bIsDown = true;
		CCP.PlayerMenu.ContentPane:Clear();
		GAMEMODE:PMCreateBio();
		
	end
	CCP.PlayerMenu.TopBar.Buttons[1]:PerformLayout();
	
	CCP.PlayerMenu.TopBar.Buttons[2] = vgui.Create( "DButton", CCP.PlayerMenu.TopBar );
	CCP.PlayerMenu.TopBar.Buttons[2]:SetFont( "STALKER.LabelMenu" );
	CCP.PlayerMenu.TopBar.Buttons[2]:SetText( "Characters" );
	CCP.PlayerMenu.TopBar.Buttons[2]:SetPos( 206, 10 );
	CCP.PlayerMenu.TopBar.Buttons[2]:SetSize( 188, 35 );
	CCP.PlayerMenu.TopBar.Buttons[2].m_bTitleButton = true;
	CCP.PlayerMenu.TopBar.Buttons[2].DoClick = function( btn )
		if LocalPlayer():TiedUp() then
			LocalPlayer():Notify(nil, COLOR_ERR, "You can't switch characters while tied up.")
			
			return true
		end
		
		if table.Count( self.Characters ) >= self.MaxCharacters then
			self.CCMode = CC_SELECT_C
		else
			self.CCMode = CC_CREATESELECT_C
		end
		
		CCP.PlayerMenu:Close()
		self:CreateCharEditor()
	end
	CCP.PlayerMenu.TopBar.Buttons[2]:PerformLayout();
	
	CCP.PlayerMenu.TopBar.Buttons[3] = vgui.Create( "DButton", CCP.PlayerMenu.TopBar );
	CCP.PlayerMenu.TopBar.Buttons[3]:SetFont( "STALKER.LabelMenu" );
	CCP.PlayerMenu.TopBar.Buttons[3]:SetText( "Business" );
	CCP.PlayerMenu.TopBar.Buttons[3]:SetPos( 398, 10 );
	CCP.PlayerMenu.TopBar.Buttons[3]:SetSize( 188, 35 );
	CCP.PlayerMenu.TopBar.Buttons[3].m_bTitleButton = true;
	CCP.PlayerMenu.TopBar.Buttons[3].DoClick = function( self )
		
		for k,v in next, CCP.PlayerMenu.TopBar.Buttons do
		
			v.m_bIsDown = false;
			
		end
		self.m_bIsDown = true;
		CCP.PlayerMenu.ContentPane:Clear();
		GAMEMODE:PMCreateBusiness();
		
	end
	CCP.PlayerMenu.TopBar.Buttons[3]:PerformLayout();
	
	if !LocalPlayer():HasCharFlag("X") then
		CCP.PlayerMenu.TopBar.Buttons[3]:SetEnabled(false)
	end
	
	CCP.PlayerMenu.TopBar.Buttons[4] = vgui.Create( "DButton", CCP.PlayerMenu.TopBar );
	CCP.PlayerMenu.TopBar.Buttons[4]:SetFont( "STALKER.LabelMenu" );
	CCP.PlayerMenu.TopBar.Buttons[4]:SetText( "Settings" );
	CCP.PlayerMenu.TopBar.Buttons[4]:SetPos( 590, 10 );
	CCP.PlayerMenu.TopBar.Buttons[4]:SetSize( 188, 35 );
	CCP.PlayerMenu.TopBar.Buttons[4].m_bTitleButton = true;
	CCP.PlayerMenu.TopBar.Buttons[4].DoClick = function( self )
		
		for k,v in next, CCP.PlayerMenu.TopBar.Buttons do
		
			v.m_bIsDown = false;
			
		end
		self.m_bIsDown = true;
		CCP.PlayerMenu.ContentPane:Clear();
		GAMEMODE:PMCreateSettings();
		
	end
	CCP.PlayerMenu.TopBar.Buttons[4]:PerformLayout();
	
	CCP.PlayerMenu.ContentPane = vgui.Create( "DPanel", CCP.PlayerMenu );
	CCP.PlayerMenu.ContentPane:SetPos( 12, 80 );
	CCP.PlayerMenu.ContentPane:SetSize( 764, 370 );
	function CCP.PlayerMenu.ContentPane:Paint( w, h )
	
		// for debug
		--surface.SetDrawColor( 255, 255, 255, 255 );
		--surface.DrawOutlinedRect( 0, 0, w, h );
		
	end
	
	function CCP.PlayerMenu:OnClose()
   
        if( self.NameEdit and IsValid( self.NameEdit )) then
       
            self.NameEdit:Close();
            self.NameEdit = nil;
       
        end
       
        if( self.DescEdit and IsValid( self.DescEdit )) then
       
            self.DescEdit:Close();
            self.DescEdit = nil;
           
        end
       
        if( self.Title and IsValid( self.Title )) then
       
            self.Title:Close();
            self.Title = nil;
           
        end
   
    end
	
	self:PMCreateBio();
	
end

local allowedChars = [[abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890 -|+=.,\/;:_#]];

function GM:PMCreateNameEdit()
	
	CCP.PlayerMenu.NameEdit = vgui.Create( "DFrame" );
	CCP.PlayerMenu.NameEdit:SetSize( 300, 114 );
	CCP.PlayerMenu.NameEdit:Center();
	CCP.PlayerMenu.NameEdit:SetTitle( "Change Name" );
	CCP.PlayerMenu.NameEdit.lblTitle:SetFont( "CombineControl.Window" );
	CCP.PlayerMenu.NameEdit:MakePopup();
	CCP.PlayerMenu.NameEdit.PerformLayout = CCFramePerformLayout;
	CCP.PlayerMenu.NameEdit:PerformLayout();
	
	CCP.PlayerMenu.NameEdit.Label = vgui.Create( "DLabel", CCP.PlayerMenu.NameEdit );
	CCP.PlayerMenu.NameEdit.Label:SetText( string.len( LocalPlayer():RPName() ) .. "/" .. self.MaxNameLength );
	CCP.PlayerMenu.NameEdit.Label:SetPos( 10, 74 );
	CCP.PlayerMenu.NameEdit.Label:SetSize( 280, 30 );
	CCP.PlayerMenu.NameEdit.Label:SetFont( "CombineControl.LabelGiant" );
	CCP.PlayerMenu.NameEdit.Label:PerformLayout();
	
	CCP.PlayerMenu.NameEdit.Entry = vgui.Create( "DTextEntry", CCP.PlayerMenu.NameEdit );
	CCP.PlayerMenu.NameEdit.Entry:SetFont( "CombineControl.LabelBig" );
	CCP.PlayerMenu.NameEdit.Entry:SetPos( 10, 34 );
	CCP.PlayerMenu.NameEdit.Entry:SetSize( 280, 30 );
	CCP.PlayerMenu.NameEdit.Entry:PerformLayout();
	CCP.PlayerMenu.NameEdit.Entry:SetValue( LocalPlayer():RPName() );
	CCP.PlayerMenu.NameEdit.Entry:RequestFocus();
	CCP.PlayerMenu.NameEdit.Entry:SetCaretPos( string.len( CCP.PlayerMenu.NameEdit.Entry:GetValue() ) );
	function CCP.PlayerMenu.NameEdit.Entry:OnChange()
		
		if( CCP.PlayerMenu.NameEdit and CCP.PlayerMenu.NameEdit.Label ) then
			
			local val = self:GetValue();
			
			local col = Color( 200, 200, 200, 255 );
			
			if( string.len( string.Trim( val ) ) > GAMEMODE.MaxNameLength or string.len( string.Trim( val ) ) < GAMEMODE.MinNameLength ) then
				
				col = Color( 200, 0, 0, 255 );
				
			end
			
			CCP.PlayerMenu.NameEdit.Label:SetText( string.len( string.Trim( val ) ) .. "/" .. GAMEMODE.MaxNameLength );
			CCP.PlayerMenu.NameEdit.Label:SetTextColor( col );
			
		end
		
	end
	function CCP.PlayerMenu.NameEdit.Entry:AllowInput( val )
		
		if( !string.find( allowedChars, val, 1, true ) ) then
			
			return true
			
		end
		
		return false;
		
	end
	
	CCP.PlayerMenu.NameEdit.OK = vgui.Create( "DButton", CCP.PlayerMenu.NameEdit );
	CCP.PlayerMenu.NameEdit.OK:SetFont( "CombineControl.LabelSmall" );
	CCP.PlayerMenu.NameEdit.OK:SetText( "OK" );
	CCP.PlayerMenu.NameEdit.OK:SetPos( 240, 74 );
	CCP.PlayerMenu.NameEdit.OK:SetSize( 50, 30 );
	function CCP.PlayerMenu.NameEdit.OK:DoClick()
		
		local val = string.Trim( CCP.PlayerMenu.NameEdit.Entry:GetValue() );
		
		if( string.len( val ) <= GAMEMODE.MaxNameLength and string.len( val ) >= GAMEMODE.MinNameLength ) then
			
			if( !string.find( allowedChars, val, 1, true ) ) then
				
				CCP.PlayerMenu.NameEdit:Remove();
				
				if( CCP.PlayerMenu.CharacterName ) then
					
					CCP.PlayerMenu.CharacterName:SetText( val );
					
				end

				netstream.Start( "nChangeRPName", val );
				
			else
				
				LocalPlayer():Notify(nil, COLOR_ERR, "Error: Name cannot include '#', '~' or '%'.")
				
			end
			
		else
			
			LocalPlayer():Notify(nil, COLOR_ERR, "Error: Name must be between " .. GAMEMODE.MinNameLength .. " and " .. GAMEMODE.MaxNameLength .. " characters.")
			
		end
		
	end
	CCP.PlayerMenu.NameEdit.OK:PerformLayout();
	
	CCP.PlayerMenu.NameEdit.Entry.OnEnter = CCP.PlayerMenu.NameEdit.OK.DoClick;
	
end

function GM:PMCreateDescEdit()
	
	CCP.PlayerMenu.DescEdit = vgui.Create( "DFrame" );
	CCP.PlayerMenu.DescEdit:SetSize( 400, 304 );
	CCP.PlayerMenu.DescEdit:Center();
	CCP.PlayerMenu.DescEdit:SetTitle( "Change Description" );
	CCP.PlayerMenu.DescEdit.lblTitle:SetFont( "CombineControl.Window" );
	CCP.PlayerMenu.DescEdit:MakePopup();
	CCP.PlayerMenu.DescEdit.PerformLayout = CCFramePerformLayout;
	CCP.PlayerMenu.DescEdit:PerformLayout();
	
	CCP.PlayerMenu.DescEdit.Label = vgui.Create( "DLabel", CCP.PlayerMenu.DescEdit );
	CCP.PlayerMenu.DescEdit.Label:SetText( string.len( LocalPlayer():Description() ) .. "/" .. self.MaxDescLength );
	CCP.PlayerMenu.DescEdit.Label:SetPos( 10, 264 );
	CCP.PlayerMenu.DescEdit.Label:SetSize( 380, 30 );
	CCP.PlayerMenu.DescEdit.Label:SetFont( "CombineControl.LabelGiant" );
	CCP.PlayerMenu.DescEdit.Label:PerformLayout();
	
	CCP.PlayerMenu.DescEdit.Entry = vgui.Create( "DTextEntry", CCP.PlayerMenu.DescEdit );
	CCP.PlayerMenu.DescEdit.Entry:SetFont( "CombineControl.LabelSmall" );
	CCP.PlayerMenu.DescEdit.Entry:SetPos( 10, 34 );
	CCP.PlayerMenu.DescEdit.Entry:SetSize( 380, 220 );
	CCP.PlayerMenu.DescEdit.Entry:PerformLayout();
	CCP.PlayerMenu.DescEdit.Entry:SetValue( LocalPlayer():Description() );
	CCP.PlayerMenu.DescEdit.Entry:SetMultiline( true );
	CCP.PlayerMenu.DescEdit.Entry:RequestFocus();
	CCP.PlayerMenu.DescEdit.Entry:SetCaretPos( string.len( CCP.PlayerMenu.DescEdit.Entry:GetValue() ) );
	function CCP.PlayerMenu.DescEdit.Entry:OnChange()
		
		if( CCP.PlayerMenu.DescEdit.Label ) then
			
			local val = self:GetValue();
			
			local col = Color( 200, 200, 200, 255 );
			
			if( string.len( string.Trim( val ) ) > GAMEMODE.MaxDescLength ) then
				
				col = Color( 200, 0, 0, 255 );
				
			end
			
			CCP.PlayerMenu.DescEdit.Label:SetText( string.len( string.Trim( val ) ) .. "/" .. GAMEMODE.MaxDescLength );
			CCP.PlayerMenu.DescEdit.Label:SetTextColor( col );
			
		end
		
	end
	
	CCP.PlayerMenu.DescEdit.OK = vgui.Create( "DButton", CCP.PlayerMenu.DescEdit );
	CCP.PlayerMenu.DescEdit.OK:SetFont( "CombineControl.LabelSmall" );
	CCP.PlayerMenu.DescEdit.OK:SetText( "OK" );
	CCP.PlayerMenu.DescEdit.OK:SetPos( 340, 264 );
	CCP.PlayerMenu.DescEdit.OK:SetSize( 50, 30 );
	function CCP.PlayerMenu.DescEdit.OK:DoClick()
		
		local val = string.Trim( CCP.PlayerMenu.DescEdit.Entry:GetValue() );
		
		if( string.len( val ) <= GAMEMODE.MaxDescLength ) then
			
			CCP.PlayerMenu.DescEdit:Remove();
			
			if( CCP.PlayerMenu.CharacterDesc and CCP.PlayerMenu.CharacterDesc:IsValid() ) then
				
				CCP.PlayerMenu.CharacterDesc:SetText( val );
				
			end
			
			netstream.Start( "nChangeTitle", val );
			
		else
			
			LocalPlayer():Notify(nil, COLOR_ERR, "Error: Description must be less than " .. GAMEMODE.MaxDescLength .. " characters.")
			
		end
		
	end
	CCP.PlayerMenu.DescEdit.OK:PerformLayout();
	
	CCP.PlayerMenu.DescEdit.Entry.OnEnter = CCP.PlayerMenu.DescEdit.OK.DoClick;
	
end

function GM:PMCreateNotes()
	
	CCP.PlayerMenu.Notes = vgui.Create( "DFrame" );
	CCP.PlayerMenu.Notes:SetSize( 400, 304 );
	CCP.PlayerMenu.Notes:Center();
	CCP.PlayerMenu.Notes:SetTitle( "Notes" );
	CCP.PlayerMenu.Notes.lblTitle:SetFont( "CombineControl.Window" );
	CCP.PlayerMenu.Notes:MakePopup();
	CCP.PlayerMenu.Notes.PerformLayout = CCFramePerformLayout;
	CCP.PlayerMenu.Notes:PerformLayout();
	
	CCP.PlayerMenu.Notes.Entry = vgui.Create( "DTextEntry", CCP.PlayerMenu.Notes );
	CCP.PlayerMenu.Notes.Entry:SetFont( "CombineControl.LabelSmall" );
	CCP.PlayerMenu.Notes.Entry:SetPos( 10, 34 );
	CCP.PlayerMenu.Notes.Entry:SetSize( 380, 220 );
	CCP.PlayerMenu.Notes.Entry:PerformLayout();
	CCP.PlayerMenu.Notes.Entry:SetValue( cookie.GetString( "zc_notes_" .. LocalPlayer():CharID(), "" ) );
	CCP.PlayerMenu.Notes.Entry:SetMultiline( true );
	CCP.PlayerMenu.Notes.Entry:RequestFocus();
	CCP.PlayerMenu.Notes.Entry:SetCaretPos( string.len( CCP.PlayerMenu.Notes.Entry:GetValue() ) );
	
	CCP.PlayerMenu.Notes.OK = vgui.Create( "DButton", CCP.PlayerMenu.Notes );
	CCP.PlayerMenu.Notes.OK:SetFont( "CombineControl.LabelSmall" );
	CCP.PlayerMenu.Notes.OK:SetText( "OK" );
	CCP.PlayerMenu.Notes.OK:SetPos( 340, 264 );
	CCP.PlayerMenu.Notes.OK:SetSize( 50, 30 );
	function CCP.PlayerMenu.Notes.OK:DoClick()
		
		local val = string.Trim( CCP.PlayerMenu.Notes.Entry:GetValue() );
		
		CCP.PlayerMenu.Notes:Remove();
		
		cookie.Set( "zc_notes_" .. LocalPlayer():CharID(), val );
		
	end
	CCP.PlayerMenu.Notes.OK:PerformLayout();
	
	CCP.PlayerMenu.Notes.Entry.OnEnter = CCP.PlayerMenu.Notes.OK.DoClick;
	
end

function GM:PMCreateTitleEdit()
	
	CCP.PlayerMenu.Title = vgui.Create( "DFrame" );
	CCP.PlayerMenu.Title:SetSize( 400, 256 );
	CCP.PlayerMenu.Title:Center();
	CCP.PlayerMenu.Title:SetTitle( "Change Titles" );
	CCP.PlayerMenu.Title.lblTitle:SetFont( "CombineControl.Window" );
	CCP.PlayerMenu.Title:MakePopup();
	CCP.PlayerMenu.Title.PerformLayout = CCFramePerformLayout;
	CCP.PlayerMenu.Title:PerformLayout();
	
	CCP.PlayerMenu.Title.TitleOne = vgui.Create( "DLabel", CCP.PlayerMenu.Title );
	CCP.PlayerMenu.Title.TitleOne:SetText( "Title One" );
	CCP.PlayerMenu.Title.TitleOne:SetPos( 10, 24 );
	CCP.PlayerMenu.Title.TitleOne:SetSize( 380, 30 );
	CCP.PlayerMenu.Title.TitleOne:SetFont( "CombineControl.LabelGiant" );
	CCP.PlayerMenu.Title.TitleOne:PerformLayout();
	
	CCP.PlayerMenu.Title.TitleOneLabel = vgui.Create( "DLabel", CCP.PlayerMenu.Title );
	CCP.PlayerMenu.Title.TitleOneLabel:SetText( string.len( LocalPlayer():TitleOne() ) .. "/" .. 128 );
	CCP.PlayerMenu.Title.TitleOneLabel:SetPos( 320, 24 );
	CCP.PlayerMenu.Title.TitleOneLabel:SetSize( 380, 30 );
	CCP.PlayerMenu.Title.TitleOneLabel:SetFont( "CombineControl.LabelGiant" );
	CCP.PlayerMenu.Title.TitleOneLabel:PerformLayout();
	
	CCP.PlayerMenu.Title.TitleOneEntry = vgui.Create( "DTextEntry", CCP.PlayerMenu.Title );
	CCP.PlayerMenu.Title.TitleOneEntry:SetFont( "CombineControl.LabelSmall" );
	CCP.PlayerMenu.Title.TitleOneEntry:SetPos( 10, 50 );
	CCP.PlayerMenu.Title.TitleOneEntry:SetSize( 380, 64 );
	CCP.PlayerMenu.Title.TitleOneEntry:PerformLayout();
	CCP.PlayerMenu.Title.TitleOneEntry:SetValue( LocalPlayer():TitleOne() );
	CCP.PlayerMenu.Title.TitleOneEntry:SetMultiline( true );
	CCP.PlayerMenu.Title.TitleOneEntry:RequestFocus();
	CCP.PlayerMenu.Title.TitleOneEntry:SetCaretPos( string.len( CCP.PlayerMenu.Title.TitleOneEntry:GetValue() ) );
	function CCP.PlayerMenu.Title.TitleOneEntry:OnChange()
		
		if( CCP.PlayerMenu.Title.TitleOneLabel ) then
			
			local val = self:GetValue();
			
			local col = Color( 200, 200, 200, 255 );
			
			if( string.len( string.Trim( val ) ) > 128 ) then
				
				col = Color( 200, 0, 0, 255 );
				
			end
			
			CCP.PlayerMenu.Title.TitleOneLabel:SetText( string.len( string.Trim( val ) ) .. "/" .. 128 );
			CCP.PlayerMenu.Title.TitleOneLabel:SetTextColor( col );
			
		end
		
	end
	
	CCP.PlayerMenu.Title.TitleTwo = vgui.Create( "DLabel", CCP.PlayerMenu.Title );
	CCP.PlayerMenu.Title.TitleTwo:SetText( "Title Two" );
	CCP.PlayerMenu.Title.TitleTwo:SetPos( 10, 116 );
	CCP.PlayerMenu.Title.TitleTwo:SetSize( 380, 30 );
	CCP.PlayerMenu.Title.TitleTwo:SetFont( "CombineControl.LabelGiant" );
	CCP.PlayerMenu.Title.TitleTwo:PerformLayout();
	
	CCP.PlayerMenu.Title.TitleTwoLabel = vgui.Create( "DLabel", CCP.PlayerMenu.Title );
	CCP.PlayerMenu.Title.TitleTwoLabel:SetText( string.len( LocalPlayer():TitleTwo() ) .. "/" .. 128 );
	CCP.PlayerMenu.Title.TitleTwoLabel:SetPos( 320, 116 );
	CCP.PlayerMenu.Title.TitleTwoLabel:SetSize( 380, 30 );
	CCP.PlayerMenu.Title.TitleTwoLabel:SetFont( "CombineControl.LabelGiant" );
	CCP.PlayerMenu.Title.TitleTwoLabel:PerformLayout();
	
	CCP.PlayerMenu.Title.TitleTwoEntry = vgui.Create( "DTextEntry", CCP.PlayerMenu.Title );
	CCP.PlayerMenu.Title.TitleTwoEntry:SetFont( "CombineControl.LabelSmall" );
	CCP.PlayerMenu.Title.TitleTwoEntry:SetPos( 10, 142 );
	CCP.PlayerMenu.Title.TitleTwoEntry:SetSize( 380, 64 );
	CCP.PlayerMenu.Title.TitleTwoEntry:PerformLayout();
	CCP.PlayerMenu.Title.TitleTwoEntry:SetValue( LocalPlayer():TitleTwo() );
	CCP.PlayerMenu.Title.TitleTwoEntry:SetMultiline( true );
	CCP.PlayerMenu.Title.TitleTwoEntry:RequestFocus();
	CCP.PlayerMenu.Title.TitleTwoEntry:SetCaretPos( string.len( CCP.PlayerMenu.Title.TitleTwoEntry:GetValue() ) );
	function CCP.PlayerMenu.Title.TitleTwoEntry:OnChange()
		
		if( CCP.PlayerMenu.Title.TitleTwoLabel ) then
			
			local val = self:GetValue();
			
			local col = Color( 200, 200, 200, 255 );
			
			if( string.len( string.Trim( val ) ) > 128 ) then
				
				col = Color( 200, 0, 0, 255 );
				
			end
			
			CCP.PlayerMenu.Title.TitleTwoLabel:SetText( string.len( string.Trim( val ) ) .. "/" .. 128 );
			CCP.PlayerMenu.Title.TitleTwoLabel:SetTextColor( col );
			
		end
		
	end
	
	CCP.PlayerMenu.Title.OK = vgui.Create( "DButton", CCP.PlayerMenu.Title );
	CCP.PlayerMenu.Title.OK:SetFont( "CombineControl.LabelSmall" );
	CCP.PlayerMenu.Title.OK:SetText( "OK" );
	CCP.PlayerMenu.Title.OK:SetPos( 340, 216 );
	CCP.PlayerMenu.Title.OK:SetSize( 50, 30 );
	function CCP.PlayerMenu.Title.OK:DoClick()
		
		local val1 = string.Trim( CCP.PlayerMenu.Title.TitleOneEntry:GetValue() );
		local val2 = string.Trim( CCP.PlayerMenu.Title.TitleTwoEntry:GetValue() );
		
		if( string.len( val1 ) <= 128 and string.len( val2 ) <= 128 ) then
			
			CCP.PlayerMenu.Title:Remove();
			
			if( CCP.PlayerMenu.TitleOne and CCP.PlayerMenu.TitleOne:IsValid() ) then
				
				CCP.PlayerMenu.TitleOne:SetText( val1 );
				CCP.PlayerMenu.TitleOne:PerformLayout();
				
			end
			
			if( CCP.PlayerMenu.TitleTwo and CCP.PlayerMenu.TitleTwo:IsValid() ) then
			
				CCP.PlayerMenu.TitleTwo:SetText( val2 );
				CCP.PlayerMenu.TitleTwo:PerformLayout();
				
			end
			
			
			netstream.Start( "nChangeTitleOne", val1 );
			netstream.Start( "nChangeTitleTwo", val2 );
			
			CCP.PlayerMenu.TitleOne:PerformLayout();
			CCP.PlayerMenu.TitleTwo:PerformLayout();
			
		else
			
			LocalPlayer():Notify(nil, COLOR_ERR, "Error: Titles must be less than 128 characters.")
			
		end
		
	end
	CCP.PlayerMenu.Title.OK:PerformLayout();
	
	CCP.PlayerMenu.Title.TitleOneEntry.OnEnter = CCP.PlayerMenu.Title.OK.DoClick;
	CCP.PlayerMenu.Title.TitleTwoEntry.OnEnter = CCP.PlayerMenu.Title.OK.DoClick;

end
	
function GM:PMCreateBio()
	
	CCP.PlayerMenu.CharacterModel = vgui.Create( "CCharPanel", CCP.PlayerMenu.ContentPane );
	CCP.PlayerMenu.CharacterModel:SetPos( 2, 2 );
	CCP.PlayerMenu.CharacterModel:SetModel( LocalPlayer():GetModel() );
	CCP.PlayerMenu.CharacterModel.Entity:SetSkin( LocalPlayer():GetSkin() );
	for i = 0,  20 do
		CCP.PlayerMenu.CharacterModel.Entity:SetBodygroup( i, LocalPlayer():GetBodygroup( i ) );
		CCP.PlayerMenu.CharacterModel.Entity:SetSubMaterial( i, LocalPlayer():GetSubMaterial( i ) );
	end
	CCP.PlayerMenu.CharacterModel:SetSize( 216, 370 );
	CCP.PlayerMenu.CharacterModel:SetFOV( 30 );
	CCP.PlayerMenu.CharacterModel:SetCamPos( Vector( 50, 0, 56 ) );
	CCP.PlayerMenu.CharacterModel:SetLookAt( Vector( 0, 0, 56 ) );
	function CCP.PlayerMenu.CharacterModel:DoClick()
		
		self:StartScene( "scenes/expressions/citizen_angry_idle_01.vcd" );
		
	end
	function CCP.PlayerMenu.CharacterModel.Entity:GetPlayerColor()
		
		if( !LocalPlayer() or !LocalPlayer():IsValid() ) then return Vector( 1, 1, 1 ) end
		
		return LocalPlayer():GetPlayerColor();
		
	end
	if self.BonemergeBodies[LocalPlayer()] and IsValid(self.BonemergeBodies[LocalPlayer()]) then
		CCP.PlayerMenu.CharacterModel:InitializeModel(self.BonemergeBodies[LocalPlayer()]:GetModel(), CCP.PlayerMenu.CharacterModel.Entity)
	end
	for id,item in next, GAMEMODE.BonemergeItems do
		if item.Owner != LocalPlayer() then continue end
		if !item.Vars["Equipped"] then continue end
		local metaitem = GAMEMODE:GetItemByID(item.szClass)
		local mdl_str = metaitem.Bonemerge
		local scale
		
		if metaitem.AllowGender then
			if LocalPlayer():Gender() == GENDER_FEMALE then
				mdl_str = string.StripExtension(mdl_str).."_f.mdl"
			end
		elseif metaitem.ScaleForGender and LocalPlayer():Gender() == GENDER_FEMALE then
			scale = metaitem.ScaleForGender
		end
		
		local mdl = CCP.PlayerMenu.CharacterModel:InitializeModel(mdl_str,CCP.PlayerMenu.CharacterModel.Entity, scale)
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
	
	CCP.PlayerMenu.CharacterName = vgui.Create( "DLabel", CCP.PlayerMenu.ContentPane );
	CCP.PlayerMenu.CharacterName:SetText( LocalPlayer():RPName() );
	CCP.PlayerMenu.CharacterName:DockMargin( 220, 10, 0, 0 );
	CCP.PlayerMenu.CharacterName:Dock( TOP );
	CCP.PlayerMenu.CharacterName:SetSize( 540, 22 );
	CCP.PlayerMenu.CharacterName:SetFont( "CombineControl.LabelGiant" );
	CCP.PlayerMenu.CharacterName:PerformLayout();
	
	CCP.PlayerMenu.CharacterNameEdit = vgui.Create( "DButton", CCP.PlayerMenu.ContentPane );
	CCP.PlayerMenu.CharacterNameEdit:SetFont( "STALKER.LabelMenu" );
	CCP.PlayerMenu.CharacterNameEdit:SetText( "..." );
	CCP.PlayerMenu.CharacterNameEdit:SetPos( 740, 10 );
	CCP.PlayerMenu.CharacterNameEdit:SetSize( 20, 20 );
	function CCP.PlayerMenu.CharacterNameEdit:DoClick()
		
		GAMEMODE:PMCreateNameEdit();
		
	end
	CCP.PlayerMenu.CharacterNameEdit:PerformLayout();
	
	CCP.PlayerMenu.TitleOne = vgui.Create( "CCLabel", CCP.PlayerMenu.ContentPane );
	CCP.PlayerMenu.TitleOne:DockMargin( 220, 8, 0, 0 );
	CCP.PlayerMenu.TitleOne:Dock( TOP );
	CCP.PlayerMenu.TitleOne:SetSize( 510, 10 );
	CCP.PlayerMenu.TitleOne:SetFont( "CombineControl.LabelSmall" );
	CCP.PlayerMenu.TitleOne:SetText( LocalPlayer():TitleOne() );
	CCP.PlayerMenu.TitleOne:PerformLayout();
	
	CCP.PlayerMenu.TitleTwo = vgui.Create( "CCLabel", CCP.PlayerMenu.ContentPane );
	CCP.PlayerMenu.TitleTwo:DockMargin( 220, 2, 0, 0 );
	CCP.PlayerMenu.TitleTwo:Dock( TOP );
	CCP.PlayerMenu.TitleTwo:SetSize( 510, 10 );
	CCP.PlayerMenu.TitleTwo:SetFont( "CombineControl.LabelSmall" );
	CCP.PlayerMenu.TitleTwo:SetText( LocalPlayer():TitleTwo() );
	CCP.PlayerMenu.TitleTwo:PerformLayout();
	
	CCP.PlayerMenu.TitleEdit = vgui.Create( "DButton", CCP.PlayerMenu.ContentPane );
	CCP.PlayerMenu.TitleEdit:SetFont( "STALKER.LabelMenu" );
	CCP.PlayerMenu.TitleEdit:SetText( "..." );
	CCP.PlayerMenu.TitleEdit:SetPos( 740, 40 );
	CCP.PlayerMenu.TitleEdit:SetSize( 20, 20 );
	function CCP.PlayerMenu.TitleEdit:DoClick()
		
		GAMEMODE:PMCreateTitleEdit();
		
	end
	CCP.PlayerMenu.TitleEdit:PerformLayout();
	
	CCP.PlayerMenu.CharacterDescScroll = vgui.Create( "DScrollPanel", CCP.PlayerMenu.ContentPane );
	CCP.PlayerMenu.CharacterDescScroll:DockMargin( 220, 14, 0, 0 );
	CCP.PlayerMenu.CharacterDescScroll:Dock( TOP );
	CCP.PlayerMenu.CharacterDescScroll:SetSize( 540, 376 );
	function CCP.PlayerMenu.CharacterDescScroll:Paint( w, h ) end
	
	CCP.PlayerMenu.CharacterDesc = vgui.Create( "CCLabel" );
	CCP.PlayerMenu.CharacterDesc:SetPos( 0, 0 );
	CCP.PlayerMenu.CharacterDesc:SetSize( 530, 10 );
	CCP.PlayerMenu.CharacterDesc:SetFont( "CombineControl.LabelSmall" );
	CCP.PlayerMenu.CharacterDesc:SetText( LocalPlayer():Description() );
	CCP.PlayerMenu.CharacterDesc:PerformLayout();
	
	CCP.PlayerMenu.CharacterDescScroll:AddItem( CCP.PlayerMenu.CharacterDesc );
	
	CCP.PlayerMenu.CharacterDescEdit = vgui.Create( "DButton", CCP.PlayerMenu.ContentPane );
	CCP.PlayerMenu.CharacterDescEdit:SetFont( "STALKER.LabelMenu" );
	CCP.PlayerMenu.CharacterDescEdit:SetText( "..." );
	CCP.PlayerMenu.CharacterDescEdit:SetPos( 740, 80 );
	CCP.PlayerMenu.CharacterDescEdit:SetSize( 20, 20 );
	function CCP.PlayerMenu.CharacterDescEdit:DoClick()
		
		GAMEMODE:PMCreateDescEdit();
		
	end
	CCP.PlayerMenu.CharacterDescEdit:PerformLayout();
	
	local traits = { };
	
	for _, v in pairs( self.TraitsList ) do
		
		if( LocalPlayer():HasTrait( v ) ) then
			
			table.insert( traits, self.Traits[v][1] );
			
		end
		
	end
	
	CCP.PlayerMenu.CharacterTrait = vgui.Create( "DLabel", CCP.PlayerMenu.ContentPane );
	CCP.PlayerMenu.CharacterTrait:SetText( "Traits: " .. table.concat( traits, ", " ) );
	CCP.PlayerMenu.CharacterTrait:SetPos( 220, 350 );
	CCP.PlayerMenu.CharacterTrait:SetFont( "CombineControl.LabelSmall" );
	CCP.PlayerMenu.CharacterTrait:SizeToContents();
	CCP.PlayerMenu.CharacterTrait:PerformLayout();
	
	CCP.PlayerMenu.CharacterRubles = vgui.Create( "DLabel", CCP.PlayerMenu.ContentPane );
	CCP.PlayerMenu.CharacterRubles:SetText( LocalPlayer():Money().." RU" );
	CCP.PlayerMenu.CharacterRubles:SetPos( 420, 350 );
	CCP.PlayerMenu.CharacterRubles:SetFont( "CombineControl.LabelSmall" );
	CCP.PlayerMenu.CharacterRubles:SizeToContents();
	CCP.PlayerMenu.CharacterRubles:PerformLayout();
	
	CCP.PlayerMenu.CharacterNotes = vgui.Create( "DButton", CCP.PlayerMenu.ContentPane );
	CCP.PlayerMenu.CharacterNotes:SetFont( "STALKER.LabelMenu" );
	CCP.PlayerMenu.CharacterNotes:SetText( "Notes" );
	CCP.PlayerMenu.CharacterNotes:SetPos( 680, 346 );
	CCP.PlayerMenu.CharacterNotes:SetSize( 80, 20 );
	function CCP.PlayerMenu.CharacterNotes:DoClick()
		
		GAMEMODE:PMCreateNotes();
		
	end
	CCP.PlayerMenu.CharacterNotes:PerformLayout();
	
end

function GM:PMPopulateBusiness()
	
	CCP.PlayerMenu.BusinessPane:Clear();
	local y = 0;
	
	local items_to_list = {}
	for k, v in SortedPairs( self.Items ) do
		local price = hook.Run("GetBuyPrice", LocalPlayer(), k)

		if !price or price == 0 then continue end
		if !v.License then continue end
		if !LocalPlayer():HasCharFlag(v.License) then continue end

		items_to_list[#items_to_list+1] = k
	end
	
	CCP.PlayerMenu.BusinessPane.NextThink = CurTime()
	CCP.PlayerMenu.BusinessPane.CurrentItem = 1
	
	hook.Add("Think", "PopulateBusinessMenu", function()
		if !CCP.PlayerMenu.BusinessPane or !CCP.PlayerMenu.BusinessPane:IsValid() then
			hook.Remove("Think", "PopulateBusinessMenu")
			return
		end
	
		if !CCP.PlayerMenu.BusinessPane.CurrentItem then
			CCP.PlayerMenu.BusinessPane.CurrentItem = 1
		end
		
		local item = items_to_list[CCP.PlayerMenu.BusinessPane.CurrentItem]
		local metaitem = GAMEMODE:GetItemByID(item)
		if metaitem then
			
			local itempane = vgui.Create( "DPanel" );
			itempane:SetPos( 0, y );
			itempane.ItemName = metaitem.Name
			itempane:SetSize( 556, 64 );
			itempane:SetSkin( "STALKER" );
			function itempane:Paint( w, h )
				
				surface.SetDrawColor( 0, 0, 0, 70 );
				surface.DrawRect( 0, 0, w, h );
				
				surface.SetDrawColor( 0, 0, 0, 100 );
				surface.DrawOutlinedRect( 0, 0, w, h );
				
			end
			
			local icon = vgui.Create( "DModelPanel", itempane );
			icon:SetPos( 0, 0 );
			icon:SetModel( metaitem.Model );
			if( metaitem.ItemSubmaterials ) then for m,n in next, metaitem.ItemSubmaterials do icon.Entity:SetSubMaterial( n[1], n[2] ) end end
			icon:SetSize( 64, 64 );
			
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
			
			local p = icon.Paint;
			
			function icon:Paint( w, h )
				
				local pnl = CCP.PlayerMenu.BusinessPane;
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
			
			surface.SetFont( "CombineControl.LabelSmall" );
			local tW, tH = surface.GetTextSize( metaitem.Name );
			
			local d, n = GAMEMODE:FormatLine( metaitem.Desc, "CombineControl.LabelTiny", 396 );
			
			local desc = vgui.Create( "DLabel", itempane );
			desc:SetText( d );
			desc:SetPos( 74, 24 );
			desc:SetFont( "CombineControl.LabelTiny" );
			desc:SizeToContents();
			desc:PerformLayout();

			local singlePrice = hook.Run("GetBuyPrice", LocalPlayer(), item, true)
			local bulkPrice = hook.Run("GetBuyPrice", LocalPlayer(), item)

			local price = vgui.Create( "DLabel", itempane );
			price:SetText( "1 for " .. singlePrice .. " rubles" );
			price:SetPos( 74 + tW + 20, 10 );
			price:SetFont( "CombineControl.LabelTiny" );
			price:SizeToContents();
			price:PerformLayout();
			
			local price = vgui.Create( "DLabel", itempane );
			price:SetText( "5 for " .. bulkPrice .. " rubles" );
			price:SetPos( 74 + tW + 120, 10 );
			price:SetFont( "CombineControl.LabelTiny" );
			price:SizeToContents();
			price:PerformLayout();
			
			local buyone = vgui.Create( "DButton", itempane );
			buyone:SetFont( "CombineControl.LabelSmall" );
			buyone:SetText( "Buy 1" );
			buyone:SetPos( 480, 6 );
			buyone:SetSize( 46, 24 );
			function buyone:DoClick()

				if( LocalPlayer():Money() >= singlePrice ) then
					
					if( LocalPlayer():InventoryWeight() < LocalPlayer():InventoryMaxWeight() ) then
						
						netstream.Start( "nBuyItem", item, true );
						
						LocalPlayer():Notify(nil, Color(200,200,200,255), "You bought one.")
						
					else
						
						LocalPlayer():Notify(nil, COLOR_ERR, "Your inventory is full. You can't carry this.")
						
					end
					
				else
					
					LocalPlayer():Notify(nil, COLOR_ERR, "You need more money to buy this!")
					
				end
				
			end
			buyone:PerformLayout();
			
			local buyfive = vgui.Create( "DButton", itempane );
			buyfive:SetFont( "CombineControl.LabelSmall" );
			buyfive:SetText( "Buy 5" );
			buyfive:SetPos( 480, 32 );
			buyfive:SetSize( 46, 24 );
			function buyfive:DoClick()

				if( LocalPlayer():Money() >= bulkPrice ) then
					
					if( LocalPlayer():InventoryWeight() < LocalPlayer():InventoryMaxWeight() ) then
						
						netstream.Start( "nBuyItem", item, false );
						
						LocalPlayer():Notify(nil, Color(200,200,200,255), "You bought five.")
						
					else
						
						LocalPlayer():Notify(nil, COLOR_ERR, "Your inventory is full. You can't carry this.")
						
					end
					
				else
					
					LocalPlayer():Notify(nil, COLOR_ERR, "You need more money to buy this!")
					
				end
				
			end
			buyfive:PerformLayout();
			
			CCP.PlayerMenu.BusinessPane:Add( itempane );
			
			y = y + 64;
		end
		
		if CCP.PlayerMenu.BusinessPane.CurrentItem == #items_to_list then
			hook.Remove("Think", "PopulateBusinessMenu")
			CCP.PlayerMenu.BusinessPane.NextThink = nil
			CCP.PlayerMenu.BusinessPane.CurrentItem = nil
			CCP.PlayerMenu.BusinessPane.IsGenerating = nil
			return
		end
		
		CCP.PlayerMenu.BusinessPane.CurrentItem = CCP.PlayerMenu.BusinessPane.CurrentItem + 1
		CCP.PlayerMenu.BusinessPane.IsGenerating = true
	end)
	
end

function nPopulateBusiness()
	
	GAMEMODE:PMPopulateBusiness();
	
end
netstream.Hook( "nPopulateBusiness", nPopulateBusiness );

function GM:PMResetStockpileText()
	
	if( CCP.StockpileMenu.InvButtons ) then
		
		for _, v in pairs( CCP.StockpileMenu.InvButtons ) do
			
			v:Remove();
			
		end
		
	end
	
	if( !CCP.StockpileMenu.InvModel or !CCP.StockpileMenu.InvTitle or !CCP.StockpileMenu.InvWeight or !CCP.StockpileMenu.InvDesc ) then return end
	
	CCP.StockpileMenu.InvModel:SetModel( "" );
	CCP.StockpileMenu.InvTitle:SetText( "" );
	CCP.StockpileMenu.InvWeight:SetText( "" );
	CCP.StockpileMenu.InvDesc:SetText( "No item selected." );
	
end

function GM:PMCreateStockpilesMenu()

	CCP.StockpilesMenu = vgui.Create( "DFrame" );
	CCP.StockpilesMenu:SetSize( 220, 500 );
	CCP.StockpilesMenu:Center();
	CCP.StockpilesMenu:SetTitle( "Stockpiles" );
	CCP.StockpilesMenu.lblTitle:SetFont( "CombineControl.Window" );
	CCP.StockpilesMenu:MakePopup();
	CCP.StockpilesMenu.PerformLayout = CCFramePerformLayout;
	CCP.StockpilesMenu:PerformLayout();

end

function GM:PopulateMoveToStock( tbl )

	local y = 30;

	for k,v in next, tbl do
	
		CCP.StockpilesMenu.Stockpile = {};
		CCP.StockpilesMenu.Stockpile[k] = vgui.Create( "DButton", CCP.StockpilesMenu );
		CCP.StockpilesMenu.Stockpile[k]:SetFont( "CombineControl.LabelSmall" );
		CCP.StockpilesMenu.Stockpile[k]:SetText( v.Name );
		CCP.StockpilesMenu.Stockpile[k]:SetPos( 10, y );
		CCP.StockpilesMenu.Stockpile[k]:SetSize( 200, 20 );
		CCP.StockpilesMenu.Stockpile[k].DoClick = function( self )

			LocalPlayer():MoveToStockpile( GAMEMODE.Inventory.SelectedItem:GetID(), k );
			CCP.StockpilesMenu:Close();
			
		end
		CCP.StockpilesMenu.Stockpile[k]:PerformLayout()
		
		y = y + 26;
	
	end

end

local function nPopulateMoveToStock( inv )
	
	GAMEMODE:PopulateMoveToStock( inv );

end
netstream.Hook( "nPopulateMoveToStock", nPopulateMoveToStock );

local function nPopulateStockpile(items, id)
	GAMEMODE:PMCreateStockpile();
	GAMEMODE:PopulateStockpile(items, id);
	
	if CCP.StockpilesMenu and CCP.StockpilesMenu:IsValid() then
		CCP.StockpilesMenu:Close();
	end
end
netstream.Hook("nPopulateStockpile", nPopulateStockpile)

function GM:PopulateStockpilesMenu( tbl )

	local y = 30;

	for k,v in next, tbl do
	
		CCP.StockpilesMenu.Stockpile = {};
		CCP.StockpilesMenu.Stockpile[k] = vgui.Create( "DButton", CCP.StockpilesMenu );
		CCP.StockpilesMenu.Stockpile[k]:SetFont( "CombineControl.LabelSmall" );
		CCP.StockpilesMenu.Stockpile[k]:SetText( v.Name );
		CCP.StockpilesMenu.Stockpile[k]:SetPos( 10, y );
		CCP.StockpilesMenu.Stockpile[k]:SetSize( 200, 20 );
		CCP.StockpilesMenu.Stockpile[k].DoClick = function( self )
			netstream.Start("nPopulateStockpile", k)
		end
		CCP.StockpilesMenu.Stockpile[k]:PerformLayout()
		
		y = y + 26;
	
	end

end

function GM:PMCreateStockpile()

	CCP.StockpileMenu = vgui.Create( "DFrame" );
	CCP.StockpileMenu:SetSize( 800, 500 );
	CCP.StockpileMenu:Center();
	CCP.StockpileMenu:SetTitle( "Stockpile Menu" );
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

end

function GM:PopulateStockpile( tbl, id )

	local x = 0;
	local y = 0;
	local inv = table.Copy( tbl );
	
	CCP.StockpileMenu.InvButtons = {};
	CCP.StockpileMenu.ID = id;

	for k,v in next, inv do
	
		local i = GAMEMODE:GetItemByID( v.ItemClass );
		local vars = util.JSONToTable(v.Vars)
		
		if( i ) then
			
			local icon = vgui.Create( "DModelPanel", CCP.StockpileMenu.InvScroll );
			icon.Item = v.ItemClass;
			icon.InventoryID = v.id;
			
			icon:SetPos( x, y );
			icon:SetModel( vars.Model or i.Model );
			if( i.ItemSubmaterials ) then for m,n in next, i.ItemSubmaterials do icon.Entity:SetSubMaterial( n[1], n[2] ) end end
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
					
					LocalPlayer():TakeFromStockpile( self.InventoryID, CCP.StockpileMenu.ID );
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

local function nPopulateStockpilesMenu( inv )
	
	GAMEMODE:PopulateStockpilesMenu( inv );
	
end
netstream.Hook( "nPopulateStockpilesMenu", nPopulateStockpilesMenu );

local function nOpenStockpilesMenu()

	GAMEMODE:PMCreateStockpilesMenu();
	
	netstream.Start( "nRequestStockpiles" );

end
netstream.Hook( "nOpenStockpilesMenu", nOpenStockpilesMenu );

function GM:PMCreateBusiness()
	
	local y = CCP.PlayerMenu.ContentPane:GetTall() - 30;
	
	CCP.PlayerMenu.BusinessLicenses = { };
	
	if( InStockpileRange( LocalPlayer() ) ) then
	
		CCP.PlayerMenu.Stockpile = vgui.Create( "DButton", CCP.PlayerMenu.ContentPane );
		CCP.PlayerMenu.Stockpile:SetFont( "CombineControl.LabelSmall" );
		CCP.PlayerMenu.Stockpile:SetText( "Stockpile" );
		CCP.PlayerMenu.Stockpile:SetPos( 10, y );
		CCP.PlayerMenu.Stockpile:SetSize( 200, 20 );
		CCP.PlayerMenu.Stockpile.DoClick = function( self )
			
			GAMEMODE:PMCreateStockpilesMenu();

			netstream.Start( "nRequestStockpiles" );
			
		end
		CCP.PlayerMenu.Stockpile:PerformLayout()
	
	end
	
	local function PMBusinessFilter(str)
	
		local BusinessPanel = CCP.PlayerMenu.BusinessPane:GetChild(0); -- DScrollPanel consists of two panels by default: 0 - DPanel, 1 - ScrollBar.
		local ItemArr = BusinessPanel:GetChildren();
		
		for k, pnl in ipairs(ItemArr) do
			
			local ItemName = pnl.ItemName
			if str == "" or ItemName:lower():find(str:lower()) then
			
				pnl:Show();
				
			else
			
				pnl:Hide();
				
			end
			
		end
		
		local y = 0 -- reset panel positions
		for k, pnl in ipairs(ItemArr) do
			
			if pnl:IsVisible() then
				
				pnl:SetPos(0, y);
				y = y + 64;

			end
		
		end		
		
	end
	
	CCP.PlayerMenu.BusinessPane = vgui.Create( "DScrollPanel", CCP.PlayerMenu.ContentPane );
	CCP.PlayerMenu.BusinessPane:SetSize( 560, 370 );
	CCP.PlayerMenu.BusinessPane:SetPos( 220, 10 );
	CCP.PlayerMenu.BusinessPane.IsGenerating = false
	function CCP.PlayerMenu.BusinessPane:Paint( w, h )
		
		surface.SetDrawColor( 30, 30, 30, 255 );
		surface.DrawRect( 0, 0, w, h );
		
		surface.SetDrawColor( 20, 20, 20, 100 );
		surface.DrawOutlinedRect( 0, 0, w, h );
		
	end
	
	CCP.PlayerMenu.BusinessSearch = vgui.Create( "DTextEntry", CCP.PlayerMenu.ContentPane );
	CCP.PlayerMenu.BusinessSearch:SetPos( 10, 10 );
	CCP.PlayerMenu.BusinessSearch:SetSize( 200, 25 )
	CCP.PlayerMenu.BusinessSearch:SetText( "Search" )
	CCP.PlayerMenu.BusinessSearch:SetDisabled(true)
	CCP.PlayerMenu.BusinessSearch.OnEnter = function( self )
	
		PMBusinessFilter(self:GetValue());
		
	end
	CCP.PlayerMenu.BusinessSearch.Think = function( self )
		if !self.LastState and CCP.PlayerMenu.BusinessPane.IsGenerating then
			self:SetText("List is populating, please wait.")
		elseif self.LastState and !CCP.PlayerMenu.BusinessPane.IsGenerating then
			self:SetText("Search")
			self:SetDisabled(false)
		end
		
		self.LastState = CCP.PlayerMenu.BusinessPane.IsGenerating;
	end
	
	GAMEMODE:PMPopulateBusiness();
	
end

function GM:PMCreatePDANameEdit( item )
	
	CCP.PDANameEdit = vgui.Create( "DFrame" );
	CCP.PDANameEdit:SetSize( 300, 114 );
	CCP.PDANameEdit:Center();
	CCP.PDANameEdit:SetTitle( "Change PDA Name" );
	CCP.PDANameEdit.lblTitle:SetFont( "CombineControl.Window" );
	CCP.PDANameEdit:MakePopup();
	CCP.PDANameEdit.PerformLayout = CCFramePerformLayout;
	CCP.PDANameEdit:PerformLayout();
	
	CCP.PDANameEdit.Label = vgui.Create( "DLabel", CCP.PDANameEdit );
	CCP.PDANameEdit.Label:SetText( string.len( item:GetVar("Name", "") ) .. "/" .. self.MaxNameLength );
	CCP.PDANameEdit.Label:SetPos( 10, 74 );
	CCP.PDANameEdit.Label:SetSize( 280, 30 );
	CCP.PDANameEdit.Label:SetFont( "CombineControl.LabelGiant" );
	CCP.PDANameEdit.Label:PerformLayout();
	
	CCP.PDANameEdit.Entry = vgui.Create( "DTextEntry", CCP.PDANameEdit );
	CCP.PDANameEdit.Entry:SetFont( "CombineControl.LabelBig" );
	CCP.PDANameEdit.Entry:SetPos( 10, 34 );
	CCP.PDANameEdit.Entry:SetSize( 280, 30 );
	CCP.PDANameEdit.Entry:PerformLayout();
	CCP.PDANameEdit.Entry:SetValue( item:GetVar("Name", "") );
	CCP.PDANameEdit.Entry:RequestFocus();
	CCP.PDANameEdit.Entry:SetCaretPos( string.len( CCP.PDANameEdit.Entry:GetValue() ) );
	function CCP.PDANameEdit.Entry:OnChange()
		
		if( CCP.PDANameEdit and CCP.PDANameEdit.Label ) then
			
			local val = self:GetValue();
			
			local col = Color( 200, 200, 200, 255 );
			
			if( string.len( string.Trim( val ) ) > GAMEMODE.MaxNameLength or string.len( string.Trim( val ) ) < GAMEMODE.MinNameLength ) then
				
				col = Color( 200, 0, 0, 255 );
				
			end
			
			CCP.PDANameEdit.Label:SetText( string.len( string.Trim( val ) ) .. "/" .. GAMEMODE.MaxNameLength );
			CCP.PDANameEdit.Label:SetTextColor( col );
			
		end
		
	end
	function CCP.PDANameEdit.Entry:AllowInput( val )
		
		if( !string.find( allowedChars, val, 1, true ) ) then
			
			return true
			
		end
		
		return false;
		
	end
	
	CCP.PDANameEdit.OK = vgui.Create( "DButton", CCP.PDANameEdit );
	CCP.PDANameEdit.OK:SetFont( "CombineControl.LabelSmall" );
	CCP.PDANameEdit.OK:SetText( "OK" );
	CCP.PDANameEdit.OK:SetPos( 240, 74 );
	CCP.PDANameEdit.OK:SetSize( 50, 30 );
	function CCP.PDANameEdit.OK:DoClick()
		
		local val = string.Trim( CCP.PDANameEdit.Entry:GetValue() );
		
		if( string.len( val ) <= GAMEMODE.MaxNameLength and string.len( val ) >= GAMEMODE.MinNameLength ) then
			
			if( !string.find( allowedChars, val, 1, true ) ) then
				
				CCP.PDANameEdit:Remove();

				netstream.Start( "nChangePDAName", val, item:GetID() );
				
			else
				
				LocalPlayer():Notify(nil, COLOR_ERR, "Error: Name cannot include '#', '~' or '%'.")
				
			end
			
		else
			
			LocalPlayer():Notify(nil, COLOR_ERR, "Error: Name must be between " .. GAMEMODE.MinNameLength .. " and " .. GAMEMODE.MaxNameLength .. " characters.")
			
		end
		
	end
	CCP.PDANameEdit.OK:PerformLayout();
	
	CCP.PDANameEdit.Entry.OnEnter = CCP.PDANameEdit.OK.DoClick;
	
end

function GM:PMCreateSettings()
	
	CCP.PlayerMenu.SettingsMusicL = vgui.Create( "DLabel", CCP.PlayerMenu.ContentPane );
	CCP.PlayerMenu.SettingsMusicL:SetText( "Music Enabled" );
	CCP.PlayerMenu.SettingsMusicL:SetPos( 10, 10 );
	CCP.PlayerMenu.SettingsMusicL:SetFont( "CombineControl.LabelSmall" );
	CCP.PlayerMenu.SettingsMusicL:SizeToContents();
	CCP.PlayerMenu.SettingsMusicL:PerformLayout();
	
	CCP.PlayerMenu.SettingsMusic = vgui.Create( "DCheckBoxLabel", CCP.PlayerMenu.ContentPane );
	CCP.PlayerMenu.SettingsMusic:SetText( "" );
	CCP.PlayerMenu.SettingsMusic:SetPos( 150, 10 );
	CCP.PlayerMenu.SettingsMusic:SetValue( cookie.GetNumber( "zc_music", 1 ) );
	CCP.PlayerMenu.SettingsMusic:PerformLayout();
	function CCP.PlayerMenu.SettingsMusic:OnChange( val )
		
		cookie.Set( "zc_music", val and 1 or 0 );
		
		if( !val ) then
			
			GAMEMODE:FadeOutMusic( 1 );
			
		end
		
	end
	
	CCP.PlayerMenu.SettingsHUDL = vgui.Create( "DLabel", CCP.PlayerMenu.ContentPane );
	CCP.PlayerMenu.SettingsHUDL:SetText( "HUD Enabled" );
	CCP.PlayerMenu.SettingsHUDL:SetPos( 10, 40 );
	CCP.PlayerMenu.SettingsHUDL:SetFont( "CombineControl.LabelSmall" );
	CCP.PlayerMenu.SettingsHUDL:SizeToContents();
	CCP.PlayerMenu.SettingsHUDL:PerformLayout();
	
	CCP.PlayerMenu.SettingsHUD = vgui.Create( "DCheckBoxLabel", CCP.PlayerMenu.ContentPane );
	CCP.PlayerMenu.SettingsHUD:SetText( "" );
	CCP.PlayerMenu.SettingsHUD:SetPos( 150, 40 );
	CCP.PlayerMenu.SettingsHUD:SetValue( cookie.GetNumber( "zc_hud", 1 ) );
	CCP.PlayerMenu.SettingsHUD:PerformLayout();
	function CCP.PlayerMenu.SettingsHUD:OnChange( val )
		
		cookie.Set( "zc_hud", val and 1 or 0 );
		
	end
	
	CCP.PlayerMenu.SettingsHUD:PerformLayout();
	CCP.PlayerMenu.SettingsHUD:SizeToContents();
	
	CCP.PlayerMenu.SettingsChatL = vgui.Create( "DLabel", CCP.PlayerMenu.ContentPane );
	CCP.PlayerMenu.SettingsChatL:SetText( "HUD Chat Enabled" );
	CCP.PlayerMenu.SettingsChatL:SetPos( 10, 70 );
	CCP.PlayerMenu.SettingsChatL:SetFont( "CombineControl.LabelSmall" );
	CCP.PlayerMenu.SettingsChatL:SizeToContents();
	CCP.PlayerMenu.SettingsChatL:PerformLayout();
	
	CCP.PlayerMenu.SettingsChat = vgui.Create( "DCheckBoxLabel", CCP.PlayerMenu.ContentPane );
	CCP.PlayerMenu.SettingsChat:SetText( "" );
	CCP.PlayerMenu.SettingsChat:SetPos( 150, 70 );
	CCP.PlayerMenu.SettingsChat:SetValue( cookie.GetNumber( "zc_chat", 1 ) );
	CCP.PlayerMenu.SettingsChat:PerformLayout();
	function CCP.PlayerMenu.SettingsChat:OnChange( val )
		
		cookie.Set( "zc_chat", val and 1 or 0 );
		
	end
	
	CCP.PlayerMenu.SettingsChat:PerformLayout();
	CCP.PlayerMenu.SettingsChat:SizeToContents();
	
	CCP.PlayerMenu.SettingsNewbieL = vgui.Create( "DLabel", CCP.PlayerMenu.ContentPane );
	CCP.PlayerMenu.SettingsNewbieL:SetText( "Mark me as an inexperienced roleplayer" );
	CCP.PlayerMenu.SettingsNewbieL:SetPos( 200, 10 );
	CCP.PlayerMenu.SettingsNewbieL:SetFont( "CombineControl.LabelSmall" );
	CCP.PlayerMenu.SettingsNewbieL:SizeToContents();
	CCP.PlayerMenu.SettingsNewbieL:PerformLayout();
	
	CCP.PlayerMenu.SettingsNewbie = vgui.Create( "DCheckBoxLabel", CCP.PlayerMenu.ContentPane );
	CCP.PlayerMenu.SettingsNewbie:SetText( "" );
	CCP.PlayerMenu.SettingsNewbie:SetPos( 420, 10 );
	CCP.PlayerMenu.SettingsNewbie:SetValue( LocalPlayer():NewbieStatus() == NEWBIE_STATUS_NEW );
	CCP.PlayerMenu.SettingsNewbie:PerformLayout();
	function CCP.PlayerMenu.SettingsNewbie:OnChange( val )
		
		netstream.Start( "nSetNewbieStatus", val );
		
	end
	
	CCP.PlayerMenu.SettingsNewbie:PerformLayout();
	CCP.PlayerMenu.SettingsNewbie:SizeToContents();
	
	CCP.PlayerMenu.SettingsPDAL = vgui.Create( "DLabel", CCP.PlayerMenu.ContentPane );
	CCP.PlayerMenu.SettingsPDAL:SetText( "PDA Sounds Enabled" );
	CCP.PlayerMenu.SettingsPDAL:SetPos( 200, 40 );
	CCP.PlayerMenu.SettingsPDAL:SetFont( "CombineControl.LabelSmall" );
	CCP.PlayerMenu.SettingsPDAL:SizeToContents();
	CCP.PlayerMenu.SettingsPDAL:PerformLayout();
	
	CCP.PlayerMenu.SettingsPDA = vgui.Create( "DCheckBoxLabel", CCP.PlayerMenu.ContentPane );
	CCP.PlayerMenu.SettingsPDA:SetText( "" );
	CCP.PlayerMenu.SettingsPDA:SetPos( 420, 40 );
	CCP.PlayerMenu.SettingsPDA:SetValue( cookie.GetNumber( "zc_pdasound", 1 ) );
	CCP.PlayerMenu.SettingsPDA:PerformLayout();
	function CCP.PlayerMenu.SettingsPDA:OnChange( val )
		
		cookie.Set( "zc_pdasound", val and 1 or 0 );
		
	end
	
	CCP.PlayerMenu.SettingsPDA:PerformLayout();
	CCP.PlayerMenu.SettingsPDA:SizeToContents();
	
	CCP.PlayerMenu.SettingsCursorL = vgui.Create( "DLabel", CCP.PlayerMenu.ContentPane );
	CCP.PlayerMenu.SettingsCursorL:SetText( "STALKER Style Cursor" );
	CCP.PlayerMenu.SettingsCursorL:SetPos( 200, 70 );
	CCP.PlayerMenu.SettingsCursorL:SetFont( "CombineControl.LabelSmall" );
	CCP.PlayerMenu.SettingsCursorL:SizeToContents();
	CCP.PlayerMenu.SettingsCursorL:PerformLayout();
	
	CCP.PlayerMenu.SettingsCursor = vgui.Create( "DCheckBoxLabel", CCP.PlayerMenu.ContentPane );
	CCP.PlayerMenu.SettingsCursor:SetText( "" );
	CCP.PlayerMenu.SettingsCursor:SetPos( 420, 70 );
	CCP.PlayerMenu.SettingsCursor:SetValue( cookie.GetNumber( "zc_cursor", 0 ) );
	CCP.PlayerMenu.SettingsCursor:PerformLayout();
	function CCP.PlayerMenu.SettingsCursor:OnChange( val )
	
		cookie.Set( "zc_cursor", val and 1 or 0 );
		
		if !val then
			GAMEMODE:DisableCursor()
		else
			GAMEMODE:CreateCursor()
		end
		
	end
	
	CCP.PlayerMenu.SettingsCursor:PerformLayout();
	CCP.PlayerMenu.SettingsCursor:SizeToContents();
	
	CCP.PlayerMenu.SettingsThirdL = vgui.Create( "DLabel", CCP.PlayerMenu.ContentPane );
	CCP.PlayerMenu.SettingsThirdL:SetText( "Thirdperson Enabled" );
	CCP.PlayerMenu.SettingsThirdL:SetPos( 470, 10 );
	CCP.PlayerMenu.SettingsThirdL:SetFont( "CombineControl.LabelSmall" );
	CCP.PlayerMenu.SettingsThirdL:SizeToContents();
	CCP.PlayerMenu.SettingsThirdL:PerformLayout();
	
	CCP.PlayerMenu.SettingsThird = vgui.Create( "DCheckBoxLabel", CCP.PlayerMenu.ContentPane );
	CCP.PlayerMenu.SettingsThird:SetText( "" );
	CCP.PlayerMenu.SettingsThird:SetPos( 590, 10 );
	CCP.PlayerMenu.SettingsThird:SetValue( cookie.GetNumber( "zc_thirdperson", 0 ) );
	CCP.PlayerMenu.SettingsThird:PerformLayout();
	function CCP.PlayerMenu.SettingsThird:OnChange( val )
		
		cookie.Set( "zc_thirdperson", val and 1 or 0 );
		
		if val then
		
			ctp:Enable();
			
		else
		
			ctp:Disable();
			
		end
		
	end
	
	CCP.PlayerMenu.SettingsThird:PerformLayout();
	CCP.PlayerMenu.SettingsThird:SizeToContents();
	
	CCP.PlayerMenu.SettingsMOTDL = vgui.Create( "DLabel", CCP.PlayerMenu.ContentPane );
	CCP.PlayerMenu.SettingsMOTDL:SetText( "MOTD Enabled" );
	CCP.PlayerMenu.SettingsMOTDL:SetPos( 470, 40 );
	CCP.PlayerMenu.SettingsMOTDL:SetFont( "CombineControl.LabelSmall" );
	CCP.PlayerMenu.SettingsMOTDL:SizeToContents();
	CCP.PlayerMenu.SettingsMOTDL:PerformLayout();
	
	CCP.PlayerMenu.SettingsMOTD = vgui.Create( "DCheckBoxLabel", CCP.PlayerMenu.ContentPane );
	CCP.PlayerMenu.SettingsMOTD:SetText( "" );
	CCP.PlayerMenu.SettingsMOTD:SetPos( 590, 40 );
	CCP.PlayerMenu.SettingsMOTD:SetValue( cookie.GetNumber( "zc_motd", 1 ) );
	CCP.PlayerMenu.SettingsMOTD:PerformLayout();
	function CCP.PlayerMenu.SettingsMOTD:OnChange( val )
		
		cookie.Set( "zc_motd", val and 1 or 0 );
		
	end
	
	CCP.PlayerMenu.SettingsMOTD:PerformLayout();
	CCP.PlayerMenu.SettingsMOTD:SizeToContents();
	
	CCP.PlayerMenu.SettingsHeadbobL = vgui.Create( "DLabel", CCP.PlayerMenu.ContentPane );
	CCP.PlayerMenu.SettingsHeadbobL:SetText( "Headbob Enabled" );
	CCP.PlayerMenu.SettingsHeadbobL:SetPos( 470, 70 );
	CCP.PlayerMenu.SettingsHeadbobL:SetFont( "CombineControl.LabelSmall" );
	CCP.PlayerMenu.SettingsHeadbobL:SizeToContents();
	CCP.PlayerMenu.SettingsHeadbobL:PerformLayout();
	
	CCP.PlayerMenu.SettingsHeadbob = vgui.Create( "DCheckBoxLabel", CCP.PlayerMenu.ContentPane );
	CCP.PlayerMenu.SettingsHeadbob:SetText( "" );
	CCP.PlayerMenu.SettingsHeadbob:SetPos( 590, 70 );
	CCP.PlayerMenu.SettingsHeadbob:SetValue( cookie.GetNumber( "zc_headbob", 0 ) );
	CCP.PlayerMenu.SettingsHeadbob:PerformLayout();
	function CCP.PlayerMenu.SettingsHeadbob:OnChange( val )
		
		cookie.Set( "zc_headbob", val and 1 or 0 );
		
	end
	
	CCP.PlayerMenu.SettingsChat = vgui.Create( "DNumSlider", CCP.PlayerMenu.ContentPane );
	CCP.PlayerMenu.SettingsChat:SetText( "Chat Height" );
	CCP.PlayerMenu.SettingsChat:SetPos( 10, 130 );
	CCP.PlayerMenu.SettingsChat:SetSize( 300, 16 );
	CCP.PlayerMenu.SettingsChat:SetMin( 200 );
	CCP.PlayerMenu.SettingsChat:SetMax( 800 );
	CCP.PlayerMenu.SettingsChat:SetDecimals( 0 );
	CCP.PlayerMenu.SettingsChat:SetValue( cookie.GetNumber( "zc_chatheight", 300 ) );
	CCP.PlayerMenu.SettingsChat.PerformLayout = CCSliderPerformLayout;
	CCP.PlayerMenu.SettingsChat:PerformLayout();
	function CCP.PlayerMenu.SettingsChat:OnValueChanged( val )
		
		cookie.Set( "zc_chatheight", val );
		
	end
	
	CCP.PlayerMenu.SettingsChat:PerformLayout();
	CCP.PlayerMenu.SettingsChat:SizeToContents();
	
	CCP.PlayerMenu.SettingsChatLines = vgui.Create( "DNumSlider", CCP.PlayerMenu.ContentPane );
	CCP.PlayerMenu.SettingsChatLines:SetText( "Max Chat Lines" );
	CCP.PlayerMenu.SettingsChatLines:SetPos( 10, 160 );
	CCP.PlayerMenu.SettingsChatLines:SetSize( 300, 16 );
	CCP.PlayerMenu.SettingsChatLines:SetMin( 10 );
	CCP.PlayerMenu.SettingsChatLines:SetMax( 500 );
	CCP.PlayerMenu.SettingsChatLines:SetDecimals( 0 );
	CCP.PlayerMenu.SettingsChatLines:SetValue( math.floor( cookie.GetNumber( "zc_maxchatlines", 100 ) ) );
	CCP.PlayerMenu.SettingsChatLines.PerformLayout = CCSliderPerformLayout;
	CCP.PlayerMenu.SettingsChatLines:PerformLayout();
	function CCP.PlayerMenu.SettingsChatLines:OnValueChanged( val )
		
		cookie.Set( "zc_maxchatlines", val );
		
		if( #GAMEMODE.ChatLines > math.floor( cookie.GetNumber( "zc_maxchatlines", 100 ) ) ) then
			
			for i = 1, #GAMEMODE.ChatLines - math.floor( cookie.GetNumber( "zc_maxchatlines", 100 ) ) do
				
				table.remove( GAMEMODE.ChatLines, 1 );
				
			end
			
		end
		
	end
	
	CCP.PlayerMenu.SettingsChatLines:PerformLayout();
	CCP.PlayerMenu.SettingsChatLines:SizeToContents();
	
	CCP.PlayerMenu.SettingsChatOpacity = vgui.Create( "DNumSlider", CCP.PlayerMenu.ContentPane );
	CCP.PlayerMenu.SettingsChatOpacity:SetText( "Chat Background Opacity" );
	CCP.PlayerMenu.SettingsChatOpacity:SetPos( 10, 100 );
	CCP.PlayerMenu.SettingsChatOpacity:SetSize( 300, 16 );
	CCP.PlayerMenu.SettingsChatOpacity:SetMin( 0 );
	CCP.PlayerMenu.SettingsChatOpacity:SetMax( 1 );
	CCP.PlayerMenu.SettingsChatOpacity:SetDecimals( 2 );
	CCP.PlayerMenu.SettingsChatOpacity:SetValue( cookie.GetNumber( "zc_chatopacity", 0.8 ) );
	CCP.PlayerMenu.SettingsChatOpacity.PerformLayout = CCSliderPerformLayout;
	CCP.PlayerMenu.SettingsChatOpacity:PerformLayout();
	function CCP.PlayerMenu.SettingsChatOpacity:OnValueChanged( val )
		
		cookie.Set( "zc_chatopacity", val );

	end
	
	CCP.PlayerMenu.SettingsChatOpacity:PerformLayout();
	CCP.PlayerMenu.SettingsChatOpacity:SizeToContents();
	
	CCP.PlayerMenu.SettingsBlowoutVol = vgui.Create( "DNumSlider", CCP.PlayerMenu.ContentPane );
	CCP.PlayerMenu.SettingsBlowoutVol:SetText( "Blowout Volume" );
	CCP.PlayerMenu.SettingsBlowoutVol:SetPos( 10, 190 );
	CCP.PlayerMenu.SettingsBlowoutVol:SetSize( 300, 16 );
	CCP.PlayerMenu.SettingsBlowoutVol:SetMin( 0 );
	CCP.PlayerMenu.SettingsBlowoutVol:SetMax( 1 );
	CCP.PlayerMenu.SettingsBlowoutVol:SetDecimals( 2 );
	CCP.PlayerMenu.SettingsBlowoutVol:SetValue( cookie.GetNumber( "kingston.blowout.volume", 1 ) );
	CCP.PlayerMenu.SettingsBlowoutVol.PerformLayout = CCSliderPerformLayout;
	CCP.PlayerMenu.SettingsBlowoutVol:PerformLayout();
	function CCP.PlayerMenu.SettingsBlowoutVol:OnValueChanged( val )
		
		cookie.Set( "kingston.blowout.volume", val );
		kingston.blowout.volume = val;
		
	end
	
	CCP.PlayerMenu.SettingsBlowoutVol:PerformLayout();
	CCP.PlayerMenu.SettingsBlowoutVol:SizeToContents();
	
	CCP.PlayerMenu.SettingsMusicVol = vgui.Create( "DNumSlider", CCP.PlayerMenu.ContentPane );
	CCP.PlayerMenu.SettingsMusicVol:SetText( "Music Volume" );
	CCP.PlayerMenu.SettingsMusicVol:SetPos( 10, 220 );
	CCP.PlayerMenu.SettingsMusicVol:SetSize( 300, 16 );
	CCP.PlayerMenu.SettingsMusicVol:SetMin( 0 );
	CCP.PlayerMenu.SettingsMusicVol:SetMax( 1 );
	CCP.PlayerMenu.SettingsMusicVol:SetDecimals( 2 );
	CCP.PlayerMenu.SettingsMusicVol:SetValue( cookie.GetNumber( "zc_musicvolume", 1 ) );
	CCP.PlayerMenu.SettingsMusicVol.PerformLayout = CCSliderPerformLayout;
	CCP.PlayerMenu.SettingsMusicVol:PerformLayout();
	function CCP.PlayerMenu.SettingsMusicVol:OnValueChanged( val )
		
		cookie.Set( "zc_musicvolume", val );
		GAMEMODE.MusicVolume = val;
		if GAMEMODE.MusicPatch then
			GAMEMODE.MusicPatch:ChangeVolume(val, 0)
		end
		
	end
	
	CCP.PlayerMenu.SettingsMusicVol:PerformLayout();
	CCP.PlayerMenu.SettingsMusicVol:SizeToContents();
	
	local y = 300;
	
	if( GAMEMODE.WebsiteURL != "" ) then
		
		CCP.PlayerMenu.WebsiteBut = vgui.Create( "DButton", CCP.PlayerMenu.ContentPane );
		CCP.PlayerMenu.WebsiteBut:SetFont( "CombineControl.LabelSmall" );
		CCP.PlayerMenu.WebsiteBut:SetText( "Open Website" );
		CCP.PlayerMenu.WebsiteBut:SetPos( 10, y );
		CCP.PlayerMenu.WebsiteBut:SetSize( 120, 30 );
		CCP.PlayerMenu.WebsiteBut.DoClick = function( self )
			
			gui.OpenURL( GAMEMODE.WebsiteURL );
			
		end
		CCP.PlayerMenu.WebsiteBut:PerformLayout();
		
		y = y - 34;
		
	end
	
	if( GAMEMODE.SteamGroupURL != "" ) then
		
		CCP.PlayerMenu.SteamBut = vgui.Create( "DButton", CCP.PlayerMenu.ContentPane );
		CCP.PlayerMenu.SteamBut:SetFont( "CombineControl.LabelSmall" );
		CCP.PlayerMenu.SteamBut:SetText( "Open Steam Group" );
		CCP.PlayerMenu.SteamBut:SetPos( 10, y );
		CCP.PlayerMenu.SteamBut:SetSize( 120, 30 );
		CCP.PlayerMenu.SteamBut.DoClick = function( self )
			
			gui.OpenURL( GAMEMODE.SteamGroupURL );
			
		end
		CCP.PlayerMenu.SteamBut:PerformLayout();
		
		y = y - 40;
		
	end
	
	if( GAMEMODE.UpdatesURL != "" ) then
		
		CCP.PlayerMenu.UpdatesBut = vgui.Create( "DButton", CCP.PlayerMenu.ContentPane );
		CCP.PlayerMenu.UpdatesBut:SetFont( "CombineControl.LabelSmall" );
		CCP.PlayerMenu.UpdatesBut:SetText( "Server Updates" );
		CCP.PlayerMenu.UpdatesBut:SetPos( 10, y );
		CCP.PlayerMenu.UpdatesBut:SetSize( 120, 30 );
		CCP.PlayerMenu.UpdatesBut.DoClick = function( self )
			
			gui.OpenURL( GAMEMODE.UpdatesURL );
			
		end
		CCP.PlayerMenu.UpdatesBut:PerformLayout();
		
		y = y - 40;
		
	end
	
	CCP.PlayerMenu.ClearDecalBut = vgui.Create( "DButton", CCP.PlayerMenu.ContentPane );
	CCP.PlayerMenu.ClearDecalBut:SetFont( "CombineControl.LabelSmall" );
	CCP.PlayerMenu.ClearDecalBut:SetText( "Clear Decals" );
	CCP.PlayerMenu.ClearDecalBut:SetPos( 10, 334 );
	CCP.PlayerMenu.ClearDecalBut:SetSize( 120, 30 );
	CCP.PlayerMenu.ClearDecalBut.DoClick = function( self )
		
		RunConsoleCommand( "r_cleardecals" );
		
	end
	CCP.PlayerMenu.ClearDecalBut:PerformLayout();
	
	CCP.PlayerMenu.ResyncBut = vgui.Create( "DButton", CCP.PlayerMenu.ContentPane );
	CCP.PlayerMenu.ResyncBut:SetFont( "CombineControl.LabelSmall" );
	CCP.PlayerMenu.ResyncBut:SetText( "Resync Players" );
	CCP.PlayerMenu.ResyncBut:SetPos( 658, 300 );
	CCP.PlayerMenu.ResyncBut:SetSize( 100, 30 );
	CCP.PlayerMenu.ResyncBut.DoClick = function( self )
		
		netstream.Start( "nRequestAllPlayerData" );
		
	end
	CCP.PlayerMenu.ResyncBut:PerformLayout();
	
	CCP.PlayerMenu.KillBut = vgui.Create( "DButton", CCP.PlayerMenu.ContentPane );
	CCP.PlayerMenu.KillBut:SetFont( "CombineControl.LabelSmall" );
	CCP.PlayerMenu.KillBut:SetText( "Suicide" );
	CCP.PlayerMenu.KillBut:SetPos( 658, 334 );
	CCP.PlayerMenu.KillBut:SetSize( 100, 30 );
	CCP.PlayerMenu.KillBut.DoClick = function( self )
		
		RunConsoleCommand( "kill" );
		
	end
	CCP.PlayerMenu.KillBut:PerformLayout();
	
	CCP.PlayerMenu.RejoinBut = vgui.Create( "DButton", CCP.PlayerMenu.ContentPane );
	CCP.PlayerMenu.RejoinBut:SetFont( "CombineControl.LabelSmall" );
	CCP.PlayerMenu.RejoinBut:SetText( "Rejoin" );
	CCP.PlayerMenu.RejoinBut:SetPos( 690, 386 );
	CCP.PlayerMenu.RejoinBut:SetSize( 100, 30 );
	CCP.PlayerMenu.RejoinBut.DoClick = function( self )
		
		RunConsoleCommand( "retry" );
		
	end
	CCP.PlayerMenu.RejoinBut:PerformLayout();
	
end

function ccToggleThirdPerson( ply, cmd, args )
	
	cookie.Set( "zc_thirdperson", 1 - cookie.GetNumber( "zc_thirdperson", 0 ) );
	
	if( CCP.PlayerMenu and CCP.PlayerMenu:IsValid() and CCP.PlayerMenu.SettingsThird and CCP.PlayerMenu.SettingsThird:IsValid() ) then
		
		CCP.PlayerMenu.SettingsThird:SetValue( cookie.GetNumber( "zc_thirdperson", 0 ) );
		
	end
	
	if cookie.GetNumber( "zc_thirdperson", 0 ) == 1 then
	
		ctp:Enable()
		
	else
	
		ctp:Disable()
		
	end
	
end
concommand.Add( "rp_thirdperson", ccToggleThirdPerson )

local function nRequestStockpileName()

	Derma_StringRequest(
		"Stockpile Name",
		"Enter the name of your new stockpile.",
		"",
		function( text )
			
			netstream.Start( "nSetupStockpile", text );
			
		end,
		nil
	)

end
netstream.Hook( "nRequestStockpileName", nRequestStockpileName );

local function nSellItemMessage( price, itemname )

	GAMEMODE:AddChat( { CB_ALL, CB_IC }, "CombineControl.ChatNormal", Color( 200, 200, 200, 255 ), "You sold the " .. itemname .. " for " .. price .. " rubles." );

end
netstream.Hook( "nSellItemMessage", nSellItemMessage );