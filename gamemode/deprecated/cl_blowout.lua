kingston = kingston or {}
kingston.blowout = kingston.blowout or {}

kingston.blowout.SoundNames = kingston.blowout.SoundNames or {
	"blowout_announce1",
	"blowout_announce2",
	"blowout_prehit",
	"blowout_ambient1",
	"blowout_ambient2",
	"blowout_ambient3",
	"blowout_ambient4",
	"blowout_ambient5",
	"blowout_start",
	"blowout_buildup",
	"blowout_hit1",
	"blowout_hit2",
	"blowout_hit3",
	"blowout_end",
	"blowout_posthit",
	"blowout_begin",
	"blowout_flare_01",
	"blowout_flare_02",
	"blowout_flare_03",
	"blowout_flare_04",
	"radio_russian_announce1",
	"radio_russian_announce2",
	"radio_russian_announce3",
	"pda_communication_lost",
	"pda_welcome",
}

kingston.blowout.SoundPaths = kingston.blowout.SoundPaths or {
	"blowout/announce1.wav",
	"blowout/announce2.wav",
	"blowout/prehit.wav",
	"blowout/ambient1.wav",
	"blowout/ambient2.wav",
	"blowout/ambient3.wav",
	"blowout/ambient4.wav",
	"blowout/ambient5.wav",
	"blowout/start.wav",
	"blowout/buildup.wav",
	"blowout/hit1.wav",
	"blowout/hit2.wav",
	"blowout/hit3.wav",
	"blowout/end.wav",
	"blowout/posthit.wav",
	"blowout/blowout_begin.wav",
	"blowout/blowout_flare_01.wav",
	"blowout/blowout_flare_02.wav",
	"blowout/blowout_flare_03.wav",
	"blowout/blowout_flare_04.wav",
	"blowout/radio_russian_announce1.wav",
	"blowout/radio_russian_announce2.wav",
	"blowout/radio_russian_announce3.wav",
	"kingston/pda/pda_communication_lost.ogg",
	"kingston/pda/pda_welcome.ogg",
}
for i=1, #kingston.blowout.SoundNames do	--Registering custom sound scripts - probably the best way of playing multiple world-sounds on the client...
	sound.Add( {
		name = kingston.blowout.SoundNames[i],
		channel = CHAN_STATIC,
		level = 0,
		sound = kingston.blowout.SoundPaths[i]
	} )
end

kingston.blowout.last_stage = kingston.blowout.last_stage or 0
kingston.blowout.stages = kingston.blowout.stages or {}
kingston.blowout.stage_think = kingston.blowout.stage_think or {}

-- Ambient Start
kingston.blowout.stages[1] = function()
	GAMEMODE:FadeOutMusic( 10 )
	
	kingston.blowout.ambient_pp_start = CurTime()
	kingston.blowout.ambient_pp_duration = GetGlobalInt("BlowoutAnnounceDuration", 300)
	kingston.blowout.current_post_processing = 1
end

-- Blowout Start
kingston.blowout.stages[2] = function()
	local v = table.Random( GAMEMODE:GetSongList( SONG_ALERT ) );
	GAMEMODE:PlayMusic( v );

	if !kingston.blowout.ambient_pp_start then
		kingston.blowout.ambient_pp_start = CurTime()
		kingston.blowout.ambient_pp_duration = GetGlobalInt("BlowoutAnnounceDuration", 300)
	end
	
	kingston.blowout.current_post_processing = 2
	kingston.blowout.stage2_pp_start = CurTime()
end
kingston.blowout.stages[3] = function()
	kingston.blowout.current_post_processing = 3
	kingston.blowout.stage3_pp_start = CurTime()
end
kingston.blowout.stages[4] = function()
	GAMEMODE:FadeOutMusic(10)
	kingston.blowout.cooldown_pp_start = CurTime()
	kingston.blowout.cooldown_pp_duration = 20
	kingston.blowout.current_post_processing = 4
	
	local v = table.Random( GAMEMODE:GetSongList( SONG_IDLE ) );
	GAMEMODE.NextAutoMusic = CurTime() + 20
end

local function blowout_think()
	local stage = kingston.blowout.get_var("Int", "current_stage", 0)
	if kingston.blowout.last_stage != stage then
		if stage > 0 then
			kingston.blowout.stages[stage]()
			kingston.blowout.last_stage = stage
		else
			kingston.blowout.last_stage = 0
		end
	end
end
hook.Add("Think", "STALKER.BlowoutThink", blowout_think)

kingston.blowout.current_post_processing = kingston.blowout.current_post_processing or 0
kingston.blowout.post_processes = kingston.blowout.post_processes or {}

kingston.blowout.post_processes[1] = function()
	local tab = {}
	local Var = 0
	Var = math.min((CurTime() - kingston.blowout.ambient_pp_start) / kingston.blowout.ambient_pp_duration, 1)

	tab[ "$pp_colour_addr" ] = 0
	tab[ "$pp_colour_addg" ] = 0
	tab[ "$pp_colour_addb" ] = 0
	tab[ "$pp_colour_brightness" ] = -Var * 0.1
	tab[ "$pp_colour_contrast" ] = 1 - Var * 0.1
	tab[ "$pp_colour_colour" ] = 1 - Var * 0.5
	tab[ "$pp_colour_mulr" ] = 0
	tab[ "$pp_colour_mulg" ] = 0
	tab[ "$pp_colour_mulb" ] = 0
	
	DrawColorModify( tab )
end

kingston.blowout.post_processes[2] = function()
	local tab = {}
	if !kingston.blowout.is_protected(LocalPlayer()) then
		local Var = math.min((CurTime() - kingston.blowout.stage2_pp_start) / 15,1)
		local Var2 = Var ^ 2
		
		tab[ "$pp_colour_addr" ] = 0
		tab[ "$pp_colour_addg" ] = -Var * 0.15
		tab[ "$pp_colour_addb" ] = -Var * 0.25
		tab[ "$pp_colour_brightness" ] = -0.15 - Var * 0.05
		tab[ "$pp_colour_contrast" ] = 1.5 + Var2 * 1.21
		tab[ "$pp_colour_colour" ] = 0.3 - Var * 0.3
		tab[ "$pp_colour_mulr" ] = Var * 0.4
		tab[ "$pp_colour_mulg" ] = Var * 0.3
		tab[ "$pp_colour_mulb" ] = 0

		DrawBloom( 1 - Var / 1.5, 1 - Var / 1.5, 10, 10, 3, 1, 1, 1, 1)
		
		DrawColorModify( tab )
	else
		local Var = 0
		Var = math.min((CurTime() - kingston.blowout.ambient_pp_start) / kingston.blowout.ambient_pp_duration, 1)

		tab[ "$pp_colour_addr" ] = 0
		tab[ "$pp_colour_addg" ] = 0
		tab[ "$pp_colour_addb" ] = 0
		tab[ "$pp_colour_brightness" ] = -Var * 0.1
		tab[ "$pp_colour_contrast" ] = 1 - Var * 0.1
		tab[ "$pp_colour_colour" ] = 1 - Var * 0.5
		tab[ "$pp_colour_mulr" ] = 0
		tab[ "$pp_colour_mulg" ] = 0
		tab[ "$pp_colour_mulb" ] = 0
		
		DrawColorModify( tab )
	end
end

kingston.blowout.post_processes[3] = function()
	local tab = {}
	if !kingston.blowout.is_protected(LocalPlayer()) then
		local Var = math.min((CurTime() - kingston.blowout.stage2_pp_start) / 15,1)
		local Var2 = Var ^ 2
		local FlashVar = math.max(1.5 - (CurTime() - kingston.blowout.stage2_pp_start),0) / 3

		tab[ "$pp_colour_addr" ] = 0
		tab[ "$pp_colour_addg" ] = -Var * 0.15
		tab[ "$pp_colour_addb" ] = -Var * 0.25
		tab[ "$pp_colour_brightness" ] = -0.15 - Var * 0.05
		tab[ "$pp_colour_contrast" ] = 1.5 + Var2 * 1.21
		tab[ "$pp_colour_colour" ] = 0.3 - Var * 0.3
		tab[ "$pp_colour_mulr" ] = Var * 0.4
		tab[ "$pp_colour_mulg" ] = Var * 0.3
		tab[ "$pp_colour_mulb" ] = 0

		DrawBloom( 1 - Var / 1.5, 1 - Var / 1.5, 10, 10, 3, 1, 1, 1, 1)
		
		DrawColorModify( tab )
	else
		local Var = 0
		Var = math.min((CurTime() - kingston.blowout.ambient_pp_start) / kingston.blowout.ambient_pp_duration, 1)

		tab[ "$pp_colour_addr" ] = 0
		tab[ "$pp_colour_addg" ] = 0
		tab[ "$pp_colour_addb" ] = 0
		tab[ "$pp_colour_brightness" ] = -Var * 0.1
		tab[ "$pp_colour_contrast" ] = 1 - Var * 0.1
		tab[ "$pp_colour_colour" ] = 1 - Var * 0.5
		tab[ "$pp_colour_mulr" ] = 0
		tab[ "$pp_colour_mulg" ] = 0
		tab[ "$pp_colour_mulb" ] = 0
		
		DrawColorModify( tab )
	end
end

kingston.blowout.post_processes[4] = function()
	local tab = {}
	local Var = 0
	Var = math.max( math.min((kingston.blowout.cooldown_pp_start - CurTime()) / kingston.blowout.cooldown_pp_duration, 1), 0)

	tab[ "$pp_colour_addr" ] = 0
	tab[ "$pp_colour_addg" ] = 0
	tab[ "$pp_colour_addb" ] = 0
	tab[ "$pp_colour_brightness" ] = -Var * 0.1
	tab[ "$pp_colour_contrast" ] = 1 - Var * 0.1
	tab[ "$pp_colour_colour" ] = 1 - Var * 0.5
	tab[ "$pp_colour_mulr" ] = 0
	tab[ "$pp_colour_mulg" ] = 0
	tab[ "$pp_colour_mulb" ] = 0
	
	DrawColorModify( tab )
end

local function blowout_pp()
	local pp_func = kingston.blowout.post_processes[kingston.blowout.current_post_processing]
	if pp_func then
		pp_func()
	end
end
hook.Add("RenderScreenspaceEffects", "STALKER.BlowoutRPP", blowout_pp)

local function reset_to_baseline()
	kingston.blowout.current_post_processing = 0
end
netstream.Hook("CancelBlowout", reset_to_baseline)

kingston.blowout.volume = kingston.blowout.volume or cookie.GetNumber("kingston.blowout.volume", 1)
local function play_sound(sound_script)
	sound.PlayFile(sound_script, "", function(chnl)
		if IsValid(chnl) then
			chnl:SetVolume(kingston.blowout.volume)
			chnl:Play()
		end
	end)
end
netstream.Hook("blowout.play_sound", play_sound)