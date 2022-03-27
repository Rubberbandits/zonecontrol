PANEL = {}
PANEL.m_DetectorType = -1

local panelVerts = {
	{pos = Vector(1, 1, 0), normal = Vector(0, 0, 1), u = 1, v = 0, color = Color(255, 255, 255, 255)},
	{pos = Vector(-1, -1, 0), normal = Vector(0, 0, 1), u = 0, v = 1, color = Color(255, 255, 255, 255)},
	{pos = Vector(-1, 1, 0), normal = Vector(0, 0, 1), u = 0, v = 0, color = Color(255, 255, 255, 255)},
	{pos = Vector(1, 1, 0), normal = Vector(0, 0, 1), u = 1, v = 0, color = Color(255, 255, 255, 255)},
	{pos = Vector(1, -1, 0), normal = Vector(0, 0, 1), u = 1, v = 1, color = Color(255, 255, 255, 255)},
	{pos = Vector(-1, -1, 0), normal = Vector(0, 0, 1), u = 0, v = 1, color = Color(255, 255, 255, 255)},
}
local testMesh = Mesh()
testMesh:BuildFromTriangles(panelVerts)

local bearmat = Material("materials/models/kali/miscstuff/stalker/detectors/detector_bear_display.png", "noclamp smooth")
local velesmat = Material("materials/models/kali/miscstuff/stalker/detectors/detector_veles_display.png", "noclamp smooth")
local typeTable = {
	[DETECTOR_ECHO] = {
		model = "models/kali/miscstuff/stalker/detector_echo.mdl",
		bodygroup = {
			["cover"] = 1,
		},
		skin = 1,
		fov = 6,
		campos = Vector(-50, 0, 50),
		lookat = Vector(0, 0, 0),
		think = function(self)
			local nearestArt = nil
			
			local ents = ents.FindInSphere(LocalPlayer():GetPos(), 768)
			for k,v in pairs(ents) do
				if v:GetClass() == "cc_item" and v.GetItemClass then
					local metaitem = GAMEMODE:GetItemByID( v:GetItemClass() );
					if metaitem.Artifact and metaitem.Tier <= DETECTOR_ECHO then
						if nearestArt then
							local mp = LocalPlayer():GetPos()
							local p1 = nearestArt:GetPos():DistToSqr(mp)
							local p2 = v:GetPos():DistToSqr(mp)
							if p2 < p1 then
								nearestArt = v
							end
						else
							nearestArt = v
						end
					end
				end
			end
			
			if nearestArt then
				local dist = LocalPlayer():GetPos():Distance(nearestArt:GetPos())
				local minDelay = 0.125
				local maxDelay = 2 - minDelay
				local delay = maxDelay * (math.Clamp(dist - 64, 0, dist) / 704) + minDelay
				
				if not self.lastBeep then
					self.lastBeep = CurTime()
				end
				
				if CurTime() >= self.lastBeep + delay then
					-- beep!
					self.Entity:SetSkin(2)
					timer.Simple(0.025, function()
						if IsValid(self) then
							self.Entity:SetSkin(1)
						end
					end)
					
					EmitSound("stalker-kingston/detectors/echo.wav", LocalPlayer():GetPos(), LocalPlayer():EntIndex(), CHAN_AUTO, 1, 50, SND_NOFLAGS, 100)
					self.lastBeep = CurTime()
				end
			end
		end
	},
	[DETECTOR_BEAR] = {
		model = "models/kali/miscstuff/stalker/detector_bear.mdl",
		bodygroup = {
			["Screen Cover"] = 1,
		},
		skin = 1,
		fov = 6,
		campos = Vector(-50, 0, 50),
		lookat = Vector(0, 0, 0),
		think = function(self)
			local nearestArt = nil
			
			local ents = ents.FindInSphere(LocalPlayer():GetPos(), 768)
			for k,v in pairs(ents) do
				if v:GetClass() == "cc_item" and v.GetItemClass then
					local metaitem = GAMEMODE:GetItemByID( v:GetItemClass() );
					if metaitem.Artifact and metaitem.Tier <= DETECTOR_BEAR then
						if nearestArt then
							local mp = LocalPlayer():GetPos()
							local p1 = nearestArt:GetPos():DistToSqr(mp)
							local p2 = v:GetPos():DistToSqr(mp)
							if p2 < p1 then
								nearestArt = v
							end
						else
							nearestArt = v
						end
					end
				end
			end
			
			if nearestArt then
				self.nearestArt = nearestArt
				local dist = LocalPlayer():GetPos():Distance(nearestArt:GetPos())
				local minDelay = 0.125
				local maxDelay = 2 - minDelay
				local delay = maxDelay * (math.Clamp(dist - 92, 0, dist) / 736) + minDelay
				
				if not self.lastBeep then
					self.lastBeep = CurTime()
				end
				
				if CurTime() >= self.lastBeep + delay then
					-- beep!
					EmitSound("stalker-kingston/detectors/echo.wav", LocalPlayer():GetPos(), LocalPlayer():EntIndex(), CHAN_AUTO, 1, 50, SND_NOFLAGS, 100)
					self.lastBeep = CurTime()
				end
			end
		end,
		paintoverlay = function(self, w, h)
			if IsValid(self.nearestArt) then
				if LocalPlayer():GetPos():Distance(self.nearestArt:GetPos()) > 768 then
					self.nearestArt = nil
					return
				end
				local AngleTo = (LocalPlayer():EyePos() - self.nearestArt:GetPos()):Angle().y
				local AngleToTest = (AngleTo - LocalPlayer():GetAngles().y) / 15
				AngleToTest = math.Round(AngleToTest) * 15
				
				local overlayPos = Vector(1.6, 0, 1.35)
				overlayPos = self.Entity:LocalToWorld(overlayPos)
				
				local m = Matrix()
				m:Translate(overlayPos)
				m:Rotate(self.Entity:GetAngles() + Angle(-10, 0, 0))
				m:Rotate(Angle(0, 90 + AngleToTest, 0))
				m:SetScale(Vector(1.25, 1.25, 1.25))
				cam.PushModelMatrix(m)
					render.SetMaterial(bearmat)
					testMesh:Draw()
				cam.PopModelMatrix()
			end
		end,
	},
	[DETECTOR_VELES] = {
		model = "models/kali/miscstuff/stalker/detector_veles.mdl",
		bodygroup = {
			["Screen"] = 1,
		},
		skin = 1,
		fov = 6,
		campos = Vector(-38, 0, 40),
		lookat = Vector(0, 0, 0),
		think = function(self)
			self.ArtifactList = {}
			
			local ents = ents.FindInSphere(LocalPlayer():GetPos(), 768)
			for k,v in pairs(ents) do
				if v:GetClass() == "cc_item" and v.GetItemClass then
					local metaitem = GAMEMODE:GetItemByID( v:GetItemClass() );
					if metaitem.Artifact then
						table.insert(self.ArtifactList, v)
					end
				end
			end
		end,
		paintoverlay = function(self, w, h)
			local arts = self.ArtifactList
			for k,v in pairs(arts) do
				local dir = ((LocalPlayer():GetPos() - v:GetPos()):Angle() - LocalPlayer():GetAngles() - Angle(0, 90, 0))
				local dist = LocalPlayer():GetPos():Distance(v:GetPos())
				dir = Angle(0, dir.y, 0):Forward()
				
				if dist > 768 then continue end
				if dir.y < 0 then continue end
				
				local dist2d = (LocalPlayer():GetPos() - v:GetPos()):Length2D()
				local r = 1.5 * (math.Clamp(dist2d - 32, 0, 736)/736)
				local overlayPos = Vector(1.9 + (r * dir.y), (r * -dir.x), 1.1)
				overlayPos = self.Entity:LocalToWorld(overlayPos)
				
				local m = Matrix()
				m:Translate(overlayPos)
				m:Rotate(self.Entity:GetAngles())
				m:Scale(Vector(0.15, 0.15, 0.15))
				cam.PushModelMatrix(m)
					render.SetMaterial(velesmat)
					testMesh:Draw()
				cam.PopModelMatrix()
			end
		end,
	},
}

function PANEL:Init()
	
end

function PANEL:SetType(n)
	if self.Entity then
		if IsValid(self.Entity) then
			self.Entity:Remove()
		end
		self.Entity = nil
	end
	
	local d = typeTable[n]
	self:SetModel(d.model)
	self:SetCamPos(d.campos)
	self:SetLookAt(d.lookat)
	self:SetFOV(d.fov)
	
	if d.skin then
		self.Entity:SetSkin(d.skin)
	end
	
	for k,v in pairs(d.bodygroup) do
		local id = self.Entity:FindBodygroupByName(k)
		self.Entity:SetBodygroup(id, v)
	end
	
	self.m_DetectorType = n
end

function PANEL:GetType(n)
	return self.m_DetectorType
end

function PANEL:Think()
	local t = self:GetType()
	if t >= 0 then
		local e = ents.FindInSphere(LocalPlayer():GetPos(), 64)
		local d = typeTable[t]
		
		d.think(self)
		
		for k,v in pairs(e) do
			if v:GetNoDraw() then
				if v:GetClass() == "cc_item" and v.GetItemClass then
					local metaitem = GAMEMODE:GetItemByID( v:GetItemClass() );
					if( !metaitem.Artifact ) then return end
					if metaitem.Tier <= t and v:GetNoDraw() and !v.revealed then
						-- artifact has been discovered by player!
						--FIXME
						netstream.Start( "nUnhideItem", v:EntIndex() );
						v.revealed = true
					
						v:SetNoDraw(false)
						if metaitem.ItemSubmaterials then
							for m,n in next, metaitem.ItemSubmaterials do
							
								v:SetSubMaterial( n[1], n[2] );
							
							end
						end
					end
				end
			end
		end
	end
end

function PANEL:Paint( w, h )
	if !IsValid(self.Entity) then return true end
	
	local x, y = self:LocalToScreen(0, 0)
	local ang = (self.vLookatPos-self.vCamPos):Angle()
	cam.Start3D(self.vCamPos, ang, self.fFOV, x, y, w, h, 5, self.FarZ)
		render.SuppressEngineLighting(true)
		render.SetLightingOrigin(self.Entity:GetPos())
		render.ResetModelLighting(0.25, 0.25, 0.25)
		render.SetColorModulation(1, 1, 1)
		render.SetBlend(1)
		
		for i=0, 6 do
			local col = self.DirectionalLight[ i ]
			if ( col ) then
				render.SetModelLighting( i, col.r/255, col.g/255, col.b/255 )
			end
		end
		
		self:DrawModel()
		
		if typeTable[self:GetType()] and typeTable[self:GetType()].paintoverlay then
			typeTable[self:GetType()].paintoverlay(self, w, h)
		end
		
		render.SuppressEngineLighting(false)
	cam.End3D()
	
	return true
end

function PANEL:LayoutEntity(ent)
	if self.bAnimated then
		self:RunAnimation()
	end
	
	ent:SetAngles(Angle(0, RealTime() * 10 % 360, 0))
end
derma.DefineControl( "CCDetector", "", PANEL, "DModelPanel" )