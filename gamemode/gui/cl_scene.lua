zonecontrol = zonecontrol or {}
zonecontrol.scenes = zonecontrol.scenes or {}
zonecontrol.scenes.registered = zonecontrol.scenes.registered or {}
zonecontrol.scenes.active = zonecontrol.scenes.active or {}

/*
	Scene structure

	string id = {
		string scene_model,
		vector scene_origin,

		table models = {
			{
				string model,
				vector local_origin,
				angle angles
			},
			...
		}

		function CalcView(ply, pos, ang, fov, znear, zfar),
		function Think(),
		function OnCreated(scene),
		function OnDestroyed()
	}
*/

function zonecontrol.scenes.Register(id, data)
	zonecontrol.scenes.registered[id] = data
end

function zonecontrol.scenes.Create(id)
	local scene_data = zonecontrol.scenes.registered[id]
	if not scene_data then error(string.format("Invalid scene id: %s", id)) end
	if zonecontrol.scenes.active[id] then error(string.format("Scene is already active: %s", id)) end

	zonecontrol.scenes.active[id] = {}

	local scene = zonecontrol.scenes.active[id]
	scene.models = {}

	if scene_data.scene_model then
		local scene_model = ClientsideModel(scene_data.scene_model, RENDERGROUP_OPAQUE)
		scene_model:SetPos(scene_data.scene_origin)
		scene_model:Spawn()

		scene.models.scene = scene_model
	end

	if scene_data.models then
		for _, model_data in pairs(scene_data.models) do
			local model = ClientsideModel(model_data.model)
			model:SetPos(scene_data.scene_origin + model_data.local_origin)
			model:SetAngles(model_data.angles)
			model:Spawn()

			local split_model = string.Split(model_data.model, "/")
			scene.models[string.StripExtension(split_model[#split_model])] = model
		end
	end

	local scene_hook_id = string.format("scene_%s", id)
	if scene_data.CalcView then
		hook.Add("CalcView", scene_hook_id, function(ply, pos, ang, fov, znear, zfar) return scene_data.CalcView(scene, ply, pos, ang, fov, znear, zfar) end)
	end

	if scene_data.Think then
		hook.Add("Think", scene_hook_id, function() scene_data.Think(scene) end)
	end

	scene_data.OnCreated(scene)
	return scene
end

function zonecontrol.scenes.Destroy(id)
	local scene_data = zonecontrol.scenes.registered[id]
	local scene = zonecontrol.scenes.active[id]
	if not scene then error(string.format("Scene is not active: %s", id)) end

	for name,ent in pairs(scene.models) do
		if not IsValid(ent) then continue end

		ent:Remove()
	end

	local scene_hook_id = string.format("scene_%s", id)
	hook.Remove("CalcView", scene_hook_id)
	hook.Remove("Think", scene_hook_id)

	scene_data.OnDestroyed()
	zonecontrol.scenes.active[id] = nil
end