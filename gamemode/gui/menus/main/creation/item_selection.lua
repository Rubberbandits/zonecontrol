local PANEL = {}

local function ItemSelectionHover()
	if not zonecontrol.creation.items then return end

	local view_origin = Vector(3173, 298, -3970) - Vector(-27.017334, 27.934052, 22.628906)
	local screen_vector = gui.ScreenToVector(gui.MousePos())
	local found = ents.FindAlongRay(view_origin, view_origin + screen_vector * 512, Vector(-0.2, -0.2, -0.2), Vector(0.2, 0.2, 0.2))

	local item = found[1]
	if not IsValid(item) then
		zonecontrol.creation.current_item = nil
		return
	end
	if zonecontrol.creation.current_item == item then return end

	local item_pos = item:GetPos()
	local origin = Vector(item_pos.x, item_pos.y, item_pos.z + 128)
	if not zonecontrol.creation.models.selector_light then
		local light = ProjectedTexture()
			light:SetPos(origin)
			light:SetAngles(Angle(90, 0, 0))

			light:SetTexture("effects/flashlight001")
			light:SetFarZ(200)
			light:SetBrightness(1)
			light:SetFOV(6)
			light:SetColor(Color(150, 150, 150))
		light:Update()

		zonecontrol.creation.models.selector_light = light
	end

	local anim_key = zonecontrol.Animate("OutCirc", zonecontrol.creation.models.selector_light:GetPos(), origin, 1, function()
		hook.Remove("Think", "MoveItemLight")

		if not zonecontrol.creation then return end
		zonecontrol.creation.models.selector_light:SetPos(origin)
		zonecontrol.creation.models.selector_light:Update()
	end)

	hook.Add("Think", "MoveItemLight", function()
		if not zonecontrol.creation then return end
		if not zonecontrol.anims[anim_key] then return end

		zonecontrol.creation.models.selector_light:SetPos(zonecontrol.anims[anim_key])
		zonecontrol.creation.models.selector_light:Update()
	end)

	zonecontrol.creation.current_item = item
end

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

	local next = div:Add("DButton")
	next:SetFont("MainMenuSelection")
	next:Dock(BOTTOM)
	next:SetTall(40)
	next:SetText("NEXT")
	next.DoClick = function()
		self:Remove()

		zonecontrol.FinishCreation()
	end

	hook.Add("Think", "ItemSelectionHover", ItemSelectionHover)
end

function PANEL:OnRemove()
	hook.Remove("Think", "ItemSelectionHover")
end

function PANEL:OnMousePressed(keyCode)
	if not zonecontrol.creation.items then return end

	local budget = zonecontrol.creation.budget

	local item = zonecontrol.creation.current_item
	if not IsValid(item) then return end

	local selected = table.HasValue(zonecontrol.creation.items, item)
	local cost = item.data.cost
	if keyCode == MOUSE_LEFT then
		if budget - cost < 0 then return end

		zonecontrol.creation.budget = budget - cost
		if item.count == 0 then
			table.insert(zonecontrol.creation.items, item)
		end

		item.count = item.count + 1
	elseif keyCode == MOUSE_RIGHT and selected then
		zonecontrol.creation.budget = budget + cost

		item.count = item.count - 1
		if item.count <= 0 then
			table.RemoveByValue(zonecontrol.creation.items, item)
		end
	end
end

function PANEL:OnMouseReleased(keyCode)

end

vgui.Register("CharacterCreation_ItemSelection", PANEL, "DPanel")