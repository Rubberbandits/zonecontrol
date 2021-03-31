AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')
include("stalkernpcbasevars.lua")


ENT.PainSoundEnabled = true
ENT.PainSound.name = "Stalker.Controller.Pain"
ENT.PainSound.min = 1
ENT.PainSound.max = 6

ENT.DieSoundEnabled = true
ENT.DieSound.name = "Stalker.Controller.Die"
ENT.DieSound.min = 1
ENT.DieSound.max = 2


ENT.CanSpecial = true

ENT.SNPCClass="C_MONSTER_CONTROLLER"

ENT.Victims = {}
ENT.MaxVictims = 10

function ENT:Initialize()
	
	self.Model = "models/GSC/S.T.A.L.K.E.R/Monsters/Controller.mdl"
	self:STALKERNPCInit(Vector(-16,-16,70),MOVETYPE_STEP)
	
	self:SetBloodColor(BLOOD_COLOR_RED)
	
	self:DropToFloor()
	
	local TEMP_MeleeHitTable = { "Stalker.Claw.Hit" }
	
	local TEMP_MeleeMissTable = { "Stalker.Claw.Miss" }
						
	local TEMP_MeleeTable = self:STALKERNPCCreateMeleeTable()
	
	TEMP_MeleeTable.damage[1] = 19
	TEMP_MeleeTable.damagetype[1] = bit.bor(DMG_SLASH, DMG_CLUB)
	TEMP_MeleeTable.distance[1] = 21
	TEMP_MeleeTable.radius[1] = 40
	TEMP_MeleeTable.time[1] = 0.8
	TEMP_MeleeTable.bone[1] = "bip01_r_hand"
	self:STALKERNPCSetMeleeParams(1,"S_Melee1",1, TEMP_MeleeTable,TEMP_MeleeHitTable,TEMP_MeleeMissTable)
	
	TEMP_MeleeTable.damage[1] = 19
	TEMP_MeleeTable.damagetype[1] = bit.bor(DMG_SLASH, DMG_CLUB)
	TEMP_MeleeTable.distance[1] = 21
	TEMP_MeleeTable.radius[1] = 60
	TEMP_MeleeTable.time[1] = 0.8
	TEMP_MeleeTable.bone[1] = "bip01_r_hand"
	TEMP_MeleeTable.damage[2] = 19
	TEMP_MeleeTable.damagetype[2] = bit.bor(DMG_SLASH, DMG_CLUB)
	TEMP_MeleeTable.distance[2] = 21
	TEMP_MeleeTable.radius[2] = 60
	TEMP_MeleeTable.time[2] = 1.2
	TEMP_MeleeTable.bone[2] = "bip01_l_hand"
	self:STALKERNPCSetMeleeParams(2,"S_Melee2",2, TEMP_MeleeTable,TEMP_MeleeHitTable,TEMP_MeleeMissTable)

	
	self:SetHealth(GetConVar("stalker_npc_controller_health"):GetInt())
	self.MaxVictims = GetConVar("stalker_npc_controller_max_victims"):GetInt()
	
	self:SetMaxHealth(self:Health())
	
	
	self.Victims = {}
end

function ENT:STALKERNPCThinkEnemyValid()
	
end

function ENT:STALKERNPCThink()
	
end

function ENT:ControllerPlaySoundToPlayer(ent,SND)
	local TEMP_SOUND = nil
	
	if(IsValid(ent)&&ent!=nil&&ent!=NULL&&ent:IsPlayer()&&ent:Alive()&&self:Visible(ent)) then
		local TEMP_FILTER = RecipientFilter()
		
		TEMP_FILTER:AddPlayer(ent)
		
		TEMP_SOUND = CreateSound( game.GetWorld(), SND, TEMP_FILTER )
		
		if(TEMP_SOUND) then
			TEMP_SOUND:SetSoundLevel( 0 )
			TEMP_SOUND:Play()
		end
	end
	
	return TEMP_SOUND
end


function ENT:ControllerNPCSetHateTableState(NPC,ENT2)
	if(NPC!=NULL&&ENT2!=NULL&&IsValid(NPC)&&IsValid(ENT2)) then
		local TEMP_Len1 = 0
		local TEMP_Len2 = 0
		
		if(!istable(NPC.RealRelationshipBeforeControllerEnt)||NPC.RealRelationshipBeforeControllerEnt==nil) then
			NPC.RealRelationshipBeforeControllerEnt = {}
		else
			TEMP_Len1 = #NPC.RealRelationshipBeforeControllerEnt+1
		end
		
		if(!istable(NPC.RealRelationshipBeforeControllerDisp)||NPC.RealRelationshipBeforeControllerDisp==nil) then
			NPC.RealRelationshipBeforeControllerDisp = {}
		else
			TEMP_Len2 = #NPC.RealRelationshipBeforeControllerDisp+1
		end
		
		
		if(istable(NPC.RealRelationshipBeforeControllerEnt)&&istable(NPC.RealRelationshipBeforeControllerDisp)) then
			if(!table.HasValue(NPC.RealRelationshipBeforeControllerEnt,ENT2)) then
				table.insert(NPC.RealRelationshipBeforeControllerEnt,TEMP_Len1,ENT2)
				table.insert(NPC.RealRelationshipBeforeControllerDisp,TEMP_Len2,NPC:Disposition(ENT2))
		
				NPC:AddEntityRelationship(ENT2,D_HT,99)
			end
		end
	end
end


function ENT:STALKERNPCCheckingNPCOnEnemyFind(NPC,DISP)
	if(IsValid(NPC)&&NPC!=NULL) then
		if(DISP==D_HT) then
			if(NPC:IsNPC()) then
				if(NPC.ControlledByController!=true) then
					if(self:Visible(NPC)) then
						if(!isnumber(NPC.PsyInfected)) then
							NPC.PsyInfected = CurTime()
						end
						
						NPC.PsyInfected = math.Clamp(NPC.PsyInfected+4,CurTime(),CurTime()+100)
						local TEMP_MSize = 20
						
						if(NPC:GetModel()&&isstring(NPC:GetModel())&&string.Replace(NPC:GetModel()," ","")!="") then
							local TEMP_MMins, TEMP_MMaxs = NPC:GetModelBounds()
							local TEMP_MSize = (TEMP_MMins:Distance(TEMP_MMaxs)*NPC:GetModelScale())/5
						end
						
						if(NPC.PsyInfected-CurTime()>TEMP_MSize) then
							if(#self.Victims<self.MaxVictims) then
								table.insert(self.Victims,#self.Victims+1,NPC)
								
								NPC.ControlledByController = true
								NPC:SetSaveValue("wakesquad",false)
								NPC:SetSaveValue("m_iMySquadSlot",10+self:GetCreationID())
								NPC:SetSaveValue("squadname","nosquad"..self:GetCreationID())
								
								NPC:AddEntityRelationship(self,D_LI,99)
								self:AddEntityRelationship(NPC,D_LI,99)
								
								NPC:SetEnemy(nil)
								self:SetEnemy(nil)
							else
								local TEMP_VNum = #self.Victims
								local TEMP_V = 1
								
								for V=1, TEMP_VNum do
									if(!IsValid(self.Victims[TEMP_V])||self.Victims[TEMP_V]==NULL) then
										table.remove(self.Victims,TEMP_V)
									else
										TEMP_V = TEMP_V+1
									end
								end
							end
						end
					end
				else
					if(NPC:GetEnemy()==self) then
						NPC:SetEnemy(nil)
					end
				end
			end
		elseif(DISP==D_LI) then
			
			if(NPC:GetEnemy()==self) then
				NPC:SetEnemy(nil)
			end
			
			if(IsValid(self:GetEnemy())&&self:GetEnemy()!=NULL) then
				if(!NPC:GetEnemy()||!IsValid(NPC:GetEnemy())||NPC:GetEnemy()==NULL) then
					if(NPC.ControlledByController==true) then
						self:ControllerNPCSetHateTableState(NPC,self:GetEnemy())
					end
					
					NPC:AddEntityRelationship(self:GetEnemy(),D_HT,1)
					if(self:GetEnemy():IsNPC()) then
						self:GetEnemy():AddEntityRelationship(NPC,D_HT,1)
					end
					NPC:SetEnemy(self:GetEnemy())
					NPC:UpdateEnemyMemory(self:GetEnemy(),self:GetEnemy():GetPos())
				end
			end
			
			if(NPC.ControlledByController==true) then
				if(#self.Victims>0) then
					for V=1, #self.Victims do
						if(NPC!=self.Victims[V]) then
							self:ControllerNPCSetHateTableState(self.Victims[V],NPC)
						end
					end
				end
			end
		end
	end
end
							




function ENT:STALKERNPCDistanceForMeleeTooBig() 
	if(self.CanSpecial==true) then
		self:STALKERNPCPlayAnimation("S_Special1",1)
		
		self:STALKERNPCPlaySoundRandom(100,"Stalker.Controller.SpecialAttack",1,1)
		
		self:ControllerPlaySoundToPlayer(self:GetEnemy(),"Stalker.Controller.Control.1")
		
		
		timer.Create("Attack"..tostring(self).."1",1.7,1,function()
			if(IsValid(self)&&self!=nil&&self!=NULL) then
				self:STALKERNPCPlayAnimation("S_Special2",1,false)	
				self:ControllerPlaySoundToPlayer(self:GetEnemy(),"Stalker.Controller.Control.2")
				self:ControllerPlaySoundToPlayer(self:GetEnemy(),"Stalker.Controller.Control.3")
			end
		end)
		
		timer.Create("Attack"..tostring(self).."2",2.1,1,function()
			if(IsValid(self)&&self!=nil&&self!=NULL) then
				self:STALKERNPCPlayAnimation("S_Special3",1,false)	
			end
		end)
		
		timer.Create("Attack"..tostring(self).."3",2.5,1,function()
			if(IsValid(self)&&self!=nil&&self!=NULL) then
				self:STALKERNPCPlayAnimation("S_Special4",1,false)	
				self:ControllerPlaySoundToPlayer(self:GetEnemy(),"Stalker.Controller.Control.4")
				
				
				
				if(IsValid(self:GetEnemy())&&self:GetEnemy()!=nil&&self:GetEnemy()!=NULL&&self:GetEnemy():Visible(self)) then
					local TEMP_POORGUY = self:GetEnemy()
					
					if(TEMP_POORGUY:IsPlayer()&&TEMP_POORGUY:Alive()) then
						TEMP_POORGUY:ViewPunch(Angle(math.random(-40,-30),math.random(-23,23),0))

						
						if(IsValid(TEMP_POORGUY:GetActiveWeapon())&&TEMP_POORGUY:GetActiveWeapon()!=NULL) then
							if(TEMP_POORGUY:GetNWFloat("PsyDamage",0)>0.3) then
								TEMP_POORGUY:DropWeapon(TEMP_POORGUY:GetActiveWeapon())
							end
						end
					elseif(TEMP_POORGUY:IsNPC()) then
						if(!isnumber(TEMP_POORGUY.PsyInfected)) then
							TEMP_POORGUY.PsyInfected = CurTime()
						end
						
						TEMP_POORGUY.PsyInfected = math.Clamp(TEMP_POORGUY.PsyInfected+5,CurTime(),CurTime()+100)
					end
					
					//if(TEMP_POORGUY:IsNPC()||(TEMP_POORGUY:IsPlayer()&&TEMP_POORGUY:Health()>15)) then
					
					local TEMP_Conds = false
					
					
					if(TEMP_POORGUY:IsPlayer()&&TEMP_POORGUY:Alive()&&TEMP_POORGUY:Health()<=15) then
						if(TEMP_POORGUY:IsPlayer()&&TEMP_POORGUY:Health()<=15) then
							if(player_manager.TranslateToPlayerModelName(TEMP_POORGUY:GetModel())&&
							TEMP_POORGUY:LookupSequence("idle_all_scared")&&
							TEMP_POORGUY:LookupSequence("run_all_02")&&
							TEMP_POORGUY:LookupSequence("run_all_02")&&
							TEMP_POORGUY:LookupSequence("death_04")&&
							TEMP_POORGUY:LookupSequence("zombie_attack_01_original")&&
							TEMP_POORGUY:LookupSequence("zombie_attack_02_original")&&
							TEMP_POORGUY:LookupSequence("zombie_attack_03_original")&&
							TEMP_POORGUY:LookupSequence("zombie_attack_04_original")&&
							TEMP_POORGUY:LookupSequence("zombie_attack_05_original")&&
							TEMP_POORGUY:LookupSequence("zombie_attack_06_original")&&
							TEMP_POORGUY:LookupBone("ValveBiped.Bip01_Neck1")&&
							TEMP_POORGUY:LookupBone("ValveBiped.Bip01_Head1")) then
							
								local TEMP_Tracer = util.TraceHull( {
									start = TEMP_POORGUY:GetPos(),
									endpos = TEMP_POORGUY:GetPos()+Vector(0,0,5),
									filter = function( ent ) 
										if(!ent:IsWeapon()&&ent!=TEMP_POORGUY&&ent:GetParent()!=TEMP_POORGUY ) then 
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
						end
					end
					
					if(TEMP_Conds==true) then
						local TEMP_Zomb = ents.Create("npc_stalker_player_zombie")
						TEMP_Zomb.Model = TEMP_POORGUY:GetModel()
						TEMP_Zomb:SetModel(TEMP_POORGUY:GetModel())
						TEMP_Zomb:SetAngles(TEMP_POORGUY:GetAngles())
						TEMP_Zomb:SetPos(TEMP_POORGUY:GetPos()+Vector(0,0,5))
						TEMP_Zomb:Spawn()
						
						TEMP_Zomb.RagdollModel = TEMP_POORGUY:GetModel()
						TEMP_Zomb:SetModel(TEMP_POORGUY:GetModel())
						TEMP_Zomb:SetNW2Entity("ZombieOwner",TEMP_POORGUY)
						
						TEMP_POORGUY:KillSilent()
						
						TEMP_POORGUY:SetObserverMode(OBS_MODE_CHASE)
						TEMP_POORGUY:SpectateEntity(TEMP_Zomb)
					else
						local TEMP_TargetDamage = DamageInfo()
									
						TEMP_TargetDamage:SetDamage(50)
						TEMP_TargetDamage:SetInflictor(self)
						TEMP_TargetDamage:SetDamageType(DMG_PARALYZE)
						TEMP_TargetDamage:SetAttacker(self)
						TEMP_TargetDamage:SetDamagePosition(TEMP_POORGUY:NearestPoint(self:GetPos()+self:OBBCenter()))
						TEMP_TargetDamage:SetDamageForce(self:GetForward()*1000)
						TEMP_POORGUY:TakeDamageInfo(TEMP_TargetDamage)
					end
					
					
					if(TEMP_POORGUY:IsPlayer()) then
						TEMP_POORGUY:SetNWFloat("PsyDamage",math.Clamp(TEMP_POORGUY:GetNWFloat("PsyDamage",0)+0.1,0,0.5))
						TEMP_POORGUY:ConCommand( "-speed" )
					end
					
				end
			end
		end)
		
		
		timer.Create("EndAttack"..tostring(self),4.0,1,function()
			if(IsValid(self)&&self!=nil&&self!=NULL) then
				self:STALKERNPCClearAnimation()
			end
		end)
		
		
		timer.Create("AllowSomething"..tostring(self),7,1,function()
			if(IsValid(self)&&self!=nil&&self!=NULL) then
				self.CanSpecial = true
			end
		end)
					
		self.CanSpecial = false
	end
end

function ENT:STALKERNPCRemove()
	for V=0, #self.Victims+1 do
		if(IsValid(self.Victims[V])&&self.Victims[V]!=NULL) then
			if(istable(self.Victims[V].RealRelationshipBeforeControllerEnt)&&#self.Victims[V].RealRelationshipBeforeControllerEnt>0) then
				for N=0, #self.Victims[V].RealRelationshipBeforeControllerEnt+1 do
					if(isnumber(self.Victims[V].RealRelationshipBeforeControllerDisp[N])&&IsValid(self.Victims[V].RealRelationshipBeforeControllerEnt[N])) then
						self.Victims[V]:AddEntityRelationship(self.Victims[V].RealRelationshipBeforeControllerEnt[N],self.Victims[V].RealRelationshipBeforeControllerDisp[N],1)
						self.Victims[V]:SetEnemy(nil)
					end
				end
				
				self.Victims[V].ControlledByController = false
				self.Victims[V].RealRelationshipBeforeControllerEnt = nil
				self.Victims[V].RealRelationshipBeforeControllerDisp = nil
			end
		end
	end
	
	timer.Remove("AllowSomething"..tostring(self))
end