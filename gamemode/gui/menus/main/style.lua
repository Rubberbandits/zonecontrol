surface.ClearMaterial = draw.NoTexture

local SKIN = {}

SKIN.fontLabel = "MainMenuSelection"

SKIN.Colours = {}

SKIN.Colours.Button = {}
SKIN.Colours.Button.Normal			= Color(255, 255, 255, 255)
SKIN.Colours.Button.Hover			= Color(40, 40, 40, 255)
SKIN.Colours.Button.Down			= Color(100, 100, 100, 255)
SKIN.Colours.Button.Disabled		= GWEN.TextureColor( 4 + 8 * 3, 500 )

SKIN.Colours.Label = {}
SKIN.Colours.Label.Default			= Color(255, 255, 255, 255)
SKIN.Colours.Label.Bright			= Color(255, 255, 255, 255)
SKIN.Colours.Label.Dark				= Color(40, 40, 40, 255)
SKIN.Colours.Label.Highlight		= Color(255, 255, 255, 255)

SKIN.colTextEntryBG				 = Color( 240, 240, 240, 255 )
SKIN.colTextEntryBorder			 = Color( 20, 20, 20, 255 )
SKIN.colTextEntryText			 = Color( 255, 255, 255, 255 )
SKIN.colTextEntryTextHighlight	 = Color( 20, 200, 250, 255 )
SKIN.colTextEntryTextCursor		 = Color( 255, 255, 255, 255 )
SKIN.colTextEntryTextPlaceholder = Color( 128, 128, 128, 255 )

SKIN.GradientL = Material("vgui/gradient-l")
SKIN.GradientR = Material("vgui/gradient-r")
SKIN.GradientU = Material("gui/gradient_up")
SKIN.GradientD = Material("gui/gradient_down")

function SKIN:PaintPanel(panel, w, h)
end

function SKIN:PaintButton(panel, w, h)
	if not panel.Hovered then return end

	surface.SetDrawColor(255, 255, 255, 255)

	surface.SetMaterial(self.GradientR)
		surface.DrawTexturedRectUV(0, 0, w * 0.1, h, 0, 0, 1, 1)
	surface.ClearMaterial()

	surface.DrawRect(w * 0.1, 0, w - w * 0.2, h)

	surface.SetMaterial(self.GradientL)
		surface.DrawTexturedRectUV(w - w * 0.1 - 1, 0, w * 0.1, h, 0, 0, 1, 1)
	surface.ClearMaterial()
end

function SKIN:PaintVScrollBar(panel, w, h)
end

function SKIN:PaintScrollBarGrip(panel, w, h)
	surface.SetDrawColor(255, 255, 255, 255)

	surface.SetMaterial(self.GradientU)
		surface.DrawTexturedRectUV(w * 0.5 - w * 0.125, 0, w * 0.25, h * 0.2, 0, 0, 1, 1)
	surface.ClearMaterial()

	surface.DrawRect(w * 0.5 - w * 0.125, h * 0.2, w * 0.25, h - h * 0.4)

	surface.SetMaterial(self.GradientD)
		surface.DrawTexturedRectUV(w * 0.5 - w * 0.125, h - h * 0.2 - 1, w * 0.25, h * 0.2, 0, 0, 1, 1)
	surface.ClearMaterial()
end

function SKIN:PaintNumSlider(panel, w, h)
	surface.SetDrawColor(255, 255, 255, 255)

	surface.SetMaterial(self.GradientR)
		surface.DrawTexturedRectUV(0, h * 0.5 - h * 0.05, w * 0.1, h * 0.1, 0, 0, 1, 1)
	surface.ClearMaterial()

	surface.DrawRect(w * 0.1, h * 0.5 - h * 0.05, w - w * 0.2, h * 0.1)

	surface.SetMaterial(self.GradientL)
		surface.DrawTexturedRectUV(w - w * 0.1 - 1, h * 0.5 - h * 0.05, w * 0.1, h * 0.1, 0, 0, 1, 1)
	surface.ClearMaterial()
end

function SKIN:PaintSliderKnob(panel, w, h)
	surface.SetDrawColor(255, 255, 255, 255)

	surface.SetMaterial(self.GradientU)
		surface.DrawTexturedRectUV(w * 0.5 - w * 0.125, 0, w * 0.25, h * 0.2, 0, 0, 1, 1)
	surface.ClearMaterial()

	surface.DrawRect(w * 0.5 - w * 0.125, h * 0.2, w * 0.25, h - h * 0.4)

	surface.SetMaterial(self.GradientD)
		surface.DrawTexturedRectUV(w * 0.5 - w * 0.125, h - h * 0.2 - 1, w * 0.25, h * 0.2, 0, 0, 1, 1)
	surface.ClearMaterial()
end

function SKIN:PaintTextEntry(panel, w, h)
	-- Hack on a hack, but this produces the most close appearance to what it will actually look if text was actually there
	if ( panel.GetPlaceholderText && panel.GetPlaceholderColor && panel:GetPlaceholderText() && panel:GetPlaceholderText():Trim() != "" && panel:GetPlaceholderColor() && ( not panel:GetText() || panel:GetText() == "" ) ) then

		local oldText = panel:GetText()

		local str = panel:GetPlaceholderText()
		if ( str:StartsWith( "#" ) ) then str = str:sub( 2 ) end
		str = language.GetPhrase( str )

		panel:SetText( str )
		panel:DrawTextEntryText( panel:GetPlaceholderColor(), panel:GetHighlightColor(), panel:GetCursorColor() )
		panel:SetText( oldText )

		return
	end

	panel:DrawTextEntryText( panel:GetTextColor(), panel:GetHighlightColor(), panel:GetCursorColor() )
end

derma.DefineSkin("Menu", "", SKIN)