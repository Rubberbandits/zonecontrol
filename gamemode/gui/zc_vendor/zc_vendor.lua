local PANEL = {}

function PANEL:Init()
	self:SetTitle("Vendor")
	self:SetSize(ScrW() * 0.6, ScrH() * 0.8)
	self:Center()
	self:MakePopup()

	self.VendorInventory = self:Add("DScrollPanel")
	self.VendorInventory:Dock(LEFT)
	self.VendorInventory:SetWide(self:GetWide() * 0.49)
	self.VendorInventory:DockMargin(0, 0, 8, 0)

	self.PlayerInventory = self:Add("DScrollPanel")
	self.PlayerInventory:Dock(LEFT)
	self.PlayerInventory:SetWide(self:GetWide() * 0.49)
end

function PANEL:SetVendor(ent)
	self.VendorEntity = ent
end

function PANEL:PopulateInventory()
	self.PlayerInventory:Clear()

	local plyInv = self.PlayerInventory
	local vendInv = self.VendorInventory

	local plyInvY = 0;
	for id,item in next, LocalPlayer().Inventory do
		local class = item:GetClass()
		local metaitem = GAMEMODE:GetItemByID(class)
		local vendorData = self.Items[class]

		if !vendorData or vendorData.BuyFactor <= 0 then continue end

		local itempane = vgui.Create( "DPanel" );
		itempane:SetPos( 0, plyInvY );
		itempane.ItemName = item:GetName()
		itempane:SetSize( plyInv:GetWide(), 64 );
		itempane:SetSkin( "STALKER" );
		function itempane:Paint( w, h )
			
			surface.SetDrawColor( 0, 0, 0, 70 );
			surface.DrawRect( 0, 0, w, h );
			
			surface.SetDrawColor( 0, 0, 0, 100 );
			surface.DrawOutlinedRect( 0, 0, w, h );
			
		end
		
		local icon = vgui.Create( "DModelPanel", itempane );
		icon:SetPos( 0, 0 );
		icon:SetModel( item:GetModel() );
		if( metaitem.ItemSubmaterials ) then for m,n in next, metaitem.ItemSubmaterials do icon.Entity:SetSubMaterial( n[1], n[2] ) end end
		icon:SetSize( 64, 64 );
		
		if( metaitem.LookAt ) then
			
			icon:SetFOV( metaitem.FOV );
			icon:SetCamPos( metaitem.CamPos );
			icon:SetLookAt( metaitem.LookAt );
			
		else
			
			local a, b = icon.Entity:GetModelBounds();
			
			icon:SetFOV( 20 );
			icon:SetCamPos( Vector( math.abs( a.x ), math.abs( a.y ), math.abs( a.z ) ) * 5 );
			icon:SetLookAt( ( a + b ) / 2 );
			
		end
		
		if( metaitem.IconMaterial ) then icon.Entity:SetMaterial( metaitem.IconMaterial ) end
		if( metaitem.IconColor ) then icon.Entity:SetColor( metaitem.IconColor ) end
		
		function icon:LayoutEntity() end
		
		local p = icon.Paint;
		
		function icon:Paint( w, h )
			
			local pnl = self:GetParent():GetParent():GetParent();
			local x2, y2 = pnl:LocalToScreen( 0, 0 );
			local w2, h2 = pnl:GetSize();
			render.SetScissorRect( x2, y2, x2 + w2, y2 + h2, true );
			
			p( self, w, h );

			if item.Paint then
				item:Paint(self, w,h)
			end
			
			render.SetScissorRect( 0, 0, 0, 0, false );
			
		end
		
		local name = vgui.Create( "DLabel", itempane );
		name:SetText( item:GetName() );
		name:SetPos( 74, 10 );
		name:SetFont( "CombineControl.LabelSmall" );
		name:SizeToContents();
		name:PerformLayout();
		
		surface.SetFont( "CombineControl.LabelSmall" );
		
		local d, n = GAMEMODE:FormatLine( item:GetDesc(), "CombineControl.LabelTiny", itempane:GetWide() * 0.6 );
		
		local desc = vgui.Create( "DLabel", itempane );
		desc:SetText( d );
		desc:SetPos( 74, 24 );
		desc:SetFont( "CombineControl.LabelTiny" );
		desc:SizeToContents();
		desc:PerformLayout();

		local sell = vgui.Create( "DButton", itempane );
		sell:SetFont( "CombineControl.LabelSmall" );
		sell:SetText(Format("Sell for %d RU", hook.Run("CalculatePrice", item) * vendorData.BuyFactor));
		sell:SetPos( plyInv:GetWide() - 106, itempane:GetTall() / 2 - 12 );
		sell:SetSize( 100, 24 );
		sell.DoClick = function()
			net.Start("VendorSellItem")
				net.WriteEntity(self.VendorEntity)
				net.WriteUInt(item:GetID(), 32)
			net.SendToServer()

			itempane:Remove()
		end
		sell:PerformLayout();

		self.PlayerInventory:Add( itempane );

		plyInvY = plyInvY + itempane:GetTall() + 2
	end
end

function PANEL:PopulateData(data)
	self.Items = data

	local vendInv = self.VendorInventory
	local vendInvY = 0

	for class,vendorData in next, data do
		local metaitem = GAMEMODE:GetItemByID(class)

		if vendorData.SellFactor <= 0 then continue end

		local itempane = vgui.Create( "DPanel" );
		itempane:SetPos( 0, vendInvY );
		itempane.ItemName = metaitem.Name
		itempane:SetSize( vendInv:GetWide(), 64 );
		itempane:SetSkin( "STALKER" );
		function itempane:Paint( w, h )
			
			surface.SetDrawColor( 0, 0, 0, 70 );
			surface.DrawRect( 0, 0, w, h );
			
			surface.SetDrawColor( 0, 0, 0, 100 );
			surface.DrawOutlinedRect( 0, 0, w, h );
			
		end
		
		local icon = vgui.Create( "DModelPanel", itempane );
		icon:SetPos( 0, 0 );
		icon:SetModel( metaitem.Model );
		if( metaitem.ItemSubmaterials ) then for m,n in next, metaitem.ItemSubmaterials do icon.Entity:SetSubMaterial( n[1], n[2] ) end end
		icon:SetSize( 64, 64 );
		
		if( metaitem.LookAt ) then
			
			icon:SetFOV( metaitem.FOV );
			icon:SetCamPos( metaitem.CamPos );
			icon:SetLookAt( metaitem.LookAt );
			
		else
			
			local a, b = icon.Entity:GetModelBounds();
			
			icon:SetFOV( 20 );
			icon:SetCamPos( Vector( math.abs( a.x ), math.abs( a.y ), math.abs( a.z ) ) * 5 );
			icon:SetLookAt( ( a + b ) / 2 );
			
		end
		
		if( metaitem.IconMaterial ) then icon.Entity:SetMaterial( metaitem.IconMaterial ) end
		if( metaitem.IconColor ) then icon.Entity:SetColor( metaitem.IconColor ) end
		
		function icon:LayoutEntity() end
		
		local p = icon.Paint;
		
		function icon:Paint( w, h )
			
			local pnl = self:GetParent():GetParent():GetParent();
			local x2, y2 = pnl:LocalToScreen( 0, 0 );
			local w2, h2 = pnl:GetSize();
			render.SetScissorRect( x2, y2, x2 + w2, y2 + h2, true );
			
			p( self, w, h );
			
			render.SetScissorRect( 0, 0, 0, 0, false );
			
		end
		
		local name = vgui.Create( "DLabel", itempane );
		name:SetText( metaitem.Name );
		name:SetPos( 74, 10 );
		name:SetFont( "CombineControl.LabelSmall" );
		name:SizeToContents();
		name:PerformLayout();
		
		surface.SetFont( "CombineControl.LabelSmall" );
		
		local d, n = GAMEMODE:FormatLine( metaitem.Desc, "CombineControl.LabelTiny", itempane:GetWide() * 0.6 );
		
		local desc = vgui.Create( "DLabel", itempane );
		desc:SetText( d );
		desc:SetPos( 74, 24 );
		desc:SetFont( "CombineControl.LabelTiny" );
		desc:SizeToContents();
		desc:PerformLayout();

		local quantity = vgui.Create("DNumberWang", itempane)
		local buy = vgui.Create( "DButton", itempane );

		buy:SetFont( "CombineControl.LabelSmall" );
		buy:SetText(Format("Buy for %d RU", (hook.Run("GetBuyPrice", LocalPlayer(), class, true) * vendorData.SellFactor) * 1));
		buy:SetPos( vendInv:GetWide() - 106, itempane:GetTall() * 0.5 );
		buy:SetSize( 100, 24 );
		buy.DoClick = function(btn)
			local quant = quantity:GetValue()
			if quant <= 0 then
				quant = 1
			end

			net.Start("VendorBuyItem")
				net.WriteEntity(self.VendorEntity)
				net.WriteString(class)
				net.WriteUInt(quant, 32)
			net.SendToServer()
		end
		buy:PerformLayout();

		quantity:SetFont("CombineControl.LabelSmall")
		quantity:SetValue(1)
		quantity:SetPos(vendInv:GetWide() - 106, itempane:GetTall() * 0.1)
		quantity:SetSize(100, 24)
		quantity:SetDecimals(0)
		quantity:SetMin(1)
		function quantity:OnValueChanged(val)
			buy:SetText(Format("Buy for %d RU", (hook.Run("GetBuyPrice", LocalPlayer(), class, true) * vendorData.SellFactor) * val))
		end

		self.VendorInventory:Add( itempane );

		vendInvY = vendInvY + itempane:GetTall() + 2
	end

	self:PopulateInventory()
end

function PANEL:OnClose()
	if IsValid(self.AdminMenu) then
		self.AdminMenu:Close()
	end
end

local function AddItemToVendor()
	local adminMenu = GAMEMODE.VendorMenu.AdminMenu
	local panel = vgui.Create("DFrame")
	panel:SetTitle("Add Item")
	panel:SetSize(ScrW() * 0.5, ScrH() * 0.5)
	panel:Center()
	panel:MakePopup()

	panel.SearchBox = panel:Add("DTextEntry")
	panel.SearchBox:Dock(TOP)
	panel.SearchBox:SetZPos(1)
	panel.SearchBox:DockMargin(0, 0, 0, 4)
	panel.SearchBox:SetText("Search")
	function panel.SearchBox:OnValueChange(newValue)
		panel.ItemList:Clear()

		for class,metaitem in next, GAMEMODE.Items do
			if !metaitem.BulkPrice then continue end

			if metaitem.Name:find(newValue) or class:find(newValue) then
				local line = panel.ItemList:AddLine(class, metaitem.Name, hook.Run("GetBuyPrice", LocalPlayer(), class, true))
				line.ClassName = class
			end
		end
	end

	panel.ItemList = panel:Add("DListView")
	panel.ItemList:Dock(FILL)
	panel.ItemList:SetZPos(2)
	panel.ItemList:AddColumn("Classname")
	panel.ItemList:AddColumn("Item Name")
	panel.ItemList:AddColumn("Item Price")
	function panel.ItemList:DoDoubleClick(lineID, line)
		local itemClass = line.ClassName

		Derma_StringRequest("Sell Factor", "What multiplier should be used for the sell price of this item?\n(Put 0 to prevent buying it from this vendor.)", "1.5", function(text)
			local sellFactor = tonumber(text)

			Derma_StringRequest("Buy Factor", "What multiplier should be used for the buy price of this item?\n(Put 0 to prevent selling it to this vendor.)", "0.5", function(text)
				local buyFactor = tonumber(text)

				adminMenu.EditedItems[itemClass] = {
					SellFactor = sellFactor,
					BuyFactor = buyFactor,
				}

				local line = adminMenu.VendorItems:AddLine(itemClass, sellFactor, buyFactor)
				line.ClassName = itemClass

				panel:Close()
			end)
		end)
	end

	for class,metaitem in SortedPairs(GAMEMODE.Items) do
		if !metaitem.BulkPrice then continue end

		local line = panel.ItemList:AddLine(class, metaitem.Name, hook.Run("GetBuyPrice", LocalPlayer(), class, true))
		line.ClassName = class
	end
end

function PANEL:OpenAdmin()
	self:Hide()

	self.AdminMenu = vgui.Create("DFrame")
	self.AdminMenu:SetTitle("Edit Vendor")
	self.AdminMenu:SetSize(ScrW() * 0.3, self:GetTall() * 0.5)
	self.AdminMenu:Center()
	self.AdminMenu:MakePopup()
	self.AdminMenu.EditedItems = {}
	self.AdminMenu.RemovedItems = {}

	function self.AdminMenu:OnClose()
		net.Start("VendorModifyItems")
			net.WriteEntity(GAMEMODE.VendorMenu.VendorEntity)
			net.WriteUInt(table.Count(self.EditedItems) + table.Count(self.RemovedItems), 32)

			for class,removed in next, self.RemovedItems do
				net.WriteString(class)
				net.WriteBool(true)
			end
			for class,data in next, self.EditedItems do
				net.WriteString(class)
				net.WriteBool(false)
				net.WriteFloat(data.BuyFactor)
				net.WriteFloat(data.SellFactor)
			end
		net.SendToServer()
	end

	local panel = self.AdminMenu

	panel.VendorModel = panel:Add("DTextEntry")
	panel.VendorModel:Dock(TOP)
	panel.VendorModel:SetZPos(1)
	panel.VendorModel:SetText(self.VendorEntity:GetModel())
	panel.VendorModel:DockMargin(0, 0, 0, 10)
	function panel.VendorModel:OnValueChange(newValue)
		net.Start("VendorChangeModel")
			net.WriteEntity(GAMEMODE.VendorMenu.VendorEntity)
			net.WriteString(newValue)
		net.SendToServer()
	end
	
	panel.VendorItems = panel:Add("DListView")
	panel.VendorItems:SetZPos(2)
	panel.VendorItems:Dock(FILL)
	panel.VendorItems:AddColumn("Classname")
	panel.VendorItems:AddColumn("Sell (to player) Multiplier")
	panel.VendorItems:AddColumn("Buy (from player) Multiplier")
	panel.VendorItems:DockMargin(0, 0, 0, 4)
	function panel.VendorItems:OnMousePressed(keyCode)
		if keyCode == MOUSE_RIGHT then
			local menu = DermaMenu()
			menu:AddOption("Add", function()
				AddItemToVendor()
			end)
			menu:Open()
		end
	end
	function panel.VendorItems:OnRowRightClick(lineID, line)
		local itemClass = line.ClassName

		local menu = DermaMenu()
			menu:AddOption("Add", function()
				AddItemToVendor()
			end)
			menu:AddOption("Remove", function()
				panel.RemovedItems[itemClass] = true
				panel.EditedItems[itemClass] = nil
				self:RemoveLine(lineID)
			end)
			menu:AddOption("Change Sell Factor", function()
				Derma_StringRequest("Sell Factor", "What multiplier should be used for the sell price of this item?\n(Put 0 to prevent buying it from this vendor.)", tostring(line:GetColumnText(2)), function(text)
					local sellFactor = tonumber(text)

					if !panel.EditedItems[itemClass] then
						panel.EditedItems[itemClass] = table.Copy(GAMEMODE.VendorMenu.Items[itemClass])
					end

					panel.EditedItems[itemClass].SellFactor = sellFactor
					line:SetColumnText(2, sellFactor)
				end)
			end)
			menu:AddOption("Change Buy Factor", function()
				Derma_StringRequest("Buy Factor", "What multiplier should be used for the buy price of this item?\n(Put 0 to prevent selling it to this vendor.)", tostring(line:GetColumnText(3)), function(text)
					local buyFactor = tonumber(text)

					if !panel.EditedItems[itemClass] then
						panel.EditedItems[itemClass] = table.Copy(GAMEMODE.VendorMenu.Items[itemClass])
					end

					adminMenu.EditedItems[itemClass].BuyFactor = buyFactor
					line:SetColumnText(3, buyFactor)
				end)
			end)
		menu:Open()
	end

	for class,data in next, self.Items do
		local line = panel.VendorItems:AddLine(class, data.SellFactor, data.BuyFactor)
		line.ClassName = class
	end

	panel.SaveVendor = panel:Add("DButton")
	panel.SaveVendor:SetText("Save")
	panel.SaveVendor:SetZPos(3)
	panel.SaveVendor:Dock(BOTTOM)
	function panel.SaveVendor:DoClick()
		net.Start("VendorModifyItems")
			net.WriteEntity(GAMEMODE.VendorMenu.VendorEntity)
			net.WriteUInt(table.Count(panel.EditedItems) + table.Count(panel.RemovedItems), 32)

			for class,removed in next, panel.RemovedItems do
				net.WriteString(class)
				net.WriteBool(true)
			end
			for class,data in next, panel.EditedItems do
				net.WriteString(class)
				net.WriteBool(false)
				net.WriteFloat(data.BuyFactor)
				net.WriteFloat(data.SellFactor)
			end
		net.SendToServer()

		panel:Close()
	end
end

vgui.Register("zc_vendor", PANEL, "DFrame")