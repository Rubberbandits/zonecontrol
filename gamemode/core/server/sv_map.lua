GM.ServerConnectIDs = {}
function GM:InitPostEntity()
	hook.Add("InitSQLTables", "STALKER.LoadFromDB", function()
		self:LoadBans()
		RetrieveStockpiles()
	end)

	self:InitSQL()
	net.Receive("VJSay", function(len, pl) end)
	local ent = ents.FindByClass("func_dustmotes")
	for k, v in pairs(ent) do
		v:Remove()
	end

	self:SpawnSavedProps()
	if self.EntNamesToRemove then
		for _, v in pairs(self.EntNamesToRemove) do
			local tab = ents.FindByName(v)
			for _, e in pairs(tab) do
				e:Remove()
			end
		end
	end

	if self.EntPositionsToRemove then
		for _, v in pairs(self.EntPositionsToRemove) do
			local tab = ents.FindInBox(v, v)
			for _, e in pairs(tab) do
				if not table.HasValue(GAMEMODE.MapProtectedClasses, e:GetClass()) then e:Remove() end
			end
		end
	end

	if self.MapInitPostEntity then self:MapInitPostEntity() end
	if self.MapChairs then
		for _, v in pairs(self.MapChairs) do
			local chair = ents.Create("prop_vehicle_prisoner_pod")
			chair:SetPos(v[1])
			chair:SetAngles(v[2])
			chair:SetModel("models/nova/airboat_seat.mdl")
			chair:SetKeyValue("vehiclescript", "scripts/vehicles/prisoner_pod.txt")
			chair:SetKeyValue("limitview", "0")
			chair:Spawn()
			chair:Activate()
			chair:SetNoDraw(true)
			chair:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
			chair.Static = true
		end
	end

	if not self.EnableAreaportals then
		local ent = ents.FindByClass("func_areaportalwindow")
		for k, v in pairs(ent) do
			v:Fire("SetFadeStartDistance", "99999", 0)
			v:Fire("SetFadeEndDistance", "99999", 0)
		end

		local ent = ents.FindByClass("func_areaportal")
		for k, v in pairs(ent) do
			v:Fire("Open")
			v:SetKeyValue("target", "")
			v:SetSaveValue("target", "")
		end
	end

	if self.DoorData then
		for _, v in pairs(self.DoorData) do
			local ent
			if type(v[1]) == "Vector" then
				local enttab = ents.FindInBox(v[1], v[1])
				if enttab[1] then ent = enttab[1] end
			elseif type(v[1]) == "string" then
				local enttab = ents.FindByName(v[1])
				if enttab[1] then ent = enttab[1] end
			else
				ent = ents.GetMapCreatedEntity(v[1])
			end

			if ent and ent:IsValid() then
				ent:SetDoorType(v[2] or DOOR_UNBUYABLE)
				ent:SetDoorOriginalName(v[3] or "")
				ent:SetDoorName(v[3] or "")
				ent:SetDoorPrice(v[4] or 0)
				ent:SetDoorBuilding(v[5] or "")
			end
		end
	end

	local ent = ents.FindByClass("weapon_*")
	for k, v in pairs(ent) do
		v:Remove()
	end
end

GM.MapProtectedClasses = {"move_rope", "keyframe_rope",}
function GM:EntityKeyValue(ent, key, value)
	if key == "cc_static" and value == "1" then ent.Static = true end
	return self.BaseClass:EntityKeyValue(ent, key, value)
end

GM.ChairModels = {{"models/props_c17/furniturecouch001a.mdl", {Vector(4.375, -13.21875, -3.25), Angle(0, -90, 0)}, {Vector(4.71875, 14.1875, -2.96875), Angle(0, -90, 0)},}, {"models/props_c17/furniturechair001a.mdl", {Vector(-0.78111809492111, -0.34404960274696, -7.125), Angle(-0, -90, 0)},}, {"models/props_c17/furniturecouch002a.mdl", {Vector(4.1000366210938, 9.5060768127441, -5.5312490463257), Angle(0, -90, 0)}, {Vector(3.1263382434845, -10.095077514648, -5.7187495231628), Angle(0, -90, 0)},}, {"models/props_c17/chair02a.mdl", {Vector(16.85528755188, 4.6713724136353, 1.0366483926773), Angle(0, -90, 0)},}, {"models/props_combine/breenchair.mdl", {Vector(5.8337116241455, 0.83913016319275, 15.375), Angle(0, -90, 0)},}, {"models/props_interiors/furniture_chair01a.mdl", {Vector(0.44139209389687, 0.30659884214401, -3.2190895080566), Angle(0, -90, 0)},}, {"models/props_interiors/furniture_chair03a.mdl", {Vector(3.381739616394, -0.23042333126068, -3.125), Angle(0, -90, 0)},}, {"models/props_interiors/furniture_couch01a.mdl", {Vector(5.4747152328491, -17.027050018311, -9.2542018890381), Angle(0, -90, 0)}, {Vector(7.451247215271, 14.411973953247, -8.4119672775269), Angle(0, -90, 0)},}, {"models/props_interiors/furniture_couch02a.mdl", {Vector(3.9066781997681, 0.275255382061, -8.3124990463257), Angle(0, -90, 0)},}, {"models/chairs/armchair.mdl", {Vector(3.9262285232544, 0.32051900029182, 33.268924713135), Angle(0, -90, 0)},}, {"models/props_wasteland/controlroom_chair001a.mdl", {Vector(-0.09375, 0.09375, -4.78125), Angle(0, -90, 0)},}, {"models/props_c17/chair_stool01a.mdl", {Vector(-4.9375, -0.25, 33.78125), Angle(0, -90, 1)},}}
function GM:OnEntityCreated(ent)
	timer.Simple(0, function()
		if not ent or not ent:IsValid() then return end

		for _, data in pairs(self.ChairModels) do
			if not ent:GetModel() or string.lower(ent:GetModel()) != data[1] then continue end

			ent.Chairs = {}
			ent:SetUseType(SIMPLE_USE)
			for k, n in pairs(data) do
				if k > 1 then
					local chair = ents.Create("prop_vehicle_prisoner_pod")
					chair:SetPos(ent:LocalToWorld(n[1]))
					chair:SetAngles(ent:LocalToWorldAngles(n[2]))
					chair:SetModel("models/nova/airboat_seat.mdl")
					chair:SetKeyValue("vehiclescript", "scripts/vehicles/prisoner_pod.txt")
					chair:SetKeyValue("limitview", "0")
					chair:Spawn()
					chair:Activate()
					chair:SetNoDraw(true)
					chair:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
					chair:GetPhysicsObject():EnableCollisions(false)
					chair.Static = true
					chair:SetParent(ent)
					table.insert(ent.Chairs, chair)
				end
			end
		end
	end)
end

GM.ConnectMessages = {}
GM.EntryPortSpawns = {}
local files = file.Find(GM.FolderName .. "/gamemode/maps/" .. game.GetMap() .. ".lua", "LUA", "namedesc")
if #files > 0 then
	for _, v in pairs(files) do
		include("maps/" .. v)
		AddCSLuaFile("maps/" .. v)
	end

	MsgC(Color(200, 200, 200, 255), "Serverside map lua file for " .. game.GetMap() .. " loaded.\n")
else
	MsgC(Color(200, 200, 200, 255), "Warning: No serverside map lua file for " .. game.GetMap() .. ".\n")
end