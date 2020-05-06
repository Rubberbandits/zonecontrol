local PANEL = { };

AccessorFunc(PANEL, "Entity", 			"Entity")
AccessorFunc(PANEL, "vCamPos", 		"CamPos")
AccessorFunc(PANEL, "fFOV", 			"FOV")
AccessorFunc(PANEL, "vLookatPos", 		"LookAt")
AccessorFunc(PANEL, "colAmbientLight", "AmbientLight")
AccessorFunc(PANEL, "colColor", 		"Color")

function PANEL:Init()
	self.LastPaint = 0
	
	self:SetText("")
	
	self:SetAmbientLight(Color(50, 50, 50))
	
	self:SetDirectionalLight(BOX_TOP, Color(255, 255, 255))
	self:SetDirectionalLight(BOX_FRONT, Color(255, 255, 255))
	
	self:SetColor(Color(255, 255, 255, 255))
	
	self.Entity = ClientsideModel("models/humans/group01/male_01.mdl", RENDER_GROUP_OPAQUE_ENTITY)
	self.Entity:SetPos(Vector(0, 0, 10000)) -- not sure if this is a good idea.
end

function PANEL:SetModel(strModelName)
	self.Entity:SetModel(strModelName)
	self:BestGuessLayout()
end

function PANEL:GetModel()
	return self.Entity:GetModel()
end

function PANEL:PaintToolTip()
	hook.Run("PaintItemTip", self, self.Item)
end

function PANEL:Paint( w, h )
	if !self.MetaItem and self.Item then
		self.MetaItem = GAMEMODE:GetItemByID(self.Item:GetClass())
	end

	if self:IsDragging() then
		surface.SetDrawColor(Color(255, 255, 255, 255))
		surface.DrawOutlinedRect(0, 0, w, h)
	end
	
	if !self:IsDragging() then
		if self:IsHovered() and !self.LastHovered then
			self.HoverStart = RealTime()
		end
		
		if !self:IsHovered() and self.LastHovered then
			self.HoverStart = 0
		end
	end
	
	if IsValid(self.Entity) then return end

	local x, y = self:LocalToScreen(0, 0)
	self:LayoutEntity(self.Entity)
	
	cam.Start3D(self.vCamPos, (self.vLookatPos-self.vCamPos):Angle(), self.fFOV, x, y, self:GetSize())
		cam.IgnoreZ(true)
		
		render.SuppressEngineLighting(true)
		render.SetLightingOrigin(self.Entity:GetPos())
		render.ResetModelLighting(self.colAmbientLight.r/255, self.colAmbientLight.g/255, self.colAmbientLight.b/255)
		render.SetColorModulation(self.colColor.r/255, self.colColor.g/255, self.colColor.b/255)
		render.SetBlend(self.colColor.a / 255)
		
		for i=0, 6 do
			local col = self.DirectionalLight[i]
			if col then
				render.SetModelLighting(i, col.r/255, col.g/255, col.b/255)
			end
		end
		
		self:DrawModel()
		
		render.SuppressEngineLighting(false)
		cam.IgnoreZ(false)
	cam.End3D()
	
	if self.Item.Paint then
		self.Item:Paint(self, w, h)
	end
	
	self:PaintToolTip()
	
	self.LastPaint = RealTime()
	self.LastHovered = self:IsHovered()
end

function PANEL:DrawModel() -- base DModelPanel
	local curparent = self
	local rightx = self:GetWide()
	local leftx = 0
	local topy = 0
	local bottomy = self:GetTall()
	local previous = curparent
	while(curparent:GetParent() != nil) do
		curparent = curparent:GetParent()
		local x,y = previous:GetPos()
		topy = math.Max(y, topy+y)
		leftx = math.Max(x, leftx+x)
		bottomy = math.Min(y+previous:GetTall(), bottomy + y)
		rightx = math.Min(x+previous:GetWide(), rightx + x)
		previous = curparent
	end
	render.SetScissorRect(leftx,topy,rightx, bottomy, true)
	self.Entity:DrawModel()
	render.SetScissorRect(0,0,0,0, false)
end

function PANEL:PaintOver( w, h )
	self:Paint(w, h)
end

function PANEL:LayoutEntity( Entity )
	
end

function PANEL:OnMousePressed( iCode )
	if self:IsDraggable() and iCode == MOUSE_LEFT then
		self:MouseCapture(true)
		self:DragMousePress(iCode)
	end
	
	if self.Click and self.Item then
		self:Click(self.Item, GAMEMODE:GetItemByID(self.Item.Class))
		
		return
	end
	
end

function PANEL:OnMouseReleased( iCode ) 
	if input.IsKeyDown(KEY_LSHIFT) then
		print("KEY_LSHIFT")
	
		-- split stack in half
	elseif input.IsKeyDown(KEY_LCONTROL) then
		print("KEY_LCONTROL")
	
		-- take one from stack
	end
	
	-- maybe control+shift for manual number input.
	
	if iCode == MOUSE_RIGHT then
		self:CreateActionMenu()
	end
	
	self:MouseCapture(false)
	
	if self:DragMouseRelease(iCode) then
		return
	end
	
end

function PANEL:CreateActionMenu()

end

function PANEL:BestGuessLayout()
	if self.Item then
		local metaitem = GAMEMODE:GetItemByID( self.Item.Class );
		if metaitem.CamPos and metaitem.FOV and metaitem.LookAt then
			self:SetCamPos(metaitem.CamPos)
			self:SetFOV(metaitem.FOV)
			self:SetLookAt(metaitem.LookAt)
	
			return
		end
	end
	
	local ent = self:GetEntity()
	local pos = ent:GetPos()
	local tab = PositionSpawnIcon(ent, pos)
	
	if tab then 
		self:SetCamPos(tab.origin)
		self:SetFOV(tab.fov)
		self:SetLookAt(tab.origin + tab.angles:Forward() * 2048)
	end
end

vgui.Register( "CItem", PANEL, "DModelPanel" );