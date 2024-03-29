kingston = kingston or {}
kingston.bonemerge = kingston.bonemerge or {}

// Player functions
local meta = FindMetaTable("Player")
function meta:CreateNewBonemerge(szModel, iBoneScale)
	if !IsValidModel(szModel) then return end

	local hookName = self:EntIndex()..szModel

	local b = ClientsideModel(szModel, RENDERGROUP_OPAQUE)
	if !b then return end
	b:SetModel(szModel)
	b:InvalidateBoneCache()
	b:SetParent(self)
	b:AddEffects(EF_BONEMERGE)
	b:SetupBones()
	function b:Think()
		local ply = self:GetParent()
	
		if IsValid(ply) then
			if ply:GetMoveType() == MOVETYPE_NOCLIP and ply:GetNoDraw() and !self.bLastDrawState then
				self:SetNoDraw(true)
			elseif !ply:GetNoDraw() and self.bLastDrawState then
				self:SetNoDraw(false)
			end

			if ply.pac_hide_entity then
				self:SetNoDraw(true)
			end
		else
			self:Remove()
		end
		
		self.bLastDrawState = self:GetNoDraw()
	end
	hook.Add("Think", b, b.Think)

	b:CallOnRemove("clearThink", function(ent)
		hook.GetTable().Think[ent] = nil
	end)
	
	if iBoneScale then
		for i = 0, b:GetBoneCount() - 1 do 
			b:ManipulateBoneScale(i, Vector(iBoneScale, iBoneScale, iBoneScale))
		end
	end
	
	return b
end

kingston.bonemerge.data = kingston.bonemerge.data or {}

// Bonemerge data functions
function kingston.bonemerge.add(charId, itemId, itemData)
	local charData = kingston.bonemerge.data[charId]
	if !charData then
		kingston.bonemerge.data[charId] = {
			items = {}
		}

		charData = kingston.bonemerge.data[charId]
	end

	local transmittedItems = charData.items
	if !transmittedItems then 
		charData.items = {}
		transmittedItems = charData.items 
	end

	local itemExists = transmittedItems[itemId] and true or false
	local parent = itemData.Owner
	
	local metaitem = GAMEMODE:GetItemByID(itemData.szClass)
	transmittedItems[itemId] = {
		parent = parent,
		class = itemData.szClass,
		vars = itemData.Vars,
		charId = charId,
		itemId = itemId,
		removeBody = metaitem.RemoveBody
	}
	
	-- cant use full item info
	if metaitem.DummyItemUpdate then
		metaitem.DummyItemUpdate(itemData.szClass, itemData.Vars)
	end

	if itemExists then
		hook.Run("BonemergeItemUpdated", parent, charId, itemId)
	else
		hook.Run("BonemergeItemAdded", parent, charId, itemId)
	end
end

function kingston.bonemerge.remove(charId, itemId)
	if !kingston.bonemerge.data[charId] then return end
	
	local charData = kingston.bonemerge.data[charId]
	if !charData then return end

	local transmittedItems = charData.items
	if !transmittedItems then return end

	local itemData = transmittedItems[itemId]
	if !itemData then return end

	if IsValid(itemData.entity) then
		itemData.entity:Remove()
	end

	transmittedItems[itemId] = nil

	hook.Run("BonemergeItemRemoved", charId, itemId)
end

function kingston.bonemerge.createEntity(ply, itemClass, itemVars)
	if !IsValid(ply) then return end

	local metaitem = GAMEMODE:GetItemByID(itemClass)
	if metaitem.Bonemerge then
		local mdl = metaitem.Bonemerge
		local scale
		
		if ply.Gender then
			if metaitem.AllowGender then
				if ply:Gender() == GENDER_FEMALE then
					mdl = string.StripExtension(mdl).."_f.mdl"
				end
			elseif metaitem.ScaleForGender and ply:Gender() == GENDER_FEMALE then
				scale = metaitem.ScaleForGender
			end
		end

		local ent = ply:CreateNewBonemerge(mdl, scale)
		if !ent or !IsValid(ent) then
			return -- outside of pvs? creation failed.
		end
	
		if metaitem.Bodygroups then
			for _,bodygroup in next, metaitem.Bodygroups do
				-- first key in bodygroup is bodygroup index
				-- second key in bodygroup is bodygroup value
				
				ent:SetBodygroup(bodygroup[1], bodygroup[2])
			end
		end
		
		if metaitem.Submaterials then
			for _,submaterial in next, metaitem.Submaterials do
				ent:SetSubMaterial(submaterial[1], submaterial[2])
			end
		end
		
		if itemVars.SuitClass and GAMEMODE.SuitVariants[itemVars.SuitClass] then
			local suit = GAMEMODE.SuitVariants[itemVars.SuitClass]
			if suit.Submaterial then
				for _,submaterial in next, suit.Submaterial do
					ent:SetSubMaterial(submaterial[1], submaterial[2])
				end
			end
		end
		
		if metaitem.DummyItemUpdate then
			metaitem.DummyItemUpdate(itemClass, itemVars, ent)
		end

		return ent
	end
end

function kingston.bonemerge.manageEntities(ply, createEntities, removeEntities, newParent)
	local charId = ply.CharID and ply:CharID() or nil
	if !charId or charId == 0 then return end

	local charData = kingston.bonemerge.data[charId]
	if !charData then
		charData = {
			items = {}
		}

		kingston.bonemerge.data[charId] = charData
	end

	local transmittedItems = charData.items
	if !transmittedItems then 
		charData.items = {}
		transmittedItems = charData.items
	end

	local hideBody = false
	for itemId,itemData in next, transmittedItems do
		itemData.parent = ply

		local entity = itemData.entity

		if removeEntities and IsValid(entity) then
			entity:Remove()
		end

		if createEntities and GAMEMODE.EfficientModelCheck[ply:GetModel()] and itemData.vars.Equipped then
			itemData.entity = kingston.bonemerge.createEntity(ply, itemData.class, itemData.vars)

			if itemData.removeBody then
				hideBody = true
			end
		end

		if IsValid(newParent) and IsValid(itemData.entity) then
			itemData.entity:SetParent(newParent)
		end
	end

	local charParts = charData.parts
	if !charParts then
		charParts = {
			body = {
				model = ply:Body(),
			}	
		}

		charData.parts = charParts
	end

	for partType,partData in next, charParts do
		local entity = partData.entity

		if removeEntities and IsValid(entity) then
			entity:Remove()
		end

		if createEntities and !hideBody and GAMEMODE.EfficientModelCheck[ply:GetModel()] then
			if !partData.model or #partData.model == 0 then continue end

			local ent = ply:CreateNewBonemerge(partData.model)
			if !ent or !IsValid(ent) then
				continue -- outside of pvs? creation failed.
			end
			
			ent:SetSubMaterial(0, ply:BodySubMat())

			partData.entity = ent
		end

		if IsValid(newParent) and IsValid(partData.entity) then
			partData.entity:SetParent(newParent)
		end
	end

	// Garbage collection
	for _,ent in next, ply:GetChildren() do
		if ent:GetClass() != "class C_BaseFlex" then continue end
	
		local foundEntity = false
		for _,itemData in next, transmittedItems do
			if itemData.entity == ent then
				foundEntity = true
			end
		end

		for _,partData in next, charParts do
			if partData.entity == ent then
				foundEntity = true
			end
		end

		if !foundEntity then
			ent:Remove()
		end
	end
end

function kingston.bonemerge.clear()
	for _,ent in ipairs(ents.FindByClass("class C_BaseFlex")) do
		ent:Remove()
	end
end

function kingston.bonemerge.fullUpdate()
	kingston.bonemerge.clear()

	for _,ply in ipairs(player.GetHumans()) do
		if !IsValid(ply) then continue end
		if ply:IsDormant() then continue end

		kingston.bonemerge.manageEntities(ply, true, true)
	end
end

// Data handling
function GM:OnReceiveDummyItem(itemId, itemData)
	local charId = itemData.CharID

	kingston.bonemerge.add(charId, itemId, itemData)
end

function GM:BonemergeItemAdded(parent, charId, itemId)
	kingston.bonemerge.manageEntities(parent, true, true, nil, charId)
end

function GM:BonemergeItemUpdated(parent, charId, itemId)
	local charData = kingston.bonemerge.data[charId]
	if !charData then return end

	kingston.bonemerge.manageEntities(parent, true, true, nil, charId)
end

// Hooks
hook.Add("NotifyShouldTransmit", "STALKER.BonemergeUpdate", function(ent, transmit)
	if !ent:IsPlayer() then return end

	kingston.bonemerge.manageEntities(ent, transmit, true)
end)

hook.Add("NetworkEntityCreated", "STALKER.BonemergeUpdate", function(ent) 
	if !ent:IsPlayer() then return end
	
	kingston.bonemerge.manageEntities(ent, true, true)
end)

hook.Add("EntityRemoved", "STALKER.BonemergeUpdate", function(ent)
	if !ent:IsPlayer() then return end

	kingston.bonemerge.manageEntities(ent, nil, true)
end)

hook.Add("OnReloaded", "STALKER.BonemergeUpdate", function()
	kingston.bonemerge.fullUpdate()
end)

gameevent.Listen("player_spawn")
hook.Add("player_spawn", "STALKER.BonemergeUpdate", function(data)
	local ply = Player(data.userid)
	if !IsValid(ply) then return end

	if !GAMEMODE.EfficientModelCheck[ply:GetModel()] then
		kingston.bonemerge.manageEntities(ply, nil, true)

		return
	end

	kingston.bonemerge.manageEntities(ply, true, true)

	if ply == LocalPlayer() then
		kingston.bonemerge.fullUpdate()
	end
end)

gameevent.Listen("entity_killed")
hook.Add("entity_killed", "STALKER.BonemergeUpdate", function(data)
	local ent = Entity(data.entindex_killed)
	if !ent:IsPlayer() then return end

	// closure, but we need to wait for the ragdoll to be created
	timer.Create("BonemergeSwitchParent"..data.entindex_killed, 0, 0, function()
		if !IsValid(ent) then 
			timer.Remove("BonemergeSwitchParent"..data.entindex_killed)
			return
		end

		local ragdoll = ent:GetRagdollEntity()
		if !IsValid(ragdoll) then return end

		kingston.bonemerge.manageEntities(ent, nil, nil, ragdoll)
		timer.Remove("BonemergeSwitchParent"..data.entindex_killed)
	end)
end)

hook.Add("Think", "STALKER.BonemergeRefresh", function()
	local nextRefresh = GAMEMODE.nextBonemergeRefresh
	if !nextRefresh then
		GAMEMODE.nextBonemergeRefresh = CurTime()
		nextRefresh = GAMEMODE.nextBonemergeRefresh
	end

	if nextRefresh <= CurTime() then
		kingston.bonemerge.fullUpdate()

		GAMEMODE.nextBonemergeRefresh = CurTime() + 60
	end
end)

gameevent.Listen("player_disconnect")
hook.Add("player_disconnect", "STALKER.BonemergeUpdate", function(data)
	local ply = Player(data.userid)
	if !IsValid(ply) then return end

	local charId = ply:CharID()
	if charId == 0 then return end

	local charData = kingston.bonemerge.data[charId]
	if !charData then return end

	local transmittedItems = charData.items
	if !transmittedItems then return end

	for itemId,itemData in next, transmittedItems do
		kingston.bonemerge.remove(charId, itemId)
	end
end)

hook.Add("PlayerModelChanged", "STALKER.BonemergeUpdate", function(ply)
	if !IsValid(ply) then return end
	
	if !GAMEMODE.EfficientModelCheck[ply:GetModel()] then
		kingston.bonemerge.manageEntities(ply, nil, true)
		return
	end

	kingston.bonemerge.manageEntities(ply, true, true)
end)

local ACCESSOR_HOOKS = {
	RagdollIndex = function(ply, key, value)
		if value != -1 then
			// closure, but we need to wait for the ragdoll to be created
			timer.Create("BonemergeSwitchParent"..value, 0, 0, function()
				if !IsValid(ply) then 
					timer.Remove("BonemergeSwitchParent"..value)
					return
				end

				local ragdoll = ply:Ragdoll()
				if !IsValid(ragdoll) then return end
	
				kingston.bonemerge.manageEntities(ply, nil, nil, ragdoll)
				timer.Remove("BonemergeSwitchParent"..value)
			end)
		else
			kingston.bonemerge.manageEntities(ply, true, true)
		end
	end,
	Body = function(ply, key, value)
		if !ply.CharID then return end

		local charId = ply:CharID()
		if charId == 0 then return end

		local charData = kingston.bonemerge.data[charId]
		if !charData then
			kingston.bonemerge.data[charId] = {}
			charData = kingston.bonemerge.data[charId]
		end

		local charParts = charData.parts
		if !charParts then
			charData.parts = {}
			charParts = charData.parts
		end

		charParts[string.lower(key)] = {
			model = value
		}

		kingston.bonemerge.manageEntities(ply, true, true)
	end,
	BodySubMat = function(ply, key, value)
		kingston.bonemerge.manageEntities(ply, true, true)
	end
}

hook.Add("PlayerAccessorChanged", "STALKER.BonemergeUpdate", function(ply, key, value)
	local accessorHook = ACCESSOR_HOOKS[key]
	if !accessorHook then return end

	accessorHook(ply, key, value)
end)

local function DrawBonemergedShadows(ply)
	if cookie.GetNumber("zc_settings_bonemerge_shadows", 1) == 0 then return end
	if !IsValid(ply) or !ply:Alive() then return end
	
	local charId = ply:CharID()
	if !charId or charId == 0 then return end

	local charData = kingston.bonemerge.data[charId]
	if !charData then return end

	local charParts = charData.parts
	if !charParts then return end

	local bodyEntity = charParts.body.entity
	if IsValid(bodyEntity) then
		bodyEntity:CreateShadow()
	end

	local charItems = charData.items
	if !charItems then return end

	for _,itemData in next, charItems do
		local entity = itemData.entity
		if !IsValid(entity) then continue end

		entity:CreateShadow()
	end
end
hook.Add("PostPlayerDraw", "STALKER.DrawBonemergedShadows", DrawBonemergedShadows)