

kingston.admin.registerCommand("panic", {
	syntax = "<none>",
	description = "Remove all entities with motion-enabled physics",
	arguments = {},
	onRun = function(ply)
		for _,v in next, ents.FindByClass("prop_physics") do
			if IsValid(v) and IsValid(v:GetPhysicsObject()) then
				if v:GetPhysicsObject():IsMotionEnabled() then
					v:Remove()
				end
			end
		end
	end,
})