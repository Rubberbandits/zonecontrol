local PANEL = {}

function PANEL:Init()

end

function PANEL:PerformLayout(w, h)

end

function PANEL:Paint(w, h)
    surface.SetDrawColor(0, 0, 0, 200)
    surface.DrawRect(0, 0, w, h)
end

vgui.Register("ChatText", PANEL, "EditablePanel")