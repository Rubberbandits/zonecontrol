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
	self:SetZPos(32767)
	self:Droppable("zc_item")
	self:Receiver("zc_item", function(pnl, dropped, has_dropped, index, x, y)
		local dragged_pnl = dropped[1]
		if has_dropped then
			local item = pnl.Item
			local dropped_item = dragged_pnl.Item
			
			if dropped_item == item then GAMEMODE.Inventory:PopulateItems() return end

			if item:CanStack(dropped_item) then
				netstream.Start("StackItem", item:GetID(), dropped_item:GetID())
			
				item:OnStack(dropped_item)
			end
			
			GAMEMODE.Inventory:PopulateItems()
		end
	end)
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
	if !self.MetaItem and self.Item then
		self.MetaItem = GAMEMODE:GetItemByID(self.Item:GetClass())
	end

	if self:IsDragging() and self.PaintingDragging then
		local drag_w = ScreenScaleH(29) * self.Item.W
		local drag_h = ScreenScaleH(29) * self.Item.H
		
		surface.SetDrawColor(Color(200, 200, 200, 100))
		surface.DrawOutlinedRect((w / 2) - (drag_w / 2), (h / 2) - (drag_h / 2), drag_w, drag_h)
	end
	
	if !self:IsDragging() then
		if !self.NoHover then
			if self:IsHovered() then
				if !self.LastHovered then
					self.HoverStart = RealTime()
				end

				surface.SetDrawColor(150, 150, 150, 30)
				surface.DrawRect(0, 0, w, h)
			end
			
			if self.HoverStart and self.HoverStart + 1 <= RealTime() then
				GAMEMODE.ItemTooltipPanel = self
				if !GAMEMODE.ItemTooltipUpdated then
					GAMEMODE:UpdateItemTooltipPanel(self.Item)
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
	
	if self.Item.Paint then
		self.Item:Paint(self, w, h)
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
	if iCode == MOUSE_RIGHT then
		self:CreateActionMenu()
	end
	
	self:MouseCapture(false)
	
	if self:DragMouseRelease(iCode) then
		return
	end
end

function PANEL:CreateActionMenu()
	if !self.Item then return end
	if self.ActionMenuDisabled then return end

	self.action_menu = vgui.Create("DMenu")
	self.action_menu:SetSkin("zc_inventory")
	
	local item = self.Item
	local metaitem = GAMEMODE:GetItemByID(item:GetClass())
	if item.functions then
		for k,v in next, item.functions do
			if v.CanRun(item) then
				self.action_menu:AddOption((isfunction(v.SelectionName) and string.lower(v.SelectionName(item))) or string.lower(v.SelectionName), function()
					self.Item:CallFunction(k, true)
					
					GAMEMODE.Inventory:PopulateItems()
				end)
				
				self.action_menu:SetPaintBackground(true)
			end
		end
	end
	if self.Item.DynamicFunctions then
		for k,v in next, self.Item:DynamicFunctions() do
			if v.CanRun(item) then
				self.action_menu:AddOption(v.SelectionName, function()
					netstream.Start("ItemCallDynamicFunction", item:GetID(), k)
					v.OnUse(item)
					
					GAMEMODE.Inventory:PopulateItems()
				end)
				
				self.action_menu:SetPaintBackground(true)
			end
		end
	end
	if item.CanDrop then
		if item:CanDrop() then
			if InStockpileRange(LocalPlayer()) then
				self.action_menu:AddOption("stockpile", function()
					GAMEMODE:PMCreateStockpilesMenu()
					netstream.Start("nRequestMoveStockpiles");
				end)
			end
			
			if LocalPlayer():IsAdmin() then
				self.action_menu:AddOption("edit", function()
					GAMEMODE.ItemEditor = vgui.Create("CItemCreator")
					GAMEMODE.ItemEditor:SetItem(item)
				end)
			end
			
			if LocalPlayer():HasCharFlag("X") and item.BulkPrice and InStockpileRange(LocalPlayer()) and GAMEMODE.SellToMenuEnabled and item:CanSell() then
				self.action_menu:AddOption("sell for "..GAMEMODE:CalculatePrice(item).." RU", function()
					LocalPlayer():SellItemToMenu(item:GetID())
					GAMEMODE.Inventory:PopulateItems()
				end)
			end
			
			if item.CanSplitStack and item:CanSplitStack() then
				self.action_menu:AddOption("split", function()
					netstream.Start("SplitStack", item:GetID())
					GAMEMODE.Inventory:PopulateItems()
				end)
			end
		
			self.action_menu:AddOption("drop", function()
				netstream.Start("ItemDrop", item:GetID())
				item:DropItem()
				
				GAMEMODE.Inventory:PopulateItems()
			end)
		end
	end
	
	GAMEMODE.Inventory.SelectedItem = item
	
	self.action_menu:SetPaintBackground( true );
	self.action_menu:Open( gui.MouseX(), gui.MouseY(), nil, self:GetParent() );
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

vgui.Register( "zc_item", PANEL, "DModelPanel" );