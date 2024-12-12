local PANEL = {}

function PANEL:Init()
	zonecontrol.SetupItemSelection()

	local div = self:Add("DPanel")
	div:Dock(FILL)
	div:InvalidateLayout()
	div.OnMousePressed = function(_, keyCode) self:OnMousePressed(keyCode) end
	div.OnMouseReleased = function(_, keyCode) self:OnMouseReleased(keyCode) end

	local back = div:Add("DButton")
	back:SetFont("MainMenuSelection")
	back:Dock(BOTTOM)
	back:SetTall(40)
	back:SetText("BACK")
	back.DoClick = function()
		self:Remove()

		zonecontrol.CreateMainMenu()
		zonecontrol.DestroyCreationScene()
	end
end

function PANEL:OnMousePressed(keyCode)
	if not zonecontrol.creation.items then return end

	local view_origin = Vector(3173, 298, -3970) - Vector(-27.017334, 27.934052, 22.628906)
	local screen_vector = gui.ScreenToVector(gui.MousePos())
	local found = ents.FindAlongRay(view_origin, view_origin + screen_vector * 10000)

	local item = found[1]
	if not IsValid(item) then return end

	if not table.HasValue(zonecontrol.creation.items, item) then
		table.insert(zonecontrol.creation.items, item)
	else
		table.RemoveByValue(zonecontrol.creation.items, item)
	end
end

function PANEL:OnMouseReleased(keyCode)

end

vgui.Register("CharacterCreation_ItemSelection", PANEL, "DPanel")