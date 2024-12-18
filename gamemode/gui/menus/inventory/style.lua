surface.ClearMaterial = draw.NoTexture

surface.CreateFont("Inventory", {
	font = "Roboto Cn",
	extended = false,
	size = 24,
	weight = 1024,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
})

local SKIN = {}

SKIN.fontLabel = "Inventory"

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
	if panel.GetPlaceholderText and panel.GetPlaceholderColor and panel:GetPlaceholderText() and panel:GetPlaceholderText():Trim() != "" and panel:GetPlaceholderColor() and (not panel:GetText() or panel:GetText() == "") then

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

derma.DefineSkin("Inventory", "", SKIN)

local UVSKIN = {}
UVSKIN.inv_mat = CreateMaterial("inventory_pnl", "UnlitGeneric", {
	["$basetexture"] = "kingston/inventory_panels",
	["$translucent"] = 1,
	["$vertexalpha"] = 1,
	["$vertexcolor"] = 1
})
UVSKIN.mp_screen_mat = Material("kingston/mp_screen_panels")
UVSKIN.common = Material("kingston/ui_common")

UVSKIN.InventoryBack = {
	u0 = 0.67,
	v0 = 0,
	u1 = 1,
	v1 = 0.75,
}

UVSKIN.EquipFrame = {
	u0 = 0.331,
	v0 = 0,
	u1 = 0.67,
	v1 = 0.75,
}

UVSKIN.Menu = {
	u0 = 0.712,
	v0 = 0.3926,
	u1 = 0.9305,
	v1 = 0.499,
}

UVSKIN.LongButton = {
	normal = {
		u0 = 0.333,
		v0 = 0.905,
		u1 = 0.57,
		v1 = 0.9275,
	},
	hover = {
		u0 = 0.333,
		v0 = 0.9285,
		u1 = 0.57,
		v1 = 0.951,
	},
	down = {
		u0 = 0.333,
		v0 = 0.951,
		u1 = 0.57,
		v1 = 0.975,
	},
}

UVSKIN.ShortButton = {
	normal = {
		u0 = 0,
		v0 = 0,
		u1 = 1,
		v1 = 1,
	},
	hover = {
		u0 = 0,
		v0 = 0,
		u1 = 1,
		v1 = 1,
	},
	down = {
		u0 = 0,
		v0 = 0,
		u1 = 1,
		v1 = 1,
	},
}

UVSKIN.VBarUp = {
	u0 = 0.12109,
	v0 = 0.1689,
	u1 = 0.1358,
	v1 = 0.1835,
}

UVSKIN.VBarDown = {
	u0 = 0.12109,
	v0 = 0.216,
	u1 = 0.1358,
	v1 = 0.2304,
}

UVSKIN.VBar = {
	u0 = 0.12109,
	v0 = 0.2,
	u1 = 0.1358,
	v1 = 0.2156,
}

UVSKIN.HealthBar = {
	u0 = 0.333,
	v0 = 0.7705,
	u1 = 0.5435,
	v1 = 0.7871,
}

UVSKIN.ProtectionBar = {
	u0 = 0.332,
	v0 = 0.7705,
	u1 = 0.449,
	v1 = 0.7871,
}

UVSKIN.ConditionBar = {
	u0 = 0.3326,
	v0 = 0.7578,
	u1 = 0.39,
	v1 = 0.7636,
}

UVSKIN.protection_info = {
	-- radiation
	[DMG_RADIATION] = {
		default = 1,
		pos_x = ScreenScaleH(27),
		pos_y = (ScrH() / 4.9),
	},
	-- chemical burn
	[DMG_ACID] = {
		default = 1,
		pos_x = ScreenScaleH(27),
		pos_y = (ScrH() / 5.99),
	},
	-- electric shock
	[DMG_SHOCK] = {
		default = 1,
		pos_x = ScreenScaleH(27),
		pos_y = (ScrH() / 7.64),
	},
	-- thermal
	[DMG_BURN] = {
		default = 1,
		pos_x = ScreenScaleH(27),
		pos_y = (ScrH() / 10.6),
	},
	-- psychic
	[DMG_PARALYZE] = {
		default = 1,
		pos_x = ScreenScaleH(133),
		pos_y = (ScrH() / 4.9),
	},
	-- rupture
	[DMG_SLASH] = {
		default = 1,
		pos_x = ScreenScaleH(133),
		pos_y = (ScrH() / 5.99),
	},
	-- bulletproof
	[DMG_BULLET] = {
		default = 1,
		pos_x = ScreenScaleH(133),
		pos_y = (ScrH() / 7.64),
	},
}

UVSKIN.LockedArtifactSlot = {
	u0 = 0.4668,
	v0 = 0.831,
	u1 = 0.523,
	v1 = 0.8876,
}

function UVSKIN:PaintInventoryFrame(pnl, w, h)
	surface.SetDrawColor(255, 255, 255, pnl:GetAlpha() * 255)
	surface.SetMaterial(self.inv_mat)
	surface.DrawTexturedRectUV(0, 0, w, h, self.InventoryBack.u0, self.InventoryBack.v0, self.InventoryBack.u1, self.InventoryBack.v1)
end

function UVSKIN:PaintEquipFrame(pnl, w, h)
	surface.SetDrawColor(255, 255, 255, pnl:GetAlpha() * 255)
	surface.SetMaterial(self.inv_mat)
	surface.DrawTexturedRectUV(0, 0, w, h, self.EquipFrame.u0, self.EquipFrame.v0, self.EquipFrame.u1, self.EquipFrame.v1)

	local x, _ = pnl:GetPos()

	local u0 = x + ScreenScaleH(10.5)
	local v0 = h - (h / 3.87)
	local u1 = x + ScreenScaleH(10.5) + ScreenScaleH(143.5) * ( LocalPlayer():Health() / LocalPlayer():GetMaxHealth() )
	local v1 = h - (h / 3.87) + ScreenScaleH(11)

	render.SetScissorRect(u0, v0, u1, v1, true)
		surface.SetDrawColor(150, 25, 25, pnl:GetAlpha() * 255)
		surface.SetMaterial(self.inv_mat)
		surface.DrawTexturedRectUV(ScreenScaleH(10.5), h - (h / 3.87), ScreenScaleH(143.5), ScreenScaleH(11), self.HealthBar.u0, self.HealthBar.v0, self.HealthBar.u1, self.HealthBar.v1)
	render.SetScissorRect(u0, v0, u1, v1, false)

	local protection = {}
	for _,item in next, LocalPlayer().Inventory do
		if !item:GetVar("Equipped",false) then continue end
		if !item.GetArmorValues then continue end

		for m,n in next, item:GetArmorValues() do
			protection[m] = (protection[m] or ((self.protection_info[m] and self.protection_info[m].default) or 1)) * n
		end
	end

	for k,v in next, self.protection_info do
		if !protection[k] then continue end

		local u0 = x + v.pos_x
		local v0 = h - v.pos_y
		local u1 = x + v.pos_x + ScreenScaleH(82) - (ScreenScaleH(82) * protection[k])
		local v1 = h - v.pos_y + ScreenScaleH(12)

		render.SetScissorRect(u0, v0, u1, v1, true)
			surface.SetDrawColor(255, 255, 255, pnl:GetAlpha() * 255)
			surface.SetMaterial(self.inv_mat)
			surface.DrawTexturedRectUV(v.pos_x, v0, ScreenScaleH(82), ScreenScaleH(12), self.ProtectionBar.u0, self.ProtectionBar.v0, self.ProtectionBar.u1, self.ProtectionBar.v1)
		render.SetScissorRect(u0, v0, u1, v1, false)
	end
end

function UVSKIN:PaintVBar(pnl, w, h)
	surface.SetDrawColor(255, 255, 255, pnl:GetAlpha() * 255)
	surface.SetMaterial(self.common)
	surface.DrawTexturedRectUV(0, 0, w, h, self.VBar.u0, self.VBar.v0, self.VBar.u1, self.VBar.v1)
end

function UVSKIN:PaintVBarUp(pnl, w, h)
	surface.SetDrawColor(255, 255, 255, pnl:GetAlpha() * 255)
	surface.SetMaterial(self.common)
	surface.DrawTexturedRectUV(0, 0, w, h, self.VBarUp.u0, self.VBarUp.v0, self.VBarUp.u1, self.VBarUp.v1)
end

function UVSKIN:PaintVBarDown(pnl, w, h)
	surface.SetDrawColor(255, 255, 255, pnl:GetAlpha() * 255)
	surface.SetMaterial(self.common)
	surface.DrawTexturedRectUV(0, 0, w, h, self.VBarDown.u0, self.VBarDown.v0, self.VBarDown.u1, self.VBarDown.v1)
end

function UVSKIN:PaintGridSlot(pnl, w, h)
	surface.SetDrawColor(160,160,160,20)
	surface.DrawOutlinedRect(0,0,w,h)
end

function UVSKIN:PaintMenu(pnl, w, h)
	surface.SetDrawColor(255, 255, 255, pnl:GetAlpha() * 255)
	surface.SetMaterial(self.mp_screen_mat)
	surface.DrawTexturedRectUV(0, 0, w, h, self.Menu.u0, self.Menu.v0, self.Menu.u1, self.Menu.v1)
end

function UVSKIN:PaintLongButton(pnl, w, h)
	local state = self.LongButton.normal
	if pnl:IsHovered() then
		state = self.LongButton.hover
	end

	if pnl:IsDown() then
		state = self.LongButton.down
	end

	surface.SetDrawColor(255,255,255, pnl:GetAlpha() * 255)
	surface.SetMaterial(self.inv_mat)
	surface.DrawTexturedRectUV(0, 0, w, h, state.u0, state.v0, state.u1, state.v1)
end

function UVSKIN:PaintItemDurability(pnl, w, h, item)
	local x, y = pnl:LocalToScreen(0,0)
	local pos_x = w / 2 - ScreenScaleH(38.4) / 2
	local pos_y = h - ScreenScaleH(3.8)

	local u0 = x + pos_x
	local v0 = y + pos_y
	local u1 = x + pos_x + ScreenScaleH(39) * ( item:GetVar("Durability", 100) / 100 )
	local v1 = y + pos_y + ScreenScaleH(4)

	render.SetScissorRect(u0, v0, u1, v1, true)
		surface.SetDrawColor(255 - (255  * (item:GetVar("Durability", 100) / 100)), 200 * (item:GetVar("Durability", 100) / 100), 0, pnl:GetAlpha() * 255)
		surface.SetMaterial(self.inv_mat)
		surface.DrawTexturedRectUV(pos_x, pos_y, ScreenScaleH(38.4), ScreenScaleH(3.2), self.ConditionBar.u0, self.ConditionBar.v0, self.ConditionBar.u1, self.ConditionBar.v1)
	render.SetScissorRect(u0, v0, u1, v1, false)
end

function UVSKIN:PaintArtifactSlot(pnl, w, h)
	local artifact_slots
	local draw_locked
	for k,v in next, LocalPlayer().Inventory do
		if v.Base == "clothes" and v:GetVar("Equipped", false) then
			artifact_slots = v:GetArtifactSlots()
		end
	end

	if !artifact_slots or artifact_slots < 1 or pnl.SlotNumber > artifact_slots then
		draw_locked = true
	end

	if draw_locked then
		surface.SetDrawColor(255,255,255, pnl:GetAlpha() * 255)
		surface.SetMaterial(self.inv_mat)
		surface.DrawTexturedRectUV(0, 0, w, h, self.LockedArtifactSlot.u0, self.LockedArtifactSlot.v0, self.LockedArtifactSlot.u1, self.LockedArtifactSlot.v1)
	end
end

kingston.gui.RegisterSkin("Inventory", UVSKIN)

hook.Add("ScreenResolutionChanged", "STALKER.UpdateProtectionPositions", function()
	UVSKIN.protection_info = {
		-- radiation
		[DMG_RADIATION] = {
			default = 1,
			pos_x = ScreenScaleH(27),
			pos_y = (ScrH() / 4.9),
		},
		-- chemical burn
		[DMG_ACID] = {
			default = 1,
			pos_x = ScreenScaleH(27),
			pos_y = (ScrH() / 5.99),
		},
		-- electric shock
		[DMG_SHOCK] = {
			default = 1,
			pos_x = ScreenScaleH(27),
			pos_y = (ScrH() / 7.64),
		},
		-- thermal
		[DMG_BURN] = {
			default = 1,
			pos_x = ScreenScaleH(27),
			pos_y = (ScrH() / 10.6),
		},
		-- psychic
		[DMG_PARALYZE] = {
			default = 1,
			pos_x = ScreenScaleH(133),
			pos_y = (ScrH() / 4.9),
		},
		-- rupture
		[DMG_SLASH] = {
			default = 1,
			pos_x = ScreenScaleH(133),
			pos_y = (ScrH() / 5.99),
		},
		-- bulletproof
		[DMG_BULLET] = {
			default = 1,
			pos_x = ScreenScaleH(133),
			pos_y = (ScrH() / 7.64),
		},
	}
end)