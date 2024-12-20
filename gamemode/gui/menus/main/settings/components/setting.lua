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

function PANEL:CreateSlider(min, max, current_value, on_change)
	local value = self.container:Add("DLabel")
	value:SetFont("MainMenuSelection")
	value:SetText("100%")
	value:SizeToContents()
	value:SetText(string.format("%d%%", current_value * 100))
	value:Dock(RIGHT)
	value:DockMargin(8, 0, 0, 0)

	local slider = self.container:Add("DSlider")
	slider:Dock(FILL)
	slider:SetTrapInside(true)
	slider:SetSlideX(current_value)
	slider.OnValueChanged = function(_, x, y)
		local choice = math.Clamp(math.floor(x * max), min, max)
		value:SetText(string.format("%d%%", choice))

		on_change(slider, choice)
	end
	Derma_Hook(slider, "Paint", "Paint", "NumSlider")
end

function PANEL:CreateTickBox(current_value, on_change)
	local tick = self.container:Add("DCheckBox")
	tick:Dock(RIGHT)
	tick:DockMargin(0, 0, 16, 0)
	tick:SetWide(64)
	tick:SetValue(current_value)
	tick.OnChange = function(_, value)
		on_change(tick, value)
	end
end

function PANEL:CreateBinder(current_value, on_change)
	local binder = self.container:Add("DBinder")
	binder:Dock(RIGHT)
	binder:SetWide(128)
	binder:SetFont("MainMenuSelection")
	binder:SetValue(current_value)
	binder.OnChange = function(_, key)
		on_change(binder, key)
	end
end

function PANEL:CreateColorPicker(current_value, on_change)
	local picker = self.container:Add("ColorPicker")
	picker:Dock(RIGHT)
	picker:SetWide(64)
	picker:DockMargin(0, 0, 4, 0)
	picker:SetColor(current_value)
	picker.OnColorChanged = function(_, color)
		on_change(picker, color)
	end
end

function PANEL:PerformLayout(w, h)
	self.name:DockMargin(4, 2, w * 0.5 - 8, 2)

	self.container:SetWide(w * 0.5 - 8)
	self.container:DockMargin(4, 2, 4, 2)
end

vgui.Register("SettingItem", PANEL, "EditablePanel")