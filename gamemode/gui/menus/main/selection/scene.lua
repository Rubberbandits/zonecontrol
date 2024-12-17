hook.Add("OnGamemodeLoaded", "InitScene_CharacterSelection", function()
	local scene_origin = Vector(3173, 298, -3970)
	local view_origin = Vector(158.457275, 106.118317, -55.700684)
	local view_angles = Angle(5.279853, 31.469650, 0)

	zonecontrol.scenes.Register("character_selection", {
		scene_model = "models/zonecontrol/mainmenu.mdl",
		scene_origin = scene_origin,

		CalcView = function(scene, ply, pos, ang, fov, znear, zfar)
			local view = {
				origin = scene_origin + view_origin,
				angles = view_angles,
				fov = fov,
				drawviewer = false
			}

			return view
		end,
		Think = function(scene)
		end,
		OnCreated = function(scene)
		end,
		OnDestroyed = function()
		end
	})
end)