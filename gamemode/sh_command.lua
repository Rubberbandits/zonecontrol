kingston = kingston or {}
kingston.command = kingston.command or {}
kingston.command.types = kingston.command.types or {}

kingston.command.prefix = "/"

--[[
	default command structure:
	admin_only, bool
	superadmin_only, bool
	gm_only, bool
	group, string or table - usergroups that should be able to run this command
--]]

if SERVER then
	function kingston.command.run(ply, command, arguments, raw)
		local command = kingston.command.types[command]

		if command then
			local results = {command.on_run(ply, arguments or {}, raw)}
			local color = results[1] or COLOR_ERROR
			local text = results[2]

			if type(text) == "string" then
				if IsValid(ply) then
					ply:Notify(nil, color, text, (#results > 2 and unpack(results, 3)) or {})
				else
					print(text)
				end
			end
		end
	end

	function kingston.command.process(ply, text, arguments)
		if text:sub(1, 1) == kingston.command.prefix then

			local match = text:lower():match(kingston.command.prefix.."([_%w]+)")

			local command = kingston.command.types[match]
			if command then
				if !arguments then
					arguments = kingston.chat.parse_arguments(text:sub(#match + 3))
				end

				kingston.command.run(ply, match, arguments, text:sub(#match + 3))
				kingston.log.write("command", "[%s][ran command: %s] %s", ply and ply:Nick() or "rcon", match, #text:sub(#match + 3) > 0 and text:sub(#match + 3) or "no args")
			else
				if IsValid(ply) then
					ply:Notify(nil, COLOR_ERROR, "That command does not exist.")
				else
					MsgC(COLOR_ERROR, "That command does not exist.\n")
				end
			end

			return true
		end

		return false
	end
end

function kingston.command.register(id, data)
	if !id or #id == 0 then return end
	if !data then return end
	if !data.on_run then return end
	
	data.syntax = data.syntax or "[none]"
	
	if !data.can_run then
		data.can_run = function(ply, arguments)
			if !data.group and (data.admin_only or data.superadmin_only or data.gm_only) then
				return ((ply:IsAdmin() and data.admin_only) or (ply:IsSuperAdmin() and data.superadmin_only) or (ply:IsEventCoordinator() or ply:IsAdmin() and data.gm_only))
			elseif data.group then
				if istable(data.group) then
					for _,group in next, data.group do
						if ply:IsUserGroup(group) then return true end
					end
				else
					return ply:IsUserGroup(data.group)
				end
			end

			return true
		end
	end
	
	local old_onrun = data.on_run
	data.on_run = function(ply, arguments, raw)
		if !data.can_run(ply, arguments) then
			return COLOR_ERROR, "You don't have the permissions to run this command."
		else
			return old_onrun(ply, arguments, raw)
		end
	end
	
	kingston.command.types[id] = data
end

kingston.command.register("mask", {
	can_run = function(ply, args)
		return ply:Alive()
	end,
	on_run = function(ply, args)
		local changed = false
		for k,v in next, ply.Inventory do
			if v.Base == "clothes" and v.Bonemerge and v.HelmetBodygroup and v:GetVar("Equipped", false) then
				if v:GetVar("HelmetEquipped", false) then
					v:CallFunction("RemoveHelmet")
				else
					v:CallFunction("WearHelmet")
				end
				
				changed = true
			end
		end
		
		if changed then
			return COLOR_NOTIF, "Helmet changed!"
		else
			return COLOR_ERR, "You don't have a suit equipped or it doesn't have a helmet!"
		end
	end
})

kingston.command.register("roll", {
	on_run = function(ply, args, args_str)
		local num, sides, sign, mod

		num, sides, sign, mod = string.match(args_str, "^ *(%d+)d(%d+) *([%+%-]?) *(%d*) *$")

		num = tonumber(num)
		sides = tonumber(sides)
		mod = tonumber(mod)

		if not (num and sides) then
			ply:Notify(nil, Color(200, 0, 0), "Missing arguments for roll.")

			return
		end

		num = math.Clamp(num, 1, 10)
		sides = math.Clamp(sides, 2, 20)

		local results = {}
		local total = 0

		for i = 1, num do
			local roll = math.random(sides)

			total = total + roll

			table.insert(results, roll)
		end

		local output
		local str = table.concat(results, " + ")

		if #sign > 0 and mod != 0 then
			local mult = tonumber(sign .. mod)

			total = total + mult
			output = string.format("%s rolled %id%i%s%i: (%s) %s %i = %i", ply:VisibleRPName(), num, sides, sign, mod, str, sign, mod, total)
		else
			output = string.format("%s rolled %id%i: (%s) = %i", ply:VisibleRPName(), num, sides, str, total)
		end
		
		local rf = {}
		for k,v in next, player.GetAll() do
			if ply:GetPos():DistToSqr(v:GetPos()) <= (400 * 400) then
				rf[#rf + 1] = v
			end
		end
		
		if #rf > 0 then
			GAMEMODE:Notify(rf, nil, COLOR_NOTIF, output)
		end
	end
})