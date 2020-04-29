AddCSLuaFile()

kingston = kingston or {}
kingston.chat = kingston.chat or {}
kingston.chat.types = kingston.chat.types or {}

if CLIENT then
	netstream.Hook("nReceiveMessage", function(id, ply, text)
		local chat_data = kingston.chat.get(id)
		if !chat_data then return end
		
		chat_data.on_run(id, ply, text)
	end)
	
	function nConSay( str )

		GAMEMODE:AddChat({ CB_ALL, CB_OOC }, "CombineControl.ChatNormal", Color( 200, 0, 0, 255 ), "Console: " .. str);
		
	end
	netstream.Hook( "nConSay", nConSay );
	
	function nConASay( str )

		GAMEMODE:AddChat({ CB_ALL, CB_OOC }, "CombineControl.ChatNormal", Color( 200, 0, 0, 255 ), "[ADMIN] Console: " .. str);
		
	end
	netstream.Hook( "nConASay", nConASay );
else
	-- nSay: carryover from old CC system
	netstream.Hook("nSay", function(ply, text)
		ply:SetTyping( 0 );
		
		if ply:CharID() < 1 then return end
		if !ply.LastChat then ply.LastChat = 0 end
		if CurTime() - ply.LastChat < 0.05 then return end
		ply.LastChat = CurTime();
		
		if #text > 2000 then return end
		
		local chat_type, message = kingston.chat.process(ply, text)
		
		if chat_type == "ic" then
			if kingston.command.process(ply, text) then
				return
			end
		end
		
		kingston.chat.run(chat_type, ply, message)
	end)
	
	function nChangeRadio( ply, val )

		if( !ply:HasItem( "radio" ) ) then return end
		
		if( val >= 0 ) then
			
			if( val <= 999 ) then
			
				ply:SetRadioFreq( math.Round( val, 2 ) );
				
			end
			
		end
		
	end
	netstream.Hook( "nChangeRadio", nChangeRadio );
end

kingston.chat.default_type = {
	construct_string = function(chat_type, ply, text)
		local chat_data = kingston.chat.get(chat_type)
		
		return {chat_data.text_color, Format(chat_data.text_format, ply:RPName(), text)}
	end,
	on_run = function(chat_type, ply, text)
		local chat_data = kingston.chat.get(chat_type)
		local chat_str_data = chat_data.construct_string(chat_type, ply, text)
		
		chat_data.handle_log(chat_type, ply, text)
		
		if CLIENT then
			if chat_data.print_console then
				MsgC(chat_data.text_color, chat_data.print_console(chat_type, ply, text))
			end
		
			GAMEMODE:AddChat(chat_data.chat_filter, chat_data.chat_font, unpack(chat_str_data))
		end
	end,
	can_say = function(chat_type, ply)
		local chat_data = kingston.chat.get(chat_type)
		
		if !chat_data.while_dead and !ply:Alive() then
			return "You can't speak, you're dead."
		end
		
		if !chat_data.while_dead and ply:PassedOut() then
			return "You can't speak, you're passed out."
		end

		return true
	end,
	can_hear = function(chat_type, speaker, listener)
		local chat_data = kingston.chat.get(chat_type)
	
		return speaker:GetPos():DistToSqr(listener:GetPos()) <= (chat_data.chat_range * chat_data.chat_range)
	end,
	handle_log = function(chat_type, ply, text)
		local chat_data = kingston.chat.get(chat_type)
		if chat_data.no_console_print then
			kingston.log.console_log = false
		end
		
		kingston.log.write("chat", "[%s (%s)][%s] %s", ply:RPName(), ply:Nick(), chat_type, text)
		
		if chat_data.no_console_print then
			kingston.log.console_log = true
		end
	end,
	
	-- default args: name, text
	-- text_format can use markup
	text_format = "%s: %s",
	chat_command = "",
	chat_range = 400,
	chat_font = "CombineControl.ChatNormal",
	chat_filter = {CB_ALL, CB_IC},
	text_color = Color(91, 166, 221),
}

-- chat type data structure:
-- data.on_run - function to run when chat type succeeds
-- data.can_run - function to check if a player can run this chat type
-- data.can_hear - function to calculate players that can hear this chat type
-- data.construct_string - function to construct string to pass to on_run

-- data.text_format - if you dont want to use on_run, you can use this to format your chat type
-- data.chat_command - command to be used in chat to initiate this chat type
-- data.chat_range - range that this chat type can be heard from
-- data.chat_font - default font to use
-- data.chat_filter - chat filters that this chat can be seen from

-- Register new chat types
function kingston.chat.register_type(id, data)
	-- maybe we should implement error handling
	if !id or #id == 0 then return end
	if !data then return end
	
	table.Inherit(data, kingston.chat.default_type)
	kingston.chat.types[id] = data
end

-- Get data structure of a chat type
function kingston.chat.get(id)
	return kingston.chat.types[id]
end

if SERVER then
	-- Run chat type
	-- todo: add logging
	function kingston.chat.run(id, ply, text)
		local chat_data = kingston.chat.get(id)
		if !chat_data then return end
		
		local ret = chat_data.can_say(id, ply)
		if isstring(ret) then -- error
			ply:Notify(nil, Color(200,0,0,255), ret)
			return
		end
		
		local rf = {}
		if !chat_data.calculate_rf then
			for k,v in next, player.GetAll() do
				if v:CharID() < 1 then continue end
				if !chat_data.can_hear(id, ply, v) then continue end
				
				rf[#rf + 1] = v
			end
		else
			rf = chat_data.calculate_rf(id, ply, text)
		end
		
		if !rf then return end
		if #rf == 0 then return end
		
		chat_data.on_run(id, ply, text)
		
		netstream.Start(rf, "nReceiveMessage", id, ply, text)
	end
end

-- Process input to find out what kind of command it is.
-- thanks to chessnut for this code, i wrote my own but it sucked. why re-invent the wheel?
function kingston.chat.process(ply, input)
	local chat_type = "ic"

	for k, v in next, kingston.chat.types do
		local is_correct = false
		local command = ""
		local no_space = v.no_space

		if istable(v.chat_command) then
			for _, chat_command in next, v.chat_command do
				if input:sub(1, #chat_command + (no_space and 0 or 1)):lower() == chat_command..(no_space and "" or " "):lower() then
					is_correct = true
					command = chat_command..(no_space and "" or " ")

					break
				end
			end
		elseif isstring(v.chat_command) then
			is_correct = input:sub(1, #v.chat_command + (no_space and 0 or 1)):lower() == v.chat_command..(no_space and "" or " "):lower()
			command = v.chat_command..(v.no_space and "" or " ")
		end

		if is_correct then
			chat_type = k
			input = input:sub(#command + 1)

			if kingston.chat.types[k].no_space and input:sub(1, 1):match("%s") then
				input = input:sub(2)
			end

			break
		end
	end

	if !input:find("%S") then
		return
	end
	
	return chat_type, input
end

-- thanks to chessnut for this code, i wrote my own but it sucked. why re-invent the wheel?
function kingston.chat.parse_arguments(text)
	local skip = 0
	local arguments = {}
	local cur_string = ""

	for i = 1, #text do
		if i <= skip then continue end

		local c = text:sub(i, i)

		if c == "\"" then
			local match = text:sub(i):match("%b"..c..c)

			if match then
				cur_string = ""
				skip = i + #match
				arguments[#arguments + 1] = match:sub(2, -2)
			else
				cur_string = cur_string..c
			end
		elseif c == " " and cur_string != "" then
			arguments[#arguments + 1] = cur_string
			cur_string = ""
		else
			if c == " " and cur_string == "" then
				continue
			end

			cur_string = cur_string..c
		end
	end

	if cur_string != "" then
		arguments[#arguments + 1] = cur_string
	end

	return arguments
end

/* Default chat types */

kingston.chat.register_type("ic", {
	no_console_print = true,
})

kingston.chat.register_type("yell", {
	chat_command = "/y",
	chat_font = "CombineControl.ChatBig",
	chat_range = 1000,
	no_console_print = true,
	construct_string = function(chat_type, ply, text)
		return {Color(255, 50, 50), "[YELL] ", ply, ": ", text}
	end,
})

kingston.chat.register_type("whisper", {
	chat_command = "/w",
	chat_range = 50,
	chat_font = "CombineControl.ChatSmall",
	no_console_print = true,
	construct_string = function(chat_type, ply, text)
		return {Color(91, 166, 221), "[WHISPER] ", ply, ": ", text}
	end,
})

kingston.chat.register_type("it", {
	chat_command = "/it",
	no_console_print = true,
	while_dead = true,
	construct_string = function(chat_type, ply, text)
		return {Color(131, 196, 251), "** ", text}
	end,
	print_console = function(chat_type, ply, text)
		return Format("[i][%s] ", ply:RPName())
	end,
})

kingston.chat.register_type("lit", {
	chat_command = "/lit",
	chat_range = 1000,
	no_console_print = true,
	while_dead = true,
	construct_string = function(chat_type, ply, text)
		return {Color(131, 196, 251), "** ", text}
	end,
	print_console = function(chat_type, ply, text)
		return Format("[Li][%s] ", ply:RPName())
	end,
})

kingston.chat.register_type("me", {
	chat_command = {"/me"},
	no_space = true,
	no_console_print = true,
	while_dead = true,
	construct_string = function(chat_type, ply, text)
		return {Color(131, 196, 251), "** ", ply, " ", text}
	end,
})

kingston.chat.register_type("lme", {
	chat_command = {"/lme"},
	no_space = true,
	chat_range = 1000,
	no_console_print = true,
	while_dead = true,
	construct_string = function(chat_type, ply, text)
		return {Color(131, 196, 251), "** ", ply, " ", text}
	end,
})

kingston.chat.register_type("event", {
	chat_command = "/ev",
	chat_range = math.huge,
	chat_font = "CombineControl.ChatBig",
	construct_string = function(chat_type, ply, text)
		return {Color(0, 191, 255), "[EVENT] ", text}
	end,
	can_say = function(chat_type, ply, text)
		if !ply:IsAdmin() and !ply:IsEventCoordinator() then
			return "You must be admin/gamemaster to run this command."
		end
		
		return true
	end,
})

kingston.chat.register_type("localevent", {
	chat_command = "/lev",
	chat_range = 3000,
	chat_font = "CombineControl.ChatBig",
	construct_string = function(chat_type, ply, text)
		return {Color(0, 191, 255), "[L-EVENT] ", text}
	end,
	can_say = function(chat_type, ply, text)
		if !ply:IsAdmin() and !ply:IsEventCoordinator() then
			return "You must be admin/gamemaster to run this command."
		end
		
		return true
	end,
})

kingston.chat.register_type("ooc", {
	chat_command = {"/ooc", "//"},
	chat_filter = {CB_ALL, CB_OOC},
	construct_string = function(chat_type, ply, text)
		return {Color(200, 0, 0), "[OOC] ", team.GetColor(ply:Team()), ply, Color( 255, 255, 255, 255 ), ": ", text}
	end,
	can_hear = function(chat_type, speaker, listener)
		return true
	end,
	can_say = function(chat_type, ply, text)
		if ply.LastOOC and CurTime() < ply.LastOOC + GAMEMODE:OOCDelay() then
			if !ply:IsAdmin() then
				ply:Notify(nil, Color(200,200,200), "Wait %s seconds to talk in OOC.", tostring(math.Round(ply.LastOOC + GAMEMODE:OOCDelay() - CurTime())))
				return false
			end
		end
		
		ply.LastOOC = CurTime()
		return true
	end,
})

kingston.chat.register_type("looc", {
	chat_command = {"/looc", ".//", "[["},
	chat_filter = {CB_ALL, CB_OOC},
	no_console_print = true,
	construct_string = function(chat_type, ply, text)
		return {Color(138, 185, 209), "[LOOC] ", ply, ": ", text}
	end,
	can_say = function(chat_type, ply, text)
		return true
	end,
})

kingston.chat.register_type("admin", {
	chat_command = {"/a", "/admin"},
	chat_filter = {CB_ALL, CB_OOC},
	construct_string = function(chat_type, ply, text)
		if ply:IsAdmin() or ply:IsEventCoordinator() then
			return {Color(255, 107, 218), "[ADMIN] ", Color(255, 156, 230), ply, ": ", text}
		else
			return {Color(255, 107, 218), "[ADMIN - Request] ", Color(255, 156, 230), ply, ": ", text}
		end
	end,
	can_hear = function(chat_type, speaker, listener)
		return (listener:IsAdmin() or listener:IsEventCoordinator() or speaker == listener)
	end,
	can_say = function(chat_type, ply, text)
		return true
	end,
})

-- this really is awful
kingston.chat.register_type("pda", {
	chat_command = "/pda",
	no_console_print = true,
	on_run = function(chat_type, ply, text, rf)
		local args = kingston.chat.parse_arguments(text)
		local chat_data = kingston.chat.get(chat_type)
		local chat_str_data = chat_data.construct_string(chat_type, ply, text, rf)
		
		chat_data.handle_log(chat_type, ply, text)

		if args[1] == "all" then
			netstream.Start(rf, "nAddPDANotif", chat_str_data.header, chat_str_data.body, 2, 5)
		else
			netstream.Start(rf, "nAddPDANotif", chat_str_data.header, chat_str_data.body, 6, 3)
		end
	end,
	construct_string = function(chat_type, ply, text, rf)
		local args = kingston.chat.parse_arguments(text)
		local header = ""
		local body = ""
		local pda_name = ply:RPName()
		for k,v in next, ply.Inventory do
			if v:GetClass() == "pda" then
				if v:GetVar("Power", false) and v:GetVar("Primary", false) then
					pda_name = v:GetVar("Name", ply:RPName())
					pda_id = v:GetID()
					break
				end
			end
		end
		
		if !args[2] then return end
		
		if args[1] == "all" then
			header = pda_name.." -> all"
		else
			local targ = rf[1]
			local targ_name = targ:RPName()
			
			for k,v in next, targ.Inventory do
				if v:GetClass() == "pda" then
					if string.find( string.lower( v:GetVar("Name","") ), args[1], nil, true ) and v:GetVar("Power",false) then
						targ_name = v:GetVar("Name",targ:RPName())
						targ_pda_id = v:GetID()
						break
					end
				end
			end
			
			header = pda_name.." -> "..targ_name
		end

		local start = text:find(args[2])
		body = text:sub(start, #text)
		
		if args[1] != "all" then
			kingston.pda.write_chat(pda_id, targ_pda_id, body)
		end
		
		return {header = header, body = body}
	end,
	calculate_rf = function(chat_type, speaker, text)
		local chat_data = kingston.chat.types[chat_type]
		local rf = {}
		local args = kingston.chat.parse_arguments(text)
		
		if !args[2] then return end
		
		if args[1] == "all" then
			for k,v in next, player.GetAll() do
				if !chat_data.can_hear(chat_type, speaker, v) then continue end
				
				rf[#rf + 1] = v
			end

			chat_data.on_run(chat_type, speaker, text, rf)
			return {}
		end
		
		local target = GAMEMODE:FindPlayer(args[1], speaker, true)
		if !target then
			speaker:PDANotify("STALKER.net", "Recipient could not be found, or is offline. Try again later.", 3, 12)
			return {}
		end
		
		chat_data.on_run(chat_type, speaker, text, {target, speaker})
		return {}
	end,
	can_hear = function(chat_type, speaker, listener)
		local item = listener:HasItem("pda")
		if !item then return end
		for k,v in next, listener.Inventory do
			if v:GetClass() == "pda" and v:GetVar("Power", false) then
				return true
			end
		end
		
		return false
	end,
	can_say = function(chat_type, ply, text)
		if !ply:Alive() then
			return "You can't use a PDA, you're dead."
		end
		
		if ply:PassedOut() then
			return "You can't use a PDA, you're passed out."
		end
	
		local item = ply:HasItem("pda")
		local selected_pda
		if !item then 
			return "You don't have a PDA!"
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
			return "Your PDA isn't powered on, or there is no primary PDA!"
		end
		
		return true
	end,
})

-- send regular chat to surrounding players
kingston.chat.register_type("radio", {
	chat_command = {"/r", "/radio"},
	chat_filter = {CB_ALL, CB_RADIO, CB_IC},
	chat_font = "CombineControl.ChatRadio",
	no_console_print = true,
	construct_string = function(chat_type, ply, text)
		local chat_data = kingston.chat.get(chat_type)
		if CLIENT then
			if ply != LocalPlayer() and ply:GetPos():DistToSqr(LocalPlayer():GetPos()) <= (chat_data.chat_range * chat_data.chat_range) then
				return {chat_data.text_color, Format(chat_data.text_format, ply:RPName(), text)}
			end
		end
	
		return {Color(72, 118, 255), "[Radio] ", ply, ": ", text}
	end,
	calculate_rf = function(chat_type, ply, text)
		local chat_data = kingston.chat.get(chat_type)
		local rf = {ply}
		local special_rf = {}
		for k,v in next, player.GetAll() do
			if ply != v and ply:GetPos():DistToSqr(v:GetPos()) <= (chat_data.chat_range * chat_data.chat_range) then
				special_rf[#special_rf + 1] = v
			end
			if v:RadioFreq() != ply:RadioFreq() then continue end
			
			rf[#rf + 1] = v
		end
		
		if #special_rf > 0 then
			netstream.Start(special_rf, "nChatRadioSurround", chat_type, ply, text)
		end

		return rf
	end,
	can_say = function(chat_type, ply, text)
		if !ply:Alive() then
			return "You can't speak, you're dead."
		end
		
		if ply:PassedOut() then
			return "You can't speak, you're passed out."
		end

		local tr = GAMEMODE:GetHandTrace( ply, 128 );
		if tr.Entity and tr.Entity:IsValid() and tr.Entity:GetClass() == "cc_radio" then
			return true
		end
		
		if ply:HasItem("radio") then
			return true
		end
		
		return "You don't have a radio or you're not near one!"
	end,
})

if CLIENT then
	netstream.Hook("nChatRadioSurround", function(chat_type, ply, text)
		local chat_data = kingston.chat.get(chat_type)
	
		kingston.log.write("chat", "[%s (%s)][radio_sur] %s", ply:RPName(), ply:Nick(), text)
		GAMEMODE:AddChat({ CB_ALL, CB_IC }, "CombineControl.ChatNormal", chat_data.text_color, ply, ": ", text)
	end)
end

kingston.chat.register_type("pm", {
	chat_command = "/pm",
	chat_filter = {CB_ALL, CB_OOC},
	chat_font = "CombineControl.ChatNormal",
	no_console_print = true,
	construct_string = function(chat_type, ply, text)
		local args = kingston.chat.parse_arguments(text)
		local target = GAMEMODE:FindPlayer(args[1], ply)
		
		local start = text:find(args[2])
		body = text:sub(start, #text)
		
		if CLIENT then
			if ply == LocalPlayer() then
				return {Color(160, 255, 160), "[PM to ", target, "]: ", body}
			else
				return {Color(160, 255, 160), "[PM from ", ply, "]: ", body}
			end
		end
	end,
	calculate_rf = function(chat_type, speaker, text)
		local args = kingston.chat.parse_arguments(text)
		local chat_data = kingston.chat.get(chat_type)
		local target = GAMEMODE:FindPlayer(args[1], speaker)
		if !target then
			speaker:Notify(nil, Color(255,0,0), "Specified player not found.")
			return
		end
		
		return {target, speaker}
	end,
	can_say = function(chat_type, ply, text)
		return true
	end,
})

kingston.chat.Languages = { };
kingston.chat.Languages[TRAIT_ENGLISH] = { "English", "/eng" };
kingston.chat.Languages[TRAIT_CHINESE] = { "Chinese", "/chi" };
kingston.chat.Languages[TRAIT_JAPANESE] = { "Japanese", "/jap" };
kingston.chat.Languages[TRAIT_SPANISH] = { "Spanish", "/spa" };
kingston.chat.Languages[TRAIT_FRENCH] = { "French", "/fre" };
kingston.chat.Languages[TRAIT_GERMAN] = { "German", "/ger" };
kingston.chat.Languages[TRAIT_ITALIAN] = { "Italian", "/ita" };
kingston.chat.Languages[TRAIT_POLISH] = { "Polish", "/pol" };

for trait,info in next, kingston.chat.Languages do
	local id = info[2]:sub(2, #info[2])
	
	kingston.chat.register_type(id, {
		no_console_print = true,
		chat_command = info[2],
		-- any aspiring cheater could detour this and get the real text... but shh dont tell anyone
		construct_string = function(chat_type, ply, text)
			if LocalPlayer():HasTrait(trait) then
				return {Color(255, 167, 73), Format("[%s] ", info[1]), ply, ": ", text}
			end
			
			return {Color(255, 167, 73), ply, Format(" says something in %s.", info[1])}
		end,
		can_say = function(chat_type, ply, text)
			if !ply:Alive() then
				return "You can't speak, you're dead."
			end
			
			if ply:PassedOut() then
				return "You can't speak, you're passed out."
			end
		
			if !ply:HasTrait(trait) then
				return Format("You cannot speak %s!", info[1])
			end
		end,
	})
	
	kingston.chat.register_type(id.."Y", {
		no_console_print = true,
		chat_command = info[2].."y",
		chat_font = "CombineControl.ChatBig",
		chat_range = 1000,
		-- any aspiring cheater could detour this and get the real text... but shh dont tell anyone
		construct_string = function(chat_type, ply, text)
			if LocalPlayer():HasTrait(trait) then
				return {Color( 255, 167, 73, 255 ), Format("[%s - Yell] ", info[1]), ply, ": ", text}
			end
			
			return {Color( 255, 167, 73, 255 ), ply, Format(" yells something in %s.", info[1])}
		end,
		can_say = function(chat_type, ply, text)
			if !ply:Alive() then
				return "You can't speak, you're dead."
			end
			
			if ply:PassedOut() then
				return "You can't speak, you're passed out."
			end
		
			if !ply:HasTrait(trait) then
				return Format("You cannot speak %s!", info[1])
			end
		end,
	})
	
	kingston.chat.register_type(id.."W", {
		no_console_print = true,
		chat_command = info[2].."w",
		chat_font = "CombineControl.ChatSmall",
		chat_range = 150,
		-- any aspiring cheater could detour this and get the real text... but shh dont tell anyone
		construct_string = function(chat_type, ply, text)
			if LocalPlayer():HasTrait(trait) then
				return {Color( 255, 167, 73, 255 ), Format("[%s - Whisper] ", info[1]), ply, ": ", text}
			end
			
			return {Color( 255, 167, 73, 255 ), ply, Format(" whispers something in %s.", info[1])}
		end,
		can_say = function(chat_type, ply, text)
			if !ply:Alive() then
				return "You can't speak, you're dead."
			end
			
			if ply:PassedOut() then
				return "You can't speak, you're passed out."
			end
		
			if !ply:HasTrait(trait) then
				return Format("You cannot speak %s!", info[1])
			end
		end,
	})
end