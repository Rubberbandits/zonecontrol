PANEL = { };

function PANEL:Init()
	
	self.chat_bg_opacity = cookie.GetNumber( "zc_chatopacity", 0.8 )
	self.ContentScroll = vgui.Create( "DScrollPanel", self );
	self.ContentScroll:SetPos( ScreenScale(4), ScreenScale(16) );
	self.ContentScroll:SetSize( ScreenScale(192), ScreenScale(72) );
	function self.ContentScroll:Paint( w, h )
		
		surface.SetDrawColor( 0, 0, 0, 70 );
		surface.DrawRect( 0, 0, w, h );
		
		surface.SetDrawColor( 0, 0, 0, 100 );
		surface.DrawOutlinedRect( 0, 0, w, h );
		
	end
	
	self.Content = vgui.Create( "EditablePanel" );
	self.Content:SetPos( 0, 0 );
	self.Content:SetSize( ScreenScale(192), ScreenScale(10) );
	self.Content.Paint = function( content, pw, ph )
		
		local y = 0;
		
		for k, v in pairs( GAMEMODE.ChatLines ) do
			
			local start = v[1];
			local filter = v[2];
			local font = v[3];
			local text = v[4];
			
			if( table.HasValue( filter or {}, GAMEMODE.ChatboxFilter ) ) then
				
				if( !v.MarkupObjCreated ) then
				
					v.MarkupObjCreated = true;
					v.obj = king.markup.parse( text, ScreenScale(192) );
					v.obj.onDrawText = function( text, font, x, y, colour, halign, valign, alphaoverride, blk )

						if (valign == TEXT_ALIGN_CENTER) then	
						
							y = y - (v.obj.totalHeight / 2)
							
						elseif (valign == TEXT_ALIGN_BOTTOM) then	
						
							y = y - (v.obj.totalHeight)
							
						end
						
						local alpha = blk.colour.a
						if (alphaoverride) then alpha = alphaoverride end

						surface.SetFont( font )
						surface.SetTextColor( 0, 0, 0, alpha );
						surface.SetTextPos( x + 1, y + 1 );
						surface.DrawText( text );
						surface.SetTextColor( colour.r, colour.g, colour.b, alpha )
						surface.SetTextPos( x, y )
						surface.DrawText( text )
					
					end
					
				end
				if( !v.obj ) then return end
				v.obj:draw( 2, y, nil, nil );
				
				y = y + v.obj:getHeight();
				
			end
			
		end
		
		if( ph != math.max( y, 20 ) ) then
			
			content:SetTall( math.max( y, 20 ) );
			self.ContentScroll:PerformLayout();
			
			if( self.ContentScroll.VBar ) then
				
				self.ContentScroll.VBar:SetScroll( math.huge );
				
			end
			
		end
		
	end
	
	self.ContentScroll:AddItem( self.Content );
	
end

function PANEL:Paint( w, h )

	draw.RoundedBox( 0, 0, 0, w, h, Color( 30, 30, 30, 255 * self.chat_bg_opacity or 0.8 ) );
	
	return true

end

derma.DefineControl( "CCChat", "", PANEL, "EditablePanel" );