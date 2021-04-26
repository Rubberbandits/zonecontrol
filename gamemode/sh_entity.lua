local meta = FindMetaTable( "Entity" );

function game.GetDoors()
	
	local tab = { };
	
	for _, v in pairs( ents.GetAll() ) do
		
		if( v:IsDoor() ) then
			
			table.insert( tab, v );
			
		end
		
	end
	
	return tab;
	
end

hook.Add("Initialize", "STALKER.AddNewFlare", function()
	local ENT = scripted_ents.Get("tfa_mats_flare")
	if SERVER then
		function ENT:Initialize()
			self:SetModel("models/weapons/tfa_FlareGun_Shell.mdl")
			self:SetRenderMode(RENDERMODE_TRANSALPHA)
			self:SetMoveType(MOVETYPE_VPHYSICS)
			self:SetSolid(SOLID_VPHYSICS)
			self:PhysicsInit(SOLID_VPHYSICS)
			self:DrawShadow(true)
			self:SetCollisionGroup(COLLISION_GROUP_NONE)
			self.LoopSound = CreateSound(self, "weapons/tfa_mats_FlareGun/flare_burn.wav")
			self.LoopSound:Play()
			local CT = CurTime()

			if not self.FuseTime then
				self.FuseTime = CT + 600
			end

			local PHYS = self:GetPhysicsObject()
			PHYS:Wake()
			PHYS:AddGameFlag(FVPHYSICS_NO_IMPACT_DMG)
			self:NextThink(CT)
			self.FlareParticle = ents.Create("info_particle_system")
			self.FlareParticle:SetKeyValue("effect_name", "ins_flaregun_trail")
			self.FlareParticle:SetKeyValue("start_active", tostring(1))
			self.FlareParticle:SetPos(self:GetPos())
			self.FlareParticle:SetAngles(Angle(0, 0, 0))
			self.FlareParticle:Spawn()
			self.FlareParticle:Activate()
			self.FlareParticle:SetParent(self)
			self.FlareParticle:Fire("Kill", nil, 600)

			return true
		end
	else
		function ENT:Initialize()
			self.Light = DynamicLight(self:EntIndex())
			self.DieTime = CurTime() + 600
		end

		function ENT:Think()
			local TimeLeft = (self.DieTime - CurTime())
			local MUL = 1

			if TimeLeft < 5 then
				MUL = (TimeLeft / 5)
			end

			self.Light.Pos = self:GetPos()
			self.Light.r = 255
			self.Light.g = 115
			self.Light.b = 115
			self.Light.Brightness = 0.5
			self.Light.Size = 2048 * MUL
			self.Light.Decay = 0
			self.Light.DieTime = CurTime() + 2
		end
	end

	scripted_ents.Register(ENT, "tfa_mats_flare_shipment")
end)