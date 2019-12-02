AddCSLuaFile()

SWEP.Base= "weapon_cc_base"

SWEP.PrintName = "Pipe"
SWEP.Slot = 2
SWEP.SlotPos = 22
SWEP.ViewModelFOV = 10
SWEP.UseHands= true
SWEP.ViewModelFOV = 81.809045226131
SWEP.ViewModelFlip = false
SWEP.ViewModel = "models/tnb/weapons/c_pipe.mdl"
SWEP.WorldModel = "models/props_canal/mattpipe.mdl"


SWEP.Firearm= false
SWEP.Melee= true

SWEP.Primary.Automatic= true

SWEP.HoldType = "melee2"
SWEP.HoldTypeHolster = "normal"

SWEP.Holsterable = true
SWEP.HolsterUseAnim = true

SWEP.HolsterPos = Vector()
SWEP.HolsterAng = Vector()

SWEP.AimPos = Vector(-9.82, 4.47, -9.82)
SWEP.AimAng = Vector(0, 17.68, -75.53)

SWEP.Itemize = true
SWEP.ItemDescription = "An old rusty pipe."
SWEP.ItemWeight = 2
SWEP.ItemFOV = 19
SWEP.ItemCamPos = Vector(50, 50, 50)
SWEP.ItemLookAt = Vector(0, 0, 0)

SWEP.SecondaryBlock = true
SWEP.BlockMul = 0.5

SWEP.Length = 50
SWEP.SwingSound = Sound("Weapon_Crowbar.Single")
SWEP.HitFleshSound = Sound("Weapon_Crowbar.Melee_Hit")
SWEP.HitWallSound = true
SWEP.DamageMul = 5
SWEP.HitDelay = 0.8
SWEP.MissDelay = 1
SWEP.DamageType = DMG_CLUB
SWEP.HitAnim = ACT_VM_HITCENTER
SWEP.BulletDecal = true

function SWEP:AddViewKick()
self.Owner:ViewPunch(Angle(1.5, -1.5, 0))
end