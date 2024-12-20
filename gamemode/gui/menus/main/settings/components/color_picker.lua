local PANEL = {}

function PANEL:DoClick()
    if IsValid(self.popup) then self.popup:Remove() return end

    self.popup = vgui.Create("EditablePanel")
    self.popup:SetSize(256, 256)
    self.popup:SetPos(self:LocalToScreen(0, self:GetTall()))
    self.popup:MakePopup()

    local picker = self.popup:Add("DColorCombo")
    picker:Dock(FILL)
    picker:SetColor(self:GetColor())
    picker.OnValueChanged = function(_, color)
        self:SetColor(color)
        self:OnColorChanged(color)
    end
end

function PANEL:OnColorChanged(color)
    // For override
end

vgui.Register("ColorPicker", PANEL, "DColorButton")