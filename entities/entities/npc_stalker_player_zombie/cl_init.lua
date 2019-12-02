include('shared.lua')

ENT.RealModel = "models/Monsters/GMOD_Edited/ZombiePlayer.mdl"
ENT.PlayerModel = "models/Monsters/GMOD_Edited/ZombiePlayer.mdl"
ENT.CSModel = nil
ENT.PrevPos = Vector(0,0,0)
ENT.NextPosMem = 0
ENT.NeckBone = -1
ENT.HeadBone = -1
ENT.PrevCycle = 0


function ENT:Initialize()
	self.PlayerModel = self:GetModel()
	self.CSModel = ClientsideModel( self:GetModel(), RENDERGROUP_OTHER )
	self.CSModel.PlayerOwner = self:GetNW2Entity("ZombieOwner")
	self.CSModel:DrawShadow(true)

	self.Anims = {}
	self.Anims[0] = self:LookupSequence("idle_all_scared")
	self.Anims[1] = self:LookupSequence("run_all_02")
	self.Anims[2] = self:LookupSequence("run_all_02")
	self.Anims[3] = self:LookupSequence("death_04")
	self.Anims[4] = self:LookupSequence("zombie_attack_01_original")
	self.Anims[5] = self:LookupSequence("zombie_attack_02_original")
	self.Anims[6] = self:LookupSequence("zombie_attack_03_original")
	self.Anims[7] = self:LookupSequence("zombie_attack_04_original")
	self.Anims[8] = self:LookupSequence("zombie_attack_05_original")
	self.Anims[9] = self:LookupSequence("zombie_attack_06_original")
	self.PrevPos = self:GetPos()
	
	
	self.NeckBone = self:LookupBone("ValveBiped.Bip01_Neck1")
	self.HeadBone = self:LookupBone("ValveBiped.Bip01_Head1")
	
	self.PrevCycle = 0
end

function ENT:Think()
end

function ENT:Draw()
	self.CSModel:SetNoDraw(self:GetNoDraw())
	
	
	
	local TEMP_SelfAnim = self:GetSequence()
	local TEMP_Cyc = self:GetCycle()
	local TEMP_MoveX = 1
	local TEMP_MoveY = 0
	local TEMP_NewSEQ = self.Anims[TEMP_SelfAnim]
	local TEMP_NewCyc = TEMP_Cyc
	
	local TEMP_HeadAng = Angle(0,0,0)
	local TEMP_HeadPos = Vector(0,0,0)
	local TEMP_NeckAng = Angle(0,0,0)
	local TEMP_NeckPos = Vector(0,0,0)
	local TEMP_LegR1Ang = Angle(5,0,0)
	local TEMP_LegL1Ang = Angle(5,0,0)
		
	local TEMP_ZPos = 0
	local TEMP_YAng = 0
	
	
	local TEMP_PosDiff = Vector((self:GetPos()-self.PrevPos).x,(self:GetPos()-self.PrevPos).y,0)
	
	if(TEMP_PosDiff:Length()>0) then
		TEMP_PosDiff:Rotate(Angle(0,-self:GetAngles().Yaw,0))
		
		TEMP_MoveX = math.Clamp(TEMP_PosDiff.x*4, -1, 1)
		TEMP_MoveY = math.Clamp(TEMP_PosDiff.y*4, -1, 1)*-1
		
		if(self.NextPosMem<CurTime()) then
			self.PrevPos = self:GetPos()
			
			self.NextPosMem = CurTime()+0.1
		end
	end
	
	if(TEMP_SelfAnim==0) then
		TEMP_MoveX = 0
		TEMP_MoveY = 0
	elseif(TEMP_SelfAnim>3) then
		TEMP_HeadAng = Angle(0,-180,0)
		//TEMP_HeadPos = Vector(5,0,0)
		TEMP_NeckAng = Angle(0,-30,0)
		TEMP_NeckPos = Vector(-1,0,0)
	end

	TEMP_HeadAng = TEMP_HeadAng+Angle(math.random(-35,35),math.random(-35,35),math.random(-35,35))
	
	if(self.PrevCycle==TEMP_Cyc) then
		TEMP_NewCyc = TEMP_NewCyc+0.01
	end
	
	self.CSModel:SetPoseParameter("move_x",TEMP_MoveX)
	self.CSModel:SetPoseParameter("move_y",TEMP_MoveY)
	self.CSModel:SetPos(self:GetPos()-Vector(0,0,TEMP_ZPos))
	self.CSModel:SetAngles(self:GetAngles()+Angle(0,TEMP_YAng,0))
	self.CSModel:ManipulateBoneAngles(self.HeadBone,TEMP_HeadAng)
	self.CSModel:ManipulateBonePosition(self.HeadBone,TEMP_HeadPos)
	self.CSModel:ManipulateBoneAngles(self.NeckBone,TEMP_NeckAng)
	self.CSModel:ManipulateBonePosition(self.NeckBone,TEMP_NeckPos)
	self.CSModel:SetSequence(TEMP_NewSEQ)
	self.CSModel:SetCycle(TEMP_NewCyc)
	self.CSModel:SetupBones()
	self.CSModel:DrawModel()
	
	self.CSModel:SetNoDraw(true)
	
	self.PrevCycle = TEMP_Cyc
end

function ENT:OnRemove()
	self.CSModel:Remove()
end