AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')
include("STALKERNPCBaseVars.lua")

ENT.DieSoundEnabled = true
ENT.DieSound.name = "Stalker.Burer.Die"
ENT.DieSound.min = 1
ENT.DieSound.max = 1

ENT.MeleeSoundEnabled = true
ENT.MeleeSound.name = "Stalker.Burer.Melee"
ENT.MeleeSound.min = 1
ENT.MeleeSound.max = 1

ENT.IdlingSoundEnabled = true
ENT.IdlingSound.name = "Stalker.Burer.Idle"
ENT.IdlingSound.min = 1
ENT.IdlingSound.max = 3


ENT.CanSpecial = true

ENT.SNPCClass="C_MONSTER_BURER"


ENT.CanTele = 0
ENT.CanShield = 0
ENT.CanGrab = 0
ENT.CanPush = 0

ENT.ShieldStartTime = 0


ENT.MustShield = 0

ENT.NextAbilityTime = 0

ENT.MinRangeDist = 800
ENT.MaxRangeDist = 1500
ENT.VisibleSchedule = SCHED_RUN_FROM_ENEMY_FALLBACK
ENT.RangeSchedule = SCHED_RUN_RANDOM

ENT.MaxGrabs = 10
ENT.MaxGrabMass = 800

ENT.ConstraintRemoveMode = 1

ENT.AbilityIntervals = 0.3


ENT.SupportedWepBases = {}
ENT.SupportedWepClasses = {}


function ENT:Initialize()
	self.Model = "models/GSC/S.T.A.L.K.E.R/Monsters/Burer.mdl"
	self:STALKERNPCInit(Vector(20,20,60),MOVETYPE_STEP)
	
	
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
	TEMP_MeleeTable.time[1] = 0.6
	TEMP_MeleeTable.bone[1] = "right_hand"
	TEMP_MeleeTable.damage[2] = 19
	TEMP_MeleeTable.damagetype[2] = bit.bor(DMG_SLASH, DMG_CLUB)
	TEMP_MeleeTable.distance[2] = 21
	TEMP_MeleeTable.radius[2] = 60
	TEMP_MeleeTable.time[2] = 1.3
	TEMP_MeleeTable.bone[2] = "left_hand"
	self:STALKERNPCSetMeleeParams(1,"S_Melee",2, TEMP_MeleeTable,TEMP_MeleeHitTable,TEMP_MeleeMissTable)

	
	self:SetHealth(GetConVar("stalker_npc_burer_health"):GetInt())
	self.MaxGrabs = GetConVar("stalker_npc_burer_max_grabs"):GetInt()
	self.MaxGrabMass = GetConVar("stalker_npc_burer_max_mass"):GetInt()
	
	self.ConstraintRemoveMode = GetConVar("stalker_npc_burer_kill_constraints"):GetInt()
	
	
	self:SetMaxHealth(self:Health())
	
	self.CanTele = CurTime()+1
	self.CanShield = CurTime()+1
	self.CanGrab = CurTime()+1
	self.CanPush = CurTime()+1
	
	self.NextAbilityTime = CurTime()+1
	
	self.MustShield = 0
	self.ShieldStartTime = 0
	
	self:SetRenderMode(RENDERMODE_TRANSALPHA)
	
	
	
	
	
	self.SupportedWepBases = 
	{
		bobs_gun_base = true,
		bobs_scoped_base = true,
		bobs_shotty_base = true,
		tfa_gun_base = true,
		tfa_bash_base = true,
		tfa_3dcsgo_base = true,
		tfa_csgo_base = true,
		tfa_ballistic_base = true,
		cw_base = true,
		weapon_uh_base_shotty = true,
		weapon_uh_base = true,
		weapon_uh_base_sniper = true,
		weapon_cpt_base = true,
		fas2_base = true,
		fas2_base_shotgun = true
	}
	self.BlacklistedWeapons = {
		weapon_cc_hands = true,
		weapon_physgun = true,
		gmod_tool = true,
		weapon_cc_bolt = true,
	}
	/*
	table.insert(self.SupportedWepBases, "bobs_gun_base")
	table.insert(self.SupportedWepBases, "bobs_scoped_base")
	table.insert(self.SupportedWepBases, "bobs_shotty_base")
	table.insert(self.SupportedWepBases, "tfa_gun_base")
	table.insert(self.SupportedWepBases, "tfa_bash_base")
	table.insert(self.SupportedWepBases, "tfa_3dcsgo_base")
	table.insert(self.SupportedWepBases, "tfa_csgo_base")
	table.insert(self.SupportedWepBases, "cw_base")
	table.insert(self.SupportedWepBases, "weapon_uh_base_shotty")
	table.insert(self.SupportedWepBases, "weapon_uh_base")
	table.insert(self.SupportedWepBases, "weapon_uh_base_sniper")
	table.insert(self.SupportedWepBases, "weapon_cpt_base")
	table.insert(self.SupportedWepBases, "fas2_base")
	table.insert(self.SupportedWepBases, "fas2_base_shotgun")
	*/
	self.SupportedWepClasses = 
	{
		weapon_shotgun = true,
		weapon_ar2 = true,
		weapon_smg1 = true,
		weapon_pistol = true,
		weapon_357 = true,
		weapon_rpg = true,
		weapon_crossbow = true,
		mexican_chaingun = true,
	}
	
	/*
	table.insert(self.SupportedWepClasses, "weapon_shotgun")
	table.insert(self.SupportedWepClasses, "weapon_ar2")
	table.insert(self.SupportedWepClasses, "weapon_smg1")
	table.insert(self.SupportedWepClasses, "weapon_pistol")
	table.insert(self.SupportedWepClasses, "weapon_357")
	table.insert(self.SupportedWepClasses, "weapon_rpg")
	table.insert(self.SupportedWepClasses, "weapon_crossbow")
	table.insert(self.SupportedWepClasses, "mexican_chaingun")
	table.insert(self.SupportedWepClasses, "weapon_hpwr_stick")
	table.insert(self.SupportedWepClasses, "gmod_tool")
	*/
end






local function WeaponShootMode1Check(wp,fast) 
	if(wp:GetClass()=="weapon_hpwr_stick"||wp:GetClass()=="gmod_tool") then
		return true
	end
	
	if(((wp:Clip1()>0)||(isnumber(wp:GetSaveTable().m_iPrimaryAmmoCount)&&wp:GetSaveTable().m_iPrimaryAmmoCount>0&&wp:Clip1()<0))) then
		return true
	end
	
	return false
end

local function WeaponShootMode2Check(wp,fast) 
	if(wp:GetClass()=="weapon_ar2"||wp:GetClass()=="weapon_pistol"||wp:GetClass()=="weapon_357"||wp:GetClass()=="weapon_shotgun"||
	wp:GetClass()=="weapon_smg1"||wp:GetClass()=="weapon_rpg"||wp:GetClass()=="weapon_crossbow") then
		return false
	end
	
	if((wp:Clip2()>0)||(isnumber(wp:GetSaveTable().m_iSecondaryAmmoCount)&&wp:GetSaveTable().m_iSecondaryAmmoCount>0&&wp:Clip2()<0)) then
		return true
	end
	
	return false
end

local function BurerCanWeaponShoot(self,wep)
	
	if(wep.BurerGrabbedFirstTime!=true) then
		if(wep:Clip1()==0) then
			wep:SetClip1(wep:GetMaxClip1())
		end
		
		wep.BurerGrabbedFirstTime = true
	end
	
	if(wep:GetMoveType()==MOVETYPE_VPHYSICS&&
	(WeaponShootMode1Check(wep)==true||
	WeaponShootMode2Check(wep)==true)) then
		
		local TEMP_Stored = weapons.GetStored(wep:GetClass())
		local TEMP_Class = wep:GetClass()
		
		if((wep.IsVJBaseWeapon==true&&wep.Primary.DisableBulletCode!=true)||
		(isstring(wep.Base)&&self.SupportedWepBases[wep.Base]&&TEMP_Stored&&(!isfunction(TEMP_Stored.PrimaryAttack)||
		string.sub(wep.Base,1,4)=="tfa_")&&
		wep.IsMelee!=true&&(!isstring(wep.ProjectileEntity)||wep.ProjectileEntity=="")&&wep.HoldType!="melee")||
		TEMP_Class=="weapon_hpwr_stick"||(self.SupportedWepClasses[TEMP_Class]==true&&
		(!TEMP_Stored||(!isfunction(TEMP_Stored.PrimaryAttack)&&!isfunction(TEMP_Stored.PrimaryAttackCode))))) then
			return true
		end
	end
	
	return false
end


		
function ENT:BurerShoot(wep)
	if(!isnumber(wep.NextBurerShoot)||wep.NextBurerShoot<CurTime()-5) then
		wep.NextBurerShoot = CurTime()+0.01
	end
	
	if(wep.NextBurerShoot<CurTime()) then
		if(WeaponShootMode1Check(wep,true)||
		WeaponShootMode2Check(wep,true)) then
			local TEMP_Att = wep:GetAttachment(1)
			local TEMP_FPos = wep:GetPos()-(wep:GetForward()*10)
			
			if(TEMP_Att) then
				TEMP_FPos = wep:GetAttachment(1).Pos
			end
			
			local TEMP_Disp = 0.03
			local TEMP_Dmg = GetConVar("sk_npc_dmg_ar2"):GetInt() or 0
			local TEMP_DmgType = DMG_BULLET
			local TEMP_Tracer = "AR2Tracer"
			local TEMP_Sound = "Weapon_AR2.Single"
			local TEMP_Shoots = 1
			local TEMP_IsBulletWeapon = true
			local TEMP_RemoveClip = true
			local TEMP_Clip = 1
			local TEMP_AmmoConsuming = 1
			local TEMP_Muzzle = "MuzzleFlash"
			local TEMP_Radius = 1
			local TEMP_Fwd = wep:GetForward()
			local TEMP_ShootMethod = 0
			
			if(wep.IsVJBaseWeapon==true) then
				TEMP_Tracer = wep.Primary.TracerType
				TEMP_Dmg = wep.Primary.Damage
				TEMP_Disp = wep.Primary.Cone/240
				TEMP_Sound = wep.Primary.Sound[math.random(1,#wep.Primary.Sound)]
				TEMP_Shoots = wep.Primary.NumberOfShots
				
				wep.NextBurerShoot = CurTime()+wep.Primary.Delay
			elseif(isstring(wep.Base)&&string.sub(wep.Base,1,4)=="tfa_") then
				TEMP_Tracer = wep.Primary.TracerName
				TEMP_Dmg = wep.Primary.Damage
				TEMP_Disp = wep.Primary.Spread
				TEMP_Sound = wep.Primary.Sound
				TEMP_Shoots = wep.Primary.NumShots
				TEMP_DmgType = wep.Primary.DamageType
				TEMP_AmmoConsuming = wep.Primary.AmmoConsumption
				TEMP_Muzzle = wep.MuzzleFlashEffect
				TEMP_Radius = wep.Primary.Radius
				
				if(wep:Clip1()==-1) then
					TEMP_RemoveClip = false
				end
				
				if(TEMP_Tracer==nil) then
					TEMP_Tracer = wep.TracerName
				end
				wep.NextBurerShoot = CurTime() + (60 / ( wep.Primary.RPM_Displayed or wep.Primary.RPM ))
			elseif(wep.Base=="cw_base") then
				TEMP_Tracer = "Tracer"
				TEMP_Dmg = wep.Damage
				TEMP_Disp = wep.HipSpread
				TEMP_Sound = wep.FireSound
				TEMP_Shoots = wep.Shots
				TEMP_DmgType = DMG_BULLET
				TEMP_AmmoConsuming = wep.AmmoPerShot
				TEMP_Muzzle = "MuzzleFlash"
				TEMP_Radius = wep.Primary.Radius
				
				if(wep:Clip1()==-1) then
					TEMP_RemoveClip = false
				end
				
				if(TEMP_Tracer==nil) then
					TEMP_Tracer = wep.TracerName
				end
				wep.NextBurerShoot = CurTime() + (wep.FireDelay)
			elseif(isstring(wep.Base)&&string.sub(wep.Base,1,14)=="weapon_uh_base") then
				wep.NextBurerShoot = CurTime() + wep.Primary.Delay

				TEMP_Tracer = "uh_tracer"
				TEMP_Dmg = math.random(wep.Primary.MinDamage,wep.Primary.MaxDamage)
				TEMP_Disp = wep.Primary.Spread*0.4
				TEMP_Sound = wep.Primary.Sound
				TEMP_Shoots = wep.Primary.NumberofShots
			elseif(isstring(wep.Base)&&string.sub(wep.Base,1,5)=="bobs_") then
			
				wep.NextBurerShoot = CurTime() + (60/wep.Primary.RPM)
				
				local TEMP_TrInd = wep.Tracer
				
				if(TEMP_TrInd==1) then
					TEMP_Tracer = "Ar2Tracer"
				elseif(TEMP_TrInd==2) then
					TEMP_Tracer = "AirboatGunHeavyTracer"
				else
					TEMP_Tracer = "Tracer"
				end
				
				TEMP_Dmg = wep.Primary.Damage
				TEMP_Disp = wep.Primary.Spread
				TEMP_Sound = wep.Primary.Sound
				TEMP_Shoots = wep.Primary.NumShots
			elseif(wep.Base=="weapon_cpt_base") then
				TEMP_Shoots = wep.Primary.TotalShots
				TEMP_Disp = wep.Primary.Spread
				TEMP_Dmg = wep.Primary.Damage
				TEMP_Tracer = wep.Primary.TracerEffect
				TEMP_AmmoConsuming = wep.RemoveAmmoAmount
				
				if(istable(wep.tbl_Sounds)) then
					TEMP_Sound = wep.tbl_Sounds["Fire"]
				end
				
				wep.NextBurerShoot = CurTime()+wep.Primary.Delay
			elseif(wep.Base=="fas2_base"||wep.Base=="fas2_base_shotgun") then
				TEMP_Shoots = wep.Shots
				TEMP_Disp = wep.HipCone
				TEMP_Dmg = wep.Damage
				TEMP_Tracer = "Tracer"
				TEMP_AmmoConsuming = 1
				
				TEMP_Sound = wep.FireSound
				
				wep.NextBurerShoot = CurTime()+wep.FireDelay
			else
				TEMP_ShootMethod = 1
				
				if(wep:GetClass()=="weapon_ar2") then
					TEMP_Fwd = -wep:GetForward() 
					
					if(wep:GetSaveTable().m_iSecondaryAmmoCount>0&&wep:Clip1()>0) then
						TEMP_Clip = math.random(1,2)
					elseif(wep:Clip1()>0&&wep:GetSaveTable().m_iSecondaryAmmoCount<=0) then
						TEMP_Clip = 1
					elseif(wep:GetSaveTable().m_iSecondaryAmmoCount>0&&wep:Clip1()<=0) then
						TEMP_Clip = 2
					end
					
					if(TEMP_Clip==1) then
						wep.NextBurerShoot = CurTime()+0.07
					
						TEMP_Disp = 0.03
						TEMP_Dmg = GetConVar("sk_npc_dmg_ar2"):GetInt() or 0
						TEMP_DmgType = DMG_BULLET
						TEMP_Tracer = "AR2Tracer"
						TEMP_Sound = "Weapon_AR2.Single"
						
					elseif(TEMP_Clip==2) then
						wep.NextBurerShoot = CurTime()+2 
						
						TEMP_IsBulletWeapon = false
						TEMP_RemoveClip = false
						TEMP_Clip = 2

						TEMP_Sound = "Weapon_CombineGuard.Special1"
						
						timer.Create("AR2_BurerComball_Shoot"..tostring(wep),0.7,1,function()
							if(IsValid(wep)&&wep!=nil&&!IsValid(wep:GetOwner())) then
								local TEMP_Ball = ents.Create( "prop_combine_ball" )
								TEMP_Ball:SetPos( wep:GetPos()+(TEMP_Fwd*50) )
								TEMP_Ball:SetAngles( TEMP_Fwd:Angle() )
								TEMP_Ball:SetModel( "models/Effects/combineball.mdl");
								TEMP_Ball:Spawn()
								
								if(IsValid(TEMP_Ball)) then
									TEMP_Ball:Activate()
									
									TEMP_Ball:SetOwner( self )
									TEMP_Ball:GetPhysicsObject():Wake()
									TEMP_Ball:GetPhysicsObject():EnableCollisions(true)
									TEMP_Ball:SetSolid(SOLID_VPHYSICS)
									TEMP_Ball:PhysicsInit(SOLID_VPHYSICS)
									TEMP_Ball:SetCollisionGroup(24)
									TEMP_Ball:SetSaveValue('m_flRadius',10)
									TEMP_Ball:SetSaveValue('m_flSpeed',1000)
									TEMP_Ball:SetSaveValue('m_nMaxBounces',0)
									TEMP_Ball:SetSaveValue('m_nState',2)
									TEMP_Ball:SetSaveValue('touchStamp',7)
									TEMP_Ball:SetSaveValue('m_bLaunched',true)
									TEMP_Ball:SetSaveValue('m_bWeaponLaunched',true)
									TEMP_Ball:GetPhysicsObject():AddGameFlag( FVPHYSICS_DMG_DISSOLVE )
									TEMP_Ball:GetPhysicsObject():AddGameFlag( FVPHYSICS_WAS_THROWN )
									TEMP_Ball:GetPhysicsObject():SetVelocity(TEMP_Fwd*1000)
								end
								
								wep:EmitSound("Weapon_IRifle.Single")
								
							end
						end)
					end
				elseif(wep:GetClass()=="weapon_smg1") then
					TEMP_ShootMethod = 1
					
					if(wep:GetSaveTable().m_iSecondaryAmmoCount>0&&wep:Clip1()>0) then
						TEMP_Clip = math.random(1,2)
					elseif(wep:Clip1()>0&&wep:GetSaveTable().m_iSecondaryAmmoCount<=0) then
						TEMP_Clip = 1
					elseif(wep:GetSaveTable().m_iSecondaryAmmoCount>0&&wep:Clip1()<=0) then
						TEMP_Clip = 2
					end
					
					if(TEMP_Clip==1) then
						wep.NextBurerShoot = CurTime()+0.04
					
						TEMP_Disp = 0.05
						TEMP_Dmg = GetConVar("sk_npc_dmg_smg1"):GetInt() or 0
						TEMP_DmgType = DMG_BULLET
						TEMP_Tracer = "Tracer"
						TEMP_Sound = "Weapon_SMG1.Single"
					elseif(TEMP_Clip==2) then
						wep.NextBurerShoot = CurTime()+1
						
						TEMP_IsBulletWeapon = false
						TEMP_RemoveClip = false
						TEMP_Clip = 2

						TEMP_Sound = "Weapon_SMG1.Double"
						
						local TEMP_Gren = ents.Create( "grenade_ar2" )
						TEMP_Gren:SetPos( wep:GetPos()+(TEMP_Fwd*50) )
						TEMP_Gren:SetAngles( TEMP_Fwd:Angle() )
						TEMP_Gren:SetModel( "models/Items/AR2_Grenade.mdl");
						TEMP_Gren:Spawn()
						
						if(IsValid(TEMP_Gren)) then
							TEMP_Gren:Activate()
							
							TEMP_Gren:SetOwner( self )
							TEMP_Gren:SetVelocity(TEMP_Fwd*1000)
						end
					end
				elseif(wep:GetClass()=="weapon_shotgun") then
					TEMP_Fwd = -wep:GetForward()
					
					wep.NextBurerShoot = CurTime()+1
					
					TEMP_Disp = 0.1
					TEMP_Dmg = GetConVar("sk_npc_dmg_buckshot"):GetInt() or 0
					TEMP_DmgType = DMG_BUCKSHOT
					TEMP_Tracer = "Tracer"
					TEMP_Sound = "Weapon_Shotgun.Single"
					TEMP_Shoots = 10
				elseif(wep:GetClass()=="weapon_pistol") then
					TEMP_Fwd = -wep:GetForward()
					
					TEMP_ShootMethod = 1
					
					wep.NextBurerShoot = CurTime()+0.2
					
					TEMP_Disp = 0.035
					TEMP_Dmg = GetConVar("sk_npc_dmg_pistol"):GetInt() or 0
					TEMP_DmgType = DMG_BULLET
					TEMP_Tracer = "Tracer"
					TEMP_Sound = "Weapon_Pistol.Single"
					
				elseif(wep:GetClass()=="weapon_357") then
					wep.NextBurerShoot = CurTime()+0.6
					
					TEMP_Disp = 0.01
					TEMP_Dmg = GetConVar("sk_npc_dmg_357"):GetInt() or 0
					TEMP_DmgType = DMG_BULLET
					TEMP_Tracer = "Tracer"
					TEMP_Sound = "Weapon_357.Single"
				elseif(wep:GetClass()=="weapon_crossbow") then
					wep.NextBurerShoot = CurTime()+3
					
					TEMP_IsBulletWeapon = false

					TEMP_Sound = "Weapon_Crossbow.BoltSkewer"
					
					local TEMP_Bolt = ents.Create("crossbow_bolt")
					TEMP_Bolt:SetPos(wep:GetPos()+(-wep:GetForward()*30))
					TEMP_Bolt:SetAngles(TEMP_Fwd:Angle())
					TEMP_Bolt:Spawn()
					
					
					if(IsValid(TEMP_Bolt)) then
						constraint.NoCollide(TEMP_Bolt,wep)
						
						local TEMP_Dmg = GetConVar("sk_npc_dmg_crossbow"):GetInt() or 0
						
						TEMP_Bolt:SetSaveValue("m_flDamage",TEMP_Dmg)
						TEMP_Bolt:SetSaveValue("m_iDamageCount",TEMP_Dmg)
						TEMP_Bolt:SetSaveValue("touchStamp",3)
						
						TEMP_Bolt.BurerBoltDamage = TEMP_Dmg
						
						TEMP_Bolt:SetOwner(self)
					
						TEMP_Bolt:SetVelocity(TEMP_Fwd*3500)
					end
				elseif(wep:GetClass()=="weapon_rpg") then
					TEMP_Fwd = -wep:GetForward()
					wep.NextBurerShoot = CurTime()+3
					
					TEMP_IsBulletWeapon = false
					TEMP_RemoveClip = false

					TEMP_Sound = "Weapon_RPG.Single"
					
					local TEMP_Dmg = GetConVar("sk_npc_dmg_rpg_round"):GetInt() or 0
					
					local TEMP_Rocket = ents.Create( "rpg_missile" )
					TEMP_Rocket:SetPos( wep:GetPos()+(TEMP_Fwd*40) )
					TEMP_Rocket:SetAngles( TEMP_Fwd:Angle() )
					TEMP_Rocket.FlyAngle = TEMP_Fwd:Angle()
					TEMP_Rocket:Spawn()
					
					if(IsValid(TEMP_Rocket)) then
						TEMP_Rocket:SetSaveValue("m_flDamage",TEMP_Dmg)
						TEMP_Rocket:SetSaveValue("m_flRadius",100)
						TEMP_Rocket:SetOwner( self )
						TEMP_Rocket:SetSaveValue("m_hOwner",wep)
						constraint.NoCollide(TEMP_Rocket,wep)
						
						TEMP_Rocket:SetVelocity(TEMP_Fwd*1000)
					end
				elseif(wep:GetClass()=="mexican_chaingun") then
					wep.NextBurerShoot = CurTime()+wep.Primary.Delay
					
					TEMP_Disp = wep.Primary.Cone
					TEMP_Dmg = wep.Primary.Damage
					TEMP_DmgType = DMG_BULLET
					TEMP_Tracer = wep.Primary.Tracer
					TEMP_Sound = "weapons/z6_fire.wav"
					TEMP_Shoots = 1
				elseif(wep:GetClass()=="weapon_hpwr_stick") then
					TEMP_IsBulletWeapon = false
					TEMP_RemoveClip = false
					TEMP_Clip = 0
					
					local TEMP_Spells = {"Avada kedavra", "Mostro", "Secare", "Perfectium", "Dwisp", "Expelliarmus",
					"Def", "Dragoner", "Gonfiare", "Deletrius", "Winborium"} 
					
					local TEMP_RandSpell = HpwRewrite:GetSpells()[TEMP_Spells[math.random(1,#TEMP_Spells)]]
					
					TEMP_RandSpell.Owner = self
					
					if(TEMP_RandSpell) then
						local TEMP_Spell = ents.Create( "entity_hpwand_flyingspell" )
						TEMP_Spell:SetPos( wep:GetPos()+(TEMP_Fwd*10) )
						TEMP_Spell:SetAngles( TEMP_Fwd:Angle() )
						TEMP_Spell:SetFlyDirection(TEMP_Fwd)
						TEMP_Spell:SetSpellData(TEMP_RandSpell)
						TEMP_Spell:SetupOwner(self)
						TEMP_Spell:Spawn()
						
						TEMP_Spell:SetOwner(self)
						TEMP_Spell.Owner = self
						
						TEMP_Sound = "hpwrewrite/wand/maincast.wav"
						
						wep.NextBurerShoot = CurTime()+1
					else
						TEMP_Sound = ""
					end

				elseif(wep:GetClass()=="gmod_tool") then
					wep.NextBurerShoot = CurTime()+0.5
					
					TEMP_IsBulletWeapon = false
					TEMP_RemoveClip = false
					TEMP_Clip = 0

					TEMP_Sound = "Airboat.FireGunRevDown"
					
					bullet = {}
					bullet.Attacker=self
					bullet.Damage=0//999999
					bullet.Dir=TEMP_Fwd
					bullet.Spread=Vector(0,0,0)
					bullet.Tracer=1	
					bullet.Force=2
					bullet.HullSize = 2
					bullet.Num = 1
					bullet.TracerName = "ToolTracer"
					bullet.Src = TEMP_FPos 
					bullet.IgnoreEntity = wep
					bullet.Callback = function(ent,tr,dmginf)
						if(IsValid(tr.Entity)) then
							if(tr.Entity:IsPlayer()||tr.Entity:IsNPC()||GetConVar("stalker_npc_burer_toolgun_limit"):GetInt()==0) then
								if(!tr.Entity:IsPlayer()) then
									
									constraint.RemoveAll( tr.Entity )
									
									tr.Entity:SetNotSolid( true )
									tr.Entity:SetMoveType( MOVETYPE_NONE )
									tr.Entity:SetSolid(SOLID_NONE)
									
									if(tr.Entity:IsNPC()) then
										tr.Entity:SetNPCState( NPC_STATE_DEAD )
										tr.Entity:SetCondition(67)
										
										if(IsValid(tr.Entity:GetActiveWeapon())) then
											tr.Entity:GetActiveWeapon():SetNoDraw( true )
										end
									end
									
									tr.Entity:SetNoDraw( true )
									
									tr.Entity:Fire("kill","",1)
								else
									tr.Entity:KillSilent()
								end
								
								local TEMP_CEffectData = EffectData()
								TEMP_CEffectData:SetOrigin(tr.Entity:GetPos())
								TEMP_CEffectData:SetEntity(tr.Entity)
								util.Effect( "entity_remove", TEMP_CEffectData, true, true )
							end
						end
					end
					wep:FireBullets(bullet)
				end
			end
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			if(TEMP_IsBulletWeapon==true) then
				if(!isnumber(TEMP_Radius)) then
					TEMP_Radius = 1
				end
				
				if(!isnumber(TEMP_DmgType)) then
					TEMP_DmgType = DMG_BULLET
				end
				
				if(!isstring(TEMP_Tracer)) then
					TEMP_Tracer = "Tracer"
				end
				
				if(!isnumber(TEMP_Disp)) then
					TEMP_Disp = 0.05
				end
				
				if(!isnumber(TEMP_Dmg)) then
					TEMP_Dmg = 5
				end
				
				if(!isstring(TEMP_Sound)) then
					TEMP_Sound = "Weapon_AR2.Single"
				end
				
				if(!isnumber(TEMP_Shoots)) then
					TEMP_Shoots = 1
				end
				
				
				if(!isbool(TEMP_IsBulletWeapon)) then
					TEMP_IsBulletWeapon = true
				end
				
				if(!isbool(TEMP_RemoveClip)) then
					TEMP_RemoveClip = true
				end
				
				if(!isnumber(TEMP_Clip)) then
					TEMP_Clip = 1
				end
				
				if(!isnumber(TEMP_AmmoConsuming)) then
					TEMP_AmmoConsuming = 1
				end
				
				if(!isstring(TEMP_Muzzle)) then
					TEMP_Muzzle = "MuzzleFlash"
				end
				
				if(!isvector(TEMP_Fwd)) then
					TEMP_Fwd = -wep:GetForward()
				end
				

				
				if(TEMP_Shoots==nil) then
					TEMP_Shoots =  1
				end
				
				if(TEMP_ShootMethod==0) then
					bullet = {}
					bullet.Attacker=self
					bullet.Damage=TEMP_Dmg
					bullet.Dir=TEMP_Fwd
					bullet.Spread=Vector(TEMP_Disp,TEMP_Disp,TEMP_Disp)
					bullet.Tracer=1	
					bullet.Force=2
					bullet.HullSize = TEMP_Radius
					bullet.Num = TEMP_Shoots
					bullet.TracerName = TEMP_Tracer
					bullet.Src = TEMP_FPos 
					bullet.IgnoreEntity = wep
					bullet.Callback = function(ent,tr,dmginf)
						if(IsValid(tr.Entity)&&tr.Entity:GetClass()==self:GetClass()) then
							dmginf:SetDamage(0)
						end
						
						dmginf:SetDamageType(TEMP_DmgType)
					end
					wep:FireBullets(bullet)
				else
					for S=1, TEMP_Shoots do
						local TEMP_Dir = (TEMP_Fwd+Vector(math.Rand(-TEMP_Disp,TEMP_Disp),math.Rand(-TEMP_Disp,TEMP_Disp),math.Rand(-TEMP_Disp,TEMP_Disp))):GetNormalized()
							
						
						local TEMP_Tr = util.TraceLine( {
							start = TEMP_FPos,
							endpos = TEMP_FPos+(TEMP_Dir*10000),
							filter = {wep,self}
						} )
						
						if(TEMP_Tr.Hit==true) then
							if(TEMP_Radius>10) then
								util.BlastDamage( wep, self, TEMP_Tr.HitPos, TEMP_Radius, TEMP_Dmg )
							end
							
							if(IsValid(TEMP_Tr.Entity)) then
								local TEMP_DMGINF = DamageInfo()
								TEMP_DMGINF:SetDamage(TEMP_Dmg)
								TEMP_DMGINF:SetInflictor(wep)
								TEMP_DMGINF:SetAttacker(self)
								TEMP_DMGINF:SetDamageType(TEMP_DmgType)
								TEMP_DMGINF:SetDamageForce(TEMP_Dir*100)
								TEMP_Tr.Entity:TakeDamageInfo(TEMP_DMGINF)
							else
								util.Decal( "Impact.Concrete", TEMP_Tr.HitPos, TEMP_Tr.HitPos+(TEMP_Dir*5), wep )
							end
						end
							
						local TEMP_CEffectData = EffectData()
						TEMP_CEffectData:SetStart(TEMP_FPos)
						TEMP_CEffectData:SetOrigin(TEMP_Tr.HitPos)
						TEMP_CEffectData:SetEntity(wep)
						TEMP_CEffectData:SetScale(5000)
						TEMP_CEffectData:SetAngles(wep:GetAngles())
						util.Effect( TEMP_Tracer, TEMP_CEffectData, false, true )
					end
					
				end
				
				local TEMP_CEffectData = EffectData()
				TEMP_CEffectData:SetStart(TEMP_FPos)
				TEMP_CEffectData:SetOrigin(TEMP_FPos)
				TEMP_CEffectData:SetEntity(wep)
				TEMP_CEffectData:SetAngles(wep:GetAngles())
				util.Effect( TEMP_Muzzle, TEMP_CEffectData, false, true )
			end
			
			if(TEMP_RemoveClip==true) then
				if(TEMP_Clip==1) then
					wep:SetClip1(math.max(0,wep:Clip1()-TEMP_AmmoConsuming))
				else
					wep:SetClip2(math.max(0,wep:Clip2()-TEMP_AmmoConsuming))
				end
			else
				if(TEMP_Clip==1) then
					wep:SetSaveValue("m_iPrimaryAmmoCount",math.max(0,wep:GetSaveTable().m_iPrimaryAmmoCount-TEMP_AmmoConsuming))
				elseif(TEMP_Clip==2) then
					wep:SetSaveValue("m_iSecondaryAmmoCount",math.max(0,wep:GetSaveTable().m_iSecondaryAmmoCount-TEMP_AmmoConsuming))
				end
			end
			
			wep:EmitSound(TEMP_Sound)
		end
	end
end





function ENT:BurerShield()
	self:STALKERNPCPlayAnimation("S_Shield_Start",1)
			
	timer.Create("Attack"..tostring(self).."1",0.4,1,function()
		if(IsValid(self)&&self!=nil&&self!=NULL) then
			self.MustShield = CurTime()+3
			self.ShieldStartTime = CurTime()
			self:STALKERNPCPlayAnimation("S_Shield_Idle",1)
		end
	end)
end






function ENT:STALKERNPCThinkEnemyValid()
	
end

function ENT:STALKERNPCThink()
	if(self.Animation=="S_Shield_Idle"&&self.MustShield<CurTime()) then
		self:STALKERNPCPlayAnimation("S_Shield_End",1)
		self.CanShield = CurTime()+6
		self.MustShield = 0
		
		timer.Create("Attack"..tostring(self).."3",0.4,1,function()
			if(IsValid(self)&&self!=nil&&self!=NULL) then
				self:STALKERNPCStopAllTimers()
				self:STALKERNPCClearAnimation()
			end
		end)
	end
end

function ENT:STALKERNPCSelectMeleeAttack()
	if(self.MustShield>CurTime()) then
		self:BurerShield()
		return -1
	end
end




function ENT:STALKERNPCDistanceForMeleeTooBig() 
	if(self.MustShield>CurTime()&&self.PlayingAnimation==false) then
		self:BurerShield()
	end
	
	if(self.NextAbilityTime<CurTime()) then
		if(self.PlayingAnimation==false) then
			local TEMP_Rand = math.random(1,4)
			
			if(TEMP_Rand==1) then
				local TEMP_EnemySupportCollisions = true
				
				if(self:GetEnemy():GetCollisionGroup()==COLLISION_GROUP_DEBRIS||
				self:GetEnemy():GetCollisionGroup()==COLLISION_GROUP_DEBRIS_TRIGGER||
				self:GetEnemy():GetCollisionGroup()==COLLISION_GROUP_VEHICLE_CLIP||
				self:GetEnemy():GetCollisionGroup()==COLLISION_GROUP_DISSOLVING||
				self:GetEnemy():GetCollisionGroup()==COLLISION_GROUP_PUSHAWAY||
				self:GetEnemy():GetCollisionGroup()==COLLISION_GROUP_WORLD||
				self:GetEnemy():GetSolid()==SOLID_NONE||self:GetEnemy():IsEFlagSet(EFL_NO_DAMAGE_FORCES)||
				(IsValid(self:GetEnemy():GetPhysicsObject())&&self:GetEnemy():GetPhysicsObject():IsCollisionEnabled()==false)) then
					TEMP_EnemySupportCollisions = false
				end
				
				if(TEMP_EnemySupportCollisions==false) then return end
				
				if(self.CanTele<CurTime()) then
					local TEMP_Props = ents.FindInSphere(self:GetPos(),2500)
					
					local TEMP_PropDist = 2500
					local TEMP_Prop = nil
					local TEMP_ThrowProps = {}
					local TEMP_Grenades = {}
					
					
					
					if(#TEMP_Props>0) then
						for P=1,#TEMP_Props do
								
							if(TEMP_Props[P]:Visible(self)&&TEMP_Props[P]:Visible(self:GetEnemy())&&
							!IsValid(TEMP_Props[P]:GetParent())&&
							(!isnumber(TEMP_Props[P].GrabbedByBurer)||TEMP_Props[P].GrabbedByBurer<CurTime())&&
							(IsValid(TEMP_Props[P]:GetPhysicsObject())||TEMP_Props[P]:GetClass()=="crossbow_bolt"||
							TEMP_Props[P]:GetClass()=="grenade_ar2")) then
								local TEMP_ConstraintsAllow = true

								if(constraint.HasConstraints(TEMP_Props[P])) then
									if(self.ConstraintRemoveMode==0) then
										TEMP_ConstraintsAllow = false
									elseif(self.ConstraintRemoveMode==1) then
										local TEMP_Cnstr = constraint.FindConstraints(TEMP_Props[P])
										
										for C=1, #TEMP_Cnstr do
											if(!(TEMP_Cnstr[C].Type=="Rope"||TEMP_Cnstr[C].Type=="Winch"||
											TEMP_Cnstr[C].Type=="NoCollide")) then
												TEMP_ConstraintsAllow = false
											end
										end
									elseif(self.ConstraintRemoveMode==2) then
										if(istable(constraint.FindConstraint(TEMP_Props[P],"Weld"))) then
											TEMP_ConstraintsAllow = false
										end
									end
								end
								
								if(TEMP_ConstraintsAllow==true) then
									if(!IsValid(TEMP_Props[P]:GetParent())&&
									(((TEMP_Props[P]:GetClass()=="prop_physics"&&TEMP_Props[P]:GetPhysicsObject():GetMass()>1&&
									TEMP_Props[P]:GetSolid()==SOLID_VPHYSICS)||
									TEMP_Props[P]:GetClass()=="prop_combine_ball"||
									TEMP_Props[P]:GetClass()=="cup_flame")&&
									TEMP_Props[P]:GetPhysicsObject():GetMass()<self.MaxGrabMass&&
									TEMP_Props[P]:GetPhysicsObject():IsCollisionEnabled()==true&&
									TEMP_Props[P]:GetCollisionGroup()!=COLLISION_GROUP_DEBRIS&&
									TEMP_Props[P]:GetCollisionGroup()!=COLLISION_GROUP_DEBRIS_TRIGGER&&
									TEMP_Props[P]:GetCollisionGroup()!=COLLISION_GROUP_VEHICLE_CLIP&&
									TEMP_Props[P]:GetCollisionGroup()!=COLLISION_GROUP_DISSOLVING&&
									TEMP_Props[P]:GetCollisionGroup()!=COLLISION_GROUP_PUSHAWAY&&
									TEMP_Props[P]:GetCollisionGroup()!=COLLISION_GROUP_WORLD&&
									TEMP_Props[P]:GetCollisionGroup()!=COLLISION_GROUP_WEAPON&&
									TEMP_Props[P]:GetCollisionGroup()!=COLLISION_GROUP_PROJECTILE&&
									!TEMP_Props[P]:GetPhysicsObject():HasGameFlag(FVPHYSICS_NO_IMPACT_DMG)&&
									!TEMP_Props[P]:GetPhysicsObject():HasGameFlag(FVPHYSICS_NO_NPC_IMPACT_DMG))||
									TEMP_Props[P]:GetClass()=="crossbow_bolt"||TEMP_Props[P]:GetClass()=="grenade_ar2") then
										
										if(TEMP_Props[P]:GetPos():Distance(self:GetPos())>80) then
											if(TEMP_Props[P]:GetPos():Distance(self:GetEnemy():GetPos())<3000) then
												if(#TEMP_ThrowProps<self.MaxGrabs-1) then
													table.insert(TEMP_ThrowProps,TEMP_Props[P])
												end
											end
											
											if(TEMP_Props[P]:GetPos():Distance(self:GetEnemy():GetPos())<TEMP_PropDist) then
												TEMP_Prop = TEMP_Props[P]
												TEMP_PropDist = TEMP_Props[P]:GetPos():Distance(self:GetEnemy():GetPos())
											end
										end
									elseif(TEMP_Props[P]:GetClass()=="npc_grenade_frag"||
									TEMP_Props[P]:GetClass()=="obj_vj_grenade"||
									TEMP_Props[P]:GetClass()=="sent_uh_grenade"||
									TEMP_Props[P]:GetClass()=="m9k_thrown_m61"||
									TEMP_Props[P]:GetClass()=="tfa_exp_timed"||
									TEMP_Props[P]:GetClass()=="tfa_exp_contact"||
									TEMP_Props[P]:GetClass()=="cup_smoke") then
										table.insert(TEMP_Grenades,TEMP_Props[P])
									end
								end
							end
						end
						
						if(#TEMP_Grenades>0) then
							for G=1, #TEMP_Grenades do
								TEMP_Grenades[G].GrabbedByBurer = CurTime()+4
								TEMP_Grenades[G]:SetSaveValue("m_hThrower",self)
								TEMP_Grenades[G]:SetSaveValue("m_hSpawner",self)
								TEMP_Grenades[G]:SetOwner(self)
								TEMP_Grenades[G]:GetPhysicsObject():SetVelocity(Vector(0,0,0))
								
								local TEMP_DetonateTime = 1
								
								if(TEMP_Grenades[G]:GetClass()=="npc_grenade_frag") then
									TEMP_DetonateTime = TEMP_Grenades[G]:GetSaveTable().m_flDetonateTime
								elseif(TEMP_Grenades[G]:GetClass()=="sent_uh_grenade") then
									TEMP_DetonateTime = TEMP_Grenades[G].SplodeTime-CurTime()
								elseif(TEMP_Grenades[G]:GetClass()=="m9k_thrown_m61") then
									TEMP_DetonateTime = TEMP_Grenades[G].timeleft-CurTime()
								elseif(TEMP_Grenades[G]:GetClass()=="tfa_exp_timed"||
								TEMP_Grenades[G]:GetClass()=="tfa_exp_contact") then
									TEMP_DetonateTime = self.killtime-CurTime()
								elseif(TEMP_Grenades[G]:GetClass()=="obj_vj_grenade") then
									TEMP_DetonateTime = (TEMP_Grenades[G]:GetCreationTime()+TEMP_Grenades[G].FussTime)-CurTime()
								elseif(TEMP_Grenades[G]:GetClass()=="cup_smoke") then
									TEMP_DetonateTime = 1
								end
								
								if(TEMP_DetonateTime>1) then
									TEMP_DetonateTime = 1
								end

								TEMP_Grenades[G]:GetPhysicsObject():ApplyForceCenter((TEMP_Grenades[G]:GetPhysicsObject():GetMass()*
								((self:GetEnemy():GetPos()+self:GetEnemy():OBBCenter())-TEMP_Grenades[G]:GetPhysicsObject():GetPos()))
								/TEMP_DetonateTime)
							end
							
							if(TEMP_Prop==nil) then
								self:STALKERNPCPlaySoundRandom(100,"Stalker.Burer.Tele",1,1)
											
								self:STALKERNPCPlayAnimation("S_Tele_End",1)	
								
								timer.Create("Attack"..tostring(self).."4",1.2,1,function()
									if(IsValid(self)&&self!=nil&&self!=NULL) then
										self:STALKERNPCStopAllTimers()
										self:STALKERNPCClearAnimation()
										self.NextAbilityTime = CurTime()+self.AbilityIntervals
									end
								end)
							end
						end
					
						if(TEMP_Prop!=nil) then
							if(TEMP_ThrowProps[#TEMP_ThrowProps]!=TEMP_Prop) then
								table.insert(TEMP_ThrowProps,TEMP_Prop)
							end
							
							local TEMP_ThrowTime = 1.2
							self.CanTele = CurTime()+7
							
							
							for P=1, #TEMP_ThrowProps do
								if(TEMP_ThrowProps[P]:GetClass()=="prop_combine_ball"||
								TEMP_ThrowProps[P]:GetClass()=="npc_grenade_frag"||
								TEMP_ThrowProps[P]:GetClass()=="crossbow_bolt"||
								TEMP_ThrowProps[P]:GetClass()=="grenade_ar2"||
								TEMP_ThrowProps[P]:GetClass()=="cup_flame") then
									TEMP_ThrowProps[P]:SetOwner(self)
									TEMP_ThrowProps[P]:SetSaveValue("m_hSpawner",self)
									
									if(TEMP_ThrowProps[P]:GetClass()=="crossbow_bolt"||
									TEMP_ThrowProps[P]:GetClass()=="grenade_ar2") then
										TEMP_ThrowProps[P]:SetLocalVelocity(Vector(0,0,0))
									else
										if(TEMP_ThrowProps[P]:GetClass()=="npc_grenade_frag") then
											TEMP_ThrowProps[P]:SetSaveValue("m_hThrower",self)
										end
										
										TEMP_ThrowProps[P]:GetPhysicsObject():SetVelocity(Vector(0,0,0))
									end
								end
							end
						
							
							
							
							self:STALKERNPCPlayAnimation("S_Tele_Start",1)	
						
							
							timer.Create("Attack"..tostring(self).."2",0.8,1,function()
								if(IsValid(self)&&self!=nil&&self!=NULL) then
									self:STALKERNPCPlayAnimation("S_Tele_Idle",1)	
								end
							end)
							
							
							timer.Create("Attack"..tostring(self).."1",0.05,0,function()
								if(IsValid(self)&&self!=nil&&self!=NULL) then
									local TEMP_FailedProps = 0
									
									if(IsValid(self:GetEnemy())&&self:GetEnemy()!=NULL) then
										for P=1, #TEMP_ThrowProps do
											if(IsValid(TEMP_ThrowProps[P])&&TEMP_ThrowProps[P]!=NULL&&self:Visible(TEMP_ThrowProps[P])) then
												if((IsValid(TEMP_ThrowProps[P]:GetPhysicsObject())&&
												(((TEMP_ThrowProps[P]:GetClass()=="prop_physics"||
												TEMP_ThrowProps[P]:GetClass()=="prop_combine_ball"||
												TEMP_ThrowProps[P]:GetClass()=="cup_flame")&&
												TEMP_ThrowProps[P]:GetPhysicsObject():GetMass()>1))&&
												TEMP_ThrowProps[P]:GetPhysicsObject():GetMass()<self.MaxGrabMass)||
												TEMP_ThrowProps[P]:GetClass()=="crossbow_bolt"||
												TEMP_ThrowProps[P]:GetClass()=="grenade_ar2") then
													TEMP_ThrowProps[P].GrabbedByBurer = CurTime()+5
													
													if(constraint.HasConstraints(TEMP_ThrowProps[P])) then
														constraint.RemoveAll(TEMP_ThrowProps[P])
													end
													
													if(TEMP_ThrowProps[P]:GetClass()=="crossbow_bolt"||
													TEMP_ThrowProps[P]:GetClass()=="grenade_ar2") then
														TEMP_ThrowProps[P]:SetLocalVelocity(Vector(0,0,((self:GetEnemy():GetPos()+self:GetEnemy():OBBCenter()+Vector(0,0,150))-TEMP_ThrowProps[P]:GetPos()).Z):GetNormalized()*150)
													else
														if(TEMP_ThrowProps[P]:GetPhysicsObject():IsMotionEnabled()==false) then
															TEMP_ThrowProps[P]:GetPhysicsObject():EnableMotion(true)
														end
														TEMP_ThrowProps[P]:GetPhysicsObject():ApplyForceCenter((TEMP_ThrowProps[P]:GetPhysicsObject():GetMass()/2)*
														Vector(0,0,((self:GetEnemy():GetPos()+self:GetEnemy():OBBCenter()+Vector(0,0,200))-TEMP_ThrowProps[P]:GetPhysicsObject():GetPos()).Z))
													end
												else
													TEMP_FailedProps = TEMP_FailedProps+1
												end
											else
												TEMP_FailedProps = TEMP_FailedProps+1
											end
										end
									else
										TEMP_FailedProps = #TEMP_ThrowProps
									end
									
									if(TEMP_FailedProps==#TEMP_ThrowProps) then
										self:STALKERNPCPlayAnimation("S_Tele_Fail",1)	
										self:STALKERNPCStopAllTimers()
										
										for P=1, #TEMP_ThrowProps do
											if(IsValid(TEMP_ThrowProps[P])) then
												TEMP_ThrowProps[P].GrabbedByBurer = 0
											end
										end
										
										timer.Create("Attack"..tostring(self).."4",0.3,1,function()
											if(IsValid(self)&&self!=nil&&self!=NULL) then
												self:STALKERNPCStopAllTimers()
												self:STALKERNPCClearAnimation()
												self.NextAbilityTime = CurTime()+self.AbilityIntervals
											end
										end)
									end
								end
							end)
							
							timer.Create("Attack"..tostring(self).."3",TEMP_ThrowTime,1,function()
								if(IsValid(self)&&self!=nil&&self!=NULL) then
									self:STALKERNPCStopAllTimers()
									
									local TEMP_FailedProps = 0
									
									if(IsValid(self:GetEnemy())&&self:GetEnemy()!=NULL) then
										for P=1, #TEMP_ThrowProps do
											if(IsValid(TEMP_ThrowProps[P])&&TEMP_ThrowProps[P]!=NULL&&self:Visible(TEMP_ThrowProps[P])) then
												if((IsValid(TEMP_ThrowProps[P]:GetPhysicsObject())&&
												(((TEMP_ThrowProps[P]:GetClass()=="prop_physics"||
												TEMP_ThrowProps[P]:GetClass()=="prop_combine_ball"||
												TEMP_ThrowProps[P]:GetClass()=="cup_flame")&&
												TEMP_ThrowProps[P]:GetPhysicsObject():GetMass()>1))&&
												TEMP_ThrowProps[P]:GetPhysicsObject():GetMass()<self.MaxGrabMass)||
												TEMP_ThrowProps[P]:GetClass()=="crossbow_bolt"||
												TEMP_ThrowProps[P]:GetClass()=="grenade_ar2") then
													local TEMP_Ang1 = (self:GetEnemy():GetPos()-TEMP_ThrowProps[P]:GetPos()):Angle()
													local TEMP_Ang2 = (self:GetPos()-TEMP_ThrowProps[P]:GetPos()):Angle()
													

													if(math.abs(math.NormalizeAngle(TEMP_Ang1.Yaw-TEMP_Ang2.Yaw))>10||
													math.abs(math.NormalizeAngle(TEMP_Ang1.Pitch-TEMP_Ang2.Pitch))>20) then
														if(TEMP_ThrowProps[P]:GetClass()=="crossbow_bolt"||
														TEMP_ThrowProps[P]:GetClass()=="grenade_ar2") then
															TEMP_ThrowProps[P]:SetLocalVelocity(((self:GetEnemy():GetPos()+self:GetEnemy():OBBCenter())-TEMP_ThrowProps[P]:GetPos()):GetNormalized()*2500)
														else
															if(TEMP_ThrowProps[P]:GetPhysicsObject():IsMotionEnabled()==false) then
																TEMP_ThrowProps[P]:GetPhysicsObject():EnableMotion(true)
															end
															local TEMP_PosDiff = ((self:GetEnemy():GetPos()+self:GetEnemy():OBBCenter())-TEMP_ThrowProps[P]:GetPhysicsObject():GetPos())
															
															TEMP_ThrowProps[P]:GetPhysicsObject():ApplyForceCenter(TEMP_ThrowProps[P]:GetPhysicsObject():GetMass()*
															(TEMP_PosDiff:GetNormalized()*math.max(1000,TEMP_PosDiff:Length())*35))
														end
													else
														TEMP_FailedProps = TEMP_FailedProps+1
													end
												else
													TEMP_FailedProps = TEMP_FailedProps+1
												end
											else
												TEMP_FailedProps = TEMP_FailedProps+1
											end
										end
										
										for P=1, #TEMP_ThrowProps do
											if(IsValid(TEMP_ThrowProps[P])) then
												TEMP_ThrowProps[P].GrabbedByBurer = CurTime()+2
											end
										end
									else
										TEMP_FailedProps = #TEMP_ThrowProps
									end
									
									if(TEMP_FailedProps<#TEMP_ThrowProps) then
										self:STALKERNPCPlaySoundRandom(100,"Stalker.Burer.Tele",1,1)
										
										self:STALKERNPCPlayAnimation("S_Tele_End",1)	
										
										timer.Create("Attack"..tostring(self).."4",1.2,1,function()
											if(IsValid(self)&&self!=nil&&self!=NULL) then
												self:STALKERNPCStopAllTimers()
												self:STALKERNPCClearAnimation()
												self.NextAbilityTime = CurTime()+0.5
											end
										end)
									else
										self:STALKERNPCPlayAnimation("S_Tele_Fail",1)	
										
										timer.Create("Attack"..tostring(self).."4",0.3,1,function()
											if(IsValid(self)&&self!=nil&&self!=NULL) then
												self:STALKERNPCStopAllTimers()
												self:STALKERNPCClearAnimation()
												self.NextAbilityTime = CurTime()+self.AbilityIntervals
											end
										end)
									end
								end
							end)
						else
							self.CanTele = CurTime()+0.5
						end
					end
				end
			elseif(TEMP_Rand==2) then
				if(self.CanTele<CurTime()) then
					local TEMP_Weps = ents.FindInSphere(self:GetPos(),2000)
					
					local TEMP_WepDist = 5000
					local TEMP_Wep = nil
					local TEMP_GrabbedWeps = {}
					local TEMP_Grenades = {}
					
					
					
					if(#TEMP_Weps>0) then
						for P=1,#TEMP_Weps do
								
							if(TEMP_Weps[P]:Visible(self)&&TEMP_Weps[P]:Visible(self:GetEnemy())&&
							!IsValid(TEMP_Weps[P]:GetParent())&&
							(!isnumber(TEMP_Weps[P].GrabbedByBurer)||TEMP_Weps[P].GrabbedByBurer<CurTime())&&
							TEMP_Weps[P]:GetMoveType()==MOVETYPE_VPHYSICS&&IsValid(TEMP_Weps[P]:GetPhysicsObject())) then
								if(TEMP_Weps[P]:IsWeapon()&&BurerCanWeaponShoot(self,TEMP_Weps[P])) then
									local TEMP_ConstraintsAllow = true
									
									if(constraint.HasConstraints(TEMP_Weps[P])) then
										if(self.ConstraintRemoveMode==0) then
											TEMP_ConstraintsAllow = false
										elseif(self.ConstraintRemoveMode==1) then
											local TEMP_Cnstr = constraint.FindConstraints(TEMP_Weps[P])
											
											for C=1, #TEMP_Cnstr do
												if(!(TEMP_Cnstr[C].Type=="Rope"||TEMP_Cnstr[C].Type=="Winch"||
												TEMP_Cnstr[C].Type=="NoCollide")) then
													TEMP_ConstraintsAllow = false
												end
											end
										elseif(self.ConstraintRemoveMode==2) then
											if(istable(constraint.FindConstraint(TEMP_Weps[P],"Weld"))) then
												TEMP_ConstraintsAllow = false
											end
										end
									end
									
									if(TEMP_ConstraintsAllow==true) then
										if(TEMP_Weps[P]:GetPos():Distance(self:GetPos())>30) then
											if(TEMP_Weps[P]:GetPos():Distance(self:GetEnemy():GetPos())<3000) then
												if(#TEMP_GrabbedWeps<self.MaxGrabs-1) then
													table.insert(TEMP_GrabbedWeps,TEMP_Weps[P])
												end
											end
											
											if(TEMP_Weps[P]:GetPos():Distance(self:GetEnemy():GetPos())<TEMP_WepDist) then
												TEMP_Wep = TEMP_Weps[P]
												TEMP_WepDist = TEMP_Weps[P]:GetPos():Distance(self:GetEnemy():GetPos())
											end
										end
									end
								elseif(TEMP_Weps[P]:GetClass()=="npc_grenade_frag"||
								TEMP_Weps[P]:GetClass()=="obj_vj_grenade"||
								TEMP_Weps[P]:GetClass()=="sent_uh_grenade"||
								TEMP_Weps[P]:GetClass()=="m9k_thrown_m61"||
								TEMP_Weps[P]:GetClass()=="tfa_exp_timed"||
								TEMP_Weps[P]:GetClass()=="tfa_exp_contact"||
								TEMP_Weps[P]:GetClass()=="cup_smoke") then
									table.insert(TEMP_Grenades,TEMP_Weps[P])
								end
							end
						end
						
						if(#TEMP_Grenades>0) then
							for G=1, #TEMP_Grenades do
								TEMP_Grenades[G].GrabbedByBurer = CurTime()+4
								TEMP_Grenades[G]:SetSaveValue("m_hThrower",self)
								TEMP_Grenades[G]:SetSaveValue("m_hSpawner",self)
								TEMP_Grenades[G]:SetOwner(self)
								TEMP_Grenades[G]:GetPhysicsObject():SetVelocity(Vector(0,0,0))
								
								local TEMP_DetonateTime = 1
								
								if(TEMP_Grenades[G]:GetClass()=="npc_grenade_frag") then
									TEMP_DetonateTime = TEMP_Grenades[G]:GetSaveTable().m_flDetonateTime
								elseif(TEMP_Grenades[G]:GetClass()=="sent_uh_grenade") then
									TEMP_DetonateTime = TEMP_Grenades[G].SplodeTime-CurTime()
								elseif(TEMP_Grenades[G]:GetClass()=="m9k_thrown_m61") then
									TEMP_DetonateTime = TEMP_Grenades[G].timeleft-CurTime()
								elseif(TEMP_Grenades[G]:GetClass()=="tfa_exp_timed"||
								TEMP_Grenades[G]:GetClass()=="tfa_exp_contact") then
									TEMP_DetonateTime = self.killtime-CurTime()
								elseif(TEMP_Grenades[G]:GetClass()=="obj_vj_grenade") then
									TEMP_DetonateTime = (TEMP_Grenades[G]:GetCreationTime()+TEMP_Grenades[G].FussTime)-CurTime()
								elseif(TEMP_Grenades[G]:GetClass()=="cup_smoke") then
									TEMP_DetonateTime = 1
								end
								
								if(TEMP_DetonateTime>1) then
									TEMP_DetonateTime = 1
								end

								TEMP_Grenades[G]:GetPhysicsObject():ApplyForceCenter((TEMP_Grenades[G]:GetPhysicsObject():GetMass()*
								((self:GetEnemy():GetPos()+self:GetEnemy():OBBCenter())-TEMP_Grenades[G]:GetPhysicsObject():GetPos()))
								/TEMP_DetonateTime)
							end
						end
					
						if(TEMP_Wep!=nil) then
							self.MustStopShooting = CurTime()+5 
							
							if(TEMP_GrabbedWeps[#TEMP_GrabbedWeps]!=TEMP_Wep) then
								table.insert(TEMP_GrabbedWeps,TEMP_Wep)
							end
							
							self.CanTele = CurTime()+8
							
							
							
							self:STALKERNPCPlayAnimation("S_Tele_Start",1)	
						
							
							timer.Create("Attack"..tostring(self).."2",0.8,1,function()
								if(IsValid(self)&&self!=nil&&self!=NULL) then
									self:STALKERNPCPlayAnimation("S_Tele_Idle",1)	
								end
							end)
							
							local TEMP_Timers = 0
							
							timer.Create("Attack"..tostring(self).."1",0.05,0,function()
								if(IsValid(self)&&self!=nil&&self!=NULL) then
									TEMP_Timers = TEMP_Timers+1
									
									local TEMP_FailedProps = 0
									
									if(IsValid(self:GetEnemy())&&self:GetEnemy()!=NULL) then
										for P=1, #TEMP_GrabbedWeps do
											if(IsValid(TEMP_GrabbedWeps[P])&&TEMP_GrabbedWeps[P]!=NULL) then
												if(TEMP_GrabbedWeps[P]:Visible(self)&&TEMP_GrabbedWeps[P]:Visible(self:GetEnemy())&&
												TEMP_GrabbedWeps[P]:IsWeapon()&&BurerCanWeaponShoot(self,TEMP_GrabbedWeps[P])&&
												TEMP_GrabbedWeps[P]:GetMoveType()==MOVETYPE_VPHYSICS&&
												IsValid(TEMP_GrabbedWeps[P]:GetPhysicsObject())&&
												(TEMP_GrabbedWeps[P]:GetClass()=="weapon_rpg"&&
												(self:GetEnemy():GetPos()+self:GetEnemy():OBBCenter()):Distance(self:GetPos()+
												self:OBBCenter())<150)==false) then
													if(constraint.HasConstraints(TEMP_GrabbedWeps[P])) then
														constraint.RemoveAll(TEMP_GrabbedWeps[P])
													end
													
													if(TEMP_GrabbedWeps[P]:GetPhysicsObject():IsMotionEnabled()==false) then
														TEMP_GrabbedWeps[P]:GetPhysicsObject():EnableMotion(true)
													end
														
													TEMP_GrabbedWeps[P]:GetPhysicsObject():ApplyForceCenter((TEMP_GrabbedWeps[P]:GetPhysicsObject():GetMass()*0.9)*
													Vector(0,0,((self:GetEnemy():GetPos()+self:GetEnemy():OBBCenter()+Vector(0,0,60))-TEMP_GrabbedWeps[P]:GetPhysicsObject():GetPos()).Z))
													
													TEMP_GrabbedWeps[P].GrabbedByBurer = CurTime()+5
													
													local TEMP_AngToEn = ((self:GetEnemy():GetPos()+self:GetEnemy():OBBCenter())-
													TEMP_GrabbedWeps[P]:GetPos()):Angle()
													
													if(TEMP_GrabbedWeps[P]:GetClass()=="weapon_ar2"||TEMP_GrabbedWeps[P]:GetClass()=="weapon_pistol"||
													TEMP_GrabbedWeps[P]:GetClass()=="weapon_rpg"||TEMP_GrabbedWeps[P]:GetClass()=="weapon_shotgun") then
														TEMP_AngToEn:RotateAroundAxis(TEMP_AngToEn:Right(),180)
													end
													
													TEMP_AngToEn = TEMP_AngToEn-TEMP_GrabbedWeps[P]:GetAngles()
													
													local TEMP_NormAng = Angle(math.Clamp(math.NormalizeAngle(TEMP_AngToEn.Pitch),-20,20),
													math.Clamp(math.NormalizeAngle(TEMP_AngToEn.Yaw),-20,20),
													math.Clamp(math.NormalizeAngle(TEMP_AngToEn.Roll),-20,20))
													
													local TEMP_WEPVEL = TEMP_GrabbedWeps[P]:GetPhysicsObject():GetVelocity()
													TEMP_GrabbedWeps[P]:SetAngles(TEMP_GrabbedWeps[P]:GetAngles()+TEMP_NormAng)
													TEMP_GrabbedWeps[P]:GetPhysicsObject():AddAngleVelocity(-TEMP_GrabbedWeps[P]:GetPhysicsObject():GetAngleVelocity()/2)
													TEMP_GrabbedWeps[P]:GetPhysicsObject():SetVelocity(TEMP_WEPVEL)
													
													if((self.MustStopShooting<CurTime()&&isnumber(TEMP_GrabbedWeps[P].NextBurerShoot)&&TEMP_GrabbedWeps[P].NextBurerShoot<CurTime())==true) then
														TEMP_FailedProps = TEMP_FailedProps+1
													else
														if(TEMP_Timers>10) then
															self:BurerShoot(TEMP_GrabbedWeps[P])
														end
													end
												else
													TEMP_FailedProps = TEMP_FailedProps+1
												end
											else
												TEMP_FailedProps = TEMP_FailedProps+1
											end
										end
										
										
										if(TEMP_FailedProps==#TEMP_GrabbedWeps) then
											for P=1, #TEMP_GrabbedWeps do
												if(IsValid(TEMP_GrabbedWeps[P])) then
													TEMP_GrabbedWeps[P].GrabbedByBurer = 0
												end
											end
											
											self:STALKERNPCPlayAnimation("S_Tele_Fail",1)	
											self:STALKERNPCStopAllTimers()
											
											timer.Create("Attack"..tostring(self).."4",0.3,1,function()
												if(IsValid(self)&&self!=nil&&self!=NULL) then
													self:STALKERNPCStopAllTimers()
													self:STALKERNPCClearAnimation()
													self.NextAbilityTime = CurTime()+self.AbilityIntervals
												end
											end)
										end
									else
										self:STALKERNPCTryToFindEnemy(true)
										
										if(!IsValid(self:GetEnemy())||self:GetEnemy()==NULL) then
											TEMP_FailedProps = #TEMP_GrabbedWeps
										end
									end
									
									if(TEMP_FailedProps==#TEMP_GrabbedWeps) then
										for P=1, #TEMP_GrabbedWeps do
											if(IsValid(TEMP_GrabbedWeps[P])) then
												TEMP_GrabbedWeps[P].GrabbedByBurer = 0
											end
										end
										
										self:STALKERNPCPlayAnimation("S_Tele_Fail",1)	
										self:STALKERNPCStopAllTimers()
										
										timer.Create("Attack"..tostring(self).."4",0.3,1,function()
											if(IsValid(self)&&self!=nil&&self!=NULL) then
												self:STALKERNPCStopAllTimers()
												self:STALKERNPCClearAnimation()
												self.NextAbilityTime = CurTime()+self.AbilityIntervals
											end
										end)
									end
								end
							end)
							
							
						else
							self.CanTele = CurTime()+0.5
						end
					end
				end
			end
		end
		
		if(self.PlayingAnimation==false) then
			if(self.CanGrab<CurTime()) then
				local TEMP_Rand = math.random(1,5)
			
				if(TEMP_Rand==1) then
					if IsValid(self:GetEnemy():GetActiveWeapon()) and !self:GetEnemy():GetActiveWeapon():GetNoDraw() then
						if self.BlacklistedWeapons[self:GetEnemy():GetActiveWeapon():GetClass()] then return end
						if self:GetEnemy():GetActiveWeapon().Melee then return end
						local TEMP_Wep = self:GetEnemy():GetActiveWeapon()
						
						self.CanGrab = CurTime()+15
						
						self:STALKERNPCPlayAnimation("S_Stamina_Attack",1)
						
						timer.Create("Attack"..tostring(self).."1",0.4,1,function()
							if self and IsValid(self) then
								if self:GetEnemy() and self:GetEnemy():IsValid() and IsValid(self:GetEnemy():GetActiveWeapon()) and 
								!self:GetEnemy():GetActiveWeapon():GetNoDraw() then
									TEMP_Wep = self:GetEnemy():GetActiveWeapon()
									
									if(self:GetEnemy():IsPlayer()) then
										if(TEMP_Wep:GetClass()=="weapon_ar2"||TEMP_Wep:GetClass()=="weapon_smg1") then
											local TEMP_SecAmmo = TEMP_Wep:GetOwner():GetAmmoCount(TEMP_Wep:GetSaveTable().m_iSecondaryAmmoType)
											
											if(TEMP_SecAmmo>0) then
												TEMP_Wep:SetSaveValue("m_iSecondaryAmmoCount",1)
												TEMP_Wep:GetOwner():SetAmmo(TEMP_SecAmmo-1,TEMP_Wep:GetSaveTable().m_iSecondaryAmmoType)
											end
										end
										TEMP_Wep:GetOwner():ViewPunch(Angle(math.random(-1,1)*2,math.random(-1,1)*2,math.random(-1,1)*2))
										
										if(TEMP_Wep:GetClass()=="weapon_hpwr_stick"&&string.find(TEMP_Wep:GetModel(),"models/hpwrewrite/c_")) then
											local TEMP_Model = string.Replace(TEMP_Wep:GetModel(),"models/hpwrewrite/c_","models/hpwrewrite/w_")
											local TEMP_Ang = TEMP_Wep:GetAngles()
											local TEMP_Pos = self:GetEnemy():GetPos()+self:GetEnemy():OBBCenter()+Vector(0,0,10)
											
											
											
											self:GetEnemy():StripWeapon("weapon_hpwr_stick")
											
											TEMP_Wep = ents.Create("weapon_hpwr_stick")
											TEMP_Wep:SetModel(TEMP_Model)
											TEMP_Wep:SetAngles(TEMP_Ang)
											TEMP_Wep:SetPos(TEMP_Pos)
											TEMP_Wep:SetMoveType(MOVETYPE_VPHYSICS)
											TEMP_Wep:SetSolid(SOLID_VPHYSICS)
											TEMP_Wep:PhysicsInit(SOLID_VPHYSICS)
											TEMP_Wep:Spawn()
											
											TEMP_Wep:SetModel(TEMP_Model)
											TEMP_Wep:SetTrigger(false)
											
											timer.Simple(2,function()
												if(IsValid(TEMP_Wep)&&!IsValid(TEMP_Wep:GetParent())) then
													TEMP_Wep:SetTrigger(true)
												end
											end)
											
											if(IsValid(TEMP_Wep:GetPhysicsObject())) then
												TEMP_Wep:GetPhysicsObject():Wake()
												TEMP_Wep:GetPhysicsObject():EnableMotion(true)
											end
										else
											self:GetEnemy():DropWeapon(TEMP_Wep)
										end
									else
										if(TEMP_Wep:Clip1()>1) then
											TEMP_Wep:SetClip1(1)
										end
									end
								end
							end
						end)
						
						timer.Create("Attack"..tostring(self).."2",0.8,1,function()
							if(IsValid(self)&&self!=nil&&self!=NULL) then
								local TEMP_Weps = ents.FindInSphere(self:GetPos(),1000)
								
								if(#TEMP_Weps>0) then
									for P=1,#TEMP_Weps do	
										
										if(TEMP_Weps[P]:Visible(self)&&TEMP_Weps[P]:IsWeapon()&&
										!IsValid(TEMP_Weps[P]:GetParent())&&
										(!isnumber(TEMP_Weps[P].GrabbedByBurer)||TEMP_Weps[P].GrabbedByBurer<CurTime())) then
											/*if(TEMP_Weps[P]:GetClass()=="weapon_hpwr_stick"&&string.find(TEMP_Weps[P]:GetModel(),"models/hpwrewrite/c_")) then
												local TEMP_Model = string.Replace(TEMP_Weps[P]:GetModel(),"models/hpwrewrite/c_","models/hpwrewrite/w_")
												local TEMP_Ang = TEMP_Weps[P]:GetAngles()
												local TEMP_Pos = TEMP_Weps[P]:GetPos()
												
												
												
												TEMP_Weps[P]:Remove()
												
												TEMP_Weps[P] = ents.Create("weapon_hpwr_stick")
												TEMP_Weps[P]:SetModel(TEMP_Model)
												TEMP_Weps[P]:SetAngles(TEMP_Ang)
												TEMP_Weps[P]:SetPos(TEMP_Pos)
												TEMP_Weps[P]:SetMoveType(MOVETYPE_VPHYSICS)
												TEMP_Weps[P]:SetSolid(SOLID_VPHYSICS)
												TEMP_Weps[P]:PhysicsInit(SOLID_VPHYSICS)
												TEMP_Weps[P]:Spawn()
												
												TEMP_Weps[P]:SetTrigger(false)
												
												if(IsValid(TEMP_Weps[P]:GetPhysicsObject())) then
													TEMP_Weps[P]:GetPhysicsObject():Wake()
													TEMP_Weps[P]:GetPhysicsObject():EnableMotion(true)
												end
											end
											*/
											if(TEMP_Weps[P]:GetMoveType()==MOVETYPE_VPHYSICS&&IsValid(TEMP_Weps[P]:GetPhysicsObject())) then
												TEMP_Weps[P]:GetPhysicsObject():ApplyForceCenter(
												((self:GetPos()+self:OBBCenter())-TEMP_Weps[P]:GetPos())*TEMP_Weps[P]:GetPhysicsObject():GetMass()*0.8)
											end
										end
									end
								end
							end
						end)
						
						timer.Create("Attack"..tostring(self).."3",2.2,1,function()
							if(IsValid(self)&&self!=nil&&self!=NULL) then
								self:STALKERNPCStopAllTimers()
								self:STALKERNPCClearAnimation()
								self.NextAbilityTime = CurTime()+self.AbilityIntervals
							end
						end)
						
					end
				end
			end
		end
		
		
		if(self.PlayingAnimation==false) then
			if(self.CanPush<CurTime()) then
				local TEMP_Rand = math.random(1,5)
			
				if(TEMP_Rand==1) then
				
					local TEMP_CanShoot = util.TraceHull( {
						start = self:GetPos()+self:OBBCenter(),
						endpos = self:GetEnemy():GetPos()+self:GetEnemy():OBBCenter(),
						filter = function( ent ) 
							if(!ent:IsWeapon()&&ent!=self&&ent:GetParent()!=self:GetEnemy() ) then 
								return true 
							end
						end,
						mins = Vector(-1,-1,-1),
						maxs = Vector(1,1,1),
						mask = MASK_NPCSOLID
					} )
					
					if(TEMP_CanShoot.Hit==false||(TEMP_CanShoot.Hit&&TEMP_CanShoot.Entity==self:GetEnemy())) then
						self.CanPush = CurTime()+5
						
						self:STALKERNPCPlayAnimation("S_Power_Attack",1)
						
						timer.Create("Attack"..tostring(self).."1",0.9,1,function()
							if(IsValid(self)&&self!=nil&&self!=NULL) then
								local TEMP_ShootPoint = self:GetPos()+(self:GetForward()*1000)
								
								if(IsValid(self:GetEnemy())&&self:GetEnemy()!=nil&&self:GetEnemy()!=NULL) then
									TEMP_ShootPoint = self:GetEnemy():GetPos()+self:GetEnemy():OBBCenter()
								end
								
								local TEMP_ShootPos = self:GetPos()+Vector(0,0,50)+(self:GetForward()*15)
								
								local TEMP_Grav = ents.Create("ent_burer_wave")
								TEMP_Grav:SetPos(TEMP_ShootPos)
								TEMP_Grav:SetAngles((TEMP_ShootPoint-TEMP_ShootPos):Angle())
								TEMP_Grav:Spawn()
								
								TEMP_Grav:SetOwner(self)
								
								
								TEMP_Grav:GetPhysicsObject():SetVelocity((TEMP_ShootPoint-TEMP_ShootPos):GetNormalized()*3400)
								
								self:STALKERNPCPlaySoundRandom(100,"Stalker.Burer.Push",1,1)
							end
						end)
						
						timer.Create("Attack"..tostring(self).."2",2.2,1,function()
							if(IsValid(self)&&self!=nil&&self!=NULL) then
								self:STALKERNPCStopAllTimers()
								self:STALKERNPCClearAnimation()
								self.NextAbilityTime = CurTime()+self.AbilityIntervals
							end
						end)
					else
						self.CanPush = CurTime()+0.5
					end
					
					
				end
			end
		end
	end
end

function ENT:STALKERNPCDamageTake(dmginfo,mul)
	if(IsValid(dmginfo:GetInflictor())&&dmginfo:GetInflictor():GetClass()=="ent_burer_wave"&&
	dmginfo:GetInflictor():GetOwner()==self) then
		return 0
	end
	
	
	
	if(self.Animation=="S_Shield_Idle") then
		if(self.MustShield<CurTime()+1.61) then
			self.MustShield = CurTime()+1.6
		end
		
		local TEMP_DMGDIST = dmginfo:GetDamagePosition()-(self:GetPos()+self:OBBCenter())
		
		local TEMP_Effect = EffectData()
		TEMP_Effect:SetOrigin((self:GetPos()+self:OBBCenter())+(TEMP_DMGDIST:GetNormalized()*20))
		TEMP_Effect:SetEntity(self)
		TEMP_Effect:SetAngles(TEMP_DMGDIST:Angle())
		TEMP_Effect:SetScale(5)
		util.Effect("cball_bounce", TEMP_Effect,false,true)
		
		if(self.ShieldStartTime-CurTime()<-5) then
			if(self.Animation=="S_Shield_Idle") then
				self:STALKERNPCPlayAnimation("S_Radial",1)
				
				
				timer.Create("Attack"..tostring(self).."1",0.4,1,function()
					if(IsValid(self)&&self!=NULL&&self.IsAlive==true) then
						local TEMP_Victims = ents.FindInSphere(self:GetPos(),160)
						
						if(#TEMP_Victims>0) then
							for V=1, #TEMP_Victims do
								local TEMP_ENE = TEMP_Victims[V]
								
								if(IsValid(TEMP_ENE)&&TEMP_ENE!=NULL&&
								self:Visible(TEMP_ENE)&&TEMP_ENE:GetClass()!=self:GetClass()) then
									local TEMP_DMG = (160-(TEMP_ENE:GetPos():Distance(self:GetPos())*0.8))
									local TEMP_V = (TEMP_ENE:GetPos()-self:GetPos()):GetNormalized()
									
									local TEMP_FRC = Vector(TEMP_V.x*TEMP_DMG*8,TEMP_V.y*TEMP_DMG*8,250)
									
									local TEMP_TargetDamage = DamageInfo()
									TEMP_TargetDamage:SetDamage(TEMP_DMG*0.65)
									TEMP_TargetDamage:SetInflictor(self)
									TEMP_TargetDamage:SetDamageType(DMG_BLAST)
									TEMP_TargetDamage:SetAttacker(self)
									TEMP_TargetDamage:SetDamagePosition(self:GetPos())
									TEMP_TargetDamage:SetDamageForce(TEMP_FRC)
									TEMP_ENE:TakeDamageInfo(TEMP_TargetDamage)
									
									local TEMP_V = (TEMP_ENE:GetPos()-self:GetPos()):GetNormalized()
									TEMP_ENE:SetVelocity(TEMP_FRC)
								end
							end
						end
						
						self.CanShield = CurTime()+6
						self.MustShield = 0
						
						self:STALKERNPCPlaySoundRandom(100,"Stalker.Burer.Push",1,1)
						
						local TEMP_CEffectData = EffectData()
						TEMP_CEffectData:SetOrigin(self:GetPos()+Vector(0,0,20))
						TEMP_CEffectData:SetScale(80)
						TEMP_CEffectData:SetAngles(self:GetAngles())
						util.Effect( "ThumperDust", TEMP_CEffectData, false, true )
						
						
						timer.Create("Attack"..tostring(self).."2",1.0,1,function()
							if(IsValid(self)&&self!=nil&&self!=NULL) then
								self:STALKERNPCStopAllTimers()
								self:STALKERNPCClearAnimation()
							end
						end)
						
					end
				end)
			end
		end
		
		return 0
	elseif(self.CanShield<CurTime()) then
		local TEMP_Rand = math.random(1,3)
		
		if(TEMP_Rand==1) then
			self.MustShield = CurTime()+1
		end
	end
	
	return mul
end


function ENT:STALKERNPC_EnemySpotted(ent,myteam)
	if(!IsValid(self:GetEnemy())) then
		if(self.NextSoundCanPlayTime>CurTime()&&
		(self.LastPlayedSound=="Stalker.Burer.Idle1"||self.LastPlayedSound=="Stalker.Burer.Idle2")) then
			if(self.PlayingAnimation==false) then
				self:STALKERNPCStopPreviousSound()
				self:STALKERNPCPlaySoundRandom(100,"Stalker.Burer.Tele",1,1)
			end
		end
	end
		
	if(!istable(myteam)) then
		local TEMP_Burers = ents.FindInSphere(self:GetPos(), 1000)
		
		
		if (#TEMP_Burers>0) then 
			for B=1, #TEMP_Burers do
				local TEMP_NPC = TEMP_Burers[B]
				
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