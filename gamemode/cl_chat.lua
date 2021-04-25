GM.ChatboxOpen = GM.ChatboxOpen or false;
GM.ChatboxFilter = GM.ChatboxFilter or CB_ALL;

GM.ChatWidth = 600;
GM.ChatButtonWidth = 138;
GM.ChatButtonHeight = 20;

GM.ChatLines = GM.ChatLines or { };

function GM:AddChat( filter, font, ... )

	local text = "<font=CombineControl.ChatNormal>"
	local unedited = {};

	if (font) then
		text = "<font="..(font or "CombineControl.ChatNormal")..">"
	end
	
	for k, v in ipairs({...}) do
		if (type(v) == "IMaterial") then
			local ttx = tostring(v):match("%[[a-z0-9/]+%]")
			ttx = ttx:sub(2, ttx:len() - 1)
			text = text.."<img="..ttx..","..v:Width().."x"..v:Height()..">"
		elseif (type(v) == "table" and v.r and v.g and v.b) then
			text = text.."<color="..v.r..","..v.g..","..v.b..">"
			unedited[#unedited + 1] = Color(v.r, v.g, v.b);
		elseif (type(v) == "Player") then
			text = text..v:RPName():gsub("<", "&lt;"):gsub(">", "&gt;")
			
			unedited[#unedited + 1] = v:RPName();
		else
			if( !v ) then continue end
			text = text..tostring(v):gsub("<", "&lt;"):gsub(">", "&gt;")
			unedited[#unedited + 1] = tostring(v)
			text = text:gsub("%b//", function(value)
				local inner = value:sub(2, -2)

				if (inner:find("%S")) then
					return "<font="..font.."Italic>"..value:sub(2, -2).."</font>"
				end
			end)
			text = text:gsub("%b**", function(value)
				local inner = value:sub(2, -2)
				
				if(inner:find("%S")) then
					return "<font="..font.."Bold>"..value:sub(2, -2).."</font>"
				end
			end)
		end
	end

	unedited[#unedited + 1] = "\n"
	text = text.."</font>"
	table.insert( self.ChatLines, { CurTime(), filter, font, text, owner } );
	MsgC(unpack(unedited));
	
	if( #self.ChatLines > 100 ) then
		
		for i = 1, #self.ChatLines - 100 do
			
			table.remove( self.ChatLines, 1 );
			
		end
		
	end

	filter = filter or {}
	
	if( !system.HasFocus() and filter[self.ChatboxFilter] ) then
		
		system.FlashWindow();
		
	end
	
	chat.PlaySound()
	
	return #self.ChatLines;
	
end

function nAddChat( col, str )
	
	GAMEMODE:AddChat( {[CB_ALL] = true, [CB_OOC] = true}, "CombineControl.ChatNormal", Color( col.x, col.y, col.z, 255 ), str );
	
end
netstream.Hook( "nAddChat", nAddChat );

function GM:DrawChat()
	
	if( !self.ChatboxOpen ) then
		
		local y = ScrH() - 200 - 40 - 34;
		
		local tab = { };
		
		if !self.ChatLines then return end
		
		for _, v in ipairs( self.ChatLines ) do
			local filter = v[2] or {}

			if( filter[self.ChatboxFilter] and CurTime() - v[1] < 10 ) then
				
				table.insert( tab, v );
				
			end
			
		end
		
		local ty = 0;
		
		for i = #tab, math.max( #tab - 8, 1 ), -1 do
			
			local start = tab[i][1];
			local filter = tab[i][2];
			local font = tab[i][3];
			local text = tab[i][4];
			
			local amul = 0;
			
			if( CurTime() - start < 9 ) then
				
				amul = 1;
				
			else
				
				amul = 1 - ( CurTime() - start - 9 );
				
			end
			
			if( !tab[i].MarkupObjCreated ) then
			
				tab[i].MarkupObjCreated = true;
				tab[i].obj = king.markup.parse( text, ScreenScale(192) );
				tab[i].obj.onDrawText = function( text, font, x, y, colour, halign, valign, alphaoverride, blk )
				
					if (valign == TEXT_ALIGN_CENTER) then	
					
						y = y - (tab[i].obj.totalHeight / 2)
						
					elseif (valign == TEXT_ALIGN_BOTTOM) then	
					
						y = y - (tab[i].obj.totalHeight)
						
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
				
				end;
				
			end
			if( !tab[i].obj ) then return end
			tab[i].obj:draw( 30, y - tab[i].obj:getHeight(), nil, nil, 255 * amul );

			y = y - tab[i].obj:getHeight();
			ty = ty + tab[i].obj:getHeight();
			
		end
		
	end
	
end

function GM:DrawRadioChat()

	local y = ScrH() - 600 - 40 - 34;
	
	local tab = { };
	
	for _, v in ipairs( self.ChatLines ) do
		local filter = v[2] or {}

		if( filter[CB_RADIO] and CurTime() - v[1] < 10 ) then
			
			table.insert( tab, v );
			
		end
		
	end
	
	local ty = 0;
	
	for i = #tab, math.max( #tab - 8, 1 ), -1 do
		
		local start = tab[i][1];
		local filter = tab[i][2];
		local font = tab[i][3];
		local text = tab[i][4];
		
		local amul = 0;
		
		if( CurTime() - start < 9 ) then
			
			amul = 1;
			
		else
			
			amul = 1 - ( CurTime() - start - 9 );
			
		end
		
		if( !tab[i].MarkupObjCreated ) then
		
			tab[i].MarkupObjCreated = true;
			tab[i].obj = king.markup.parse( text, ScreenScale(192) );
			tab[i].obj.onDrawText = function( text, font, x, y, colour, halign, valign, alphaoverride, blk )
			
				if (valign == TEXT_ALIGN_CENTER) then	
				
					y = y - (tab[i].obj.totalHeight / 2)
					
				elseif (valign == TEXT_ALIGN_BOTTOM) then	
				
					y = y - (tab[i].obj.totalHeight)
					
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
			
			end;
			
		end
		if( !tab[i].obj ) then return end
		tab[i].obj:draw( 30, y - tab[i].obj:getHeight(), nil, nil, 255 * amul );

		y = y - tab[i].obj:getHeight();
		ty = ty + tab[i].obj:getHeight();
		
	end

end

function GM:CreateChatbox()
	
	self.ChatboxOpen = true;
	
	CCP.Chatbox = vgui.Create( "CCChat" );
	CCP.Chatbox:SetSize( ScreenScale(200), ScreenScale(100) );
	CCP.Chatbox:SetPos( ScrW() / 96, ScrH() - (ScrH() / 5.4) - (ScrH() / 31) - (ScrH() / 3.6) );
	function CCP.Chatbox:Think()
	
		if( input.IsKeyDown( KEY_ESCAPE ) ) then
		
			GAMEMODE.ChatboxOpen = false;
			
			netstream.Start( "SetTyping", 0 );
			
			self:Remove();

			GAMEMODE.Chat = nil;
		
		end
		
	end
	CCP.Chatbox:MakePopup();
	
	CCP.MessagesSent = CCP.MessagesSent or {}
	
	CCP.Chatbox.Entry = vgui.Create( "DTextEntry", CCP.Chatbox );
	CCP.Chatbox.Entry:SetFont( "CombineControl.ChatNormal" );
	CCP.Chatbox.Entry:SetPos( ScreenScale(4), ScreenScale(90) );
	CCP.Chatbox.Entry:SetSize( ScreenScale(192), ScreenScale(8) );
	CCP.Chatbox.Entry.History = CCP.MessagesSent
	CCP.Chatbox.Entry:PerformLayout();
	function CCP.Chatbox.Entry:OnEnter()
		
		if( string.len( self:GetValue() ) > 0 ) then
			
			if( string.len( self:GetValue() ) > 2000 ) then
				
				GAMEMODE:AddChat( {[CB_ALL] = true, [CB_OOC] = true}, "CombineControl.ChatNormal", Color( 200, 0, 0, 255 ), "The maximum chat length is 2000 characters. You typed " .. string.len( self:GetValue() ) .. "." );
				GAMEMODE.NextChatText = self:GetValue();
				
			else
				
				netstream.Start( "nSay", self:GetValue() );
				
			end
			
			table.insert(CCP.MessagesSent, 1, self:GetValue())
			if #CCP.MessagesSent == 50 then
				CCP.MessagesSent[#CCP.MessagesSent] = nil
			end
			
		else
			
			GAMEMODE.NextChatText = nil;
			
		end
		
		GAMEMODE.ChatboxOpen = false;
		
		self:GetParent():Remove();
		
		CCP.Chatbox = nil;
		
	end
	function CCP.Chatbox.Entry:OnTextChanged()
		
		if( string.len( self:GetValue() ) > 0 ) then
			
			if( LocalPlayer():Typing() == 1 ) then return end

			net.Start("nSetTyping")
				net.WriteBool(true)
			net.SendToServer()
		
		else
		
			if( LocalPlayer():Typing() == 0 ) then return end
			
			net.Start("nSetTyping")
				net.WriteBool(false)
			net.SendToServer()
			
		end
			
		self:SetTextColor( Color( 200, 200, 200, 255 ) );
		
	end
	function CCP.Chatbox.Entry:OnKeyCode(code)
		if ( code == KEY_UP ) then
			self.HistoryPos = self.HistoryPos + 1
			self:UpdateFromHistory()
		end

		if ( code == KEY_DOWN || code == KEY_TAB ) then
			self.HistoryPos = self.HistoryPos - 1
			self:UpdateFromHistory()
		end
	end
	if( self.NextChatText ) then
		
		CCP.Chatbox.Entry:SetValue( self.NextChatText );
		self.NextChatText = nil;
		
	end
	CCP.Chatbox.Entry:RequestFocus();
	CCP.Chatbox.Entry:SetCaretPos( string.len( CCP.Chatbox.Entry:GetValue() ) );
	
	CCP.Chatbox.AllButton = vgui.Create( "DButton", CCP.Chatbox );
	CCP.Chatbox.AllButton:SetFont( "CombineControl.LabelSmall" );
	CCP.Chatbox.AllButton:SetText( "All" );
	CCP.Chatbox.AllButton:SetPos( ScreenScale(4), ScreenScale(4) );
	CCP.Chatbox.AllButton:SetSize( ScreenScale(48), ScreenScale(8) );
	function CCP.Chatbox.AllButton:DoClick()
		
		CCP.Chatbox.AllButton:SetDisabled( true );
		CCP.Chatbox.ICButton:SetDisabled( false );
		CCP.Chatbox.OOCButton:SetDisabled( false );
		GAMEMODE.ChatboxFilter = CB_ALL;
		
	end
	
	CCP.Chatbox.ICButton = vgui.Create( "DButton", CCP.Chatbox );
	CCP.Chatbox.ICButton:SetFont( "CombineControl.LabelSmall" );
	CCP.Chatbox.ICButton:SetText( "IC" );
	local x,y,w,h = CCP.Chatbox.AllButton:GetBounds()
	CCP.Chatbox.ICButton:SetPos( x + w + ScreenScale(4), ScreenScale(4) );
	CCP.Chatbox.ICButton:SetSize( ScreenScale(48), ScreenScale(8) );
	function CCP.Chatbox.ICButton:DoClick()
		
		CCP.Chatbox.AllButton:SetDisabled( false );
		CCP.Chatbox.ICButton:SetDisabled( true );
		CCP.Chatbox.OOCButton:SetDisabled( false );
		GAMEMODE.ChatboxFilter = CB_IC;
		
	end
	
	CCP.Chatbox.OOCButton = vgui.Create( "DButton", CCP.Chatbox );
	CCP.Chatbox.OOCButton:SetFont( "CombineControl.LabelSmall" );
	CCP.Chatbox.OOCButton:SetText( "OOC" );
	local x,y,w,h = CCP.Chatbox.ICButton:GetBounds()
	CCP.Chatbox.OOCButton:SetPos( x + w + ScreenScale(4), ScreenScale(4) );
	CCP.Chatbox.OOCButton:SetSize( ScreenScale(48), ScreenScale(8) );
	function CCP.Chatbox.OOCButton:DoClick()
		
		CCP.Chatbox.AllButton:SetDisabled( false );
		CCP.Chatbox.ICButton:SetDisabled( false );
		CCP.Chatbox.OOCButton:SetDisabled( true );
		GAMEMODE.ChatboxFilter = CB_OOC;
		
	end
	
	if( self.ChatboxFilter == CB_ALL ) then
		
		CCP.Chatbox.AllButton:SetDisabled( true );
		
	end
	
	if( self.ChatboxFilter == CB_IC ) then
		
		CCP.Chatbox.ICButton:SetDisabled( true );
		
	end
	
	if( self.ChatboxFilter == CB_OOC ) then
		
		CCP.Chatbox.OOCButton:SetDisabled( true );
		
	end
	
	CCP.Chatbox.CloseButton = vgui.Create( "DButton", CCP.Chatbox );
	CCP.Chatbox.CloseButton:SetFont( "marlett" );
	CCP.Chatbox.CloseButton:SetText( "r" );
	CCP.Chatbox.CloseButton:SetPos( ScreenScale(200) - ScreenScale(12), ScreenScale(4) );
	CCP.Chatbox.CloseButton:SetSize( ScreenScale(8), ScreenScale(8) );
	function CCP.Chatbox.CloseButton:DoClick()
		
		GAMEMODE.ChatboxOpen = false;
		
		self:GetParent():Remove();
		
		CCP.Chatbox = nil;
		
	end
	
end

function GM:StartChat()
	
	return true;
	
end

function GM:ChatText( index, name, text, type )
	
	if( self.NotifyWhenPlayersJoin ) then
		
		if( type == "joinleave" ) then
			if( !string.find( text, "left the game" ) ) then
				GAMEMODE:AddChat( {[CB_ALL] = true, [CB_OOC] = true}, "CombineControl.ChatNormal", Color( 150, 150, 150, 255 ), text );
			end
		end
		
	end
	
	return true;
	
end

if( !chat.OldAddText ) then

	chat.OldAddText = chat.AddText;

	function chat.AddText( ... )
		
		local args = { ... };
		
		local col;
		local str = "";
		
		for k, v in pairs( args ) do
			
			if( type( v ) == "table" and !col ) then
				
				col = v;
				
			elseif( type( v ) == "string" ) then
				
				str = str .. v;
				
			elseif( type( v ) == "Player" ) then
				
				str = str .. v:Nick();
				
			end
			
		end
		
		GAMEMODE:AddChat( {[CB_ALL] = true, [CB_OOC] = true}, "CombineControl.ChatNormal", col, str );
		
	end
	
end

function GM:AddPDANotification(header, body, notif_x, notif_y, is_priority)
	local notification = {
		header = header,
		body = body,
		notif_x = notif_x,
		notif_y = notif_y,
		start = CurTime(),
		paint_alpha = 1,
		priority = is_priority,
	}
	table.insert(GAMEMODE.PDANotifications, notification)
	
	if #GAMEMODE.PDANotifications > 3 then
		table.remove(GAMEMODE.PDANotifications, 1)
	end
	
	hook.Run("PDANotificationAdded", notification)
end

function GM:PDANotificationAdded(notif)
	MsgC(Color(128, 128, 128), Format("[PDA] %s\t", notif.header))
	MsgC(Color(229, 201, 98), Format("%s\n", notif.body))
	
	if cookie.GetNumber("zc_pdasound", 1) == 1 or notif.priority then
		surface.PlaySound("kingston/pda/pda_tip.ogg")
	end
	
	kingston.log.write("chat", "[%s][pda] %s", notif.header, notif.body)
end

local function nStockpileNameTaken()
	LocalPlayer():Notify(nil, COLOR_ERROR, "This stockpile name is already taken!")
end
netstream.Hook( "nStockpileNameTaken", nStockpileNameTaken );

local function nAddPDANotification(header, body, notif_x, notif_y, is_priority)
	GAMEMODE:AddPDANotification(header, body, notif_x, notif_y, is_priority)
end
netstream.Hook( "nAddPDANotif", nAddPDANotification )