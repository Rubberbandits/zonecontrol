AddCSLuaFile()

SWEP.Base			= "weapon_cc_base"

SWEP.PrintName 		= "Snork Claws"
SWEP.Slot 			= 1
SWEP.SlotPos 		= 10

SWEP.UseHands		= true
SWEP.ViewModel 		= "models/weapons/c_arms_citizen.mdl"
SWEP.WorldModel 	= "models/lagsnork.mdl"

SWEP.HoldType = "fist"
SWEP.HoldTypeHolster = "normal"

SWEP.DrawAnim = "fists_draw"
SWEP.HolsterAnim = "fists_holster"

SWEP.Holsterable = true
SWEP.HolsterUseAnim = true
SWEP.NoDrawHolstered = true

SWEP.HolsterPos = Vector(0, -0.25, 0)
SWEP.HolsterAng = Vector()

SWEP.AimPos = Vector(-2.93, 2.81, -4.24)
SWEP.AimAng = Vector(-0.81, 0, 0)

SWEP.SecondaryBlock = false

SWEP.NextSound = 0

SWEP.isHarmless = true

SWEP.InfoText = [[Holstered - Primary: Knock on doors.
Holstered - Secondary: Nothing.
Unholstered - Primary: Punch.
Unholstered - Secondary: Block.
Reload: Ram door.]]

SWEP.AttackAnims = {
	{"fists_left", Angle(0, -10, 0)},
	{"fists_right", Angle(0, 10, 0)},
	{"fists_uppercut", Angle(-7, 2, 0)}}

SWEP.SlashSounds = {
	"physics/flesh/flesh_squishy_impact_hard1.wav",
	"physics/flesh/flesh_squishy_impact_hard2.wav",
	"physics/flesh/flesh_squishy_impact_hard3.wav",
	"physics/flesh/flesh_squishy_impact_hard4.wav"
}

SWEP.SwingSounds = {
	"kingston-stalker/mutants/bloodsucker/attack_0.wav",
	"kingston-stalker/mutants/bloodsucker/attack_1.wav",
	"kingston-stalker/mutants/bloodsucker/attack_2.wav"
}

SWEP.RunAttackAnims = {
	"STAND_RUN_ATTACK_LEFT_0",
	"STAND_RUN_ATTACK_RIGHT_0"
}

SWEP.Itemize = true
SWEP.ItemDescription = "Bloodsucker claws."
SWEP.ItemWeight = 0
SWEP.ItemFOV = 25
SWEP.ItemCamPos = Vector(-2.94, 50, 0.27)
SWEP.ItemLookAt = Vector(-1.44, 0, 0)

function SWEP:Initialize()
	self:SetWeaponHoldType(self.HoldType)
	self:SetWeaponHoldTypeHolster(self.HoldTypeHolster)
	self.Weapon:SetMaterial("engine/occlusionproxy")
end

function SWEP:Precache()
	util.PrecacheSound("physics/wood/wood_crate_impact_hard2.wav")

	util.PrecacheSound("doors/door_latch3.wav")
	util.PrecacheSound("doors/door_locked2.wav")

	for _, v in pairs(self.SlashSounds) do

		util.PrecacheSound(v)

	end

	for _, v in pairs(self.SwingSounds) do

		util.PrecacheSound(v)

	end
end

function SWEP:IdleNow()
	local vm = self.Owner:GetViewModel()
	vm:SendViewModelMatchingSequence(vm:LookupSequence("fists_idle_0" .. math.random(1, 2)))
end

function SWEP:PreDrawViewModel(vm, wep, ply)
	vm:SetMaterial("engine/occlusionproxy") -- Hide that view model with hacky material
end

function SWEP:PrimaryHolstered()
	local tr = GAMEMODE:GetHandTrace(self.Owner)

	if tr.Entity and tr.Entity:IsValid() and tr.Entity:IsDoor() then

		self:PlaySound("physics/wood/wood_crate_impact_hard2.wav", 70, math.random(95, 105))

		self:SetNextPrimaryFire(CurTime() + 0.1)

	end
end

function SWEP:PrimaryUnholstered()
	if self.Owner:KeyDown(IN_ATTACK2) then return end

	self:SetNextPrimaryFire(CurTime() + 1.8)
	self:SetNextSecondaryFire(CurTime() + 1.1)
	
	if self.Owner:GetVelocity():Length() < 5 then
		self.Owner:PlayVCD( "STAND_ATTACK_0");

		timer.Simple(.4, function()
		self:PlaySound(table.Random(self.SwingSounds), 74, math.random(90, 110))
		end)
		
		local vm = self.Owner:GetViewModel()
		vm:SendViewModelMatchingSequence(vm:LookupSequence("fists_idle_01"))

		local anim = table.Random(self.AttackAnims)
		local runattack = table.Random(self.RunAttackAnims)

		timer.Simple(0, function()
			if (not IsValid(self) || not IsValid(self.Owner) || not self.Owner:GetActiveWeapon() || self.Owner:GetActiveWeapon() ~= self) then return end

			local vm = self.Owner:GetViewModel()
			vm:SendViewModelMatchingSequence(vm:LookupSequence(anim[1]))

			self:Idle()
		end)

		timer.Simple(0.1, function()
			if (not IsValid(self) || not IsValid(self.Owner) || not self.Owner:GetActiveWeapon() || self.Owner:GetActiveWeapon() ~= self) then return end

			self.Owner:ViewPunch(anim[2])
		end)

		timer.Simple(.4, function()
			if (not IsValid(self) || not IsValid(self.Owner) || not self.Owner:GetActiveWeapon() || self.Owner:GetActiveWeapon() ~= self) then return end

			self:FistDamage()
		end)
	else
		self.Owner:PlayVCD( "runattack" );

		timer.Simple(.4, function()
		self:PlaySound(table.Random(self.SwingSounds), 74, math.random(90, 110))
		end)
		
		local vm = self.Owner:GetViewModel()
		vm:SendViewModelMatchingSequence(vm:LookupSequence("fists_idle_01"))

		local anim = table.Random(self.AttackAnims)

		timer.Simple(0, function()
			if (not IsValid(self) || not IsValid(self.Owner) || not self.Owner:GetActiveWeapon() || self.Owner:GetActiveWeapon() ~= self) then return end

			local vm = self.Owner:GetViewModel()
			vm:SendViewModelMatchingSequence(vm:LookupSequence(anim[1]))

			self:Idle()
		end)

		timer.Simple(0.1, function()
			if (not IsValid(self) || not IsValid(self.Owner) || not self.Owner:GetActiveWeapon() || self.Owner:GetActiveWeapon() ~= self) then return end

			self.Owner:ViewPunch(anim[2])
		end)

		timer.Simple(.4, function()
			if (not IsValid(self) || not IsValid(self.Owner) || not self.Owner:GetActiveWeapon() || self.Owner:GetActiveWeapon() ~= self) then return end

			self:FistDamage()
			timer.Simple(.4, function()
				self:FistDamage()
				end)
		end)	
	end
end

function SWEP:FistDamage()
	if CLIENT then return end

	self.Owner:LagCompensation(true)

	local trace = {}
	trace.start = self.Owner:GetShootPos()
	trace.endpos = trace.start + self.Owner:GetAimVector() * 50
	trace.filter = self.Owner
	trace.mins = Vector(-8, -8, -8)
	trace.maxs = Vector(8, 8, 8)

	local tr = util.TraceHull(trace)

	if tr.Hit then

		self:PlaySound(table.Random(self.SlashSounds), 74, math.random(80, 90))

		if tr.Entity and tr.Entity:IsValid() then

			local blockmul = 1

			if tr.Entity:IsPlayer() then

				if tr.Entity:GetActiveWeapon() and tr.Entity:GetActiveWeapon():IsValid() then

					if tr.Entity:GetActiveWeapon().IsBlocking and tr.Entity:GetActiveWeapon():IsBlocking() then

						blockmul = tr.Entity:GetActiveWeapon().BlockMul

					end

				end

			end

			local dmg = DamageInfo()
			dmg:SetAttacker(self.Owner)
			dmg:SetDamage(30)
			dmg:SetDamageForce(Vector(0, 0, 1))
			dmg:SetDamagePosition(tr.Entity:GetPos())
			dmg:SetDamageType(DMG_SLASH)
			dmg:SetInflictor(self)

			tr.Entity:TakeDamageInfo(dmg)

		end

	end

	self.Owner:LagCompensation(false)
end

function SWEP:Reload()
	if not IsFirstTimePredicted() then return end
	if (self.NextSound - CurTime() < 0) then
	self:PlaySound("kingston-stalker/mutants/bloodsucker/bloodsucker_script_attack_" .. math.random(0,1) .. ".wav", 120, 100, 1)
	self.NextSound = CurTime() + 3
	end
end

function SWEP:SecondaryUnholstered()
end

function SWEP:SecondaryHolstered()
end

function SWEP:HolsterChild()
	self:OnRemove()
end

function SWEP:OnRemove()
	if self.Owner and self.Owner:IsValid() then

		local vm = self.Owner:GetViewModel()

		if vm and vm:IsValid() then

			vm:SetMaterial("")

		end

	end

	timer.Stop("cc_weapon_idle" .. self:EntIndex())
end