AddCSLuaFile()

if(SERVER) then
	util.AddNetworkString("STALKERNPCControllerStopPsySound")
	
	if( !GetConVar("stalker_npc_corpse_dietime")) then
		CreateConVar("stalker_npc_corpse_dietime", 300, bit.bor(FCVAR_ARCHIVE, FCVAR_REPLICATED) ,[[Burer and controller serverside corpse will be removed after this amount of seconds. 0 - not remove.]])
	end
	
	
	
	if( !GetConVar("stalker_npc_burer_toolgun_limit")) then
		CreateConVar("stalker_npc_burer_toolgun_limit", 1, bit.bor(FCVAR_ARCHIVE, FCVAR_REPLICATED) ,[[Limits toolgun for burer. 1 - kill player and npc's only, 0 - kill all.]])
	end
	
	if( !GetConVar("stalker_npc_burer_max_mass")) then
		CreateConVar("stalker_npc_burer_max_mass", 800, bit.bor(FCVAR_ARCHIVE, FCVAR_REPLICATED) ,[[Maximal mass of prop that burer can throw.]])
	end
	
	if( !GetConVar("stalker_npc_burer_kill_constraints")) then
		CreateConVar("stalker_npc_burer_kill_constraints", 1, bit.bor(FCVAR_ARCHIVE, FCVAR_REPLICATED) ,[[Constraints on grabbed by burer prop will be removed. 0 - not remove, 1 - remove if prop only have rope and winch constraint, 2 - remove if prop don't have weld constraint, 3 - remove all constraints.]])
	end
	
	if( !GetConVar("stalker_npc_burer_max_grabs")) then
		CreateConVar("stalker_npc_burer_max_grabs", 10, bit.bor(FCVAR_ARCHIVE, FCVAR_REPLICATED) ,[[Maximal amount of entities that burer can hold at same time.]])
	end
	
	if( !GetConVar("stalker_npc_burer_health")) then
		CreateConVar("stalker_npc_burer_health", 400, bit.bor(FCVAR_ARCHIVE, FCVAR_REPLICATED) ,[[Burer health.]])
	end
	
	
	
	if( !GetConVar("stalker_npc_controller_max_victims")) then
		CreateConVar("stalker_npc_controller_max_victims", 10, bit.bor(FCVAR_ARCHIVE, FCVAR_REPLICATED) ,[[Maximal amount of npc's that controller can control.]])
	end
	
	if( !GetConVar("stalker_npc_controller_health")) then
		CreateConVar("stalker_npc_controller_health", 300, bit.bor(FCVAR_ARCHIVE, FCVAR_REPLICATED) ,[[Controller health.]])
	end
	
	
	
	cvars.AddChangeCallback( "stalker_npc_corpse_dietime", function( name, Cold, Cnew )
		if(!isnumber(tonumber(Cnew))) then
			if(isnumber(tonumber(Cold))) then
				GetConVar(name):SetInt(tonumber(Cold))
			else
				GetConVar(name):SetInt(300)
			end
		else
			if(tonumber(Cnew)>6000) then
				GetConVar(name):SetInt(6000)
			elseif(tonumber(Cnew)<0) then
				GetConVar(name):SetInt(0)
			elseif(math.floor(tonumber(Cnew))!=tonumber(Cnew)) then
				GetConVar(name):SetInt(tonumber(Cold))
			end
		end
	end )
	
	
	
	cvars.AddChangeCallback( "stalker_npc_burer_toolgun_limit", function( name, Cold, Cnew )
		if(!isnumber(tonumber(Cnew))) then
			if(isnumber(tonumber(Cold))) then
				GetConVar(name):SetInt(tonumber(Cold))
			else
				GetConVar(name):SetInt(1)
			end
		else
			if(tonumber(Cnew)>1) then
				GetConVar(name):SetInt(1)
			elseif(tonumber(Cnew)<0) then
				GetConVar(name):SetInt(0)
			elseif(math.floor(tonumber(Cnew))!=tonumber(Cnew)) then
				GetConVar(name):SetInt(tonumber(Cold))
			end
		end
	end )

	cvars.AddChangeCallback( "stalker_npc_burer_max_mass", function( name, Cold, Cnew )
		if(!isnumber(tonumber(Cnew))) then
			if(isnumber(tonumber(Cold))) then
				GetConVar(name):SetInt(tonumber(Cold))
			else
				GetConVar(name):SetInt(800)
			end
		else
			if(tonumber(Cnew)>2000) then
				GetConVar(name):SetInt(2000)
			elseif(tonumber(Cnew)<100) then
				GetConVar(name):SetInt(100)
			elseif(math.floor(tonumber(Cnew))!=tonumber(Cnew)) then
				GetConVar(name):SetInt(tonumber(Cold))
			end
		end
	end )
	
	cvars.AddChangeCallback( "stalker_npc_burer_max_grabs", function( name, Cold, Cnew )
		if(!isnumber(tonumber(Cnew))) then
			if(isnumber(tonumber(Cold))) then
				GetConVar(name):SetInt(tonumber(Cold))
			else
				GetConVar(name):SetInt(10)
			end
		else
			if(tonumber(Cnew)>20) then
				GetConVar(name):SetInt(20)
			elseif(tonumber(Cnew)<1) then
				GetConVar(name):SetInt(1)
			elseif(math.floor(tonumber(Cnew))!=tonumber(Cnew)) then
				GetConVar(name):SetInt(tonumber(Cold))
			end
		end
	end )
	
	cvars.AddChangeCallback( "stalker_npc_burer_kill_constraints", function( name, Cold, Cnew )
		if(!isnumber(tonumber(Cnew))) then
			if(isnumber(tonumber(Cold))) then
				GetConVar(name):SetInt(tonumber(Cold))
			else
				GetConVar(name):SetInt(1)
			end
		else
			if(tonumber(Cnew)>3) then
				GetConVar(name):SetInt(3)
			elseif(tonumber(Cnew)<0) then
				GetConVar(name):SetInt(0)
			elseif(math.floor(tonumber(Cnew))!=tonumber(Cnew)) then
				GetConVar(name):SetInt(tonumber(Cold))
			end
		end
	end )
	
	cvars.AddChangeCallback( "stalker_npc_burer_health", function( name, Cold, Cnew )
		if(!isnumber(tonumber(Cnew))) then
			if(isnumber(tonumber(Cold))) then
				GetConVar(name):SetInt(tonumber(Cold))
			else
				GetConVar(name):SetInt(400)
			end
		else
			if(tonumber(Cnew)>999999) then
				GetConVar(name):SetInt(999999)
			elseif(tonumber(Cnew)<10) then
				GetConVar(name):SetInt(10)
			elseif(math.floor(tonumber(Cnew))!=tonumber(Cnew)) then
				GetConVar(name):SetInt(tonumber(Cold))
			end
		end
	end )
	
	
	
	cvars.AddChangeCallback( "stalker_npc_controller_max_victims", function( name, Cold, Cnew )
		if(!isnumber(tonumber(Cnew))) then
			if(isnumber(tonumber(Cold))) then
				GetConVar(name):SetInt(tonumber(Cold))
			else
				GetConVar(name):SetInt(10)
			end
		else
			if(tonumber(Cnew)>20) then
				GetConVar(name):SetInt(20)
			elseif(tonumber(Cnew)<1) then
				GetConVar(name):SetInt(1)
			elseif(math.floor(tonumber(Cnew))!=tonumber(Cnew)) then
				GetConVar(name):SetInt(tonumber(Cold))
			end
		end
	end )
	
	cvars.AddChangeCallback( "stalker_npc_controller_health", function( name, Cold, Cnew )
		if(!isnumber(tonumber(Cnew))) then
			if(isnumber(tonumber(Cold))) then
				GetConVar(name):SetInt(tonumber(Cold))
			else
				GetConVar(name):SetInt(300)
			end
		else
			if(tonumber(Cnew)>999999) then
				GetConVar(name):SetInt(999999)
			elseif(tonumber(Cnew)<10) then
				GetConVar(name):SetInt(10)
			elseif(math.floor(tonumber(Cnew))!=tonumber(Cnew)) then
				GetConVar(name):SetInt(tonumber(Cold))
			end
		end
	end )
end

local TEMP_VOICEDIST = 350


local function AddNPC(NAME,TYPE)
	local NPC = {
		Name = NAME, 
		Class = TYPE,			
		Category = "S.T.A.L.K.E.R."	
	}

	list.Set( "NPC", TYPE, NPC )
end

AddNPC("Controller (ZC Friendly)","npc_stalker_controller_100rads")
AddNPC("Burer (ZC Friendly)","npc_stalker_burer_100rads")

local function AddSoundInterval(NAME,IMIN,IMAX,CHAN,VOL,LEV,PITMIN,PITMAX,PATH)
	for S=IMIN, IMAX do
		sound.Add( {
			name = NAME..S,
			channel = CHAN,
			volume = VOL,
			level = LEV,
			pitch = { PITMIN, PITMAX },
			sound = PATH..S..".wav"
		} )
	end
end


local function AddSound(NAME,CHAN,VOL,LEV,PITMIN,PITMAX,PATH)
	sound.Add( {
		name = NAME,
		channel = CHAN,
		volume = VOL,
		level = LEV,
		pitch = { PITMIN, PITMAX },
		sound = PATH
	} )
end

AddSound("Stalker.Controller.Die1",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"GSC/S.T.A.L.K.E.R/Monsters/controller/controller_die_0.wav")
AddSound("Stalker.Controller.Die2",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"GSC/S.T.A.L.K.E.R/Monsters/controller/controller_die_1.wav")

AddSound("Stalker.Controller.Pain1",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"GSC/S.T.A.L.K.E.R/Monsters/controller/controller_hit_0.wav")
AddSound("Stalker.Controller.Pain2",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"GSC/S.T.A.L.K.E.R/Monsters/controller/controller_hit_1.wav")
AddSound("Stalker.Controller.Pain3",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"GSC/S.T.A.L.K.E.R/Monsters/controller/controller_hit_2.wav")

AddSound("Stalker.Controller.SpecialAttack1",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"GSC/S.T.A.L.K.E.R/Monsters/controller/controller_attack_hit.wav")

AddSound("Stalker.Controller.PsyAura1",CHAN_AUTO,1,0,98,102,"GSC/S.T.A.L.K.E.R/Monsters/controller/controller_presence_1.wav")
AddSound("Stalker.Controller.PsyAura2",CHAN_AUTO,1,0,98,102,"GSC/S.T.A.L.K.E.R/Monsters/controller/controller_presence_2.wav")
AddSound("Stalker.Controller.PsyAura3",CHAN_AUTO,1,0,98,102,"GSC/S.T.A.L.K.E.R/Monsters/controller/controller_presence_3.wav")

AddSound("Stalker.Controller.Control.1",CHAN_WEAPON,1,0,98,102,"GSC/S.T.A.L.K.E.R/Monsters/controller/controller_tube_prepare.wav")
AddSound("Stalker.Controller.Control.2",CHAN_WEAPON,1,0,98,102,"GSC/S.T.A.L.K.E.R/Monsters/controller/controller_first_hit.wav")
AddSound("Stalker.Controller.Control.3",CHAN_WEAPON,1,0,98,102,"GSC/S.T.A.L.K.E.R/Monsters/controller/controller_whoosh.wav")
AddSound("Stalker.Controller.Control.4",CHAN_WEAPON,1,0,98,102,"GSC/S.T.A.L.K.E.R/Monsters/controller/controller_final_hit.wav")

AddSoundInterval("Stalker.Controller.Glitches",1,11,CHAN_VOICE,0.15,0,98,102,"GSC/S.T.A.L.K.E.R/Monsters/controller/psy_effects/galutination_")



AddSoundInterval("Stalker.ZombiedPlayer.Idle",1,3,CHAN_VOICE,1,TEMP_VOICEDIST*0.92,98,102,"npc/fast_zombie/idle")

AddSoundInterval("Stalker.ZombiedPlayer.Die",1,3,CHAN_VOICE,1,TEMP_VOICEDIST*0.92,178,182,"npc/zombie/zombie_die")



sound.Add( {
	name = "Stalker.Burer.Footstep",
	channel = CHAN_BODY,
	volume = 1,
	level = 320,
	pitch = { 98, 102 },
	sound = {"GSC/S.T.A.L.K.E.R/Monsters/large_step1.wav",
	"GSC/S.T.A.L.K.E.R/Monsters/large_step2.wav" }
} )

sound.Add( {
	name = "Stalker.Controller.Footstep",
	channel = CHAN_BODY,
	volume = 1,
	level = 320,
	pitch = { 98, 102 },
	sound = {"npc/fast_zombie/foot1.wav",
	"npc/fast_zombie/foot2.wav",
	"npc/fast_zombie/foot3.wav",
	"npc/fast_zombie/foot4.wav"}
} )






AddSound("Stalker.Burer.Die1",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"GSC/S.T.A.L.K.E.R/Monsters/burer/burer_attacking_0.wav")

AddSound("Stalker.Burer.Idle1",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"GSC/S.T.A.L.K.E.R/Monsters/burer/burer_idle_0.wav")
AddSound("Stalker.Burer.Idle2",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"GSC/S.T.A.L.K.E.R/Monsters/burer/burer_idle_1.wav")
AddSound("Stalker.Burer.Idle3",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"GSC/S.T.A.L.K.E.R/Monsters/burer/burer_idle_2.wav")

AddSound("Stalker.Burer.Melee1",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"GSC/S.T.A.L.K.E.R/Monsters/burer/burer_attack_0.wav")

AddSound("Stalker.Burer.Push1",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"GSC/S.T.A.L.K.E.R/Monsters/burer/burer_gravi_attack_0.wav")
AddSound("Stalker.Burer.Tele1",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"GSC/S.T.A.L.K.E.R/Monsters/burer/burer_telekinetic_0.wav")

AddSound("Stalker.BurerWave.Collide",CHAN_WEAPON,1,400,98,102,"GSC/S.T.A.L.K.E.R/Monsters/burer/burer_gravi_wave_0.wav")




AddSound("Stalker.Claw.Hit",CHAN_WEAPON,1,300,98,102,"GSC/S.T.A.L.K.E.R/Monsters/slash_physics_hit1.wav")
AddSound("Stalker.Claw.Miss",CHAN_WEAPON,1,300,98,102,"GSC/S.T.A.L.K.E.R/Monsters/claw_miss.wav")
























//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////






local ControllerPlayerPsyEffectTime = 0
local LanguageChoosen = 0
local TEMP_CheckPosTime = 0
local CPRT = 0

if(CLIENT) then


	local function ControllerWeaponFuncNoDraw( self )
		if(LocalPlayer():GetNWFloat("PsyDamage",0)>0.1) then		
			return
		end
		
		self:DrawModel()
	end
	
	local function ControllerNpcFuncChangeDraw( self )
		if(IsValid(self:GetActiveWeapon())) then
			self:GetActiveWeapon().RenderOverride = ControllerWeaponFuncNoDraw
		end
		
		local TEMP_RealModel = self:GetModel()
		local TEMP_RealPos = self:GetPos()
		local TEMP_RealCyc = self:GetCycle()
		local TEMP_RealSeq = self:GetSequence()
			
		if(LocalPlayer():GetNWFloat("PsyDamage",0)>0.2) then		
			
			if(!isvector(self.TEMP_PrevPos)) then
				self.TEMP_PrevPos = TEMP_RealPos
			end
			
			local TEMP_SPD = self:GetSequenceGroundSpeed(TEMP_RealSeq)
			
			local TEMP_Seq = "S_Idle"
			
			if(TEMP_SPD>0) then
				TEMP_Seq = "S_Walk"
			end
			
			self.TEMP_PrevPos = self:GetPos()
			
			self:SetModel("models/GSC/S.T.A.L.K.E.R/Monsters/Controller.mdl")
			self:SetModelScale(1)
			
			self:SetSequence(self:LookupSequence(TEMP_Seq))
			
			local TEMP_RandVec = (VectorRand()*math.random(5,10))
			self:SetPos(self:GetPos()+TEMP_RandVec)
			self:SetupBones()
			self:DrawModel()
			
			self:SetPos(self:GetPos())
			self:SetupBones()
			self:DrawModel()
			
			self:SetModel(TEMP_RealModel)
			self:SetPos(TEMP_RealPos)
			self:SetSequence(TEMP_RealSeq)
			self:SetCycle(TEMP_RealCyc)
			self:SetupBones()
			
			return
		end
		
		self:DrawModel()
	end

	local TEMP_ControllerReDrawNext = 0

	hook.Add("Think","StalkerControllerEntsRender",function()
		if(TEMP_ControllerReDrawNext<CurTime()) then
			local ply = LocalPlayer()
			
			if(ply:GetNWFloat("PsyDamage",0)>0.1&&ply:Alive()) then 
				local TEMP_NPCS = ents.FindInSphere(ply:GetPos(),3000)
				
				if(#TEMP_NPCS>0) then
					for N=1, #TEMP_NPCS do
						if(IsValid(TEMP_NPCS[N])&&TEMP_NPCS[N]!=NULL&&
						TEMP_NPCS[N]:GetClass()!="npc_stalker_controller_100rads"&&(TEMP_NPCS[N]:IsNPC()&&
						TEMP_NPCS[N]:GetMoveType()==MOVETYPE_STEP)||
						(TEMP_NPCS[N]:IsPlayer()&&TEMP_NPCS[N]!=ply&&TEMP_NPCS[N]:Alive())) then
							if(!isfunction(TEMP_NPCS[N].RenderOverride)) then
								TEMP_NPCS[N].RenderOverride = ControllerNpcFuncChangeDraw
							end
						end
					end
				end
			end
			
			TEMP_ControllerReDrawNext = CurTime()+1
		end
	end)
end


hook.Add("Think","StalkerControllerPlayerPsyDamage",function()
	if(CLIENT) then
		if(IsValid(LocalPlayer())&&LocalPlayer()!=nil&&LocalPlayer()!=NULL) then
			if(LanguageChoosen==0) then
				if(system.GetCountry()=="RU"||system.GetCountry()=="BY"||system.GetCountry()=="UK") then
					language.Add("npc_stalker_burer_100rads", "Бюрер" )
					language.Add("npc_stalker_controller_100rads", "Контролёр" )
					language.Add("npc_stalker_player_zombie", "Зомбированный" )
					language.Add("ent_burer_wave", "Гравитационная волна" )
				else
					language.Add("npc_stalker_burer_100rads", "Burer" )
					language.Add("npc_stalker_controller_100rads", "Controller" )
					language.Add("npc_stalker_player_zombie", "Zombied" )
					language.Add("ent_burer_wave", "Gravitational wave" )
				end
				LanguageChoosen = 1
			end
		end
	end
		
	for P=1, #player.GetAll() do
		local ply = player.GetAll()[P]
		
		if(SERVER) then
			ply:SetNWFloat("PsyHealthTemp",math.max(ply:GetNWFloat("PsyHealthTemp",0)-0.0001,-100))
			
			if(ControllerPlayerPsyEffectTime<CurTime()) then
						
				local TEMP_CONTROLLERS = ents.FindByClass("npc_stalker_controller_100rads")
				
				if(GetConVar("ai_disabled"):GetInt()==0&&GetConVar("ai_ignoreplayers"):GetInt()==0&&#TEMP_CONTROLLERS>0) then
					local TEMP_NEARESTCONTROLLER = ply
					local TEMP_NEARESTCONTROLLERDISTANCE = 6000
					
					for C=1, #TEMP_CONTROLLERS do
						local ent = TEMP_CONTROLLERS[C]
						local TEMP_CONTROLLERDISTANCE = ply:GetPos():Distance(ent:GetPos())
						
						if(ent:Visible(ply)&&TEMP_CONTROLLERDISTANCE<TEMP_NEARESTCONTROLLERDISTANCE) then
							TEMP_NEARESTCONTROLLERDISTANCE = TEMP_CONTROLLERDISTANCE
							TEMP_NEARESTCONTROLLER = ent
							
							if(ply:GetNWFloat("PsyDamage",0)<0) then
								ply:SetNWFloat("PsyDamage",0)
							end
							
							ply:SetNWFloat("PsyDamage",
							math.Clamp(ply:GetNWFloat("PsyDamage",0)+((6000-TEMP_CONTROLLERDISTANCE)/300000),0,0.5))
						end
					end
					
					if(TEMP_NEARESTCONTROLLER!=ply) then
						if(ply:GetEyeTrace().Entity==TEMP_NEARESTCONTROLLER) then
							ply:ViewPunch(Angle(math.random(-1,1)*2,math.random(-1,1)*2,math.random(-1,1)*2))
						end
						
						if(ply.ControlPsyAuraPlayerSound&&!string.find(tostring(ply.ControlPsyAuraPlayerSound),
						"GSC/S.T.A.L.K.E.R/Monsters/controller/controller_presence_3.wav")) then
							ply.ControlPsyAuraPlayerSound:Stop()
							ply.ControlPsyAuraPlayerSound = nil
						end
						
						
						if(!timer.Exists("ControllerCameraShake"..tostring(ply))||ply.ControlPsyAuraPlayerSound==nil) then
							ply.ControlPsyAuraPlayerSound = TEMP_NEARESTCONTROLLER:ControllerPlaySoundToPlayer(ply,"Stalker.Controller.PsyAura3")
						end
						
					else
						ply:SetNWFloat("PsyDamage",math.max(ply:GetNWFloat("PsyDamage",0)-0.01,-100))
						
						if(ply.ControlPsyAuraPlayerSound) then
							ply.ControlPsyAuraPlayerSound:Stop()
							ply.ControlPsyAuraPlayerSound = nil
						end
								
					end
				else
					ply:SetNWFloat("PsyDamage",math.max(ply:GetNWFloat("PsyDamage",0)-0.01,-100))
					
					if(ply.ControlPsyAuraPlayerSound) then
						ply.ControlPsyAuraPlayerSound:Stop()
						ply.ControlPsyAuraPlayerSound = nil
					end
				end

				ControllerPlayerPsyEffectTime = CurTime()+0.2
			end
		end
				
		if(ply:GetNWFloat("PsyHealthTemp",0)>0||ply:GetNWFloat("PsyDamage",0)>0) then 

			if(SERVER) then
				if(!timer.Exists("ControllerCameraShake"..tostring(ply))) then
					local TEMP_CAMSHAKENUM = 0
					local TEMP_CAMSHAKESIDE = -1
					
					if(timer.Exists("ControllerCameraShake"..tostring(ply))) then
						timer.Remove("ControllerCameraShake"..tostring(ply))
					end
					
						
					timer.Create("ControllerCameraShake"..tostring(ply),0.04,0,function()
						if(ply:GetNWFloat("PsyDamage",0)>0) then
							if(IsValid(ply)&&ply!=NULL) then
								ply:ViewPunch(Angle(0,0,(TEMP_CAMSHAKENUM*ply:GetNWFloat("PsyDamage",0))/6))
								
								
								TEMP_CAMSHAKENUM = TEMP_CAMSHAKENUM+TEMP_CAMSHAKESIDE
								
								if(TEMP_CAMSHAKENUM==30||TEMP_CAMSHAKENUM==-30) then
									TEMP_CAMSHAKESIDE = TEMP_CAMSHAKESIDE*-1
								end
							end
						end
					end)
				end
						
				if(ply:GetNWFloat("PsyDamage",0)>0) then
					if(ply:GetNWFloat("PsyHealthTemp",0)<0) then
						ply:SetNWFloat("PsyHealthTemp",0)
					end
					
					ply:SetNWFloat("PsyHealthTemp",ply:GetNWFloat("PsyHealthTemp",0)+ply:GetNWFloat("PsyDamage",0))
				end
				
				if(ply:Alive()&&ply:GetNWFloat("PsyHealthTemp",0)>100) then
					if((game.MaxPlayers()==1&&ply:IsFlagSet(FL_GODMODE)==false)||
					(game.MaxPlayers()>1&&GetConVar("sbox_godmode"):GetInt()==0)) then
						if(ply:Health()>1) then
							ply:SetHealth(ply:Health()-1)
						else
							local TEMP_Conds = false
							
							if(player_manager.TranslateToPlayerModelName(ply:GetModel())&&
							ply:LookupSequence("idle_all_scared")&&
							ply:LookupSequence("run_all_02")&&
							ply:LookupSequence("run_all_02")&&
							ply:LookupSequence("death_04")&&
							ply:LookupSequence("zombie_attack_01_original")&&
							ply:LookupSequence("zombie_attack_02_original")&&
							ply:LookupSequence("zombie_attack_03_original")&&
							ply:LookupSequence("zombie_attack_04_original")&&
							ply:LookupSequence("zombie_attack_05_original")&&
							ply:LookupSequence("zombie_attack_06_original")&&
							ply:LookupBone("ValveBiped.Bip01_Neck1")&&
							ply:LookupBone("ValveBiped.Bip01_Head1")) then
								local TEMP_Tracer = util.TraceHull( {
									start = ply:GetPos(),
									endpos = ply:GetPos()+Vector(0,0,5),
									filter = function( ent ) 
										if(!ent:IsWeapon()&&ent!=ply&&ent:GetParent()!=ply ) then 
											return true 
										end 
									end,
									mins = Vector(-16,-16,0),
									maxs = Vector(16,16,70),
									mask = MASK_NPCSOLID
								} )
								
								if(!TEMP_Tracer.Hit) then
									TEMP_Conds = true
								end
							end
							
							
							if(TEMP_Conds==true) then
								local TEMP_Zomb = ents.Create("npc_stalker_player_zombie")
								TEMP_Zomb.Model = ply:GetModel()
								TEMP_Zomb:SetModel(ply:GetModel())
								TEMP_Zomb:SetAngles(ply:GetAngles())
								TEMP_Zomb:SetPos(ply:GetPos()+Vector(0,0,5))
								TEMP_Zomb:Spawn()
								
								TEMP_Zomb.RagdollModel = ply:GetModel()
								TEMP_Zomb:SetModel(ply:GetModel())
								TEMP_Zomb:SetNW2Entity("ZombieOwner",ply)
								
								ply:KillSilent()
								
								ply:SetObserverMode(OBS_MODE_CHASE)
								ply:SpectateEntity(TEMP_Zomb)
							else
								local TEMP_TargetDamage = DamageInfo()
								
								TEMP_TargetDamage:SetDamage(15)
								TEMP_TargetDamage:SetInflictor(ply)
								TEMP_TargetDamage:SetDamageType(DMG_SONIC)
								TEMP_TargetDamage:SetAttacker(ply)
								TEMP_TargetDamage:SetDamagePosition(ply:GetPos()+ply:OBBCenter())
								TEMP_TargetDamage:SetDamageForce(Vector(0,0,0))
								ply:TakeDamageInfo(TEMP_TargetDamage)
							end
						end
					end
					
					
					ply:SetNWFloat("PsyHealthTemp",ply:GetNWFloat("PsyHealthTemp",0)-100,0)
				end
			else
				util.ScreenShake( LocalPlayer():GetPos(), ply:GetNWFloat("PsyDamage",0)*2, 
				ply:GetNWFloat("PsyDamage",0)*2, 0.2, 5 )
			end
		end
	end
end)

if(CLIENT) then
	local TEMP_NEXTSCARYSOUNDTIME = 0
	local PsyVoicesPlaying = false
	
	hook.Add( "PreDrawHUD", "ControllerPsyEffect_Client", function()
		if(IsValid(LocalPlayer())&&LocalPlayer():Alive()) then
			local TEMP_PSYDMG = LocalPlayer():GetNWFloat("PsyDamage",0)
			
			if(TEMP_PSYDMG>0.2) then
				if(PsyVoicesPlaying==false) then
					LocalPlayer():EmitSound("Stalker.Controller.Voices")
					PsyVoicesPlaying = true
				end
				
				if(TEMP_NEXTSCARYSOUNDTIME<CurTime()) then
					local TEMP_SCARYSOUND = "Stalker.Controller.Glitches"..math.random(1,11)
					
					TEMP_NEXTSCARYSOUNDTIME = CurTime()+math.random(2,8)+SoundDuration(TEMP_SCARYSOUND)
					
					LocalPlayer():EmitSound(TEMP_SCARYSOUND)
				end
			else
				if(PsyVoicesPlaying==true) then
					LocalPlayer():StopSound("Stalker.Controller.Voices")
					PsyVoicesPlaying = false
				end
			end
				
			if(TEMP_PSYDMG>0) then
				local tab = {
					[ "$pp_colour_addr" ] = 0.01*(TEMP_PSYDMG*2),
					[ "$pp_colour_addg" ] = 0.02*(TEMP_PSYDMG*2),
					[ "$pp_colour_addb" ] = 0.3*(TEMP_PSYDMG*2),
					[ "$pp_colour_brightness" ] = -0.43*(TEMP_PSYDMG*2),
					[ "$pp_colour_contrast" ] = 1-(0.22*(TEMP_PSYDMG*2)),
					[ "$pp_colour_colour" ] = 1-(0.7*(TEMP_PSYDMG*2)),
				}

				DrawColorModify( tab )
				
				
				
				
				
				DrawMotionBlur( 0.3, 0.9*(TEMP_PSYDMG*2), 0.001 )
				
				
				
				
				
				local TEMP_BLUR = Material("pp/blurscreen")
			
				cam.Start2D()
					local x, y = 0, 0
					local scrW, scrH = ScrW(), ScrH()
					surface.SetDrawColor(255, 255, 255)
					surface.SetMaterial( TEMP_BLUR )
					
					for i = 1, 3 do
						TEMP_BLUR:SetFloat("$blur", (LocalPlayer():GetNWFloat("PsyDamage",0)*3)*i)
						TEMP_BLUR:Recompute()
						render.UpdateScreenEffectTexture()
						surface.DrawTexturedRect(x * -1, y * -1, scrW, scrH)
					end
				cam.End2D()
			end
		end
	end )
	
	
	hook.Add("PostDrawOpaqueRenderables","StalkerControllerGlitches",function(isDrawingDepth, isDrawSkybox )
		if(LocalPlayer():Alive()&&LocalPlayer():GetNWFloat("PsyDamage",0)>0.2) then
			
		end
	end)
end

if(CLIENT) then
	net.Receive("STALKERNPCControllerStopPsySound", function()
		if(PsyVoicesPlaying==true) then
			LocalPlayer():StopSound("Stalker.Controller.Voices")
			PsyVoicesPlaying = false
		end
	end)
end



if(SERVER) then

	hook.Add("EntityTakeDamage" , "Burer Bolt Damage" , function( ent , dmginfo )
		if(IsValid(dmginfo:GetInflictor())&&
		IsValid(dmginfo:GetInflictor():GetOwner())&&dmginfo:GetInflictor():GetOwner():GetClass()=="npc_stalker_burer_100rads") then
			if(dmginfo:GetInflictor():GetClass()=="crossbow_bolt") then
				if(isnumber(dmginfo:GetInflictor().BurerBoltDamage)) then
					dmginfo:SetAttacker(dmginfo:GetInflictor():GetOwner())
					dmginfo:SetDamage( dmginfo:GetInflictor().BurerBoltDamage )
				end
			end
		end
	end)
	
	hook.Add("ScaleNPCDamage","StalkerNPCHitboxDamage", function( npc, hitgr, dmg )
		if(npc.SNPCClass=="C_MONSTER_LAB"||npc.SNPCClass=="C_MONSTER_CONTROLLER") then
			npc.LastDamageHitgroup = hitgr
		end
	end)
end


function STALKERNPCClearPsyEffect(ply)
	if(timer.Exists("ControllerCameraShake"..tostring(ply))) then
		timer.Remove("ControllerCameraShake"..tostring(ply))
	end
	
	if(ply.ControlPsyAuraPlayerSound) then
		ply.ControlPsyAuraPlayerSound:Stop()
		ply.ControlPsyAuraPlayerSound = nil
	end
	
	ply:SetNWFloat("PsyDamage",0)
	ply:SetNWFloat("PsyHealthTemp",0)
	
	net.Start("STALKERNPCControllerStopPsySound")
	net.Send(ply)
end


hook.Add("PlayerDeath","StalkerControllerPlayerDeath",function(ply)
	STALKERNPCClearPsyEffect(ply)
end)


hook.Add("PlayerSpawn","StalkerControllerPlayerPsyHealthRestore",function(ply)
	STALKERNPCClearPsyEffect(ply)
end)
