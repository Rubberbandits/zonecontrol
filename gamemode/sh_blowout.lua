kingston = kingston or {}
kingston.blowout = kingston.blowout or {}

function kingston.blowout.get_var(type, key, default)
	return Entity(0)["GetNW2"..type](Entity(0), "kingston.blowout_var."..key, default)
end

function kingston.blowout.is_protected(ent)
	if ent:IsPlayer() then
		if ent:CharID() == 0 then
			return true
		end
	
		if ent:HasCharFlag("Y") then
			return true
		end
		
		if ent.Inventory then
			for k,v in next, ent.Inventory do
				if v:GetClass() == "psiband" and v:GetVar("Equipped", false) then
					return true
				elseif v:GetClass() == "psiband_monolith" and v:GetVar("Equipped", false) then
					return false
				end
			end
		end
		
		if ent.PassedOut and ent:PassedOut() then
			return true
		end
	end

	-- Cre8or code
	local pos = ent:GetShootPos()
	local tracedata_up = {}
	tracedata_up.start = pos
	tracedata_up.endpos = pos + Vector(0,0,999999)
	tracedata_up.mask = MASK_SOLID_BRUSHONLY + MASK_WATER 
	local trace_up = util.TraceLine(tracedata_up)	--Can the entity see the sky?

	if trace_up.HitSky then
		local Pos_up = trace_up.HitPos
		local tracedata_down = {}
		tracedata_down.start = Pos_up
		tracedata_down.endpos = pos
		tracedata_down.mask = MASK_SOLID_BRUSHONLY + MASK_WATER 
		local trace_down = util.TraceLine(tracedata_down)	--Can the sky see the entity? (excludes entities that are below displacements or inside brushes)
		
		if !trace_down.Hit then
			return false
		end
		
		return true
	end

	return true
end