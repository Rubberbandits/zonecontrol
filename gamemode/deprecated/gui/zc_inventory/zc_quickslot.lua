local PANEL = {}

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
	self:SetZPos(32767)
	self:Droppable("zc_quickslot")
	self:Receiver("zc_item", function(pnl, dropped, has_dropped, index, x, y)
		local dragged_pnl = dropped[1]
		if has_dropped then
			local dropped_item = dragged_pnl.Item
			
			if !dropped_item.QuickUse or (dropped_item.CanQuickUse and !dropped_item:CanQuickUse()) then
				GAMEMODE.Inventory:PopulateItems() 
				return
			end
			
			pnl:SetBoundItem(dropped_item)
			GAMEMODE.Inventory:PopulateItems()
		end
	end)
	
	self.Binder = vgui.Create("DBinder", self)
	self.Binder:SetSize(ScreenScaleH(16), ScreenScaleH(8))
	self.Binder:SetPos(0,self:GetTall() - self.Binder:GetTall())
	self.Binder.OnChange = function(pnl, key)
		kingston.quickslot.set_bind(self.BindIndex, key)
	end
end

function PANEL:SetModel(strModelName)
	-- Note - there's no real need to delete the old
	-- entity, it will get garbage collected, but this is nicer.
	if ( IsValid( self.Entity ) ) then
		self.Entity:Remove()
		self.Entity = nil
	end

	-- Note: Not in menu dll
	if ( !ClientsideModel ) then return end

	self.Entity = ClientsideModel( strModelName, RENDERGROUP_OTHER )
	if ( !IsValid( self.Entity ) ) then return end

	self.Entity:SetNoDraw( true )
	self.Entity:SetIK( false )
	
	self:BestGuessLayout()
end

function PANEL:GetModel()
	return self.Entity:GetModel()
end

function PANEL:Paint( w, h )
	if self.BoundItem and !self.BoundItem.IsItem then
		self:ClearBoundItem()
		return
	end
		

	if !self.MetaItem and self.BoundItem then
		self.MetaItem = GAMEMODE:GetItemByID(self.BoundItem:GetClass())
	end
	
	if !self:IsDragging() and self.BoundItem then
		if !self.NoHover then
			if self:IsHovered() and !self.LastHovered then
				self.HoverStart = RealTime()
			end
			
			if self.HoverStart and self.HoverStart + 1 <= RealTime() then
				GAMEMODE.ItemTooltipPanel = self
				if !GAMEMODE.ItemTooltipUpdated then
					GAMEMODE:UpdateItemTooltipPanel(self.BoundItem)
				end
			end
			
			if !self:IsHovered() and self.LastHovered then
				self.HoverStart = nil
				GAMEMODE.ItemTooltipPanel = nil
				GAMEMODE.ItemTooltipUpdated = nil
			end
		end
	end
	
	if ( !IsValid( self.Entity ) ) then return end

	local x, y = self:LocalToScreen( 0, 0 )

	self:LayoutEntity( self.Entity )

	local ang = self.aLookAngle
	if ( !ang ) then
		ang = ( self.vLookatPos - self.vCamPos ):Angle()
	end

	cam.Start3D( self.vCamPos, ang, self.fFOV, x, y, w, h, 5, self.FarZ )
		render.SuppressEngineLighting( true )
		render.SetLightingOrigin( self.Entity:GetPos() )
		render.ResetModelLighting( self.colAmbientLight.r / 255, self.colAmbientLight.g / 255, self.colAmbientLight.b / 255 )
		render.SetColorModulation( self.colColor.r / 255, self.colColor.g / 255, self.colColor.b / 255 )
		render.SetBlend( ( self:GetAlpha() / 255 ) * ( self.colColor.a / 255 ) ) -- * surface.GetAlphaMultiplier()

		for i = 0, 6 do
			local col = self.DirectionalLight[ i ]
			if ( col ) then
				render.SetModelLighting( i, col.r / 255, col.g / 255, col.b / 255 )
			end
		end

		self:DrawModel()

		render.SuppressEngineLighting( false )
	cam.End3D()
	
	if self.BoundItem.Paint then
		self.BoundItem:Paint(self, w, h)
	end
	
	self.LastPaint = RealTime()
	self.LastHovered = self:IsHovered()
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
	self:MouseCapture(false)
	
	if self:DragMouseRelease(iCode) then
		return
	end
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

function PANEL:SetBoundItem(item)
	local bind = kingston.quickslot.is_bound(self.Binder:GetSelectedNumber())
	if !bind then return end
	
	for k,v in next, kingston.quickslot.get_binds() do
		if v.BoundItem == item then
			v.BoundItem = nil
		end
	end
	
	for k,v in next, self:GetParent():GetChildren() do
		if v.BoundItem == item then
			v:ClearBoundItem()
		end
	end
	
	bind.BoundItem = item
	self.BoundItem = item
	self:SetModel(item:GetModel())

	if item.GetBodygroupCategory then
		self.Entity:SetBodygroup(item:GetBodygroupCategory(), item:GetBodygroup())
	end
	
	if item.Base == "clothes" then
		local submats = item:GetItemSubmaterials()
		if submats then
			for m,n in next, submats do
				self.Entity:SetSubMaterial(n[1], n[2])
			end
		end
	else
		if item.ItemSubmaterials then
			for m,n in next, item.ItemSubmaterials do
				self.Entity:SetSubMaterial(n[1], n[2])
			end
		end
	end
end

function PANEL:ClearBoundItem()
	local bind = kingston.quickslot.is_bound(self.Binder:GetSelectedNumber())
	if !bind then return end
	
	bind.BoundItem = nil
	self.BoundItem = nil
	self:SetModel("")
end

function PANEL:SetBind(index)
	local data = kingston.quickslot.get_binds()[index]
	if !data then return end
	
	self.BindIndex = index
	self.Binder:SetPos(0,self:GetTall() - self.Binder:GetTall())
	if data.key then
		self.Binder:SetSelectedNumber(data.key)
	end
	if data.BoundItem and data.BoundItem.IsItem then
		self:SetBoundItem(data.BoundItem)
	elseif data.BoundItem then
		self:ClearBoundItem()
	end
end

vgui.Register("zc_quickslot", PANEL, "DModelPanel")