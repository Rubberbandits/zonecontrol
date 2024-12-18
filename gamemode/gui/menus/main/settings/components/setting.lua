local PANEL = {}

function PANEL:Init()
	self.name = self:Add("DLabel")
	self.name:Dock(LEFT)
	self.name:DockMargin(4, 2, self:GetWide() * 0.5 - 8, 2)
	self.name:SetFont("MainMenuSelection")

	self.container = self:Add("EditablePanel")
	self.container:Dock(RIGHT)
	self.container:DockMargin(4, 2, self:GetWide() * 0.5 - 8, 2)
	self.container:SetWide(self:GetWide() * 0.5 - 8)
end

function PANEL:SetText(text)
	self.name:SetText(text)
	self.name:SizeToContents()
end

function PANEL:Paint(w, h)
	surface.SetDrawColor(20, 20, 20, 200)
	surface.DrawRect(0, 0, w, h)
end

function PANEL:CreateSlider(min, max, on_change)
	local slider = self.container:Add("DSlider")
	slider:Dock(FILL)
	slider:SetTrapInside(true)
	slider:SetSlideX(0)
	slider.OnValueChanged = function(_, x, y)
		local choice = math.Clamp(math.floor(x * max), min, max)
		on_change(slider, choice)
	end
	Derma_Hook(slider, "Paint", "Paint", "NumSlider")
end

function PANEL:PerformLayout(w, h)
	self.name:DockMargin(4, 2, w * 0.5 - 8, 2)

	self.container:SetWide(w * 0.5 - 8)
	self.container:DockMargin(4, 2, 4, 2)
end

vgui.Register("SettingItem", PANEL, "EditablePanel")