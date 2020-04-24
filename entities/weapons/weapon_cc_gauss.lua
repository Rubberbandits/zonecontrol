AddCSLuaFile()

SWEP.Base			= "weapon_cc_base"

SWEP.PrintName 		= "Object 62"
SWEP.Slot 			= 2
SWEP.SlotPos 		= 55

SWEP.UseHands		= false
SWEP.ViewModel 		= "models/weapons/v_gauss.mdl"
SWEP.WorldModel 	= "models/weapons/w_gauss.mdl"
SWEP.Firearm				= true

SWEP.Primary.ClipSize 		= 10
SWEP.Primary.DefaultClip 	= 0
SWEP.Primary.Ammo			= "gauss"
SWEP.Primary.InfiniteAmmo	= true
SWEP.Primary.Automatic		= false
SWEP.Primary.Sound			= "kingston_wpn/gauss_shoot.ogg"
SWEP.Primary.HitParticle = {"hunter_shield_impact2", "warp_shield_impact", "striderbuster_shotdown_core_flash"} -- can be a string or table for multiple particles
SWEP.Primary.Damage			= 2000 --needs toning down when other mods are introduced
SWEP.Primary.Force			= 20
SWEP.Primary.Accuracy		= 0.01
SWEP.Primary.Delay			= 2
SWEP.Primary.RecoilAdd		= 0
SWEP.Primary.ReloadSound	= "kingston_wpn/gauss_cry/reload.ogg"
SWEP.ViewModelFlip 	= true

SWEP.HoldType = "ar2"
SWEP.HoldTypeHolster = "passive"

SWEP.Primary.HitSound = {"hl1/ambience/port_suckin1.wav"}

SWEP.Holsterable = true

SWEP.HolsterPos = Vector( -5.08, -0.43, 0 );
SWEP.HolsterAng = Vector( -12.01, -42.7, 0 );

SWEP.AimPos = Vector( 2.92, -0, -0 );
SWEP.AimAng = Vector( 0, 0, 0 );

SWEP.Scoped = true

SWEP.Itemize = true
SWEP.ItemDescription = "An exceedingly rare rifle designed and built within the Zone. Once a favorite of Monolith sharpshooters; now a mostly-forgotten relic."
SWEP.ItemWeight = 12
SWEP.ItemFOV = 25
SWEP.ItemCamPos = Vector(-2.94, 50, 0.27)
SWEP.ItemLookAt = Vector(-1.44, 0, 0)

function SWEP:Reload()
	local item = self.Owner:HasItem("gauss")
	if self:Clip1() == 0 and item then
		if istable(item) and !item.IsItem then
			item = item[1]
		end

		self:SetClip1(item:GetVar("Amount", 5))

		if SERVER then
			item:RemoveItem(true)
		end

		self:SendWeaponAnimShared(ACT_VM_RELOAD)
		self.Owner:SetAnimation(PLAYER_RELOAD)

		self:SetNextPrimaryFire(CurTime() + self:SequenceDuration())

	end
end