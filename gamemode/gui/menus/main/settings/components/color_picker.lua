local PANEL = {}

function PANEL:DoClick()
	if self.open then return end
	self.open = true

	self.popup = vgui.Create("EditablePanel")
	self.popup:SetSize(256, 256)
	self.popup:SetPos(self:LocalToScreen(0, self:GetTall()))
	self.popup:MakePopup()
	self.popup.OnFocusChanged = function(_, gained)
		if gained then return end

		self.popup:Remove()
		self.open = false
	end

	local picker = self.popup:Add("DColorCombo")
	picker:Dock(FILL)
	picker:SetColor(self:GetColor())
	picker.OnValueChanged = function(_, color)
		self:SetColor(color)
		self:OnColorChanged(color)
	end
	picker.OnFocusChanged = function(_, gained)
		if gained then return end

		self.popup:Remove()
		self.open = false
	end
end

function PANEL:OnColorChanged(color)
	// For override
end

vgui.Register("ColorPicker", PANEL, "DColorButton")