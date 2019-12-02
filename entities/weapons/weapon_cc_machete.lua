AddCSLuaFile()

SWEP.Base			= "weapon_cc_base"

SWEP.PrintName 		= "Machete"
SWEP.Slot 			= 2
SWEP.SlotPos 		= 187

SWEP.UseHands		= true
SWEP.ViewModel 	= 	"models/tnb/weapons/c_machete.mdl"
SWEP.WorldModel = 	"models/tnb/weapons/w_machete.mdl"

SWEP.Firearm				= false
SWEP.Melee					= true

SWEP.Primary.Automatic		= true

SWEP.HoldType = "melee"
SWEP.HoldTypeHolster = "normal"

SWEP.Holsterable = true

SWEP.HolsterPos = Vector(0, -11.6, 0)
SWEP.HolsterAng = Vector(0, 0, 0)

SWEP.AimPos = Vector(4.47, 8.04, -6.25)
SWEP.AimAng = Vector(11.25, 56.25, 24.11)

SWEP.Itemize = true
SWEP.ItemDescription = "Huge blade"
SWEP.ItemWeight = 0.5
SWEP.ItemFOV = 19
SWEP.ItemCamPos = Vector(-0.89, 50, -0.89)
SWEP.ItemLookAt = Vector(0, 0, 8.04)

SWEP.ItemBulkPrice		= 10000
SWEP.ItemLicense		= LICENSE_BLACK

SWEP.SecondaryBlock = true
SWEP.BlockMul = 0.9

SWEP.Length = 80
SWEP.SwingSound = {"weapons/knife/knife_slash1.wav", "weapons/knife/knife_slash2.wav"}
SWEP.HitFleshSound = {"weapons/knife/knife_hit1.wav", "weapons/knife/knife_hit2.wav", "weapons/knife/knife_hit3.wav", "weapons/knife/knife_hit4.wav"}
SWEP.HitWallSound = Sound("weapons/knife/knife_hitwall1.wav")
SWEP.DamageMul = 15
SWEP.HitDelay = 0.4
SWEP.MissDelay = 0.5
SWEP.DamageType = DMG_SLASH

function SWEP:AddViewKick()
	self.Owner:ViewPunch(Angle(1.5, -1.5, 0))
end