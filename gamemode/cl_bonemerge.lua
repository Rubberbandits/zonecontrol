local s_Meta = FindMetaTable("Player")

function s_Meta:CreateNewBonemerge(szModel, iBoneScale)
	if !IsValidModel(szModel) then return end

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
			if !self.LastParent then
				if !self.bLastAliveState then
					self.bLastAliveState = ply:Alive()
				end
				
				if !self.nLastCharID then
					self.nLastCharID = ply:CharID()
				end
			else
				if !self.bLastAliveState then
					self.bLastAliveState = self.LastParent:Alive()
				end
				
				if !self.nLastCharID then
					self.nLastCharID = self.LastParent:CharID()
				end
			end
	
			if ply:GetMoveType() == MOVETYPE_NOCLIP and ply:GetNoDraw() and !self.bLastDrawState then
				self:SetNoDraw(true)
			elseif !ply:GetNoDraw() and self.bLastDrawState then
				self:SetNoDraw(false)
			end

			if !self.LastParent then
				if !ply:Alive() and self.bLastAliveState then
					self.LastParent = ply
					self:SetParent(ply:GetRagdollEntity())
					self:AddEffects(EF_BONEMERGE)
				end
				
				if ply:CharID() != self.nLastCharID then
					GAMEMODE.BonemergeEntities[self] = nil
					GAMEMODE:RemoveBonemergedItemCache(ply)
					self:Remove()
				end
			else
				if self.LastParent:Alive() and !self.bLastAliveState then
					self:SetParent(self.LastParent)
					self:AddEffects(EF_BONEMERGE)
					self.LastParent = nil
				end
				
				if self.LastParent:CharID() != self.nLastCharID then
					GAMEMODE.BonemergeEntities[self] = nil
					GAMEMODE:RemoveBonemergedItemCache(ply)
					self:Remove()
				end
			end
		else
			if !IsValid(self.LastParent) then
				GAMEMODE:RemoveBonemergedItemCache(ply)
				self:Remove()
			else
				self:SetParent(self.LastParent)
				self:AddEffects(EF_BONEMERGE)
				self.LastParent = nil
			end
		end
		
		self.bLastDrawState = self:GetNoDraw()
		if !self.LastParent then
			if IsValid(ply) then
				self.bLastAliveState = ply:Alive()
				self.nLastCharID = ply:CharID()
			end
		else
			if !IsValid(self.LastParent) then return end
		
			self.bLastAliveState = self.LastParent:Alive()
			self.nLastCharID = self.LastParent:CharID()
		end
	end
	hook.Add("Think", b, b.Think)
	
	if iBoneScale then
		for i = 0, b:GetBoneCount() - 1 do 
			b:ManipulateBoneScale(i, Vector(iBoneScale, iBoneScale, iBoneScale))
		end
	end
	
	GAMEMODE.BonemergeEntities[b] = b
	return b
end

GM.BonemergeItems = GM.BonemergeItems or {}
GM.BonemergeItemKeys = GM.BonemergeItemKeys or {}
GM.BonemergeEntities = GM.BonemergeEntities or {}
GM.BonemergeBodies = GM.BonemergeBodies or {}
GM.BodyHidden = GM.BodyHidden or {}

function GM:OnReceiveDummyItem(s_iID, s_DummyItem)
	local metaitem = GAMEMODE:GetItemByID(s_DummyItem.szClass)
	if !self.BonemergeItems[s_iID] then
		self.BonemergeItems[s_iID] = {
			Owner = s_DummyItem.Owner,
			szClass = s_DummyItem.szClass,
			Vars = s_DummyItem.Vars,
			CharID = s_DummyItem.CharID,
			ID = s_iID,
		}
		
		table.insert(self.BonemergeItemKeys, s_iID)
		self.BonemergeItems[s_iID].Key = #self.BonemergeItemKeys
	else
		self.BonemergeItems[s_iID].Vars = s_DummyItem.Vars
		self.BonemergeItems[s_iID].CharID = s_DummyItem.CharID
	end

	if s_DummyItem.Vars["Equipped"] then
		if metaitem.RemoveBody then
			self.BodyHidden[s_DummyItem.Owner] = true
			if self.BonemergeBodies[s_DummyItem.Owner] then
				self.BonemergeBodies[s_DummyItem.Owner]:Remove()
				self.BonemergeBodies[s_DummyItem.Owner] = nil
			end
		end
	elseif !s_DummyItem.Vars["Equipped"] then
		local owner = self.BonemergeItems[s_iID]["Owner"]
		if self.BonemergeItems[s_iID].BonemergedEntity then
			self.BonemergeItems[s_iID].BonemergedEntity:Remove()
			self.BonemergeItems[s_iID].BonemergedEntity = nil
		end
		
		if metaitem.RemoveBody and !self.BonemergeBodies[s_DummyItem.Owner] then
			self.BodyHidden[s_DummyItem.Owner] = false

			if s_DummyItem.Owner.Body then
				local body = s_DummyItem.Owner:Body()
				if !body or #body == 0 then return end

				self.BonemergeBodies[s_DummyItem.Owner] = s_DummyItem.Owner:CreateNewBonemerge(s_DummyItem.Owner:Body())
				self.BonemergeBodies[s_DummyItem.Owner]:SetSubMaterial(0, s_DummyItem.Owner:BodySubMat())
			end
		end
	end
	
	-- cant use full item info
	if metaitem.DummyItemUpdate then
		metaitem.DummyItemUpdate(s_DummyItem, self.BonemergeItems[s_iID].BonemergedEntity)
	end
end

function GM:RemoveBonemergedItemCache(ply)
	self.BodyHidden[ply] = false
	if self.BonemergeBodies[ply] and self.BonemergeBodies[ply]:IsValid() then
		self.BonemergeBodies[ply]:Remove()
		self.BonemergeBodies[ply] = nil
	end
	
	for k,v in next, self.BonemergeItems do
		if v.Owner == ply then
			if v.BonemergedEntity then
				v.BonemergedEntity:Remove()
				v.BonemergedEntity = nil
			end
		end
	end
end

local function ProcessBonemergeItems(ply)
	local ent_found
	for _,m in ipairs(GAMEMODE.BonemergeItemKeys) do
		local n = GAMEMODE.BonemergeItems[m]

		if n.Owner == ply and n.CharID != ply:CharID() then
			if n.BonemergedEntity then
				n.BonemergedEntity:Remove()
			end
			n.BonemergedEntity = nil
			table.remove(GAMEMODE.BonemergeItemKeys, n.Key)
			GAMEMODE.BonemergeItems[m] = nil
			
			continue
		end
		
		if n.Owner == ply and (!n.BonemergedEntity or !IsValid(n.BonemergedEntity)) and n.Vars["Equipped"] then
			local metaitem = GAMEMODE:GetItemByID(n.szClass)
			if metaitem.Bonemerge then
				local mdl = metaitem.Bonemerge
				local scale
				
				if metaitem.AllowGender then
					if ply:Gender() == GENDER_FEMALE then
						mdl = string.StripExtension(mdl).."_f.mdl"
					end
				elseif metaitem.ScaleForGender and ply:Gender() == GENDER_FEMALE then
					scale = metaitem.ScaleForGender
				end
		
				n.BonemergedEntity = ply:CreateNewBonemerge(mdl, scale)
				if n.BonemergedEntity then
					ent_found = true
				end
				
				if !n.BonemergedEntity or !IsValid(n.BonemergedEntity) then
					continue -- outside of pvs? creation failed.
				end

				if metaitem.RemoveBody and GAMEMODE.BonemergeBodies[ply] then
					GAMEMODE.BonemergeBodies[ply]:Remove()
					GAMEMODE.BonemergeBodies[ply] = nil
				end
			
				if metaitem.Bodygroups then
					for _,bodygroup in next, metaitem.Bodygroups do
						-- first key in bodygroup is bodygroup index
						-- second key in bodygroup is bodygroup value
						
						n.BonemergedEntity:SetBodygroup(bodygroup[1], bodygroup[2])
					end
				end
				
				if metaitem.Submaterials then
					for _,submaterial in next, metaitem.Submaterials do
						n.BonemergedEntity:SetSubMaterial(submaterial[1], submaterial[2])
					end
				end
				
				if n.Vars["SuitClass"] and GAMEMODE.SuitVariants[n.Vars["SuitClass"]] then
					local suit = GAMEMODE.SuitVariants[n.Vars["SuitClass"]]
					if suit.Submaterial then
						for _,submaterial in next, suit.Submaterial do
							n.BonemergedEntity:SetSubMaterial(submaterial[1], submaterial[2])
						end
					end
				end
				
				if metaitem.DummyItemUpdate then
					metaitem.DummyItemUpdate(n, n.BonemergedEntity)
				end
			end
		elseif !n.Vars["Equipped"] and n.BonemergedEntity then
			n.BonemergedEntity:Remove()
			n.BonemergedEntity = nil
		elseif n.Owner == ply and n.BonemergedEntity then
			ent_found = true
		elseif !IsValid(n.Owner) and n.CharID == ply:CharID() then
			n.Owner = ply
		end
	end
	
	return ent_found
end

local function ProcessBody(ply)
	if !GAMEMODE.BodyHidden[ply] and !IsValid(GAMEMODE.BonemergeBodies[ply]) then
		GAMEMODE.BonemergeBodies[ply] = ply:CreateNewBonemerge(ply:Body())
		if !IsValid(GAMEMODE.BonemergeBodies[ply]) then return end
		GAMEMODE.BonemergeBodies[ply]:SetSubMaterial(0, ply:BodySubMat())
	elseif GAMEMODE.BodyHidden[ply] and IsValid(GAMEMODE.BonemergeBodies[ply]) then
		GAMEMODE.BonemergeBodies[ply]:Remove()
		GAMEMODE.BonemergeBodies[ply] = nil
	end
end

local function BonemergeThink()
	for k,v in ipairs(player.GetAll()) do
		if !IsValid(v) then continue end
		if !v.CharID then continue end
		if v:CharID() <= 0 then continue end
		if v:IsDormant() then continue end
		if !GAMEMODE.EfficientModelCheck[v:GetModel()] and !v.CacheCleared then GAMEMODE:RemoveBonemergedItemCache(v) v.CacheCleared = true continue end
		if v:GetNoDraw() then continue end
		if #v:Body() == 0 then continue end
		
		ProcessBody(v)
		local ent_found = ProcessBonemergeItems(v)
		
		if (!GAMEMODE.BonemergeBodies[v] or !IsValid(GAMEMODE.BonemergeBodies[v])) and !ent_found then
			GAMEMODE.BodyHidden[v] = false
			ProcessBody(v)
		elseif GAMEMODE.BonemergeBodies[v] and IsValid(GAMEMODE.BonemergeBodies[v]) and ent_found and !GAMEMODE.BodyHidden[v] then
			GAMEMODE.BodyHidden[v] = true
			ProcessBody(v)
		end
	end
end
hook.Add("Think", "STALKER.BonemergeThink", BonemergeThink)

local function HandleBodySubMatChange(ply, key, value)
	if key == "BodySubMat" then
		if IsValid(GAMEMODE.BonemergeBodies[ply]) then
			GAMEMODE.BonemergeBodies[ply]:SetSubMaterial(0, value)
		end
	end
end
hook.Add("PlayerAccessorChanged", "STALKER.HandleBodySubMatChange", HandleBodySubMatChange)

local function DrawBonemergedShadows(ply)
	if !IsValid(ply) or !ply:Alive() then return end
	
	if IsValid(GAMEMODE.BonemergeBodies[ply]) then
		GAMEMODE.BonemergeBodies[ply]:CreateShadow()
	end
	
	for _,m in ipairs(GAMEMODE.BonemergeItemKeys) do
		local n = GAMEMODE.BonemergeItems[m]

		if !n then continue end

		if n.Owner == ply and IsValid(n.BonemergedEntity) and n.Vars["Equipped"] then
			n.BonemergedEntity:CreateShadow()
		end
	end
end
hook.Add("PostPlayerDraw", "STALKER.DrawBonemergedShadows", DrawBonemergedShadows)