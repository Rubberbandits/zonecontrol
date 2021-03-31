AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')
include("stalkernpcbasevars.lua")


ENT.SNPCClass="C_ZOMBIE"

ENT.IdlingSoundEnabled = true
ENT.IdlingSound.name = "Stalker.ZombiedPlayer.Idle"
ENT.IdlingSound.min = 1
ENT.IdlingSound.max = 3

ENT.ChasingSoundEnabled = true
ENT.ChasingSound.name = "Stalker.ZombiedPlayer.Idle"
ENT.ChasingSound.min = 1
ENT.ChasingSound.max = 3

ENT.DieSoundEnabled = true
ENT.DieSound.name = "Stalker.ZombiedPlayer.Die"
ENT.DieSound.min = 1
ENT.DieSound.max = 3

function ENT:NoRagdollCode()
	local TEMP_Seq = "death_0"..math.random( 1, 4 )
	
	if(TEMP_Seq) then
		local TEMP_Anim = ents.Create( 'base_gmodentity' )
		TEMP_Anim:SetModel( self:GetModel() )
		TEMP_Anim:SetPos( self:GetPos() )
		TEMP_Anim:SetAngles( self:GetAngles() )
		TEMP_Anim:Spawn()

		TEMP_Anim:SetSequence( TEMP_Anim:LookupSequence( TEMP_Seq ) )
		TEMP_Anim:SetPlaybackRate( 1 )
		TEMP_Anim.AutomaticFrameAdvance = true
		
		
		function TEMP_Anim:Think()
			self:NextThink( CurTime() )
			return true
		end
		
		local TEMP_Dissolver = ents.Create( "env_entity_dissolver" )
		TEMP_Dissolver:SetPos( TEMP_Anim:GetPos() )
		TEMP_Dissolver:SetKeyValue( "dissolvetype", 3 )
		TEMP_Dissolver:Spawn()
		TEMP_Dissolver:Activate()
		
		local TEMP_Name = "Dissolving_Tyrant_Victim_Ragdoll"..tostring(TEMP_Anim)
		TEMP_Anim:SetName( TEMP_Name )
		TEMP_Dissolver:Fire( "Dissolve", TEMP_Name, 1.4 )
		TEMP_Dissolver:Fire( "Kill", "", 1.5 )
	else
		self:Remove()
	end
end

function ENT:Initialize()
	self.Model = player.GetAll()[1]:GetModel() //"models/Monsters/GMOD_Edited/ZombiePlayer.mdl"
	self:STALKERNPCInit(Vector(16,16,80),MOVETYPE_STEP)
	
	self:ResetSequence(self:LookupSequence("zombie_run"))
	self:SetNPCState(NPC_STATE_SCRIPT)
	
	self.MinRangeDist = 800
	self.MaxRangeDist = 1500
	self:SetBloodColor(BLOOD_COLOR_RED)
	
	self:DropToFloor()
	
	local TEMP_MeleeHitTable = { "Stalker.Claw.Hit" }
	
	local TEMP_MeleeMissTable = { "Stalker.Claw.Miss" }
						
	local TEMP_MeleeTable = self:STALKERNPCCreateMeleeTable()

	TEMP_MeleeTable.damage[1] = 19
	TEMP_MeleeTable.damagetype[1] = bit.bor(DMG_CLUB)
	TEMP_MeleeTable.distance[1] = 21
	TEMP_MeleeTable.radius[1] = 60
	TEMP_MeleeTable.time[1] = 0.9
	TEMP_MeleeTable.bone[1] = "ValveBiped.Bip01_R_Hand"
	self:STALKERNPCSetMeleeParams(1,"Attack2",1, TEMP_MeleeTable,TEMP_MeleeHitTable,TEMP_MeleeMissTable)

	self:SetHealth(200)
	self:SetMaxHealth(self:Health())
	
	self.RealMDL = "models/Monsters/GMOD_Edited/ZombiePlayer.mdl"
	self.RagdollModel = self:GetModel()
	
	timer.Simple(0.2,function()
		if(IsValid(self)) then
			self.Model = self.RealMDL
			self:SetModel(self.RealMDL)
			self:ResetSequence(self:LookupSequence("Idle"))
			self:SetNPCState(NPC_STATE_IDLE)
			self:STALKERNPCInit(Vector(16,16,80),MOVETYPE_STEP)
			
			self:SetModelName(self.RagdollModel)
		end
	end)
	
	self.ServersideRagdollOnly = true
	self.FakeDeathOnly = true
	
	self:DrawShadow(false)
end



function ENT:STALKERNPC_EnemySpotted(ent,myteam)
	if(!istable(myteam)) then
		local TEMP_Zombies = ents.FindInSphere(self:GetPos(), 1000)
		
		
		if (#TEMP_Zombies>0) then 
			for B=1, #TEMP_Zombies do
				local TEMP_NPC = TEMP_Zombies[B]
				
				if(IsValid(TEMP_NPC)&&TEMP_NPC!=nil&&TEMP_NPC!=NULL&&TEMP_NPC!=self&&
				TEMP_NPC:GetClass()==self:GetClass()&&(!IsValid(TEMP_NPC:GetEnemy())||TEMP_NPC:GetEnemy()==NULL)) then
					TEMP_NPC:AddEntityRelationship( ent, D_HT, 1 )
					TEMP_NPC:SetEnemy(ent)
					TEMP_NPC:UpdateEnemyMemory(ent,ent:GetPos())
				end
			end
		end
	else
		if(#myteam>0) then
			for E=1, #myteam do
				if((!IsValid(myteam[E]:GetEnemy())||myteam[E]:GetEnemy()==NULL)&&myteam[E]:GetPos():Distance(self:GetPos())<1000) then
					myteam[E]:AddEntityRelationship( ent, D_HT, 1 )
					myteam[E]:SetEnemy(ent)
					myteam[E]:UpdateEnemyMemory(ent,ent:GetPos())
				end
			end
		end
	end
end
