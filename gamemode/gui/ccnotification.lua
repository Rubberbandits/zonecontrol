PANEL = { };

AccessorFunc( PANEL, "m_colHeaderText", 				"HeaderTextColor" );
AccessorFunc( PANEL, "m_colBodyText", 				"BodyTextColor" );
AccessorFunc( PANEL, "m_colTextStyle", 			"TextStyleColor" )
AccessorFunc( PANEL, "m_HeaderFontName", 				"HeaderFont" )
AccessorFunc( PANEL, "m_BodyFontName", 				"BodyFont" )

PANEL.SetColor = PANEL.SetTextColor;
PANEL.ChildLabels = { };

function PANEL:GetColor()

	return self.m_colTextStyle

end

-- since all the notifications are a bunch of images stitched together in a single file.
function PANEL:SetNotificationImage( nX, nY )

	self.nNotificationX = nX;
	self.nNotificationY = nY;

end

function PANEL:SetHeaderText( t )
	self.FakeHeaderText = t;
	
	surface.SetFont( self.m_HeaderFontName );
	local h = GAMEMODE.FontHeight[self.m_HeaderFontName];
	
	if( !self.ChildHeaderLabels ) then
		
		self.ChildHeaderLabels = { };
		
	end
	
	for _, v in pairs( self.ChildHeaderLabels ) do
		
		v:Remove();
		
	end
	
	self.ChildHeaderLabels = { };
	
	local lines = string.Explode( "\n", GAMEMODE:FormatLine( self.FakeHeaderText or "", self.m_HeaderFontName, self:GetWide() - ScrW() / 16 ) );
	local s = 1;
	
	local y = 0;
	
	for k, v in pairs( lines ) do
		
		local label = vgui.Create( "DLabel", self );
		label:SetText( v );
		label:SetSize( self:GetWide() - ScrW() / 16, h );
		label:SetPos( ScrW() / 16 + 8, y );
		label:SetFont( self.m_HeaderFontName );
		label:SetTextColor( self.m_colHeaderText );
		label:SetAutoStretchVertical( true );
		label:SetWrap( true );
		label:PerformLayout();
		table.insert( self.ChildHeaderLabels, label );
		
		y = y + h;
		
	end
end

function PANEL:SetBodyText( t )
	
	self.FakeBodyText = t;
	
	surface.SetFont( self.m_BodyFontName );
	local h = GAMEMODE.FontHeight[self.m_BodyFontName];
	
	if( !self.ChildBodyLabels ) then
		
		self.ChildBodyLabels = { };
		
	end
	
	for _, v in pairs( self.ChildBodyLabels ) do
		
		v:Remove();
		
	end
	
	self.ChildBodyLabels = { };
	
	local lines = string.Explode( "\n", GAMEMODE:FormatLine( self.FakeBodyText or "", self.m_BodyFontName, self:GetWide() - ScrW() / 16 ) );
	local s = 1;
	
	local y = 0;
	
	for k,v in next, self.ChildHeaderLabels or {} do
		y = y + v:GetTall()
	end
	
	for k, v in pairs( lines ) do
		
		local label = vgui.Create( "DLabel", self );
		label:SetText( v );
		label:SetSize( self:GetWide() - ScrW() / 16, h );
		label:SetPos( ScrW() / 16 + 8, y );
		label:SetFont( self.m_BodyFontName );
		label:SetTextColor( self.m_colBodyText );
		label:SetAutoStretchVertical( true );
		label:SetWrap( true );
		label:PerformLayout();
		table.insert( self.ChildBodyLabels, label );
		
		y = y + h;
		
	end
	
end

function PANEL:Paint( w, h )
	
	kingston.gui.FindFunc( self, "Paint", "PDANotification", ScrW() / 16, ScrH() / 18 );
	
end

function PANEL:PerformLayout()
	
	self:SizeToContentsY();
	
end

function PANEL:SizeToContentsY()
	
	local y = 0;
	
	for k, v in pairs( self.ChildLabels ) do
		
		v:SetPos( ScrW() / 16 + 8, y );
		y = y + v:GetTall();
		
	end
	
	self:SetTall( y + ScrH() / 18 );
	
end

derma.DefineControl( "CCNotification", "", PANEL, "DPanel" )