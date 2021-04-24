AddCSLuaFile();

ENT.Base = "base_anim";
ENT.Type = "anim";

ENT.PrintName		= "";
ENT.Author			= "";
ENT.Contact			= "";
ENT.Purpose			= "";
ENT.Instructions	= "";

ENT.Spawnable			= false;
ENT.AdminSpawnable		= false;
ENT.LootCategory		= MUTANT_COMMON;

function ENT:PostEntityPaste( ply, ent, tab )
	
	GAMEMODE:LogSecurity( ply:SteamID(), "n/a", ply:VisibleRPName(), "Tried to duplicate " .. ent:GetClass() .. "!" );
	ent:Remove();
	
end

function ENT:Initialize()
	if( CLIENT ) then return end
	
	self:SetModel( "models/props_combine/breenglobe.mdl" );
	self:SetCollisionGroup( COLLISION_GROUP_PASSABLE_DOOR );
	self:DrawShadow(false)
end

if CLIENT then
	function ENT:Draw()
		if !LocalPlayer():IsAdmin() then return end
		if !IsValid(LocalPlayer():GetActiveWeapon()) then return end
		if LocalPlayer():GetActiveWeapon():GetClass() != "gmod_tool" then return end

		render.SetColorMaterial()
		render.DrawSphere(self:GetPos(), 200, 25, 25, Color(255,0,255, 100))
	end
end

function ENT:SetMutantCategory(cat)
	self.MutantCategory = cat
end

function ENT:CanPhysgun()
	
	return false;
	
end

local function PointOnCircle(ang, radius, offX, offY)
	ang =  math.rad(ang)
	local x = math.cos(ang) * radius + offX
	local y = math.sin(ang) * radius + offY
	return x, y
end

function ENT:Think()
	if !SERVER then return end

	if !self.NextMutantSpawn then
		self.NextMutantSpawn = CurTime() + math.random(300, 1200)
	end

	if self.NextMutantSpawn <= CurTime() then
		local npcCount = 0
		for _,ent in ipairs(ents.GetAll()) do
			if ent:IsNPC() or ent:IsNextBot() then
				npcCount = npcCount + 1
			end
		end

		if npcCount >= 30 then
			self.NextMutantSpawn = CurTime() + math.random(300, 1200)
			return
		end

		local npcGroup = table.Random(GAMEMODE.RandomMutantGroups)

		if istable(npcGroup) then
			local totalNPCs = {}
			local interval = 360 / #npcGroup
			local pos = self:GetPos()
			local radius = 200

			for i,npcClass in ipairs(npcGroup) do
				local x, y = PointOnCircle(i * interval, math.random(50,200), pos.x, pos.y)

				local npc = ents.Create(npcClass)
				npc:SetPos(Vector(x, y, pos.z + 10))
				npc:Spawn()

				npc.DisableWandering = false
				npc.IdleAlwaysWander = true
				npc.AlertFriendsOnDeath = true
				table.insert(totalNPCs, npc)
			end
		elseif isstring(npcGroup) then
			local npc = ents.Create(npcGroup)
			npc:SetPos(self:GetPos() + Vector(math.random(25,200), math.random(25,200), 0))
			npc:Spawn()

			npc.DisableWandering = false
			npc.IdleAlwaysWander = true
			npc.AlertFriendsOnDeath = true
		end

		self.NextMutantSpawn = CurTime() + math.random(300, 1200)
	end
end

if SERVER then
	local GM = gmod.GetGamemode()

	function GM:LoadMutantSpawns()
		local data = file.Read("zonecontrol/"..game.GetMap().."/mutantspawns.txt", "DATA")

		if !data or #data == 0 then return end

		local spawns = util.JSONToTable(data)
		if spawns then
			for _,data in ipairs(spawns) do
				local spawn = ents.Create("npc_spawner")
				spawn:SetPos(data.Pos)
				spawn:SetMutantCategory(data.MutantCategory)
				spawn:Spawn()
			end
		end
	end

	function GM:SaveMutantSpawns()
		if !file.IsDir("zonecontrol", "DATA") then
			file.CreateDir("zonecontrol")
		end

		if !file.IsDir("zonecontrol/"..game.GetMap(), "DATA") then
			file.CreateDir("zonecontrol/"..game.GetMap())
		end

		local data = {}
		for _,spawn in ipairs(ents.FindByClass("npc_spawner")) do
			table.insert(
				data,
				{
					Pos = spawn:GetPos(),
					MutantCategory = spawn.MutantCategory
				}
			)
		end

		file.Write("zonecontrol/"..game.GetMap().."/mutantspawns.txt", util.TableToJSON(data))
	end

	hook.Add("InitPostEntity", "STALKER.LoadMutantSpawns", function()
		hook.Run("LoadMutantSpawns")
	end)

	hook.Add("ShutDown", "STALKER.SaveMutantSpawns", function()
		hook.Run("SaveMutantSpawns")
	end)
end