_G.oldVGUICreate = _G.oldVGUICreate or vgui.Create
_G.vguiElements = _G.vguiElements or {}

function vgui.Create(...)
	local pnl = oldVGUICreate(...)
	table.insert(vguiElements, pnl)
	return pnl;
end

local cursor = Material("kingston/cursor")

function GM:CreateCursor()
	function hideCursor()
		for idx, pnl in ipairs(vguiElements) do
			if pnl and pnl:IsValid() and not pnl.CursorSet then
				pnl:SetCursor("blank")
				pnl.CursorSet = true
			elseif not pnl or not pnl:IsValid() then
				table.remove(vguiElements, idx)
			end
		end
	end
	hook.Add("Think", "STALKER.HideCursor", hideCursor)

	hook.Add("PostRenderVGUI", "STALKER.Cursor", function()
		if vgui.CursorVisible() and not gui.IsGameUIVisible() and system.HasFocus() then
			local x,y = input.GetCursorPos()

			surface.SetDrawColor(255, 255, 255, 255)
			surface.SetMaterial(cursor)
			surface.DrawTexturedRectUV(x, y, 48, 48, 0, 0, 0.65, 0.65)
		end
	end)

--[[ 	local overlay = vgui.Create("DPanel") 
	overlay:SetSize(ScrW(), ScrH()) 
	overlay.Paint = function() end
	_G.CursorOverlay = overlay ]]
end

function GM:DisableCursor()
	hook.Remove("Think", "STALKER.HideCursor")
	hook.Remove("PostRenderVGUI", "STALKER.Cursor")

	for _, pnl in next, vguiElements do
		if pnl and pnl:IsValid() then
			pnl:SetCursor("arrow")
		end
	end

	//_G.CursorOverlay:Remove()
end

if cookie.GetNumber("zc_cursor", 0) == 1 then
	GM:CreateCursor()
end