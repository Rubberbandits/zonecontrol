zonecontrol = zonecontrol or {}
zonecontrol.anims = zonecontrol.anims or {}

local scene_origin = Vector(3173, 298, -3970)
local player_origin = Vector(-140, -94, 100)
local model_light_origin = Vector(-122, -90, 1)
local item_light_origin = Vector(-28, 61, 1)

local item_player_origin = Vector(-28, 20, 100)
local item_camera_origin = Vector(-27.017334, 27.934052, 22.628906)

local table_maxs = Vector(32, 20, 39)

local reverse_angle = Angle(0, 180, 0)
local zero_angle = Angle(0, 0, 0)
local item_camera_angle = Angle(55, -90, 0)

local function CreationCalcView(ply, pos, ang, fov, znear, zfar)
	local view = {
		origin = scene_origin,
		angles = zero_angle,
		fov = fov,
		drawviewer = false
	}

	view = hook.Run("CharacterCreation_CalcView", view, ply, pos, ang, fov, znear, zfar)
	return view
end

hook.Add("CharacterCreation_CalcView", "Model", function(view)
	if not zonecontrol.creation then return end
	if zonecontrol.creation.stage != 1 then return end

	view.origin = scene_origin - player_origin - (zero_angle:Forward() * 32) + zero_angle:Up() * 64

	return view
end)

local function ItemSelectionView(view)
	if not zonecontrol.creation then return end
	if zonecontrol.creation.stage != 2 then return end

	view.origin = scene_origin - item_camera_origin
	view.angles = item_camera_angle

	return view
end

local function SetupLight(origin)
	if IsValid(zonecontrol.creation.light) then return end

	local light = DynamicLight(LocalPlayer():EntIndex(), false)
	if light then
		light.pos = origin
		light.r = 112
		light.g = 79
		light.b = 8
		light.brightness = 6
		light.decay = 1000
		light.size = 128
		light.noworld = true
		light.dietime = CurTime() + 1
	end

	zonecontrol.creation.light = light
end

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

function zonecontrol.CreateCreationScene()
	zonecontrol.DestroyCreationScene()

	zonecontrol.creation = {}
	zonecontrol.creation.stage = 1
	zonecontrol.creation.models = {}
	zonecontrol.anims = {}

	local scene = ClientsideModel("models/zonecontrol/mainmenu.mdl", RENDERGROUP_OPAQUE)
	scene:SetPos(scene_origin)
	scene:Spawn()

	zonecontrol.creation.models.scene = scene

	local player_model = ClientsideModel(GAMEMODE.CitizenModels[1], RENDERGROUP_OPAQUE)
	player_model:SetPos(scene_origin - player_origin)
	player_model:SetAngles(reverse_angle)
	player_model:SetSequence("menu_combine")
	player_model:SetupBones()
	player_model:Spawn()

	player_model:SetEyeTarget(reverse_angle:Up() * -20)

	zonecontrol.creation.models.player = player_model

	local player_body = ClientsideModel(GAMEMODE.BodyModels[1], RENDERGROUP_OPAQUE)
	player_body:SetParent(player_model)
	player_body:AddEffects(EF_BONEMERGE + EF_BONEMERGE_FASTCULL)
	player_body:SetupBones()
	player_body:Spawn()

	zonecontrol.creation.models.body = player_body

	hook.Add("CalcView", "CreationView", CreationCalcView)
	hook.Add("Think", "CreationLighting", function() SetupLight(scene_origin - model_light_origin) end)
	zonecontrol.creation.models.light = SetupLamp(scene_origin - model_light_origin, Angle(89, 0, 0))
end

function zonecontrol.CreationChangeModel(model)
	if not zonecontrol.creation then return end

	local player_model = zonecontrol.creation.models.player
	player_model:InvalidateBoneCache()
	player_model:SetModel(model)
	player_model:SetSequence("menu_combine")
	player_model:SetupBones()

	local player_body = player_model:GetChildren()[1]
	player_body:InvalidateBoneCache()
	if string.find(model, "fmale") then
		player_body:SetModel(string.StripExtension(GAMEMODE.BodyModels[1]) .. "_f.mdl")
	else
		player_body:SetModel(GAMEMODE.BodyModels[1])
	end
end

local function ItemSelectionHalo()
	if not zonecontrol.creation.items then return end

	halo.Add(zonecontrol.creation.items, color_white, 2, 2, 2 )
end

local render_pos = Vector(0, -1.4, 1.2)
local budget_color = Color(0, 0, 0, 255)
local cost_color = Color(200, 0, 0, 255)
local function RubleCountRender(ent, amount)
	if not ent["3d2d_pos"] then
		ent["3d2d_pos"] = ent:GetPos() + render_pos
	end

	cam.Start3D2D(ent["3d2d_pos"], Angle(0, 180, 0), 0.01)
		surface.SetFont("RubleCount")

		local budget_w, _ = surface.GetTextSize(amount)
		draw.SimpleText(amount, "RubleCount", -budget_w / 2, 0, budget_color)

		if zonecontrol.creation.current_item then
			local data = GAMEMODE.GearSelection[zonecontrol.creation.current_item.class]
			local cost_text = "-" .. data.cost
			local cost_w, cost_h = surface.GetTextSize(cost_text)

			surface.SetDrawColor(20, 20, 20, 200)
			surface.DrawRect(-budget_w / 2 + budget_w, 0, cost_w, cost_h)

			draw.SimpleText(cost_text, "RubleCount", -budget_w / 2 + budget_w, 0, cost_color)
		end
	cam.End3D2D()
end

local function ItemCountRender(ent)
	local count = ent.count
	if not count then return end
	if count == 0 then return end

	if not ent["3d2d_pos"] then
		local pos = ent:GetPos()
		ent["3d2d_pos"] = pos + Vector(0, 0, 6)
	end

	local old_ec = render.EnableClipping(false)
		cam.Start3D2D(ent["3d2d_pos"], Angle(0, 180, 45), 0.01)
			surface.SetFont("RubleCount")

			local count_w, count_h = surface.GetTextSize("x" .. count)

			surface.SetDrawColor(20, 20, 20, 200)
			surface.DrawRect(-count_w / 2, 0, count_w, count_h)

			draw.SimpleText("x" .. count, "RubleCount", -count_w / 2, 0, color_white)
		cam.End3D2D()
	render.EnableClipping(old_ec)
end

function zonecontrol.SetupItemSelection()
	hook.Remove("Think", "CreationLighting")

	if IsValid(zonecontrol.creation.models.light) then
		zonecontrol.creation.models.light:Remove()
	end

	zonecontrol.creation.stage = 2
	zonecontrol.creation.models.light = SetupLamp(scene_origin - item_light_origin, Angle(89, 0, 0))

	local table_one = ClientsideModel("models/tnb/props/table2.mdl", RENDERGROUP_OPAQUE)
		table_one:SetPos(scene_origin - Vector(-26, 51, 102))
		table_one:SetAngles(Angle(0, 90, 0))
		table_one:Spawn()
	zonecontrol.creation.models.table = table_one

	zonecontrol.creation.models.player:SetPos(scene_origin - item_player_origin)
	zonecontrol.creation.models.player:SetAngles(Angle(0, -90, 0))
	zonecontrol.creation.models.player:SetSequence("idle_all_02")

	zonecontrol.creation.budget = GAMEMODE.RubleBudget

	local table_pos = table_one:GetPos()
	local ruble_counter = ClientsideModel("models/kek1ch/money_ukraina.mdl", RENDERGROUP_OPAQUE)
		ruble_counter:SetPos(table_pos - Vector(-4, -18, -table_maxs.z))
		ruble_counter:SetAngles(Angle(0, -90, 0))
		ruble_counter:Spawn()
		ruble_counter.RenderOverride = function(ent)
			if not zonecontrol.creation then return end

			ent:DrawModel()
			RubleCountRender(ent, zonecontrol.creation.budget)
		end
	zonecontrol.creation.models.rubles = ruble_counter

	for item_class,data in pairs(GAMEMODE.GearSelection) do
		local ent = ents.CreateClientProp()
		ent:SetModel(GAMEMODE.Items[item_class].Model)
		ent:SetPos(Vector(table_pos.x - data.origin.x, table_pos.y - data.origin.y, table_pos.z + table_maxs.z + data.origin.z))
		ent:SetAngles(data.angs)
		ent:Spawn()
		ent:ManipulateBoneScale(0, Vector(data.scale, data.scale, data.scale))
		ent:SetSolid(SOLID_BBOX)
		ent:SetCollisionBounds(Vector(-1, -1, -1), Vector(1, 1, 1))
		ent.class = item_class
		ent.data = data
		ent.count = 0
		ent.RenderOverride = function(ent)
			if not zonecontrol.creation then return end

			ent:DrawModel()
			ItemCountRender(ent)
		end

		zonecontrol.creation.models[item_class] = ent
	end

	zonecontrol.creation.items = {}

	hook.Add("PreDrawHalos", "ItemSelectionHalo", ItemSelectionHalo)
	local origin_anim_key = zonecontrol.Animate("OutExpo", (scene_origin - player_origin) - (zero_angle:Forward() * 32) + (zero_angle:Up() * 64), scene_origin - item_camera_origin, 2, function()
		hook.Remove("CharacterCreation_CalcView", "TransitionAnimation")
		hook.Add("CharacterCreation_CalcView", "ItemSelection", ItemSelectionView)
	end)
	local angles_anim_key = zonecontrol.Animate("OutQuart", zero_angle, item_camera_angle, 0.5)
	hook.Add("CharacterCreation_CalcView", "TransitionAnimation", function(view)
		if not zonecontrol.creation then return end
		if not zonecontrol.anims[origin_anim_key] then return end

		view.origin = zonecontrol.anims[origin_anim_key]
		view.angles = zonecontrol.anims[angles_anim_key] or item_camera_angle

		return view
	end)
end

function zonecontrol.DestroyCreationScene()
	if not zonecontrol.creation then return end
	if not zonecontrol.creation.models then return end

	for idx,ent in pairs(zonecontrol.creation.models) do
		ent:Remove()
	end

	hook.Remove("CalcView", "CreationView")
	hook.Remove("Think", "CreationLighting")
	hook.Remove("PreDrawHalos", "ItemSelectionHalo")

	zonecontrol.creation = nil
end

function zonecontrol.Animate(smoother, from, to, duration, callback)
	if type(from) != type(to) then error("from and to argument are not of the same type!") end

	local anim_key = string.format("anim-%s-%s", smoother, duration)
	local start = CurTime()
	local lerp_func = isvector(from) and LerpVector or (isangle(from) and LerpAngle or Lerp)
	hook.Add("Think", anim_key, function()
		local progress = (CurTime() - start) / duration
		zonecontrol.anims[anim_key] = lerp_func(math.ease[smoother](progress), from, to)

		if start + duration <= CurTime() then
			if callback and isfunction(callback) then
				callback(anim_key)
			end

			hook.Remove("Think", anim_key)
			zonecontrol.anims[anim_key] = nil
		end
	end)

	return anim_key
end