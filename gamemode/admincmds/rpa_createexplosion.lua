

kingston.admin.registerCommand("createexplosion", {
	syntax = "<none>",
	description = "Create an explosion where you are aiming. Doesn't do damage.",
	arguments = {},
	onRun = function(ply)
		local trace = {}
		trace.start = ply:EyePos()
		trace.endpos = trace.start + ply:GetAimVector() * 32768
		trace.filter = ply
		local tr = util.TraceLine(trace)
		
		local explo = ents.Create("env_explosion")
		explo:SetOwner(ply)
		explo:SetPos(tr.HitPos)
		explo:SetKeyValue("iMagnitude", 1)
		explo:SetKeyValue("iRadiusOverride", 1)
		explo:Spawn()
		explo:Activate()
		explo:Fire("Explode")
	end,
})