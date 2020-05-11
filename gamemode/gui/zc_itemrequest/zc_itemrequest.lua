local PANEL = {}

function PANEL:Init()
	self:SetSize(ScrW() / 2, ScrH() / 1.2)
	self:Center()
	self:MakePopup()
	self:SetTitle("Item Request")
	self.data = {}
	
	self.ItemList = vgui.Create("DScrollPanel", self)
	self.ItemList:SetSize(self:GetWide(), self:GetTall() / 3)
	self.ItemList:SetPos(0,24)
	
	self.ItemSearch = vgui.Create("DTextEntry", self)
	self.ItemSearch:SetSize(self:GetWide() - 8, 20)
	self.ItemSearch:SetPos(4, self:GetTall() / 3 + 26)
	self.ItemSearch:SetText("Search...")
	self.ItemSearch.OnChange = function(txt)
		self:PopulateItemList(txt:GetText())
	end
	
	self.EditMain = vgui.Create("DPanel", self)
	self.EditMain:SetSize(self:GetWide() / 2, self:GetTall() / 1.75)
	self.EditMain:SetPos(0, self:GetTall() / 3 + 48)
	self.EditMain.Paint = function(pnl, w, h)
	end
	
	self.ModelDisplay = vgui.Create("DModelPanel", self.EditMain)
	self.ModelDisplay:SetPos(4, 0)
	self.ModelDisplay:SetModel("models/props_junk/TrafficCone001a.mdl")
	self.ModelDisplay:SetSize(self.EditMain:GetWide() - 8, self.EditMain:GetTall() / 2)
	self.ModelDisplay:SetFOV(20)
	self.ModelDisplay:SetCamPos(Vector(50, 50, 50))
	self.ModelDisplay:SetLookAt(Vector(0, 0, 0))
	
	local p = self.ModelDisplay.Paint
	
	function self.ModelDisplay:Paint( w, h )
		surface.SetDrawColor(0, 0, 0, 70)
		surface.DrawRect(0, 0, w, h)
		
		surface.SetDrawColor(0, 0, 0, 100)
		surface.DrawOutlinedRect(0, 0, w, h)
		
		p(self, w, h)
	end
	
	function self.ModelDisplay:LayoutEntity( ent ) end
	
	local y = self.EditMain:GetTall() / 2 + 2
	
	self.NameEntry = vgui.Create("DTextEntry", self.EditMain)
	self.NameEntry:SetSize(self.EditMain:GetWide() - 8, 24)
	self.NameEntry:SetPos(4, y)
	self.NameEntry:SetText("Generic Item")
	
	y = y + self.NameEntry:GetTall() + 2
	
	self.ModelEntry = vgui.Create("DTextEntry", self.EditMain)
	self.ModelEntry:SetSize(self.EditMain:GetWide() - 12 - 64, 24)
	self.ModelEntry:SetPos(4, y)
	self.ModelEntry:SetText("models/props_junk/TrafficCone001a.mdl")
	self.ModelEntry.OnEnter = function(panel)
		self.ModelDisplay:SetModel(panel:GetValue())
	end
	
	self.WeightEntry = vgui.Create("DNumberWang", self.EditMain)
	self.WeightEntry:SetSize(64, 24)
	self.WeightEntry:SetPos(self.EditMain:GetWide() - 4 - 64, y)
	self.WeightEntry:SetValue(1)
	self.WeightEntry:SetDecimals(2)
	self.WeightEntry:SetMinMax(0.01, 1000)
	
	y = y + self.ModelEntry:GetTall() + 2
	
	self.DescEntry = vgui.Create("DTextEntry", self.EditMain)
	self.DescEntry:SetSize(self.EditMain:GetWide() - 8, self.EditMain:GetTall() / 2.65)
	self.DescEntry:SetPos(4, y)
	self.DescEntry:SetText("A generic item so generic it is generic in every way, shape and form.")
	self.DescEntry:SetMultiline(true)
	
	self.DataListView = vgui.Create("DListView", self)
	self.DataListView:SetSize(self:GetWide() / 2 - 4, self:GetTall() / 1.75)
	self.DataListView:SetPos(self:GetWide() / 2, self:GetTall() / 3 + 48)
	self.DataListView:AddColumn("Key")
	self.DataListView:AddColumn("Value")
	self.DataListView.SortByColumn = function() end
	self.DataListView.DoDoubleClick = function(panel, id, line)
		if self.HandleSpecificKey[line:GetColumnText(1)] then
			self.HandleSpecificKey[line:GetColumnText(1)](self, line)
			return
		end
		
		if self.HandleDataType[line.DataType] then
			self.HandleDataType[line.DataType](self, line:GetColumnText(1), line)
		end
	end
	self.DataListView.OnRowRightClick = function(panel, id, line)
		local menu = DermaMenu(panel)
		menu:AddOption("Edit", function()
			if self.HandleSpecificKey[line:GetColumnText(1)] then
				self.HandleSpecificKey[line:GetColumnText(1)](self, line)
				return
			end
			
			if self.HandleDataType[line.DataType] then
				self.HandleDataType[line.DataType](self, line:GetColumnText(1), line)
			end
		end)
		menu:Open()
	end
	
	self.RequestBtn = vgui.Create("DButton", self)
	self.RequestBtn:SetSize(self:GetWide() - 8, 20)
	self.RequestBtn:SetPos(4, self:GetTall() - 22)
	self.RequestBtn:SetText("Request")
	self.RequestBtn.DoClick = function(btn)
		local sent_data = self.data
		sent_data.Name = self.NameEntry:GetText()
		sent_data.Weight = self.WeightEntry:GetValue()
		sent_data.Model = self.ModelEntry:GetText()
		sent_data.Desc = self.DescEntry:GetText()
		
		netstream.Start("RequestItemSpawn", self.CurrentItem, sent_data)
	end
	
	self.CurrentItem = "generic_item"
	self:PopulateItemList()
end

local blacklist = {
	Equipped = true,
	Name = true,
	Desc = true,
	Weight = true,
	Model = true,
}

PANEL.HandleDataType = {
	string = function(panel, key, line)
		Derma_StringRequest(
			"Input",
			"Enter the new value of "..key,
			"",
			function(text) 
				panel.data[key] = text 
				line:SetColumnText(2, text)
			end
		)
	end,
	table = function(panel, key)
		if panel.TableEditor and panel.TableEditor:IsValid() then
			panel.TableEditor:Close()
		end

		panel.TableEditor = vgui.Create("DFrame")
		panel.TableEditor:SetSize(512, 256)
		panel.TableEditor:SetTitle("Data Editor")
		panel.TableEditor:Center()
		panel.TableEditor:MakePopup()
		panel.TableEditor:ShowCloseButton(true)
		panel.TableEditor:SetDraggable(true)
		
		local parent = panel.TableEditor
		
		parent.DataList = vgui.Create("DListView", parent)
		parent.DataList:SetSize(504, 224)
		parent.DataList:SetPos(4, 28)
		parent.DataList:SetMultiSelect(false)
		parent.DataList:AddColumn("Key")
		parent.DataList:AddColumn("Value")
	end,
	number = function(panel, key, line)
		Derma_StringRequest(
			"Input",
			"Enter the new value of "..key,
			"",
			function(text) 
				panel.data[key] = tonumber(text)
				line:SetColumnText(2, text)
			end
		)
	end,
}

PANEL.HandleSpecificKey = {
	SuitClass = function(panel, line)
		if panel.SuitClassEditor and panel.SuitClassEditor:IsValid() then
			panel.SuitClassEditor:Close()
		end

		panel.SuitClassEditor = vgui.Create("DFrame")
		panel.SuitClassEditor:SetSize(256, 256)
		panel.SuitClassEditor:SetTitle("Data Editor")
		panel.SuitClassEditor:Center()
		panel.SuitClassEditor:MakePopup()
		panel.SuitClassEditor:ShowCloseButton(true)
		panel.SuitClassEditor:SetDraggable(true)
		
		local parent = panel.SuitClassEditor
		
		parent.VariantList = vgui.Create("DListView", parent)
		parent.VariantList:SetSize(248, 200)
		parent.VariantList:SetPos(4, 28)
		parent.VariantList:SetMultiSelect(false)
		parent.VariantList:AddColumn("Variant Class Name")
		parent.VariantList:AddColumn("Variant Name")
		parent.VariantList.OnRowSelected = function(panel, id, line)
			parent.SelectButton:SetDisabled(false)
		end
		
		parent.SelectButton = vgui.Create("DButton", parent)
		parent.SelectButton:SetSize(248, 20)
		parent.SelectButton:SetPos(4, 232)
		parent.SelectButton:SetText("Select")
		parent.SelectButton:SetDisabled(true)
		parent.SelectButton.DoClick = function(button)
			local id = parent.VariantList:GetSelectedLine()
			local line_var = parent.VariantList:GetLine(id)
			local variant_class = line_var:GetColumnText(1)
			
			if GAMEMODE.SuitVariants[variant_class] then
				panel.data.SuitClass = variant_class
				line:SetColumnText(2, variant_class)
				
				parent:Close()
			end
		end
		
		for k,v in next, GAMEMODE.SuitVariants do
			if v.BaseSuit == panel.CurrentItem then
				parent.VariantList:AddLine(k, v.Name)
			end
		end
	end,
	Upgrades = function(panel)
		local metaitem = GAMEMODE:GetItemByID(panel.CurrentItem)
		panel.data.Upgrades = panel.data.Upgrades or table.Copy(metaitem.Vars.Upgrades)
		
		if panel.TableEditor and panel.TableEditor:IsValid() then
			panel.TableEditor:Close()
		end

		panel.TableEditor = vgui.Create("DFrame")
		panel.TableEditor:SetSize(512, 256)
		panel.TableEditor:SetTitle("Data Editor")
		panel.TableEditor:Center()
		panel.TableEditor:MakePopup()
		panel.TableEditor:ShowCloseButton(true)
		panel.TableEditor:SetDraggable(true)
		
		local parent = panel.TableEditor
		
		parent.DataList = vgui.Create("DListView", parent)
		parent.DataList:SetSize(248, 200)
		parent.DataList:SetPos(4, 28)
		parent.DataList:SetMultiSelect(false)
		parent.DataList:AddColumn("Upgrade Class")
		parent.DataList:AddColumn("Upgrade Name")
		parent.DataList.OnRowSelected = function(panel, id, line)
			parent.RemoveUpgrade:SetDisabled(false)
		end
		
		parent.PossibleUpgrades = vgui.Create("DListView", parent)
		parent.PossibleUpgrades:SetSize(252, 200)
		parent.PossibleUpgrades:SetPos(256, 28)
		parent.PossibleUpgrades:SetMultiSelect(false)
		parent.PossibleUpgrades:AddColumn("Upgrade Class")
		parent.PossibleUpgrades:AddColumn("Upgrade Name")
		parent.PossibleUpgrades.OnRowSelected = function(panel, id, line)
			parent.AddUpgrade:SetDisabled(false)
		end
		
		parent.RemoveUpgrade = vgui.Create("DButton", parent)
		parent.RemoveUpgrade:SetSize(248, 20)
		parent.RemoveUpgrade:SetPos(4, 232)
		parent.RemoveUpgrade:SetText("Remove")
		parent.RemoveUpgrade:SetDisabled(true)
		parent.RemoveUpgrade.DoClick = function(button)
			local id = parent.DataList:GetSelectedLine()
			local line = parent.DataList:GetLine(id)
			local upgrade_class = line:GetColumnText(1)
			
			if panel.data.Upgrades[upgrade_class] then
				panel.data.Upgrades[upgrade_class] = nil
				
				parent.PossibleUpgrades:AddLine(upgrade_class, GAMEMODE.Upgrades[upgrade_class].Name)
				
				parent.DataList:RemoveLine(id)
				button:SetDisabled(true)
			end
		end
		
		parent.AddUpgrade = vgui.Create("DButton", parent)
		parent.AddUpgrade:SetSize(252, 20)
		parent.AddUpgrade:SetPos(256, 232)
		parent.AddUpgrade:SetText("Add")
		parent.AddUpgrade:SetDisabled(true)
		parent.AddUpgrade.DoClick = function(button)
			local id = parent.PossibleUpgrades:GetSelectedLine()
			local line = parent.PossibleUpgrades:GetLine(id)
			local upgrade_class = line:GetColumnText(1)
			
			if GAMEMODE.Upgrades[upgrade_class] then
				panel.data.Upgrades[upgrade_class] = true
				
				parent.DataList:AddLine(upgrade_class, GAMEMODE.Upgrades[upgrade_class].Name)
				parent.PossibleUpgrades:RemoveLine(id)
				button:SetDisabled(true)
			end
		end
		
		for k,v in next, panel.data.Upgrades do
			parent.DataList:AddLine(k, GAMEMODE.Upgrades[k].Name)
		end
		
		for k,v in next, GAMEMODE.Upgrades do
			if v.Item[panel.CurrentItem] and !panel.data.Upgrades[k] then
				parent.PossibleUpgrades:AddLine(k, v.Name)
			end
		end
	end,
}

function PANEL:PopulateItemList(search_str)
	self.ItemList:Clear()
	
	for k,v in next, GAMEMODE.Items do
		if search_str and (!(k:lower()):find(search_str:lower()) and !((v.Name):lower()):find(search_str:lower())) then
			continue
		end
	
		local pnl = vgui.Create("DPanel", self.ItemList)
		pnl:Dock(TOP)
		pnl:SetTall(self.ItemList:GetTall() / 3)
		pnl.Paint = function(pnl, w, h)
		end
		
		pnl.mdl_display = vgui.Create("DModelPanel", pnl)
		pnl.mdl_display:SetPos(0, 0)
		pnl.mdl_display:SetModel(v.Model)
		pnl.mdl_display:SetSize(ScreenScaleH(48), pnl:GetTall())
		pnl.mdl_display:SetFOV(20)
		pnl.mdl_display:SetCamPos(Vector(50, 50, 50))
		pnl.mdl_display:SetLookAt(Vector(0, 0, 0))
		
		local p = pnl.mdl_display.Paint
		function pnl.mdl_display:Paint( w, h )
			surface.SetDrawColor(0, 0, 0, 70)
			surface.DrawRect(0, 0, w, h)
			
			surface.SetDrawColor(0, 0, 0, 100)
			surface.DrawOutlinedRect(0, 0, w, h)
			
			p(self, w, h)
		end
		
		local name = vgui.Create( "DLabel", pnl );
		name:SetText( v.Name );
		name:SetPos( ScreenScaleH(48) + 10, 10 );
		name:SetFont( "CombineControl.LabelSmall" );
		name:SizeToContents();
		name:PerformLayout();
		
		surface.SetFont( "CombineControl.LabelSmall" );
		local a, b = surface.GetTextSize( v.Name );
		
		local id = vgui.Create( "DLabel", pnl );
		id:SetText( "ID: " .. k );
		id:SetPos( ScreenScaleH(48) + a + 20, 10 );
		id:SetFont( "CombineControl.LabelTiny" );
		id:SetTextColor( Color( 200, 200, 100, 255 ) );
		id:SizeToContents();
		id:PerformLayout();
		
		local d, n = GAMEMODE:FormatLine( v.Desc, "CombineControl.LabelTiny", 472 );
		
		local desc = vgui.Create( "DLabel", pnl );
		desc:SetText( d );
		desc:SetPos( ScreenScaleH(48) + 10, 24 );
		desc:SetFont( "CombineControl.LabelTiny" );
		desc:SizeToContents();
		desc:PerformLayout();
		
		local select_btn = vgui.Create("DButton", pnl)
		select_btn:SetSize(ScreenScaleH(32), ScreenScaleH(24))
		select_btn:SetPos(self.ItemList:GetWide() - ScreenScaleH(48) - 4, pnl:GetTall() / 2 - select_btn:GetTall() / 2)
		select_btn:SetText("Select")
		select_btn.DoClick = function(pnl)
			self:SelectItem(k)
		end
	end
end

function PANEL:SelectItem(item)
	local metaitem = GAMEMODE:GetItemByID(item)
	
	self.ModelDisplay:SetModel(metaitem.Model)
	self.ModelEntry:SetText(metaitem.Model)
	self.NameEntry:SetText(metaitem.Name)
	self.WeightEntry:SetValue(metaitem.Weight)
	self.DescEntry:SetText(metaitem.Desc)
	self.DataListView:Clear()
	self.data = {}
	
	self.CurrentItem = item
	
	if metaitem.Vars then
		for k,v in next, metaitem.Vars do
			if blacklist[k] then continue end
			
			local line = self.DataListView:AddLine(k, v)
			line.DataType = type(v)
		end
	end
end

vgui.Register("zc_itemrequest", PANEL, "DFrame")