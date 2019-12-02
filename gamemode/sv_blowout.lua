-- Sounds and post-processing credit to Cre8or, creator of the Blowout! addon on workshop.
-- Recoded for Point of Contact.
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

kingston.blowout.timers = kingston.blowout.timers or {}

kingston.blowout.current_stage = kingston.blowout.current_stage or 0
kingston.blowout.next_action = kingston.blowout.next_action or 0
kingston.blowout.next_stage = kingston.blowout.next_stage or 0

kingston.blowout.stages = kingston.blowout.stages or {}
kingston.blowout.stage_think = kingston.blowout.stage_think or {}
kingston.blowout.timer_stages = kingston.blowout.timer_stages or {}

function kingston.blowout.set_stage(stage, duration)
	if !stage then return end
	
	local time_to = CurTime() + (duration or 10)
	
	kingston.blowout.next_stage = stage
	kingston.blowout.next_action = time_to
end

function kingston.blowout.create_timer(id, duration, func)
	if !id or !duration or !func then return end
	
	kingston.blowout.timers[id] = {
		start_time = CurTime(),
		duration = duration,
		callback = func,
	}
end

function kingston.blowout.get_timer(id)
	return kingston.blowout.timers[id] or false
end

-- This function only accepts soundscripts.
function kingston.blowout.play_sound(soundscript)
	local sound_properties = sound.GetProperties(soundscript)
	if !sound_properties then return end
	
	netstream.Start(nil, "blowout.play_sound", "sound/"..sound_properties.sound)
end

function kingston.blowout.set_var(type, key, value)
	Entity(0)["SetNW2"..type](Entity(0), "kingston.blowout_var."..key, value)
end

-- Blowout specifics

-- Ambient Start
kingston.blowout.stages[1] = function()
	kingston.blowout.next_sound = CurTime() + math.random(15,60)
	kingston.blowout.total_sounds = math.random(5,10)
	kingston.blowout.sounds_played = 0
	kingston.blowout.buildup_played = false
	kingston.blowout.connection_lost = false
	kingston.blowout.has_done_alert = false
	kingston.blowout.set_var("Bool", "connection_lost", false)
	
	kingston.blowout.set_stage(2, GAMEMODE:BlowoutAnnounceDuration())
	kingston.blowout.set_var("Bool", "active_blowout", true)
end

kingston.blowout.stage_think[1] = function()
	if CurTime() >= kingston.blowout.next_sound and kingston.blowout.sounds_played < kingston.blowout.total_sounds then
		kingston.blowout.play_sound("blowout_ambient"..math.random(1,5))
	
		kingston.blowout.next_sound = CurTime() + math.random(15,60)
		kingston.blowout.sounds_played = kingston.blowout.sounds_played + 1
	end
	
	if kingston.blowout.next_action - CurTime() <= 60 and !kingston.blowout.has_done_alert then
		kingston.blowout.play_sound("radio_russian_announce"..math.random(1,3))
		netstream.Start(nil, "nAddPDANotif", "Attention!", "An emission is approaching, seek cover immediately!", 1, 1, true)
		
		kingston.blowout.has_done_alert = true
	end
	
	if kingston.blowout.next_action - CurTime() <= 16 and !kingston.blowout.buildup_played then
		kingston.blowout.buildup_played = true
		kingston.blowout.play_sound("blowout_buildup")
	end
	
	if kingston.blowout.next_action - CurTime() <= 10 and !kingston.blowout.connection_lost then
		netstream.Start(nil, "nAddPDANotif", "Connection lost...", "Connection to STALKER.net lost...", 3, 12, true)
		
		kingston.blowout.connection_lost = true
		kingston.blowout.set_var("Bool", "connection_lost", true)
		kingston.blowout.play_sound("pda_communication_lost")
	end
end

-- Blowout Start
kingston.blowout.stages[2] = function()
	kingston.blowout.play_sound("blowout_begin")
	kingston.blowout.next_sound = CurTime() + 13
	local duration = math.random(15,45)
	kingston.blowout.set_stage(3, duration)
	
	if !kingston.blowout.connection_lost then
		netstream.Start(nil, "nAddPDANotif", "Connection lost...", "Connection to STALKER.net lost...", 3, 12, true)
		
		kingston.blowout.connection_lost = true
		kingston.blowout.set_var("Bool", "connection_lost", true)
		kingston.blowout.play_sound("pda_communication_lost")
	end
	
	local e=ents.Create("env_shake")	--Shake the world a little
	e:SetKeyValue("amplitude", "1")
	e:SetKeyValue("frequency","100.0")
	e:SetKeyValue("duration",tostring(duration))
	e:SetKeyValue("spawnflags", "5")
	e:Fire("startshake")
end
kingston.blowout.stage_think[2] = function()
	if CurTime() >= kingston.blowout.next_sound then
		kingston.blowout.play_sound("blowout_flare_0"..math.random(1,4))
	
		kingston.blowout.next_sound = CurTime() + math.random(5,10)
	end
end

kingston.blowout.stages[3] = function()
	kingston.blowout.play_sound("blowout_start")
	kingston.blowout.next_sound = CurTime() + 5
	kingston.blowout.next_damage = CurTime() + 5
	
	local duration = math.random(30, 180)
	
	local e=ents.Create("env_shake")
	e:SetKeyValue("amplitude", "3")
	e:SetKeyValue("frequency","100.0")
	e:SetKeyValue("duration",tostring(duration))
	e:SetKeyValue("spawnflags", "5")
	e:Fire("startshake")
	
	kingston.blowout.set_stage(4, duration)
end
kingston.blowout.stage_think[3] = function()
	if CurTime() >= kingston.blowout.next_sound then
		local hit_or_lightning = math.random(1,3)
		if hit_or_lightning == 1 then
			kingston.blowout.play_sound("blowout_hit"..math.random(1,3))
		elseif hit_or_lightning == 2 then
			kingston.blowout.play_sound("blowout_lightning_0"..math.random(1,5))
		else
			kingston.blowout.play_sound("blowout_flare_0"..math.random(1,4))
		end
	
		kingston.blowout.next_sound = CurTime() + math.random(0.75,1)
	end
	
	if CurTime() >= kingston.blowout.next_damage then
		for k,v in next, player.GetAll() do
			if v:CharID() <= 0 then continue end
			if !v:Alive() then continue end
			if v:IsEFlagSet(EFL_NOCLIP_ACTIVE) then continue end
			if kingston.blowout.is_protected(v) then continue end
			
			kingston.blowout.do_damage(v)
			kingston.blowout.next_damage = CurTime() + 5
		end
	end
end

kingston.blowout.stages[4] = function()
	kingston.blowout.play_sound("blowout_end")
	kingston.blowout.has_done_alert = false
	
	kingston.blowout.create_timer("finish_blowout", 10, function()
		netstream.Start(nil, "nAddPDANotif", "Connection regained", "Reconnected to STALKER.net", 3, 12, true)
		
		kingston.blowout.connection_lost = false
		kingston.blowout.set_var("Bool", "connection_lost", false)
		kingston.blowout.play_sound("pda_welcome")
	end)
	
	if GAMEMODE:BlowoutAutoShedule() > 0 then
		kingston.blowout.set_stage(1, GAMEMODE:BlowoutInterval())
	else
		kingston.blowout.set_stage(0, 20)
	end
	
	kingston.blowout.set_var("Bool", "active_blowout", false)
end

function kingston.blowout.initiate(immediate)
	if GAMEMODE:BlowoutEnabled() < 1 then return end

	if immediate then
		kingston.blowout.set_stage(2, 0)
	else
		kingston.blowout.set_stage(1, 0)
	end
end

function kingston.blowout.cancel()
	kingston.blowout.set_stage(0, 0)
	netstream.Start(nil, "CancelBlowout")
	
	if kingston.blowout.connection_lost then
		kingston.blowout.has_done_alert = false
		kingston.blowout.connection_lost = false
		
		kingston.blowout.set_var("Bool", "connection_lost", false)

		netstream.Start(nil, "nAddPDANotif", "Connection regained", "Reconnected to STALKER.net", 3, 12, true)
		kingston.blowout.play_sound("pda_welcome")
	end
	
	kingston.blowout.set_var("Bool", "active_blowout", false)
end

function kingston.blowout.do_damage(ent)
	if kingston.blowout.is_protected(ent) then return end
	
	local dmginfo = DamageInfo()
	dmginfo:SetDamage(25)
	dmginfo:SetAttacker(ent)
	dmginfo:SetDamageType(DMG_SONIC)
	ent:TakeDamageInfo(dmginfo)
end

local function blowout_think()
	if GAMEMODE:BlowoutEnabled() < 1 then return end
	
	for index,timer in next, kingston.blowout.timers do
		if CurTime() >= timer.start_time + timer.duration then
			timer.callback()
			kingston.blowout.timers[index] = nil
		end
	end
	
	if kingston.blowout.next_action > 0 and CurTime() >= kingston.blowout.next_action then
		kingston.blowout.current_stage = kingston.blowout.next_stage
		
		local stage_func = kingston.blowout.stages[kingston.blowout.current_stage]
		if stage_func then
			stage_func()
		end
		
		kingston.blowout.set_var("Int", "current_stage", kingston.blowout.current_stage)
	end
	
	if kingston.blowout.stage_think[kingston.blowout.current_stage] then
		kingston.blowout.stage_think[kingston.blowout.current_stage]()
	end
end
hook.Add("Think", "STALKER.BlowoutThink", blowout_think)