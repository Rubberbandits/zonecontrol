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
SKIN.Colours.Label.Default			= GWEN.TextureColor( 4 + 8 * 8, 508 )
SKIN.Colours.Label.Bright			= GWEN.TextureColor( 4 + 8 * 9, 508 )
SKIN.Colours.Label.Dark				= GWEN.TextureColor( 4 + 8 * 8, 500 )
SKIN.Colours.Label.Highlight		= GWEN.TextureColor( 4 + 8 * 9, 500 )

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

derma.DefineSkin("Menu", "", SKIN)