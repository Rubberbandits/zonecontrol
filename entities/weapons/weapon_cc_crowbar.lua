AddCSLuaFile();

SWEP.Base			= "weapon_cc_base";

SWEP.PrintName 		= "Crowbar";
SWEP.Slot 			= 2;
SWEP.SlotPos 		= 21;

SWEP.UseHands		= true;
SWEP.ViewModel 		= "models/weapons/c_crowbar.mdl";
SWEP.WorldModel 	= "models/weapons/w_crowbar.mdl";

SWEP.Firearm				= false;
SWEP.Melee					= true;

SWEP.MeleeBreach				= true;

SWEP.Primary.Automatic		= true;

SWEP.HoldType = "melee";
SWEP.HoldTypeHolster = "normal";

SWEP.Holsterable = true;
SWEP.HolsterUseAnim = true;

SWEP.HolsterPos = Vector();
SWEP.HolsterAng = Vector();

SWEP.AimPos = Vector( -9.82, 4.47, -9.82 );
SWEP.AimAng = Vector( 0, 17.68, -75.53 );

SWEP.Itemize = true;
SWEP.ItemDescription = "It's an iron crowbar, painted red.";
SWEP.ItemWeight = 1;
SWEP.ItemFOV = 19;
SWEP.ItemCamPos = Vector( 50, 50, 50 );
SWEP.ItemLookAt = Vector( 0, 0, 0 );

SWEP.ItemBulkPrice		= 12500;
SWEP.ItemLicense		= LICENSE_BLACK;

SWEP.SecondaryBlock = true;
SWEP.BlockMul = 0.5;

SWEP.Length = 90;
SWEP.SwingSound = Sound( "Weapon_Crowbar.Single" );
SWEP.HitFleshSound = Sound( "Weapon_Crowbar.Melee_Hit" );
SWEP.HitWallSound = true;
SWEP.DamageMul = 14;
SWEP.HitDelay = 1.1;
SWEP.MissDelay = 1.9;
SWEP.DamageType = DMG_CLUB;
SWEP.HitAnim = ACT_VM_HITCENTER;
SWEP.BulletDecal = true;

function SWEP:AddViewKick()
	
	self.Owner:ViewPunch( Angle( 1.5, -1.5, 0 ) );
	
end