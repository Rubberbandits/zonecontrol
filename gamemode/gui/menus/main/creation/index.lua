local PANEL = {}

function PANEL:Init()
	zonecontrol.CreateCreationScene()

	local total_skins_models = 0
	local model_indices = {}
	for _,model in pairs(GAMEMODE.CitizenModels) do
		local count = NumModelSkins(model)
		for i = 0, count - 1 do
			model_indices[total_skins_models + i + 1] = {model = model, skin = i}
		end

		total_skins_models = #model_indices
	end

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
		zonecontrol.DestroyCreationScene()
	end

	local next_page = div:Add("DButton")
	next_page:SetFont("MainMenuSelection")
	next_page:Dock(BOTTOM)
	next_page:SetTall(40)
	next_page:SetText("NEXT")
	next_page.DoClick = function()
		self:Remove()

		local item_select = vgui.Create("CharacterCreation_ItemSelection")
		item_select:SetSkin("Menu")
		item_select:Dock(FILL)
		item_select:DockPadding(ScrW() * 0.33, ScrH() * 0.1, ScrW() * 0.33, ScrH() * 0.1)
		item_select:MakePopup()
	end

	local slider = div:Add("DSlider")
	slider:Dock(BOTTOM)
	slider:SetTrapInside(true)
	slider:SetSlideX(0)
	slider.OnValueChanged = function(_, x, y)
		local choice = math.Clamp(math.floor(1 + (x * #model_indices)), 1, #model_indices)

		local model_data = model_indices[choice]
		zonecontrol.CreationChangeModel(model_data.model)
		zonecontrol.creation.models.player:SetSkin(model_data.skin)
	end
	Derma_Hook(slider, "Paint", "Paint", "NumSlider")
end

vgui.Register("CharacterCreation", PANEL, "DPanel")