hook.Add("InitPostEntity", "InitializeChat", function()
	if not IsValid(GAMEMODE.Chat) then
		GAMEMODE.Chat = zonecontrol.chat.create()
	end
end)

function GM:HUDPaint()
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

			surface.SetDrawColor(20, 20, 20, alpha - 55)
			surface.DrawRect(screen_x, screen_y, w, h)

			line.line.markup:draw(screen_x + 2, screen_y + 5, nil, nil, alpha)
		end
	end
end

function GM:HUDShouldDraw(str)
	if str == "CHudWeaponSelection" then return false end
	if str == "CHudAmmo" then return false end
	if str == "CHudAmmoSecondary" then return false end
	if str == "CHudHealth" then return false end
	if str == "CHudBattery" then return false end
	if str == "CHudChat" then return false end
	if str == "CHudDamageIndicator" then return false end
	if str == "CHudCrosshair" then return false end

	return true
end