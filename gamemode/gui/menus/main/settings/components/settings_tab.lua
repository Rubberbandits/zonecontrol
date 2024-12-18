local PANEL = {}

function PANEL:GetTabHeight()
	return 40
end

vgui.Register("SettingsTab", PANEL, "DTab")