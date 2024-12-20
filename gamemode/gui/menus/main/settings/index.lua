local PANEL = {}

function PANEL:Init()
	self.changed_settings = {}

	for _,category in pairs(zonecontrol.settings.categories) do
		local panel = self:Add("DScrollPanel")

		for key,data in pairs(zonecontrol.settings.default) do
			if data.category != category then continue end

			local current_value = zonecontrol.settings.get(key)

			local setting = panel:Add("SettingItem")
			setting:SetText("#" .. key)
			setting:SetTall(64)
			setting:Dock(TOP)
			setting:DockMargin(4, 4, 4, 4)

			if data.type == "float" then
				setting:CreateSlider(0, 100, current_value, function(_, choice)
					self.changed_settings[key] = choice / 100
				end)
			elseif data.type == "bool" then
				setting:CreateTickBox(current_value, function(_, choice)
					self.changed_settings[key] = choice
				end)
			elseif data.type == "int" and category == "controls" then
				setting:CreateBinder(current_value, function(_, choice)
					self.changed_settings[key] = choice
				end)
			elseif data.type == "color" then
				setting:CreateColorPicker(current_value, function(_, choice)
					self.changed_settings[key] = choice
				end)
			end
		end

		local sheet_data = self:AddSheet(string.upper(category), panel)
		sheet_data.Tab:SetFont("MainMenuSelection")
		sheet_data.Tab:SizeToContents()
	end
end

function PANEL:OnRemove()
	for key,value in pairs(self.changed_settings) do
		zonecontrol.settings.set(key, value)
	end
end

function PANEL:AddSheet( label, panel, material, NoStretchX, NoStretchY, Tooltip )
	if not IsValid(panel) then
		ErrorNoHalt( "DPropertySheet:AddSheet tried to add invalid panel!" )
		debug.Trace()
		return
	end

	local Sheet = {}

	Sheet.Name = label

	Sheet.Tab = vgui.Create("SettingsTab", self)
	Sheet.Tab:SetTooltip(Tooltip)
	Sheet.Tab:Setup(label, self, panel, material)

	Sheet.Panel = panel
	Sheet.Panel.NoStretchX = NoStretchX
	Sheet.Panel.NoStretchY = NoStretchY
	Sheet.Panel:SetPos(self:GetPadding(), 40 + self:GetPadding())
	Sheet.Panel:SetVisible(false)

	panel:SetParent(self)

	table.insert(self.Items, Sheet)

	if not self:GetActiveTab() then
		self:SetActiveTab(Sheet.Tab)
		Sheet.Panel:SetVisible(true)
	end

	self.tabScroller:AddPanel(Sheet.Tab)

	return Sheet
end

vgui.Register("Settings", PANEL, "DPropertySheet")