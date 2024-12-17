local PANEL = {}

local character_origin = Vector(211.010498, 140.790405, -82.586426)
local character_angles = Angle(0, -150, 0)

local function SetupLamp(origin, angles)
	local light = ProjectedTexture()
		light:SetPos(origin)
		light:SetAngles(angles)

		light:SetTexture("effects/flashlight001")
		light:SetFarZ(256)
		light:SetBrightness(1)
		light:SetColor(Color(112, 79, 8))
	light:Update()

	return light
end

function PANEL:Init()
	local scene = zonecontrol.scenes.Create("character_selection")

	self.loading = true

	net.Start("CharacterFetch")
	net.SendToServer()

	local div = self:Add("DPanel")
	div:Dock(FILL)
	div:InvalidateLayout()

	local back = div:Add("DButton")
	back:SetFont("MainMenuSelection")
	back:Dock(BOTTOM)
	back:SetTall(40)
	back:SetText("BACK")
	back.DoClick = function()
		self:Remove()

		zonecontrol.CreateMainMenu()
	end

	local delete = div:Add("DButton")
	delete:SetFont("MainMenuSelection")
	delete:Dock(BOTTOM)
	delete:SetTall(40)
	delete:SetText("DELETE")
	delete.DoClick = function()
		self:Remove()

		zonecontrol.CreateMainMenu()
	end

	local select = div:Add("DButton")
	select:SetFont("MainMenuSelection")
	select:Dock(BOTTOM)
	select:SetTall(40)
	select:SetText("SELECT")
	select.DoClick = function()
		if not self.selected_character then return end

		net.Start("CharacterLoad")
			net.WriteUInt(self.selected_character, 32)
		net.SendToServer()

		self:Remove()
	end

	local slider = div:Add("DSlider")
	slider:Dock(BOTTOM)
	slider:SetTrapInside(true)
	slider:SetSlideX(0)
	slider.OnValueChanged = function(_, x, y)
		if self.loading then return end
		if not self.characters then return end

		local choice = math.Clamp(math.floor(1 + (x * #self.characters)), 1, #self.characters)

		local character = self.characters[choice]
		local model = scene.models.character
			model:InvalidateBoneCache()
			model:SetModel(character.model)
			model:SetSequence("sit")
			model:SetupBones()

		local body = scene.models.character_body
			body:InvalidateBoneCache()
			body:SetModel(character.body)

		self.selected_character = character.id
		div.character_name:SetText(character.name)
	end
	Derma_Hook(slider, "Paint", "Paint", "NumSlider")

	div.character_name = div:Add("DLabel")
	div.character_name:SetFont("MainMenuSelection")
	div.character_name:SetText("")
	div.character_name:SetTall(40)
	div.character_name:DockMargin(0, 0, 0, 8)
	div.character_name:Dock(BOTTOM)

	hook.Add("CharacterFetch", "PopulateCharacterSelect", function(characters)
		self.characters = characters

		local character_data = characters[1]
		local scene_origin = scene.models.scene:GetPos()
		local character = ClientsideModel(character_data.model, RENDERGROUP_OPAQUE)
			character:SetPos(scene_origin + character_origin)
			character:SetAngles(character_angles)
			character:SetSequence("sit")
			character:SetupBones()
			character:Spawn()
		scene.models.character = character

		local character_body = ClientsideModel(character_data.body, RENDERGROUP_OPAQUE)
			character_body:SetParent(character)
			character_body:AddEffects(EF_BONEMERGE + EF_BONEMERGE_FASTCULL)
			character_body:SetupBones()
			character_body:Spawn()
		scene.models.character_body = character_body

		scene.models.lamp = SetupLamp(scene_origin + character_origin + Vector(0, 0, 128), Angle(90, 0, 0))

		self.selected_character = character_data.id
		div.character_name:SetText(character_data.name)
		self.loading = false
	end)
end

function PANEL:OnRemove()
	hook.Remove("CharacterFetch", "PopulateCharacterSelect")
	zonecontrol.scenes.Destroy("character_selection")
end

function PANEL:Paint(w, h)
	if self.loading then
		surface.SetDrawColor(0, 0, 0, 255)
		surface.DrawRect(0, 0, w, h)
	end
end

vgui.Register("CharacterSelection", PANEL, "DPanel")