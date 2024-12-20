function GM:AddChat( filter, font, ... )
	local text = string.format("<font=%s>", font or "NewChatFont")
	local unedited = {};

	for k, v in ipairs({...}) do
		if type(v) == "IMaterial" then
			local ttx = tostring(v):match("%[[a-z0-9/]+%]")
			ttx = ttx:sub(2, ttx:len() - 1)
			text = text .. "<img=" .. ttx .. "," .. v:Width() .. "x" .. v:Height() .. ">"
		elseif type(v) == "table" and v.r and v.g and v.b then
			text = text .. "<color=" .. v.r .. "," .. v.g .. "," .. v.b .. ">"
			unedited[#unedited + 1] = Color(v.r, v.g, v.b);
		elseif type(v) == "Player" then
			text = text .. v:RPName():gsub("<", "&lt;"):gsub(">", "&gt;")

			unedited[#unedited + 1] = v:RPName();
		else
			if not v then continue end
			text = text .. tostring(v):gsub("<", "&lt;"):gsub(">", "&gt;")
			unedited[#unedited + 1] = tostring(v)
			text = text:gsub("%b//", function(value)
				local inner = value:sub(2, -2)

				if inner:find("%S") then
					return "<font=" .. font .. "Italic>" .. value:sub(2, -2) .. "</font>"
				end
			end)
			text = text:gsub("%b**", function(value)
				local inner = value:sub(2, -2)

				if inner:find("%S") then
					return "<font=" .. font .. "Bold>" .. value:sub(2, -2) .. "</font>"
				end
			end)
		end
	end

	unedited[#unedited + 1] = "\n"
	text = text .. "</font>"
	GAMEMODE.Chat:AddLine(text)
	MsgC(unpack(unedited));

	filter = filter or {}

	if not system.HasFocus() then
		system.FlashWindow();
	end

	chat.PlaySound()
end

function nAddChat( col, str )

	GAMEMODE:AddChat( {[CB_ALL] = true, [CB_OOC] = true}, "NewChatFont", Color( col.x, col.y, col.z, 255 ), str );

end
netstream.Hook( "nAddChat", nAddChat );

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

		GAMEMODE:AddChat( {[CB_ALL] = true, [CB_OOC] = true}, "NewChatFont", col, str );

	end

end

hook.Add("InitPostEntity", "InitializeChat", function()
	if not IsValid(GAMEMODE.Chat) then
		GAMEMODE.Chat = zonecontrol.chat.create()
	end
end)

hook.Add("HUDPaint", "PaintChat", function()
	local chatbox = GAMEMODE.Chat
	if IsValid(chatbox) and not chatbox:HasHierarchicalFocus() then
		local chatbox_text = chatbox.chat
		if chatbox_text.last_line_added and chatbox_text.last_line_added + 10 < CurTime() then return end

		local total_lines = chatbox_text.lines:Size()
		for idx = total_lines, total_lines - 5, -1 do
			if idx == 0 then break end
			local line = chatbox_text.lines[idx]

			if not line then continue end
			if not istable(line) then continue end
			if CurTime() - line.added > 6 then continue end

			local screen_x, screen_y = line.line:LocalToScreen(0, 0)
			local w, h = line.line:GetSize()

			local alpha = 255
			if CurTime() - line.added > 5 then
				local progress = (CurTime() - (line.added + 5)) / 1
				alpha = Lerp(progress, 255, 0)
			end

			surface.SetDrawColor(20, 20, 20, math.Clamp(alpha, 0, 200))
			surface.DrawRect(screen_x, screen_y, w, h)

			line.line.markup:draw(screen_x + 2, screen_y + 5, nil, nil, alpha)
		end
	end
end)