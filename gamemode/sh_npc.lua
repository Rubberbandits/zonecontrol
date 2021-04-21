local meta = FindMetaTable( "Entity" );
local pmeta = FindMetaTable( "Player" );

GM.NPCAccessors = {
	{ "Static", 			"Bool",		false },
	{ "Driver", 			"Entity",	NULL },
	{ "GunOn",				"Bool",		false },
	{ "MastermindColor",	"Vector",	Vector( 255, 255, 255 ) },
	{ "TargetPos",			"Vector",	Vector() },
	{ "HatesUnflaggedCPs",	"Bool",		false },
	{ "HatesFlaggedCPs",	"Bool",		false },
	{ "HatesCitizens",		"Bool",		false },
	{ "HatesRebels",		"Bool",		false },
	{ "HatesWeapons",		"Bool",		false },
};

for k, v in pairs( GM.NPCAccessors ) do
	
	meta["SetNPC" .. v[1]] = function( self, val )
		
		if( CLIENT ) then return end
		
		if( self["NPC" .. v[1] .. "Val"] == val ) then return end
		
		self["NPC" .. v[1] .. "Val"] = val;
		
		netstream.Start( nil, "nSetNPC"..v[1], self, val );
		
	end
	
	meta["NPC" .. v[1]] = function( self )
		
		if( self["NPC" .. v[1] .. "Val"] == false ) then
			
			return false;
			
		end
		
		return self["NPC" .. v[1] .. "Val"] or v[3];
		
	end
	
	if( CLIENT ) then
		
		local function nRecvData( npc, val )
			
			if( npc and npc:IsValid() ) then
				
				npc["NPC" .. v[1] .. "Val"] = val;
				
			end
			
		end
		netstream.Hook( "nSetNPC" .. v[1], nRecvData );
		
	end
	
end

function meta:InitializeNPCAccessors()
	
	for _, v in pairs( GAMEMODE.NPCAccessors ) do
		
		self[v[1] .. "Val"] = v[3];
		
	end
	
end

function meta:SyncNPCData( ply )
	
	for _, n in pairs( GAMEMODE.NPCAccessors ) do
		
		netstream.Start( ply, "nSetNPC"..n[1], self, self["NPC" .. n[1]]( self ) ); 
		
	end
	
end

function nRequestNPCData( ply, ent )
	
	if( CLIENT ) then return end
	
	ent:SyncNPCData( ply );
	
end
netstream.Hook( "nRequestNPCData", nRequestNPCData );

function ents.GetNPCs()
	
	local tab = { };
	
	for _, v in pairs( ents.GetAll() ) do
		
		if( v:GetClass() == "bullseye_strider_focus" ) then continue; end
		if( v:GetClass() == "npc_bullseye" ) then continue; end
		if( v:GetClass() == "monster_generic" ) then continue; end
		
		if( !v:NPCStatic() ) then
			
			if( v:IsNPC() and v:Health() > 0 ) then
				
				table.insert( tab, v );
				
			end
			
			if( v:GetClass() == "prop_vehicle_apc" ) then
				
				table.insert( tab, v );
				
			end
			
		end
		
	end
	
	return tab;
	
end

local dropItems = {
	npc_wick_mutant_dog = {
		chance = 30, 
		items = {
			"taildog",
		},
	},
	vj_mutant_burer = {
		chance = 50, 
		items = {
			"handburer",
		},
	},
	vj_mutant_burer3 = {
		chance = 90, 
		items = {
			"handburer",
		},
	},
	vj_mutant_controler2 = {
		chance = 90, 
		items = {
			"handcontroller",
		},
	},
	vj_mutant_controler8 = {
		chance = 90, 
		items = {
			"handcontroller",
		},
	},
	vj_mutant_controler6 = {
		chance = 90, 
		items = {
			"handcontroller",
		},
	},
	vj_mutant_izlom = {
		chance = 40, 
		items = {
			"adhesive",
			"antidote",
			"beans",
			"bolt_lucky",
			"boots",
			"buckleparts",
			"cigs",
			"coffeebeans",
			"cossacks",
			"crayons",
			"gasrag",
			"grease",
			"jarteeth",
			"keys1",
			"oldpda",
			"playboy",
			"pliers",
			"sign1",
			"tinmug",
			"walnut_odd",
			"wire",
			"wrench",
		},
	},
	vj_mutant_izlom4 = {
		chance = 40, 
		items = {
			"adhesive",
			"antidote",
			"beans",
			"bolt_lucky",
			"boots",
			"buckleparts",
			"cigs",
			"coffeebeans",
			"cossacks",
			"crayons",
			"gasrag",
			"grease",
			"jarteeth",
			"keys1",
			"oldpda",
			"playboy",
			"pliers",
			"sign1",
			"tinmug",
			"walnut_odd",
			"wire",
			"wrench",
		},
	},
	vj_mutant_izlom3 = {
		chance = 40, 
		items = {
			"adhesive",
			"antidote",
			"beans",
			"bolt_lucky",
			"boots",
			"buckleparts",
			"cigs",
			"coffeebeans",
			"cossacks",
			"crayons",
			"gasrag",
			"grease",
			"jarteeth",
			"keys1",
			"oldpda",
			"playboy",
			"pliers",
			"sign1",
			"tinmug",
			"walnut_odd",
			"wire",
			"wrench",
		},
	},
	vj_mutant_zombi = {
		chance = 40, 
		items = {
			"adhesive",
			"antidote",
			"beans",
			"bolt_lucky",
			"boots",
			"buckleparts",
			"cigs",
			"coffeebeans",
			"cossacks",
			"crayons",
			"gasrag",
			"grease",
			"jarteeth",
			"keys1",
			"oldpda",
			"playboy",
			"pliers",
			"sign1",
			"tinmug",
			"walnut_odd",
			"wire",
			"wrench",
		},
	},
	vj_mutant_zombi2 = {
		chance = 40, 
		items = {
			"adhesive",
			"antidote",
			"beans",
			"bolt_lucky",
			"boots",
			"buckleparts",
			"cigs",
			"coffeebeans",
			"cossacks",
			"crayons",
			"gasrag",
			"grease",
			"jarteeth",
			"keys1",
			"oldpda",
			"playboy",
			"pliers",
			"sign1",
			"tinmug",
			"walnut_odd",
			"wire",
			"wrench",
		},
	},
	vj_mutant_psevdodog4 = {
		chance = 20, 
		items = {
			"tailpseudodog",
		},
	},
	vj_mutant_psevdodog = {
		chance = 50, 
		items = {
			"tailpseudodog",
		},
	},
	vj_mutant_psevdodog4 = {
		chance = 70, 
		items = {
			"tailpseudodog",
		},
	},
	vj_mutant_psydog = {
		chance = 70, 
		items = {
			"tailpseudodog",
		},
	},
	vj_mutant_psydog = {
		chance = 70, 
		items = {
			"tailpseudodog",
		},
	},
	vj_mutant_bloodsucker2 = {
		chance = 20, 
		items = {
			"tentacles",
		},
	},
	vj_mutant_bloodsucker5 = {
		chance = 50, 
		items = {
			"tentacles",
		},
	},
	vj_mutant_bloodsucker = {
		chance = 50, 
		items = {
			"tentacles",
		},
	},
	vj_mutant_bloodsucker4 = {
		chance = 80, 
		items = {
			"tentacles",
		},
	},
	npc_wick_mutant_snork = {
		chance = 40, 
		items = {
			"footsnork",
		},
	},
	vj_mutant_boar = {
		chance = 30, 
		items = {
			"boarchop",
		},
	},
	vj_mutant_boar3 = {
		chance = 80, 
		items = {
			"boarchop",
		},
	},
	vj_mutant_boar2 = {
		chance = 50, 
		items = {
			"boarchop",
		},
	},
	vj_mutant_boar4 = {
		chance = 50, 
		items = {
			"boarchop",
		},
	},
	vj_mutant_cat = {
		chance = 40, 
		items = {
			"catgland",
		},
	},
	vj_mutant_cat3 = {
		chance = 70, 
		items = {
			"catgland",
		},
	},
	vj_mutant_chimera = {
		chance = 90, 
		items = {
			"chimeraclaw",
		},
	},
	vj_mutant_chimera5 = {
		chance = 40, 
		items = {
			"chimeraclaw",
			"flash",
		},
	},
	vj_mutant_chimera3 = {
		chance = 60, 
		items = {
			"chimeraclaw",
		},
	},
	vj_mutant_flesh = {
		chance = 40, 
		items = {
			"fleshmeat",
			"flesheye",
		},
	},
	vj_mutant_flesh6 = {
		chance = 20, 
		items = {
			"fleshmeat",
			"flesheye",
		},
	},
	vj_mutant_flesh2 = {
		chance = 70, 
		items = {
			"fleshmeat",
			"flesheye",
		},
	},
	vj_mutant_poltergeist = {
		chance = 20, 
		items = {
			"moonlight",
		},
	},
	vj_mutant_poltergeist3 = {
		chance = 20, 
		items = {
			"flame",
		},
	},
}

if SERVER then
	function GM:OnNPCKilled(npc, attacker, inflictor, dmginfo)
		if !attacker:IsPlayer() then return end

		local possibleItems = dropItems[npc:GetClass()]
		if possibleItems then
			local chance = math.random(1, 100)
			if chance <= possibleItems.chance then
				local itemID = table.Random(possibleItems.items)
				local ent = self:CreateNewItemEntity(itemID, npc:GetPos() + npc:GetAngles():Up() * 10, Angle())
			end
		end
	end

	hook.Add("Initialize", "STALKER.DetourVREJCode", function()
	local task_idleWander = ai_vj_schedule.New("vj_idle_wander")
		task_idleWander:EngTask("TASK_GET_PATH_TO_RANDOM_NODE", 350)
		task_idleWander:EngTask("TASK_WAIT_FOR_MOVEMENT", 0)
		task_idleWander.ResetOnFail = true
		task_idleWander.CanBeInterrupted = true
		task_idleWander.IsMovingTask = true
		task_idleWander.MoveType = 0

		local ENT = scripted_ents.GetStored("npc_vj_creature_base").t

		function ENT:VJ_TASK_IDLE_WANDER()
			if self.MovementType == VJ_MOVETYPE_AERIAL or self.MovementType == VJ_MOVETYPE_AQUATIC then self:AA_IdleWander(true) return end
			local act = VJ_PICK(self.AnimTbl_Walk)

			if !isnumber(act) then
				act = self:GetSequenceActivity(self:LookupSequence(act))
			end

			self:SetMovementActivity(act)
			//self:SetLastPosition(self:GetPos() + self:GetForward() * 300)
			self:StartSchedule(task_idleWander)
		end
	end)

	hook.Add("TFA_PostPrimaryAttack", "STALKER.AlertNearbyNPCs", function(weapon)
		if CLIENT then
			if !IsFirstTimePredicted() then return end
		end
		
		if !weapon.NextAlertFire then
			weapon.NextAlertFire = CurTime()
		end

		if weapon.NextAlertFire <= CurTime() then
			local weaponOwner = weapon:GetOwner()

			for _,npc in ipairs(ents.GetAll()) do
				if !npc.VJ_AddCertainEntityAsEnemy then continue end
				if npc:GetPos():DistToSqr(weaponOwner:GetPos()) > 1000*1000 then continue end
				if IsValid(npc:GetEnemy()) then continue end

				self:VJ_DoSetEnemy(weaponOwner)
			end

			weapon.NextAlertFire = CurTime() + 5
		end
	end)
end