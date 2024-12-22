local PANEL = {}

function PANEL:Init()
	self.lines = util.Stack()
	self.last_line_added = 0
	self:GetVBar():SetHideButtons(true)
end

function PANEL:AddLine(text)
	local line = self:Add("MarkupText")
	line:Dock(TOP)
	line:SetWide(self:GetWide())
	line:DockMargin(0, 2, 0, 2)
	line:SetText(text)
	line:SizeToContents()

	self.lines:Push({line = line, added = CurTime()})

	if self.lines:Size() > 50 then
		self.lines:Pop():Remove()
	end

	self:InvalidateChildren(true)

	local vbar = self:GetVBar()
	local canvas_height = self:GetCanvas():GetTall()
	if canvas_height > self:GetTall() then
		vbar:SetScroll(canvas_height)
	end

	self.last_line_added = CurTime()
end

function PANEL:Paint(w, h)
	surface.SetDrawColor(20, 20, 20, 200)
	surface.DrawRect(0, 0, w, h)
end

vgui.Register("ChatText", PANEL, "DScrollPanel")