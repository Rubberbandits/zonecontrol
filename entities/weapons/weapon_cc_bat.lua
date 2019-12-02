AddCSLuaFile()

SWEP.Base= "weapon_cc_base"

SWEP.PrintName = "Baseball Bat"
SWEP.Slot = 2
SWEP.SlotPos = 186
SWEP.ViewModelFOV = 10
SWEP.UseHands= true
SWEP.ViewModelFOV = 81
SWEP.ViewModelFlip = false
SWEP.ViewModel 	= 	"models/tnb/weapons/c_baseballbat.mdl"
SWEP.WorldModel = 	"models/tnb/weapons/w_bat.mdl"


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
SWEP.ItemDescription = "For sports...."
SWEP.ItemWeight = 1
SWEP.ItemFOV = 19
SWEP.ItemCamPos = Vector(50, 50, 50)
SWEP.ItemLookAt = Vector(0, 0, 0)

SWEP.ItemBulkPrice= 3000
SWEP.ItemLicense= LICENSE_BLACK

SWEP.SecondaryBlock = true
SWEP.BlockMul = 0.8

SWEP.Length = 75
SWEP.SwingSound = Sound("Weapon_Crowbar.Single")
SWEP.HitFleshSound = Sound("Weapon_Crowbar.Melee_Hit")
SWEP.HitWallSound = true
SWEP.DamageMul = 15
SWEP.HitDelay = 0.8
SWEP.MissDelay = 1
SWEP.DamageType = DMG_CLUB
SWEP.HitAnim = ACT_VM_HITCENTER
SWEP.BulletDecal = true

function SWEP:AddViewKick()
self.Owner:ViewPunch(Angle(1.5, -1.5, 0))
end