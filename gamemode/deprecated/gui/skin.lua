local meta = FindMetaTable( "Panel" );

local matHover = Material( "vgui/spawnmenu/hover" );
matFrame = Material( "kingston/frame_panels" );
matMultiplayer = Material( "kingston/multiplayer_panels" );
matHints = Material( "kingston/hint_panels" );
matSleep = Material( "kingston/sleep_panels" );
matPDA = Material( "kingston/pda_panels" );
local matDialogMenu = Material("kingston/ui_actor_dialog")

function meta:DrawSelections()

	if ( !self.m_bSelectable ) then return end
	if ( !self.m_bSelected ) then return end
	
	surface.SetDrawColor( 255, 255, 255, 255 );
	surface.SetMaterial( matHover );
	self:DrawTexturedRect();

end

function GM:ForceDermaSkin()
	
	return "CombineControl";
	
end

function CCFramePerformLayout( self )
	
	if( self.btnClose and self.btnClose:IsValid() ) then
		
		self.btnClose:SetPos( self:GetWide() - 24, 0 );
		self.btnClose:SetSize( 24, 24 );
		self.btnClose:SetFont( "marlett" );
		self.btnClose:SetText( "r" );
		self.btnClose:PerformLayout();
		
	end
	
	if( self.m_bPDA ) then
	
		self.btnClose:Remove();
		
	end
	
	if( self.btnMaxim and self.btnMaxim:IsValid() ) then
		
		self.btnMaxim:Remove();
		
	end
	
	if( self.btnMinim and self.btnMinim:IsValid() ) then
		
		self.btnMinim:Remove();
		
	end
	
	if( self.lblTitle and self.lblTitle:IsValid() ) then
		
		self.lblTitle:SetPos( 6, 0 )
		self.lblTitle:SetSize( self:GetWide() - 25, 24 )
		
	end
	
end

function CCSliderPerformLayout( self )
	
	if( self.Label and self.Label:IsValid() ) then
		
		self.Label:SetFont( "CombineControl.LabelSmall" );
		
	end
	
	if( self.TextArea and self.TextArea:IsValid() ) then
		
		self.TextArea:SetFont( "CombineControl.LabelSmall" );
		
	end
	
end

SKIN = { }

SKIN.fontFrame		= "CombineControl.Window"
SKIN.fontTab		= "CombineControl.Window"

SKIN.GwenTexture	= Material( "gwenskin/GModDefault.png" );

SKIN.control_color 				= Color( 255, 255, 255, 255 )
SKIN.control_color_highlight	= Color( 150, 150, 150, 255 )
SKIN.control_color_active 		= Color( 255, 10, 10, 255 )
SKIN.control_color_bright 		= Color( 90, 90, 90, 255 )
SKIN.control_color_dark 		= Color( 40, 40, 40, 255 )

SKIN.Colours = {}

SKIN.Colours.Window = {}
SKIN.Colours.Window.TitleActive			= Color( 200, 200, 200, 255 );
SKIN.Colours.Window.TitleInactive		= Color( 200, 200, 200, 255 );

SKIN.Colours.Button = {}
SKIN.Colours.Button.Normal				= Color( 200, 200, 200, 255 );
SKIN.Colours.Button.Hover				= Color( 255, 255, 255, 255 );
SKIN.Colours.Button.Down				= Color( 255, 0, 0, 255 );
SKIN.Colours.Button.Disabled			= Color( 150, 150, 150, 255 );

SKIN.Colours.Label = { }
SKIN.Colours.Label.Default		= Color( 200, 200, 200, 255 );
SKIN.Colours.Label.Bright		= Color( 255, 255, 255, 255 );
SKIN.Colours.Label.Dark			= Color( 150, 150, 150, 255 );
SKIN.Colours.Label.Highlight	= Color( 255, 0, 0, 255 );

SKIN.Colours.Tab = {}
SKIN.Colours.Tab.Active = {}
SKIN.Colours.Tab.Active.Normal			= GWEN.TextureColor( 4 + 8 * 4, 508 );
SKIN.Colours.Tab.Active.Hover			= GWEN.TextureColor( 4 + 8 * 5, 508 );
SKIN.Colours.Tab.Active.Down			= GWEN.TextureColor( 4 + 8 * 4, 500 );
SKIN.Colours.Tab.Active.Disabled		= GWEN.TextureColor( 4 + 8 * 5, 500 );

SKIN.Colours.Tab.Inactive = {}
SKIN.Colours.Tab.Inactive.Normal		= GWEN.TextureColor( 4 + 8 * 6, 508 );
SKIN.Colours.Tab.Inactive.Hover			= GWEN.TextureColor( 4 + 8 * 7, 508 );
SKIN.Colours.Tab.Inactive.Down			= GWEN.TextureColor( 4 + 8 * 6, 500 );
SKIN.Colours.Tab.Inactive.Disabled		= GWEN.TextureColor( 4 + 8 * 7, 500 );

SKIN.Colours.Tree = {}
SKIN.Colours.Tree.Lines					= Color( 160, 160, 160, 255 );		---- !!!
SKIN.Colours.Tree.Normal				= Color( 160, 160, 160, 255 );
SKIN.Colours.Tree.Hover					= Color( 255, 255, 255, 255 );
SKIN.Colours.Tree.Selected				= Color( 200, 200, 200, 255 );

SKIN.Colours.Properties = {}
SKIN.Colours.Properties.Line_Normal			= GWEN.TextureColor( 4 + 8 * 12, 508 );
SKIN.Colours.Properties.Line_Selected		= GWEN.TextureColor( 4 + 8 * 13, 508 );
SKIN.Colours.Properties.Line_Hover			= GWEN.TextureColor( 4 + 8 * 12, 500 );
SKIN.Colours.Properties.Title				= GWEN.TextureColor( 4 + 8 * 13, 500 );
SKIN.Colours.Properties.Column_Normal		= GWEN.TextureColor( 4 + 8 * 14, 508 );
SKIN.Colours.Properties.Column_Selected		= GWEN.TextureColor( 4 + 8 * 15, 508 );
SKIN.Colours.Properties.Column_Hover		= GWEN.TextureColor( 4 + 8 * 14, 500 );
SKIN.Colours.Properties.Border				= GWEN.TextureColor( 4 + 8 * 15, 500 );
SKIN.Colours.Properties.Label_Normal		= GWEN.TextureColor( 4 + 8 * 16, 508 );
SKIN.Colours.Properties.Label_Selected		= GWEN.TextureColor( 4 + 8 * 17, 508 );
SKIN.Colours.Properties.Label_Hover			= GWEN.TextureColor( 4 + 8 * 16, 500 );

SKIN.Colours.Category = {}
SKIN.Colours.Category.Header				= GWEN.TextureColor( 4 + 8 * 18, 500 );
SKIN.Colours.Category.Header_Closed			= GWEN.TextureColor( 4 + 8 * 19, 500 );
SKIN.Colours.Category.Line = {}
SKIN.Colours.Category.Line.Text				= GWEN.TextureColor( 4 + 8 * 20, 508 );
SKIN.Colours.Category.Line.Text_Hover		= GWEN.TextureColor( 4 + 8 * 21, 508 );
SKIN.Colours.Category.Line.Text_Selected	= GWEN.TextureColor( 4 + 8 * 20, 500 );
SKIN.Colours.Category.Line.Button			= GWEN.TextureColor( 4 + 8 * 21, 500 );
SKIN.Colours.Category.Line.Button_Hover		= GWEN.TextureColor( 4 + 8 * 22, 508 );
SKIN.Colours.Category.Line.Button_Selected	= GWEN.TextureColor( 4 + 8 * 23, 508 );
SKIN.Colours.Category.LineAlt = {}
SKIN.Colours.Category.LineAlt.Text				= GWEN.TextureColor( 4 + 8 * 22, 500 );
SKIN.Colours.Category.LineAlt.Text_Hover		= GWEN.TextureColor( 4 + 8 * 23, 500 );
SKIN.Colours.Category.LineAlt.Text_Selected		= GWEN.TextureColor( 4 + 8 * 24, 508 );
SKIN.Colours.Category.LineAlt.Button			= GWEN.TextureColor( 4 + 8 * 25, 508 );
SKIN.Colours.Category.LineAlt.Button_Hover		= GWEN.TextureColor( 4 + 8 * 24, 500 );
SKIN.Colours.Category.LineAlt.Button_Selected	= GWEN.TextureColor( 4 + 8 * 25, 500 );

SKIN.colTextEntryText			= Color( 200, 200, 200, 255 )
SKIN.colTextEntryTextHighlight	= Color( 40, 40, 40, 255 )
SKIN.colTextEntryTextCursor		= Color( 200, 200, 200, 255 )

SKIN.Colours.TooltipText	= Color( 200, 200, 200, 255 );

SKIN.PrintName 		= "CombineControl"
SKIN.Author 		= "disseminate"
SKIN.DermaVersion	= 1

function SKIN:PaintFrame( panel, w, h )

	draw.RoundedBox( 0, 0, 0, w, h, Color( 30, 30, 30, 230 ) );
	draw.RoundedBox( 0, 0, 0, w, 24, Color( 20, 20, 20, 255 ) );
	surface.DrawOutlinedRect( 0, 0, w, h );
	
end

function SKIN:PaintButton( panel, w, h )
	
	if ( !panel.m_bBackground ) then return end
	
	surface.SetDrawColor( 40, 40, 40, 255 );
	surface.DrawRect( 0, 0, w, h );
	
	if ( panel:GetDisabled() ) then
		surface.SetDrawColor( 30, 30, 30, 255 );
		surface.DrawRect( 1, 1, w - 2, h - 2 );
		return;
	end	
	
	if panel.GetToggle and panel:GetToggle() then
		surface.SetDrawColor( 100, 60, 60, 255 );
	else
		surface.SetDrawColor( 60, 60, 60, 255 );
	end
	surface.DrawRect( 1, 1, w - 2, h - 2 );

end

function SKIN:PaintWindowCloseButton( panel, w, h )

	
	
end

function SKIN:PaintTextEntry( panel, w, h )
	
	local w, h = panel:GetSize();
	
	if( panel:GetDrawBackground() ) then
		
		surface.SetDrawColor( 30, 30, 30, 255 );
		surface.DrawRect( 0, 0, w, h );
		
		surface.SetDrawColor( 40, 40, 40, 255 );
		surface.DrawRect( 1, 1, w - 2, h - 2 );
		
	end
	
	panel:DrawTextEntryText( panel:GetTextColor(), panel:GetHighlightColor(), panel:GetCursorColor() );
	
end

function SKIN:PaintButtonDown( panel, w, h )
	
	if( !panel.LaidOut ) then
		
		panel.LaidOut = true;
		panel:SetText( "u" );
		panel:SetFont( "marlett" );
		
	end
	
	self:PaintButton( panel, w, h );

end

function SKIN:PaintButtonUp( panel, w, h )
	
	if( !panel.LaidOut ) then
		
		panel.LaidOut = true;
		panel:SetText( "t" );
		panel:SetFont( "marlett" );
		
	end
	
	self:PaintButton( panel, w, h );

end

function SKIN:PaintVScrollBar( panel, w, h )

	--self.tex.Scroller.TrackV( 0, 0, w, h );	

end

function SKIN:PaintScrollBarGrip( panel, w, h )

	self:PaintButton( panel, w, h );

end

function SKIN:PaintListView( panel, w, h )

	surface.SetDrawColor( 30, 30, 30, 255 );
	surface.DrawRect( 0, 0, w, h );
	
	surface.SetDrawColor( 20, 20, 20, 100 );
	surface.DrawOutlinedRect( 0, 0, w, h );

end

function SKIN:PaintListViewLine( panel, w, h )
	
	if ( panel:IsSelected() ) then

		surface.SetDrawColor( 60, 60, 60, 255 );
		surface.DrawRect( 0, 0, w, h );
	 
	elseif ( panel.Hovered ) then

		surface.SetDrawColor( 50, 50, 50, 255 );
		surface.DrawRect( 0, 0, w, h );
		
	elseif ( panel.m_bAlt ) then

		surface.SetDrawColor( 40, 40, 40, 255 );
		surface.DrawRect( 0, 0, w, h );
	    
	end

end

function SKIN:PaintComboDownArrow( panel, w, h )
	
	draw.DrawText( "u", "marlett", 0, 0, Color( 200, 200, 200, 255 ) );

end

function SKIN:PaintComboBox( panel, w, h )
	
	surface.SetDrawColor( 30, 30, 30, 255 );
	surface.DrawRect( 0, 0, w, h );
	
	if( panel.Depressed or panel:IsMenuOpen() ) then
		
		surface.SetDrawColor( 60, 60, 60, 255 );
		surface.DrawRect( 1, 1, w - 2, h - 2 );
		
	elseif( panel:GetDisabled() ) then

		surface.SetDrawColor( 30, 30, 30, 255 );
		surface.DrawRect( 1, 1, w - 2, h - 2 );
	    
	else
		
		surface.SetDrawColor( 40, 40, 40, 255 );
		surface.DrawRect( 1, 1, w - 2, h - 2 );
		
	end
	
end

function SKIN:PaintMenu( panel, w, h )
	
	local odd = true;
	
	for i = 0, h, 22 do
		
		if( odd ) then
			
			surface.SetDrawColor( 40, 40, 40, 255 );
			surface.DrawRect( 0, i, w, 22 );
			
		else
			
			surface.SetDrawColor( 50, 50, 50, 255 );
			surface.DrawRect( 0, i, w, 22 );
			
		end
		
		odd = !odd;
		
	end
	
end

function SKIN:PaintMenuOption( panel, w, h )
	
	if( !panel.LaidOut ) then
		
		panel.LaidOut = true;
		panel:SetFont( "CombineControl.LabelSmall" );
		panel:SetTextColor( Color( 200, 200, 200, 255 ) );
		
	end
	
	if( panel.m_bBackground and ( panel.Hovered or panel.Highlight ) ) then
		
		surface.SetDrawColor( 70, 70, 70, 255 );
		surface.DrawRect( 0, 0, w, h );
		
	end
	
	self.MenuOptionOdd = !self.MenuOptionOdd;
	
	if( panel:GetChecked() ) then
		
		self.tex.Menu_Check( 5, h / 2 - 7, 15, 15 );
		
	end
	
end

SKIN.BulletMat = Material( "icon16/bullet_white.png" );

function SKIN:PaintCCTreeNode( panel, w, h )
	
	if( panel.GetDrawIcon and panel:GetDrawIcon() ) then
		
		local vCol = panel:GetIconColor();
		
		if( vCol ) then
			
			surface.SetDrawColor( vCol.x, vCol.y, vCol.z, 255 );
			surface.DrawRect( panel.Expander.x + panel.Expander:GetWide() + 4, (panel:GetLineHeight() - 16) * 0.5, 16, 16 );
			
		else
			
			surface.SetMaterial( self.BulletMat );
			
			local iconCol = panel:GetBulletColor();
			
			if( iconCol ) then
				
				surface.SetDrawColor( iconCol.x, iconCol.y, iconCol.z, 255 );
				
			else
				
				surface.SetDrawColor( 255, 255, 255, 255 );
				
			end
			
			surface.DrawTexturedRect( panel.Expander.x + panel.Expander:GetWide() + 4, (panel:GetLineHeight() - 16) * 0.5, 16, 16 );
			
		end
		
	end
	
end

function SKIN:PaintCCTreeNodeButton( panel, w, h )

	if ( !panel.m_bSelected ) then return end
	
	local w, _ = panel:GetTextSize() 
	
	surface.SetDrawColor( 100, 40, 40, 200 );
	surface.DrawRect( 38, 0, w + 6, h );

end

derma.DefineSkin( "CombineControl", "", SKIN );

SKIN = {};

SKIN.fontFrame		= "CombineControl.Window"
SKIN.fontTab		= "CombineControl.Window"

SKIN.GwenTexture	= Material( "gwenskin/GModDefault.png" );

SKIN.control_color 				= Color( 255, 255, 255, 255 )
SKIN.control_color_highlight	= Color( 150, 150, 150, 255 )
SKIN.control_color_active 		= Color( 255, 10, 10, 255 )
SKIN.control_color_bright 		= Color( 90, 90, 90, 255 )
SKIN.control_color_dark 		= Color( 40, 40, 40, 255 )

SKIN.Colours = {}

SKIN.Colours.Window = {}
SKIN.Colours.Window.TitleActive			= Color( 200, 200, 200, 255 );
SKIN.Colours.Window.TitleInactive		= Color( 200, 200, 200, 255 );

SKIN.Colours.Button = {}
SKIN.Colours.Button.Normal				= Color( 211, 213, 212, 255 );
SKIN.Colours.Button.Hover				= Color( 255, 255, 255, 255 );
SKIN.Colours.Button.Down				= Color( 255, 0, 0, 255 );
SKIN.Colours.Button.Disabled			= Color( 150, 150, 150, 255 );

SKIN.Colours.Label = { }
SKIN.Colours.Label.Default		= Color( 200, 200, 200, 255 );
SKIN.Colours.Label.Bright		= Color( 255, 255, 255, 255 );
SKIN.Colours.Label.Dark			= Color( 150, 150, 150, 255 );
SKIN.Colours.Label.Highlight	= Color( 255, 0, 0, 255 );

SKIN.Colours.Tab = {}
SKIN.Colours.Tab.Active = {}
SKIN.Colours.Tab.Active.Normal			= GWEN.TextureColor( 4 + 8 * 4, 508 );
SKIN.Colours.Tab.Active.Hover			= GWEN.TextureColor( 4 + 8 * 5, 508 );
SKIN.Colours.Tab.Active.Down			= GWEN.TextureColor( 4 + 8 * 4, 500 );
SKIN.Colours.Tab.Active.Disabled		= GWEN.TextureColor( 4 + 8 * 5, 500 );

SKIN.Colours.Tab.Inactive = {}
SKIN.Colours.Tab.Inactive.Normal		= GWEN.TextureColor( 4 + 8 * 6, 508 );
SKIN.Colours.Tab.Inactive.Hover			= GWEN.TextureColor( 4 + 8 * 7, 508 );
SKIN.Colours.Tab.Inactive.Down			= GWEN.TextureColor( 4 + 8 * 6, 500 );
SKIN.Colours.Tab.Inactive.Disabled		= GWEN.TextureColor( 4 + 8 * 7, 500 );

SKIN.Colours.Tree = {}
SKIN.Colours.Tree.Lines					= Color( 160, 160, 160, 255 );		---- !!!
SKIN.Colours.Tree.Normal				= Color( 160, 160, 160, 255 );
SKIN.Colours.Tree.Hover					= Color( 255, 255, 255, 255 );
SKIN.Colours.Tree.Selected				= Color( 200, 200, 200, 255 );

SKIN.Colours.Properties = {}
SKIN.Colours.Properties.Line_Normal			= GWEN.TextureColor( 4 + 8 * 12, 508 );
SKIN.Colours.Properties.Line_Selected		= GWEN.TextureColor( 4 + 8 * 13, 508 );
SKIN.Colours.Properties.Line_Hover			= GWEN.TextureColor( 4 + 8 * 12, 500 );
SKIN.Colours.Properties.Title				= GWEN.TextureColor( 4 + 8 * 13, 500 );
SKIN.Colours.Properties.Column_Normal		= GWEN.TextureColor( 4 + 8 * 14, 508 );
SKIN.Colours.Properties.Column_Selected		= GWEN.TextureColor( 4 + 8 * 15, 508 );
SKIN.Colours.Properties.Column_Hover		= GWEN.TextureColor( 4 + 8 * 14, 500 );
SKIN.Colours.Properties.Border				= GWEN.TextureColor( 4 + 8 * 15, 500 );
SKIN.Colours.Properties.Label_Normal		= GWEN.TextureColor( 4 + 8 * 16, 508 );
SKIN.Colours.Properties.Label_Selected		= GWEN.TextureColor( 4 + 8 * 17, 508 );
SKIN.Colours.Properties.Label_Hover			= GWEN.TextureColor( 4 + 8 * 16, 500 );

SKIN.Colours.Category = {}
SKIN.Colours.Category.Header				= GWEN.TextureColor( 4 + 8 * 18, 500 );
SKIN.Colours.Category.Header_Closed			= GWEN.TextureColor( 4 + 8 * 19, 500 );
SKIN.Colours.Category.Line = {}
SKIN.Colours.Category.Line.Text				= GWEN.TextureColor( 4 + 8 * 20, 508 );
SKIN.Colours.Category.Line.Text_Hover		= GWEN.TextureColor( 4 + 8 * 21, 508 );
SKIN.Colours.Category.Line.Text_Selected	= GWEN.TextureColor( 4 + 8 * 20, 500 );
SKIN.Colours.Category.Line.Button			= GWEN.TextureColor( 4 + 8 * 21, 500 );
SKIN.Colours.Category.Line.Button_Hover		= GWEN.TextureColor( 4 + 8 * 22, 508 );
SKIN.Colours.Category.Line.Button_Selected	= GWEN.TextureColor( 4 + 8 * 23, 508 );
SKIN.Colours.Category.LineAlt = {}
SKIN.Colours.Category.LineAlt.Text				= GWEN.TextureColor( 4 + 8 * 22, 500 );
SKIN.Colours.Category.LineAlt.Text_Hover		= GWEN.TextureColor( 4 + 8 * 23, 500 );
SKIN.Colours.Category.LineAlt.Text_Selected		= GWEN.TextureColor( 4 + 8 * 24, 508 );
SKIN.Colours.Category.LineAlt.Button			= GWEN.TextureColor( 4 + 8 * 25, 508 );
SKIN.Colours.Category.LineAlt.Button_Hover		= GWEN.TextureColor( 4 + 8 * 24, 500 );
SKIN.Colours.Category.LineAlt.Button_Selected	= GWEN.TextureColor( 4 + 8 * 25, 500 );

SKIN.colTextEntryText			= Color( 200, 200, 200, 255 )
SKIN.colTextEntryTextHighlight	= Color( 40, 40, 40, 255 )
SKIN.colTextEntryTextCursor		= Color( 200, 200, 200, 255 )

SKIN.Colours.TooltipText	= Color( 200, 200, 200, 255 );

SKIN.PrintName 		= "STALKER"
SKIN.Author 		= "rusty"
SKIN.DermaVersion	= 1

function SKIN:PaintFrame( panel, w, h )

	if( panel.m_bPrompt ) then
	
		DisableClipping( true );
		surface.SetDrawColor( 255, 255, 255, 255 );
		surface.SetMaterial( matSleep );
		surface.DrawTexturedRectUV( 0, 0, w, h, 0, 0, 0.66, 0.26 );
		DisableClipping( false );
		return;
		
	end

	DisableClipping( true );
	surface.SetDrawColor( 255, 255, 255, 255 );
	surface.SetMaterial( matFrame );
	surface.DrawTexturedRectUV( 0, -20, w + 10, h + 10, 0.3, 0, 0.9, 0.4 );
	DisableClipping( false );
	
end

function SKIN:PaintButton( panel, w, h )
	
	if ( !panel.m_bBackground ) then return end
	
	if( panel.m_bTitleButton ) then
	
		DisableClipping( true );
		surface.SetDrawColor( 255, 255, 255, 255 );
		surface.SetMaterial( matHints );
		if( !panel.m_bIsDown ) then
		
			surface.DrawTexturedRectUV( 0, 0, w, h, 0.095, 0.53, 0.218, 0.556 );
			
		else
		
			surface.DrawTexturedRectUV( 0, 0, w, h, 0.095, 0.561, 0.218, 0.586 );
		
		end
		DisableClipping( false );
		
		return;
	
	end

	kingston.gui.FindFunc(panel, "Paint", "Button", w, h)

end

function SKIN:PaintWindowCloseButton( panel, w, h )

	
	
end

function SKIN:PaintNumberUp( panel, w, h )

end

function SKIN:PaintNumberDown( panel, w, h )

end

function SKIN:PaintTextEntry( panel, w, h )
	
	local w, h = panel:GetSize();
	
	if( panel:GetDrawBackground() ) then
	
		if( panel.GetDecimals ) then
		
			DisableClipping( true );
			surface.SetDrawColor( 255, 255, 255, 255 );
			surface.SetMaterial( matMultiplayer );
			surface.DrawTexturedRectUV( 0, 0, w, h, 0.204, 0.574, 0.266, 0.593 );
			DisableClipping( false );
			
		else
		
			surface.SetDrawColor( 30, 30, 30, 255 );
			surface.DrawRect( 0, 0, w, h );
			
			surface.SetDrawColor( 40, 40, 40, 255 );
			surface.DrawRect( 1, 1, w - 2, h - 2 );
		
		end
		
		--surface.SetDrawColor( 255, 255, 255, 255 );
		--surface.DrawOutlinedRect( 0, 0, w, h );
		
	end
	
	panel:DrawTextEntryText( panel:GetTextColor(), panel:GetHighlightColor(), panel:GetCursorColor() );
	
end

function SKIN:PaintCheckBox( panel, w, h )

	if( panel:GetChecked() ) then
	
		DisableClipping( true );
		surface.SetDrawColor( 255, 255, 255, 255 );
		surface.SetMaterial( matMultiplayer );
		surface.DrawTexturedRectUV( -11, -2, w + 50, h + 20, 0.817, 0.188, 0.87, 0.22 );
		DisableClipping( false );
	
	else
	
		DisableClipping( true );
		surface.SetDrawColor( 255, 255, 255, 255 );
		surface.SetMaterial( matMultiplayer );
		surface.DrawTexturedRectUV( 0, -2, w + 50, h + 17, 0.826, 0.161, 0.88, 0.19 );
		DisableClipping( false );
	
	end

end

function SKIN:PaintSlider( panel, w, h )

end

function SKIN:PaintSliderKnob( panel, w, h )

	DisableClipping( true );
	surface.SetDrawColor( 255, 255, 255, 255 );
	surface.SetMaterial( matHints );
	surface.DrawTexturedRectUV( 0, -1, w + 6, h + 3, 0.289, 0.72, 0.31, 0.74 );
	DisableClipping( false );

end

function SKIN:PaintComboDownArrow( panel, w, h )
	
	draw.DrawText( "u", "marlett", 0, 0, Color( 200, 200, 200, 255 ) );

end

function SKIN:PaintComboBox( panel, w, h )
	
	surface.SetDrawColor( 30, 30, 30, 255 );
	surface.DrawRect( 0, 0, w, h );
	
	if( panel.Depressed or panel:IsMenuOpen() ) then
		
		surface.SetDrawColor( 60, 60, 60, 255 );
		surface.DrawRect( 1, 1, w - 2, h - 2 );
		
	elseif( panel:GetDisabled() ) then

		surface.SetDrawColor( 30, 30, 30, 255 );
		surface.DrawRect( 1, 1, w - 2, h - 2 );
	    
	else
		
		surface.SetDrawColor( 40, 40, 40, 255 );
		surface.DrawRect( 1, 1, w - 2, h - 2 );
		
	end
	
end

function SKIN:PaintButtonDown( panel, w, h )
	kingston.gui.FindFunc(panel, "Paint", "ScrollButtonDown", w, h)
end

function SKIN:PaintButtonUp( panel, w, h )
	kingston.gui.FindFunc(panel, "Paint", "ScrollButtonUp", w, h)
end

function SKIN:PaintVScrollBar( panel, w, h )

	--self.tex.Scroller.TrackV( 0, 0, w, h );	
	
end

function SKIN:PaintScrollBarGrip( panel, w, h )
	kingston.gui.FindFunc(panel, "Paint", "ScrollBarGrip", w, h)
end

function SKIN:PaintVScrollBar( panel, w, h )

end

derma.DefineSkin( "STALKER", "rusty", SKIN );

local UVSkin = {};

local inventory_panels = Material( "kingston/inventory_panels" )
local ui_common = Material( "kingston/ui_common" )
local hint_panels = Material( "kingston/hint_panels" )
local multiplayer_panels = Material( "kingston/multiplayer_panels" )
local ui_actor_upgrades_1 = Material( "kingston/ui_actor_upgrades_1" )
local ui_actor_upgrades_2 = Material( "kingston/ui_actor_upgrades_2" )
local ui_actor_upgrades_3 = Material( "kingston/ui_actor_upgrades_3" )
local ui_actor_upgrades_4 = Material( "kingston/ui_actor_upgrades_4" )
local ui_actor_upgrades_5 = Material( "kingston/ui_actor_upgrades_armor" )
local ui_actor_upgrades_6 = Material( "kingston/ui_actor_upgrades_armor_1" )

UVSkin.InventoryFrame = {
	{
		mat = inventory_panels,
		x = 0,
		y = 0,
		u0 = 0.667,
		v0 = 0,
		u1 = 1,
		v1 = 0.75,
	}
};

UVSkin.PDANotification = {
	{
		mat = Material( "kingston/ui_actor_newsmanager_icons" ),
		x = 0,
		y = 0,
		u0 = 0,
		v0 = 0,
		u1 = 0.081,
		v1 = 0.0459,
	},
}

UVSkin.Scrollbar = {
	{
		mat = ui_common,
		x = 0,
		y = 0,
		u0 = 0.121,
		v0 = 0.1995,
		u1 = 0.135,
		v1 = 0.216,
	},
	{
		mat = ui_common,
		x = 0,
		y = 0,
		u0 = 0.121,
		v0 = 0.2159,
		u1 = 0.135,
		v1 = 0.2298,
	},
	{
		mat = ui_common,
		x = 0,
		y = 0,
		u0 = 0.121,
		v0 = 0.169,
		u1 = 0.135,
		v1 = 0.1839,
	},
};

UVSkin.RepairButton = {
	{
		mat = inventory_panels, -- normal
		x = 0,
		y = 0,
		u0 = 0.487,
		v0 = 0.7939,
		u1 = 0.543,
		v1 = 0.8228,
	},
	{
		mat = inventory_panels, -- hovered
		x = 0,
		y = 0,
		u0 = 0.3197,
		v0 = 0.7939,
		u1 = 0.376,
		v1 = 0.8228,
	},
	{
		mat = inventory_panels, -- clicked
		x = 0,
		y = 0,
		u0 = 0.3758,
		v0 = 0.7939,
		u1 = 0.4315,
		v1 = 0.8228,
	},
	{
		mat = inventory_panels, -- disabled
		x = 0,
		y = 0,
		u0 = 0.431,
		v0 = 0.7939,
		u1 = 0.487,
		v1 = 0.8228,
	},
}

UVSkin.TechCloseButton = {
	{
		mat = inventory_panels, -- normal
		x = 0,
		y = 0,
		u0 = 0.332,
		v0 = 0.927,
		u1 = 0.5705,
		v1 = 0.952,
	},
	{
		mat = inventory_panels, -- hovered
		x = 0,
		y = 0,
		u0 = 0.332,
		v0 = 0.904,
		u1 = 0.5705,
		v1 = 0.9281,
	},
	{
		mat = inventory_panels, -- clicked
		x = 0,
		y = 0,
		u0 = 0.332,
		v0 = 0.952,
		u1 = 0.5705,
		v1 = 0.975,
	},
}

UVSkin.EquipFrame = {
	{ 	
		mat = inventory_panels,
		x = 0,
		y = 0,
		u0 = 0.333,
		v0 = 0,
		u1 = 0.667,
		v1 = 0.75,
	}
};

UVSkin.CharCreateFrame = {
	{ 	
		mat = Material( "kingston/frame_panels" ),
		disableclip = true,
		x = 0,
		y = -20,
		u0 = 0.3,
		v0 = 0.42,
		u1 = 0.9,
		v1 = 0.82,
	},
};

UVSkin.TitleButtonUp = {
	{
		mat = hint_panels,
		disableclip = true,
		x = 0,
		y = 0,
		u0 = 0.095,
		v0 = 0.53,
		u1 = 0.218,
		v1 = 0.556,
	},
};

UVSkin.TitleButtonDown = {
	{
		mat = hint_panels,
		disableclip = true,
		x = 0,
		y = 0,
		u0 = 0.095,
		v0 = 0.561,
		u1 = 0.218,
		v1 = 0.586,
	},
};

UVSkin.Button = {
	{
		mat = multiplayer_panels,
		x = 0,
		y = 0,
		u0 = 0.42,
		v0 = 0.55,
		u1 = 0.523,
		v1 = 0.571,
	},
	{
		mat = multiplayer_panels,
		x = 0,
		y = 0,
		u0 = 0.206,
		v0 = 0.551,
		u1 = 0.3085,
		v1 = 0.571,
	},
};

UVSkin.TechMenu = {
	{
		mat = inventory_panels,
		x = 0,
		y = 0,
		u0 = 0,
		v0 = 0,
		u1 = 0.33,
		v1 = 0.75,
	},
}

UVSkin.UpgradeButton = {
	{
		mat = ui_actor_upgrades_1,
		x = 0,
		y = 0,
		u0 = 0,
		v0 = 0,
		u1 = 0.088,
		v1 = 0.043,
	},
	{
		mat = ui_actor_upgrades_2,
		x = 0,
		y = 0,
		u0 = 0,
		v0 = 0,
		u1 = 0.088,
		v1 = 0.043,
	},
	{
		mat = ui_actor_upgrades_3,
		x = 0,
		y = 0,
		u0 = 0,
		v0 = 0,
		u1 = 0.088,
		v1 = 0.043,
	},
	{
		mat = ui_actor_upgrades_4,
		x = 0,
		y = 0,
		u0 = 0,
		v0 = 0,
		u1 = 0.088,
		v1 = 0.043,
	},
	{
		mat = ui_actor_upgrades_5,
		x = 0,
		y = 0,
		u0 = 0,
		v0 = 0,
		u1 = 0.04395,
		v1 = 0.02148,
	},
	{
		mat = ui_actor_upgrades_6,
		x = 0,
		y = 0,
		u0 = 0,
		v0 = 0,
		u1 = 0.04395,
		v1 = 0.02148,
	},
}

UVSkin.UpgradeStates = {
	{ -- green has
		mat = ui_actor_upgrades_1,
		x = 3,
		y = 3,
		w = 8,
		u0 = 0.801,
		v0 = 0,
		u1 = 0.806,
		v1 = 0.0418,
	},
	{ -- yellow hover
		mat = ui_actor_upgrades_1,
		x = 3,
		y = 3,
		w = 8,
		u0 = 0.811,
		v0 = 0,
		u1 = 0.816,
		v1 = 0.0419,
	},
	{ -- red incompat
		mat = ui_actor_upgrades_1,
		x = 3,
		y = 3,
		w = 8,
		u0 = 0.807,
		v0 = 0,
		u1 = 0.809,
		v1 = 0.0419,
	},
}

UVSkin.CleaningMenu = {
	{
		mat = multiplayer_panels,
		x = 0,
		y = 0,
		u0 = 0.515,
		v0 = 0.64,
		u1 = 0.995,
		v1 = 0.995,
	},
	{
		mat = multiplayer_panels,
		x = 0,
		y = 0,
		u0 = 0.515,
		v0 = 0.64,
		u1 = 0.995,
		v1 = 0.995,
	},
}

UVSkin.DialogMenu = {
	mat = matDialogMenu,
	x = -6,
	y = 0,
	u0 = 0.02,
	v0 = 0,
	u1 = 0.61,
	v1 = 0.73,
	addw = 28,
	addh = 0,
	disableclip = true
}

function UVSkin:PaintDFrame( panel, w, h )

end

function UVSkin:PaintEquipFrame( panel, w, h )

	local skin = kingston.gui.classes[panel:GetSkin().Name];
	for k,v in next, skin.EquipFrame do
	
		surface.SetDrawColor( 255, 255, 255, 255 );
		
		if( v.mat ) then
			
			surface.SetMaterial( v.mat );
			
		end
		
		surface.DrawTexturedRectUV( v.x or 0, v.y or 0, w, h, v.u0, v.v0, v.u1, v.v1 );
	
	end

end

function UVSkin:PaintInventoryFrame( panel, w, h )

	local skin = kingston.gui.classes[panel:GetSkin().Name];
	for k,v in next, skin.InventoryFrame do
	
		surface.SetDrawColor( 255, 255, 255, 255 );
		
		if( v.mat ) then
			
			surface.SetMaterial( v.mat );
			
		end
		
		surface.DrawTexturedRectUV( v.x or 0, v.y or 0, w, h, v.u0, v.v0, v.u1, v.v1 );
	
	end

end

function UVSkin:PaintCharCreateFrame( panel, w, h )

	local skin = kingston.gui.classes[panel:GetSkin().Name];
	for k,v in next, skin.CharCreateFrame do
	
		surface.SetDrawColor( 255, 255, 255, 255 );
		
		if( v.mat ) then
			
			surface.SetMaterial( v.mat );
			
		end
		
		if( v.disableclip ) then
		
			DisableClipping( true );
			
		end
		
		surface.DrawTexturedRectUV( v.x or 0, v.y or 0, w + ( addw or 0 ), h + ( addh or 0 ), v.u0, v.v0, v.u1, v.v1 );
		
		if( v.disableclip ) then
		
			DisableClipping( false );
			
		end
	
	end

end

function UVSkin:PaintTitleButton( panel, w, h )

	local skin = kingston.gui.classes[panel:GetSkin().Name];
	if( !panel.m_bIsDown ) then
	
		for k,v in next, skin.TitleButtonUp do
		
			surface.SetDrawColor( 255, 255, 255, 255 );
			
			if( v.mat ) then
				
				surface.SetMaterial( v.mat, "noclamp smooth" );
				
			end
			
			if( v.disableclip ) then
			
				DisableClipping( true );
				
			end
			
			surface.DrawTexturedRectUV( v.x or 0, v.y or 0, v.w or w, v.h or h, v.u0, v.v0, v.u1, v.v1 );
			
			if( v.disableclip ) then
			
				DisableClipping( false );
				
			end
		
		end
		
	else
	
		for k,v in next, skin.TitleButtonDown do
		
			surface.SetDrawColor( 255, 255, 255, 255 );
			
			if( v.mat ) then
				
				surface.SetMaterial( v.mat, "noclamp smooth" );
				
			end
			
			if( v.disableclip ) then
			
				DisableClipping( true );
				
			end
			
			surface.DrawTexturedRectUV( v.x or 0, v.y or 0, v.w or w, v.h or h, v.u0, v.v0, v.u1, v.v1 );
			
			if( v.disableclip ) then
			
				DisableClipping( false );
				
			end
		
		end
	
	end

end

function UVSkin:PaintButton( panel, w, h )

	local skin = kingston.gui.classes[panel:GetSkin().Name];
	local v = skin.Button[1]
	
	surface.SetDrawColor( 255, 255, 255, 255 );
	
	if panel.GetToggle and panel:GetToggle() then
		v = skin.Button[2]
	end
	
	if( v.mat ) then
		
		surface.SetMaterial( v.mat );
		
	end
	
	if( v.disableclip ) then
	
		DisableClipping( true );
		
	end
	
	surface.DrawTexturedRectUV( v.x or 0, v.y or 0, w + ( addw or 0 ), h + ( addh or 0 ), v.u0, v.v0, v.u1, v.v1 );
	
	if( v.disableclip ) then
	
		DisableClipping( false );
		
	end

end

function UVSkin:PaintTechMenuFrame( panel, w, h )

	local skin = kingston.gui.classes[panel:GetSkin().Name];
	for k,v in next, skin.TechMenu do
	
		surface.SetDrawColor( 255, 255, 255, 255 );
		
		if( v.mat ) then
			
			surface.SetMaterial( v.mat );
			
		end
		
		surface.DrawTexturedRectUV( v.x or 0, v.y or 0, w, h, v.u0, v.v0, v.u1, v.v1 );
	
	end
	
end

function UVSkin:PaintUpgradeButton( panel, w, h )

	local skin = kingston.gui.classes[panel:GetSkin().Name];
	local v = skin.UpgradeButton[panel.nUpgradePage];
	local u0 = ( ( v.u1 * panel.nUpgradeX ) - ( ( v.u1 * panel.nUpgradeX ) / panel.nUpgradeX ) );
	local v0 = ( ( v.v1 * panel.nUpgradeY ) - ( ( v.v1 * panel.nUpgradeY ) / panel.nUpgradeY ) );
	local u1 = v.u1 * panel.nUpgradeX;
	local v1 = v.v1 * panel.nUpgradeY;

	surface.SetDrawColor( 255, 255, 255, 255 );
	
	if( v.mat ) then
		
		surface.SetMaterial( v.mat );
		
	end
	
	if( v.disableclip ) then
	
		DisableClipping( true );
		
	end
	
	surface.DrawTexturedRectUV( v.x or 0, v.y or 0, w + ( addw or 0 ), h + ( addh or 0 ), u0, v0, u1, v1 );
	
	if( v.disableclip ) then
	
		DisableClipping( false );
		
	end
	
	if( !panel:IsEnabled() and !panel.ItemHasUpgrade ) then
	
		surface.SetDrawColor( 0, 0, 0, 200 );
		surface.DrawRect( v.x or 0, v.y or 0, w + ( addw or 0 ), h + ( addh or 0 ) );
		
	end
	
	if( panel:IsHovered() and panel:IsEnabled() and !panel.ItemHasUpgrade ) then
	
		local v = skin.UpgradeStates[2];
		surface.SetDrawColor( 255, 255, 255, 255 );
	
		if( v.mat ) then
			
			surface.SetMaterial( v.mat );
			
		end
		
		if( v.disableclip ) then
		
			DisableClipping( true );
			
		end
		
		surface.DrawTexturedRectUV( v.x or 0, v.y or 0, v.w or w, v.h or h, v.u0, v.v0, v.u1, v.v1 );
		
		if( v.disableclip ) then
		
			DisableClipping( false );
			
		end
	
	end
	
	if( panel.ItemHasUpgrade ) then
	
		local v = skin.UpgradeStates[1];
		surface.SetDrawColor( 255, 255, 255, 255 );
	
		if( v.mat ) then
			
			surface.SetMaterial( v.mat );
			
		end
		
		if( v.disableclip ) then
		
			DisableClipping( true );
			
		end
		
		surface.DrawTexturedRectUV( v.x or 0, v.y or 0, v.w or w, v.h or h, v.u0, v.v0, v.u1, v.v1 );
		
		if( v.disableclip ) then
		
			DisableClipping( false );
			
		end
	
	end
	
	if( panel.UpgradeIncompatible ) then
	
		local v = skin.UpgradeStates[3];
		surface.SetDrawColor( 255, 255, 255, 255 );
	
		if( v.mat ) then
			
			surface.SetMaterial( v.mat );
			
		end
		
		if( v.disableclip ) then
		
			DisableClipping( true );
			
		end
		
		surface.DrawTexturedRectUV( v.x or 0, v.y or 0, v.w or w, v.h or h, v.u0, v.v0, v.u1, v.v1 );
		
		if( v.disableclip ) then
		
			DisableClipping( false );
			
		end
		
	end

end

function UVSkin:PaintCleaningMenu(panel, w, h)

	local skin = kingston.gui.classes[panel:GetSkin().Name];
	for k,v in next, skin.CleaningMenu do
	
		surface.SetDrawColor( 255, 255, 255, 255 );
		
		if( v.mat ) then
			
			surface.SetMaterial( v.mat );
			
		end
		
		surface.DrawTexturedRectUV( v.x or 0, v.y or 0, w, h, v.u0, v.v0, v.u1, v.v1 );
	
	end
	
end

function UVSkin:PaintRepairButton( panel, w, h )

	local skin = kingston.gui.classes[panel:GetSkin().Name];
	local v = skin.RepairButton[1]
	
	surface.SetDrawColor( 255, 255, 255, 255 );
	
	if !panel:IsEnabled() then
		v = skin.RepairButton[4]
	elseif panel:IsHovered() then
		v = skin.RepairButton[2]
	end
	
	if panel:IsDown() then
		v = skin.RepairButton[3]
	end
	
	if( v.mat ) then
		
		surface.SetMaterial( v.mat );
		
	end
	
	if( v.disableclip ) then
	
		DisableClipping( true );
		
	end
	
	surface.DrawTexturedRectUV( v.x or 0, v.y or 0, w + ( addw or 0 ), h + ( addh or 0 ), v.u0, v.v0, v.u1, v.v1 );
	
	if( v.disableclip ) then
	
		DisableClipping( false );
		
	end

end

function UVSkin:PaintTechCloseButton( panel, w, h )

	local skin = kingston.gui.classes[panel:GetSkin().Name];
	local v = skin.TechCloseButton[1]
	
	surface.SetDrawColor( 255, 255, 255, 255 );
	
	/*if panel:IsHovered() then
		v = skin.TechCloseButton[2]
	end*/
	
	if panel:IsDown() then
		v = skin.TechCloseButton[3]
	end
	
	if( v.mat ) then
		
		surface.SetMaterial( v.mat );
		
	end
	
	if( v.disableclip ) then
	
		DisableClipping( true );
		
	end
	
	surface.DrawTexturedRectUV( v.x or 0, v.y or 0, w + ( addw or 0 ), h + ( addh or 0 ), v.u0, v.v0, v.u1, v.v1 );
	
	if( v.disableclip ) then
	
		DisableClipping( false );
		
	end

end

function UVSkin:PaintPDANotification( panel, w, h )

	local skin = kingston.gui.classes[panel:GetSkin().Name];
	local v = self.PDANotification[1];
	local u0 = ( ( v.u1 * panel.nNotificationX ) - ( ( v.u1 * panel.nNotificationX ) / panel.nNotificationX ) );
	local v0 = ( ( v.v1 * panel.nNotificationY ) - ( ( v.v1 * panel.nNotificationY ) / panel.nNotificationY ) );
	local u1 = v.u1 * panel.nNotificationX;
	local v1 = v.v1 * panel.nNotificationY;

	surface.SetDrawColor( 255, 255, 255, 255 );
	
	if( v.mat ) then
		
		surface.SetMaterial( v.mat );
		
	end
	
	if( v.disableclip ) then
	
		DisableClipping( true );
		
	end
	
	surface.DrawTexturedRectUV( v.x or 0, v.y or 0, w + ( addw or 0 ), h + ( addh or 0 ), u0, v0, u1, v1 );
	
	if( v.disableclip ) then
	
		DisableClipping( false );
		
	end

end

function UVSkin:PaintScrollBarGrip(panel, w, h)
	local skin = kingston.gui.classes[panel:GetSkin().Name];
	local v = self.Scrollbar[1];

	surface.SetDrawColor( 255, 255, 255, 255 );
	
	if( v.mat ) then
		
		surface.SetMaterial( v.mat );
		
	end
	
	if( v.disableclip ) then
	
		DisableClipping( true );
		
	end
	
	surface.DrawTexturedRectUV( v.x or 0, v.y or 0, w + ( addw or 0 ), h + ( addh or 0 ), v.u0, v.v0, v.u1, v.v1 );
	
	if( v.disableclip ) then
	
		DisableClipping( false );
		
	end
end

function UVSkin:PaintScrollButtonDown(panel, w, h)
	local skin = kingston.gui.classes[panel:GetSkin().Name];
	local v = self.Scrollbar[2];

	surface.SetDrawColor( 255, 255, 255, 255 );
	
	if( v.mat ) then
		
		surface.SetMaterial( v.mat );
		
	end
	
	if( v.disableclip ) then
	
		DisableClipping( true );
		
	end
	
	surface.DrawTexturedRectUV( v.x or 0, v.y or 0, w + ( addw or 0 ), h + ( addh or 0 ), v.u0, v.v0, v.u1, v.v1 );
	
	if( v.disableclip ) then
	
		DisableClipping( false );
		
	end
end

function UVSkin:PaintScrollButtonUp(panel, w, h)
	local skin = kingston.gui.classes[panel:GetSkin().Name];
	local v = self.Scrollbar[3];

	surface.SetDrawColor( 255, 255, 255, 255 );
	
	if( v.mat ) then
		
		surface.SetMaterial( v.mat );
		
	end
	
	if( v.disableclip ) then
	
		DisableClipping( true );
		
	end
	
	surface.DrawTexturedRectUV( v.x or 0, v.y or 0, w + ( addw or 0 ), h + ( addh or 0 ), v.u0, v.v0, v.u1, v.v1 );
	
	if( v.disableclip ) then
	
		DisableClipping( false );
		
	end
end

function UVSkin:PaintDialogMenu(panel, w, h)
	local skin = kingston.gui.classes[panel:GetSkin().Name];
	local v = self.DialogMenu;

	surface.SetDrawColor( 255, 255, 255, 255 );
	
	if( v.mat ) then
		
		surface.SetMaterial( v.mat );
		
	end
	
	if( v.disableclip ) then
	
		DisableClipping( true );
		
	end
	
	surface.DrawTexturedRectUV( v.x or 0, v.y or 0, w + ( v.addw or 0 ), h + ( v.addh or 0 ), v.u0, v.v0, v.u1, v.v1 );
	
	if( v.disableclip ) then
	
		DisableClipping( false );
		
	end
end

kingston.gui.RegisterSkin( "STALKER", UVSkin );