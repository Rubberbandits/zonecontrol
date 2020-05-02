local PANEL = {}

function PANEL:Init()
	self:SetTitle("Item Editor")
	self:SetSize(512, 512)
	self:ShowCloseButton(true)
	self:SetDraggable(true)
	self:Center()
	self:MakePopup()
	self.data = {}
	
	self.ModelDisplay = vgui.Create("DModelPanel", self)
	self.ModelDisplay:SetPos( self:GetWide() - 256, 24 );
	self.ModelDisplay:SetModel( "models/props_junk/TrafficCone001a.mdl" );
	self.ModelDisplay:SetSize( 256, 256 - 24 );
	self.ModelDisplay:SetFOV( 20 );
	self.ModelDisplay:SetCamPos( Vector( 50, 50, 50 ) );
	self.ModelDisplay:SetLookAt( Vector( 0, 0, 0 ) );
	
	local p = self.ModelDisplay.Paint;
	
	function self.ModelDisplay:Paint( w, h )
		surface.SetDrawColor( 0, 0, 0, 70 );
		surface.DrawRect( 0, 0, w, h );
		
		surface.SetDrawColor( 0, 0, 0, 100 );
		surface.DrawOutlinedRect( 0, 0, w, h );
		
		p( self, w, h );
	end
	
	function self.ModelDisplay:LayoutEntity( ent ) end
	
	self.NameEntry = vgui.Create("DTextEntry", self)
	self.NameEntry:SetSize(248, 24)
	self.NameEntry:SetPos(4, 28)
	self.NameEntry:SetText("Generic Item")
	
	self.ModelEntry = vgui.Create("DTextEntry", self)
	self.ModelEntry:SetSize(248, 24)
	self.ModelEntry:SetPos(4, 56)
	self.ModelEntry:SetText("models/props_junk/TrafficCone001a.mdl")
	self.ModelEntry.OnEnter = function(panel)
		self.ModelDisplay:SetModel(panel:GetValue())
	end
	
	self.WeightEntry = vgui.Create("DNumberWang", self)
	self.WeightEntry:SetSize(64, 24)
	self.WeightEntry:SetPos(4, 84)
	self.WeightEntry:SetValue(1)
	self.WeightEntry:SetDecimals(2)
	self.WeightEntry:SetMinMax(0.01, 1000)
	
	self.DescEntry = vgui.Create("DTextEntry", self)
	self.DescEntry:SetSize(248, 144)
	self.DescEntry:SetPos(4, 112)
	self.DescEntry:SetText("A generic item so generic it is generic in every way, shape and form.")
	self.DescEntry:SetMultiline(true)
	
	self.DataListView = vgui.Create("DListView", self)
	self.DataListView:SetSize(504, 224)
	self.DataListView:SetPos(4, 260)
	self.DataListView:SetMultiSelect(false)
	self.DataListView:AddColumn("Key")
	self.DataListView:AddColumn("Value")
	self.DataListView.SortByColumn = function() end
	self.DataListView.DoDoubleClick = function(panel, id, line)
		if self.HandleSpecificKey[line:GetColumnText(1)] then
			self.HandleSpecificKey[line:GetColumnText(1)](self)
			return
		end
		
		if self.HandleDataType[line.DataType] then
			self.HandleDataType[line.DataType](self, line:GetColumnText(1))
		end
	end
	self.DataListView.OnRowRightClick = function(panel, id, line)
		local menu = DermaMenu(panel)
		menu:AddOption("Edit", function()
			if self.HandleSpecificKey[line:GetColumnText(1)] then
				self.HandleSpecificKey[line:GetColumnText(1)](self)
				return
			end
			
			if self.HandleDataType[line.DataType] then
				self.HandleDataType[line.DataType](self, line:GetColumnText(1))
			end
		end)
		
		menu:AddSpacer()
		
		menu:AddOption("New", function()
		
		end)
		
		menu:Open()
	end
	
	self.SaveButton = vgui.Create("DButton", self)
	self.SaveButton:SetSize(504, 20)
	self.SaveButton:SetPos(4, 488)
	self.SaveButton:SetText("Save")
	self.SaveButton.DoClick = function(button)
		self:SaveCurrentItem()
		GAMEMODE:PMUpdateInventory()
		self:Close()
	end
end

local blacklist = {
	Equipped = true,
	Name = true,
	Desc = true,
	Weight = true,
	Model = true,
}

PANEL.HandleDataType = {
	string = function(panel, key)
		Derma_StringRequest(
			"Input",
			"Enter the new value of "..key,
			"",
			function(text) panel.data[key] = text end
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
	number = function(panel, key)
		Derma_StringRequest(
			"Input",
			"Enter the new value of "..key,
			"",
			function(text) panel.data[key] = tonumber(text) end
		)
	end,
}

PANEL.HandleSpecificKey = {
	SuitClass = function(panel)
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
			local line = parent.VariantList:GetLine(id)
			local variant_class = line:GetColumnText(1)
			
			if GAMEMODE.SuitVariants[variant_class] then
				panel.data.SuitClass = variant_class
				
				parent:Close()
			end
		end
		
		for k,v in next, GAMEMODE.SuitVariants do
			if v.BaseSuit == panel.CurrentItem:GetClass() then
				parent.VariantList:AddLine(k, v.Name)
			end
		end
	end,
	Upgrades = function(panel)
		panel.data.Upgrades = panel.data.Upgrades or table.Copy(panel.CurrentItem["Vars"].Upgrades)
		
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
			if v.Item[panel.CurrentItem:GetClass()] and !panel.data.Upgrades[k] then
				parent.PossibleUpgrades:AddLine(k, v.Name)
			end
		end
	end,
}

function PANEL:SetItem(item)
	if !item then return end
	
	self.NameEntry:SetText(item:GetName())
	self.WeightEntry:SetValue(item:GetWeight())
	self.DescEntry:SetText(item:GetVar("Desc", item.Desc))
	self.ModelEntry:SetText(item:GetModel())
	self.ModelDisplay:SetModel(item:GetModel())
	self.CurrentItem = item
	
	for k,v in next, item:GetVars() do
		if blacklist[k] then continue end
		local value = v
		if istable(v) then value = "(table)" end
		
		local line = self.DataListView:AddLine(k, value)
		line.DataType = type(v)
	end
end

function PANEL:SaveCurrentItem()
	if !self.CurrentItem then return end
	local data = self.data or {}
	
	data.Name = self.NameEntry:GetText()
	data.Weight = tonumber(self.WeightEntry:GetValue())
	data.Desc = self.DescEntry:GetText()
	data.Model = self.ModelEntry:GetText()
	
	netstream.Start("ChangeItemData", self.CurrentItem:GetID(), data)
end

vgui.Register("CItemCreator", PANEL, "DFrame")