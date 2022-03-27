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
concommand.AddGamemaster = function() end
concommand.AddAdmin = function() end

if SERVER then
	util.AddNetworkString("zcCommandList")

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

	local function GetSimilarCommands(str)
		local similar = {}
		for cmd,_ in pairs(kingston.command.types) do
			if string.match(cmd, string.Trim(str)) then
				table.insert(similar, cmd)
			end
		end

		return similar
	end

	function kingston.command.process(ply, text, arguments)
		if string.utf8sub(text, 1, 1) == kingston.command.prefix then

			local match = text:lower():match(kingston.command.prefix.."([_%w]+)")
			if !match then
				local post = string.Explode(" ", text)
				local len = string.len(post[1])

				match = string.utf8sub(post[1], 2, len)
			end

			local command = kingston.command.types[match]
			if command then
				if !arguments then
					arguments = kingston.chat.parse_arguments(text:sub(#match + 3))
				end

				kingston.command.run(ply, match, arguments, text:sub(#match + 3))
				if command.log then
					command.log(ply, arguments, text:sub(#match + 3))
				else
					kingston.log.write("command", "[%s][ran command: %s] %s", ply and ply:Nick() or "rcon", match, #text:sub(#match + 3) > 0 and text:sub(#match + 3) or "no args")
				end
			else
				local similar = GetSimilarCommands(match)
				if IsValid(ply) then
					ply:Notify(nil, COLOR_ERROR, "That command does not exist. Are you looking for any of these?\n\t%s", table.concat(similar, "\n\t"))
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
	data.description = data.description or "No description"
	
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
		local can_run, reason = data.can_run(ply, arguments)
		if !can_run then
			return COLOR_ERROR, reason or "You don't have permission to run this command."
		else
			return old_onrun(ply, arguments, raw)
		end
	end
	
	kingston.command.types[id] = data
end

kingston.command.register("mask", {
	can_run = function(ply, args)
		return ply:Alive(), "You need to be alive to change your mask!"
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
			return COLOR_ERROR, "You don't have a suit equipped or it doesn't have a helmet!"
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

kingston.command.register("pda", {
	can_run = function(ply, args)
		if !ply:Alive() then
			return false, "You can't use a PDA, you're dead."
		end
		
		if ply:PassedOut() then
			return false, "You can't use a PDA, you're passed out."
		end
	
		local item = ply:HasItem("pda")
		local selected_pda
		if !item then 
			return false, "You don't have a PDA!"
		end
		for k,v in next, ply.Inventory do
			if v:GetClass() == "pda" then
				if v:GetVar("Power", false) and v:GetVar("Primary", false) then
					selected_pda = v
					break
				end
			end
		end
		if !selected_pda then
			return false, "Your PDA isn't powered on, or there is no primary PDA!"
		end

		if !kingston.blowout.can_use_pda() then
			return false, "There is currently an ongoing emission!"
		end
		
		return true
	end,
	on_run = function(ply, args, raw)
		local rf = {}
		local pda_rank
		local pda_name
		local pda_id
		local header
		local text = string.PatternSafe(raw)
		for k,v in next, ply.Inventory do
			if v:GetClass() == "pda" then
				if v:GetVar("Power", false) and v:GetVar("Primary", false) then
					pda_name = v:GetVar("PDAName")
					pda_id = v:GetID()
					pda_rank = v:GetPDARank()
					break
				end
			end
		end
		
		if !args[2] then return end
		if !pda_name or #pda_name == 0 then 
			ply:PDANotify("STALKER.net", "You must register your PDA first before using STALKER.net!", 2, 12)
			
			return
		end
		
		local start, finish = text:find(string.PatternSafe(args[1]))
		if !finish then return end
		local body = string.Replace(text:sub(finish + 2, #text), "%", "")
		
		if args[1] == "all" then
			header = Format("[%s] %s -> all", pda_rank, pda_name)
			
			for _,targ in next, player.GetAll() do
				if !targ.Inventory then continue end
				for id,item in next, targ.Inventory do
					if item:GetClass() == "pda" then
						if item:GetVar("Power", false) then
							rf[#rf + 1] = targ
							break
						end
					end
				end
			end
		else
			local pda = GAMEMODE:FindPlayer(args[1], ply, true)
			if !pda then
				ply:PDANotify("STALKER.net", "Recipient could not be found, or is offline. Try again later.", 3, 12)
				return
			end
			local targ_name = pda:GetVar("PDAName")
			local targ_pda_id = pda:GetID()
			
			if !targ_name or #targ_name == 0 then 
				ply:PDANotify("STALKER.net", "Recipient could not be found, or is offline. Try again later.", 3, 12)
				return
			end

			local target = pda:Owner()
			if !target or !IsValid(target) then 
				ply:PDANotify("STALKER.net", "Recipient could not be found, or is offline. Try again later.", 3, 12)
				return
			end
			
			header = pda_name.." -> "..targ_name
			kingston.pda.write_chat(pda_id, targ_pda_id, body)
			
			rf = {target, ply}
		end
		
		if args[1] == "all" then
			netstream.Start(rf, "nAddPDANotif", header, body, 2, 5)

			if GAMEMODE.PDADiscordHook then
				// fire and forget
				http.Post(GAMEMODE.ProxySite, {
					url = GAMEMODE.PDADiscordHook,
					data = util.TableToJSON({
						username = header,
						content = body,
						avatar_url = "https://cdn.discordapp.com/attachments/367478333425844224/956297681658052608/latest.png",
						allowed_mentions = {parse = {}}
					})
				})
			end
		else
			netstream.Start(rf, "nAddPDANotif", header, body, 6, 3)
		end
	end
})

kingston.command.register("pm", {
	can_run = function(ply, args)
		return true
	end,
	on_run = function(ply, args, raw)
		local target = GAMEMODE:FindPlayer(args[1], ply)
		if !target then
			return COLOR_ERROR, "Specified player not found."
		end

		local text = string.PatternSafe(raw)
		local start, finish = text:find(string.PatternSafe(args[1]))
		local body = string.Replace(text:sub(finish + 2, #text), "%", "")

		ply:Notify(nil, Color(160, 255, 160), "[PM to %s]: %s", target:RPName(), body)
		target:Notify(nil, Color(160, 255, 160), "[PM from %s]: %s", ply:RPName(), body)
	end
})

local anoraks = {
	brown = "models/kingstonstalker/bandit/bandit1",
	green = "models/kingstonstalker/bandit/bandit2",
	black = "models/kingstonstalker/bandit/bandit3",
	white = "models/kingstonstalker/bandit/bandit4",
	grey = "models/kingstonstalker/bandit/bandit5",
}

kingston.command.register("anorak", {
	description = "Change the color of your anorak.",
	syntax = "<string color [black/white/grey/green/brown]>",
	can_run = function(ply, args)
		return ply:Alive(), "You need to be alive to change your anorak!"
	end,
	on_run = function(ply, args)
		if anoraks[args[1]] then
			ply:SetBodySubMat(anoraks[args[1]])
		else
			ply:SetBodySubMat("models/kingstonstalker/bandit/bandit1")
		end
	end
})

kingston.command.register("cmdhelp", {
	on_run = function(ply, args)
		local commands = {}

		for cmd,data in SortedPairs(kingston.command.types) do
			table.insert(commands, Format("/%s %s\n\t\t%s", cmd, data.syntax, data.description))
		end

		net.Start("zcCommandList")
			net.WriteTable(commands)
		net.Send(ply)
	end
})

local function SetEntityDesc( ply, cmd, args, szArgs )
	local targ = ply:GetEyeTraceNoCursor().Entity
	local szDesc = szArgs

	if !ply:IsAdmin() then
		if #szDesc > 512 then return end
		if targ.PropSteamID and targ:PropSteamID() != ply:SteamID() then return end
	end

	if targ and IsValid(targ) and targ:GetClass() == "prop_physics" or targ:GetClass() == "prop_ragdoll" then
		if targ.PropDesc and SERVER then
			targ:SetPropDesc(szDesc)
		end
	end
end
concommand.Add( "rp_propdesc", SetEntityDesc ); 