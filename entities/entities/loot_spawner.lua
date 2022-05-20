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
ENT.LootCategory		= LOOT_COMMON;

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
		render.DrawSphere(self:GetPos(), 50, 25, 25, Color(0,255,0, 100))
	end
end

function ENT:SetLootCategory(cat)
	self.LootCategory = cat
end

function ENT:CanPhysgun()
	
	return false;
	
end

local function CalculatePlayerRatio()
	local maxPlayers = game.MaxPlayers()
	local playerRatio = (maxPlayers - player.GetCount()) / maxPlayers

	return playerRatio
end

function ENT:Think()
	if !SERVER then return end

	if !self.NextLootSpawn then
		local playerRatio = CalculatePlayerRatio()
		local minTime = math.Clamp(1200 * playerRatio, 120, 1200)
		local maxTime = math.Clamp(3600 * playerRatio, 150, 3600)

		self.NextLootSpawn = CurTime() + math.random(minTime, maxTime)
	end

	if self.NextLootSpawn <= CurTime() then
		local playerRatio = CalculatePlayerRatio()
		local minTime = math.Clamp(1200 * playerRatio, 120, 1200)
		local maxTime = math.Clamp(3600 * playerRatio, 150, 3600)

		local chance = math.random(0, 100)
		if GAMEMODE.ItemSpawnChance > chance then
			self.NextLootSpawn = CurTime() + math.random(minTime, maxTime)
			return
		end

		local surroundItemCount = 0
		for _,ent in ipairs(ents.FindInSphere(self:GetPos(), 100)) do
			if ent:GetClass() == "cc_item" then
				if ent.DeleteTime and ent.DeleteTime <= CurTime() then
					ent:Remove()
					continue
				end

				surroundItemCount = surroundItemCount + 1
			end
		end

		if surroundItemCount >= 5 then
			self.NextLootSpawn = CurTime() + math.random(minTime,maxTime)
			return
		end

		local totalItemCount = #ents.FindByClass("cc_item")
		local inverseRatio = 1 - playerRatio
		if totalItemCount >= math.Clamp(200 * inverseRatio, 25, 200) then
			self.NextLootSpawn = CurTime() + math.random(minTime,maxTime)
			return
		end

		local playersInVicinity = 0
		for _,ent in pairs(ents.FindInSphere(self:GetPos(), 2048)) do
			if ent:IsPlayer() then
				playersInVicinity = playersInVicinity + 1
			end
		end

		if playersInVicinity == 0 then
			self.NextLootSpawn = CurTime() + math.random(150, 300)
			return
		end

		local lootItems = {}

		for class,item in next, GAMEMODE.Items do
			if item.Rarity and item.Rarity == self.LootCategory and item.AllowRandomSpawn then
				table.insert(lootItems, class)
			end
		end

		local randomItem = table.Random(lootItems)

		local ent = GAMEMODE:CreateNewItemEntity(randomItem, self:GetPos() + Vector(math.random(0,40), math.random(0,40), 0) + self:GetAngles():Up() * 10, Angle(0,0,0))
		ent.DeleteTime = CurTime() + 300

		self.NextLootSpawn = CurTime() + math.random(minTime, maxTime)
	end
end

if SERVER then
	local GM = gmod.GetGamemode()

	function GM:LoadLootSpawns()
		local data = file.Read("zonecontrol/"..game.GetMap().."/lootspawns.txt", "DATA")

		if !data or #data == 0 then return end

		local spawns = util.JSONToTable(data)
		if spawns then
			for _,data in ipairs(spawns) do
				local spawn = ents.Create("loot_spawner")
				spawn:SetPos(data.Pos)
				spawn:SetLootCategory(data.LootCategory)
				spawn:Spawn()
			end
		end
	end

	function GM:SaveLootSpawns()
		if !file.IsDir("zonecontrol", "DATA") then
			file.CreateDir("zonecontrol")
		end

		if !file.IsDir("zonecontrol/"..game.GetMap(), "DATA") then
			file.CreateDir("zonecontrol/"..game.GetMap())
		end

		local data = {}
		for _,spawn in ipairs(ents.FindByClass("loot_spawner")) do
			table.insert(
				data,
				{
					Pos = spawn:GetPos(),
					LootCategory = spawn.LootCategory
				}
			)
		end

		file.Write("zonecontrol/"..game.GetMap().."/lootspawns.txt", util.TableToJSON(data))
	end

	hook.Add("InitPostEntity", "STALKER.LoadLootSpawns", function()
		hook.Run("LoadLootSpawns")
	end)

	hook.Add("ShutDown", "STALKER.SaveLootSpawns", function()
		hook.Run("SaveLootSpawns")
	end)
end