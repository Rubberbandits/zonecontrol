local PANEL = {}

function PANEL:SetText(text)
	self.text = text
	//self.markup = king.markup.parse(text, self:GetWide())
	self:InvalidateLayout(true)
end

function PANEL:GetText()
	return self.text
end

function PANEL:PerformLayout(w, h)
	if not self.text then return end

	local markup_obj = king.markup.parse(self.text, w)
	if h != markup_obj:getHeight() then
		self:SetSize(markup_obj:size())
		self.markup = markup_obj
	end
end

function PANEL:Paint(w, h)
	if not self.markup then return end

	self.markup:draw(0, 0)
end

vgui.Register("MarkupText", PANEL, "Panel")