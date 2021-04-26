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
		render.DrawSphere(self:GetPos(), 25, 25, 25, Color(0,0,255, 100))
	end
end

function ENT:CanPhysgun()
	
	return false;
	
end

if SERVER then
	local GM = gmod.GetGamemode()

	function GM:LoadShipmentSpawns()
		local data = file.Read("zonecontrol/"..game.GetMap().."/shipmentspawns.txt", "DATA")

		if !data or #data == 0 then return end

		local spawns = util.JSONToTable(data)
		if spawns then
			for _,data in ipairs(spawns) do
				local spawn = ents.Create("shipment_spawner")
				spawn:SetPos(data.Pos)
				spawn:Spawn()
			end
		end
	end

	function GM:SaveShipmentSpawns()
		if !file.IsDir("zonecontrol", "DATA") then
			file.CreateDir("zonecontrol")
		end

		if !file.IsDir("zonecontrol/"..game.GetMap(), "DATA") then
			file.CreateDir("zonecontrol/"..game.GetMap())
		end

		local data = {}
		for _,spawn in ipairs(ents.FindByClass("shipment_spawner")) do
			table.insert(
				data,
				{
					Pos = spawn:GetPos(),
				}
			)
		end

		file.Write("zonecontrol/"..game.GetMap().."/shipmentspawns.txt", util.TableToJSON(data))
	end

	hook.Add("InitPostEntity", "STALKER.LoadShipmentSpawns", function()
		hook.Run("LoadShipmentSpawns")
	end)

	hook.Add("ShutDown", "STALKER.SaveShipmentSpawns", function()
		hook.Run("SaveShipmentSpawns")
	end)
end