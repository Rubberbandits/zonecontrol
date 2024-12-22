local PANEL = {}

function PANEL:SetText(text)
	self.text = text
	self:InvalidateLayout(true)

	local w, h = self:GetSize()
	local markup_obj = king.markup.parse(self.text, w - 2)
	if not markup_obj then return end

	if h != markup_obj:getHeight() then
		local _, markup_h = markup_obj:size()
		self:SetSize(w, markup_h + 10)
		self.markup = markup_obj
	end
end

function PANEL:GetText()
	return self.text
end

function PANEL:Paint(w, h)
	if not self.markup then return end

	self.markup:draw(2, 5)
end

vgui.Register("MarkupText", PANEL, "Panel")