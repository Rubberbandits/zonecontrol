local PANEL = {}

function PANEL:AddSelection(text, callback)
    local btn = self:Add("DButton")
    btn:SetFont("MainMenuSelection")
    btn:SetText(text)
    btn:SetHeight(ScrH() * 0.05)
    btn:DockMargin(0, 10, 0, 10)
    btn.DoClick = callback
end

vgui.Register("MenuSelection", PANEL, "DListLayout")