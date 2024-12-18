local PANEL = {}

function PANEL:Init()
	self.lines = util.Stack()
end

function PANEL:AddLine(text)
	local line = self:Add("MarkupText")
	line:Dock(BOTTOM)
	line:SetText(text)
	line:SizeToContents()

	self.lines:Push(line)

	if self.lines:Size() > 50 then
		self.lines:Pop():Remove()
	end
end

function PANEL:PerformLayout(w, h)

end

function PANEL:Paint(w, h)
	surface.SetDrawColor(0, 0, 0, 200)
	surface.DrawRect(0, 0, w, h)
end

vgui.Register("ChatText", PANEL, "EditablePanel")