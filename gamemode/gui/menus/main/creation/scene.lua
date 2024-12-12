zonecontrol = zonecontrol or {}

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
		origin = scene_origin - player_origin,
		angles = zero_angle,
		fov = fov,
		drawviewer = false
	}

	view.origin:Sub(zero_angle:Forward() * 32)
	view.origin:Add(zero_angle:Up() * 64)

	return view
end

local function ItemCalcView(ply, pos, ang, fov, znear, zfar)
	local view = {
		origin = scene_origin - item_camera_origin,
		angles = item_camera_angle,
		fov = fov,
		drawviewer = false
	}

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
	zonecontrol.creation.models = {}

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

function zonecontrol.SetupItemSelection()
	hook.Remove("CalcView", "CreationView")
	hook.Remove("Think", "CreationLighting")

	if IsValid(zonecontrol.creation.models.light) then
		zonecontrol.creation.models.light:Remove()
	end

	zonecontrol.creation.models.light = SetupLamp(scene_origin - item_light_origin, Angle(89, 0, 0))

	hook.Add("Think", "CreationLighting", function() SetupLight(scene_origin - item_light_origin) end)

	local table_one = ClientsideModel("models/tnb/props/table2.mdl", RENDERGROUP_OPAQUE)
	table_one:SetPos(scene_origin - Vector(-26, 51, 102))
	table_one:SetAngles(Angle(0, 90, 0))
	table_one:Spawn()

	zonecontrol.creation.models.table = table_one

	zonecontrol.creation.models.player:SetPos(scene_origin - item_player_origin)
	zonecontrol.creation.models.player:SetAngles(Angle(0, -90, 0))
	zonecontrol.creation.models.player:SetSequence("idle_all_02")

	local idx = 0
	local table_pos = table_one:GetPos()
	for item_class,data in pairs(GAMEMODE.GearSelection) do
		local ent = ents.CreateClientProp()
		ent:SetModel(GAMEMODE.Items[item_class].Model)
		ent:SetPos(Vector(table_pos.x - data.origin.x, table_pos.y - data.origin.y, table_pos.z + table_maxs.z + data.origin.z))
		ent:SetAngles(data.angs)
		ent:Spawn()
		ent:ManipulateBoneScale(0, Vector(data.scale, data.scale, data.scale))
		ent:SetSolid(SOLID_BBOX)
		ent:SetCollisionBounds(Vector(-2, -2, -2), Vector(2, 2, 2))

		zonecontrol.creation.models[item_class] = ent
		idx = idx + 1
		print(item_class)
		if idx == 20 then break end
	end

	zonecontrol.creation.items = {}

	hook.Add("PreDrawHalos", "ItemSelectionHalo", ItemSelectionHalo)
	hook.Add("CalcView", "CreationView", ItemCalcView)
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