local PANEL = {}

function PANEL:Init()
	self:SetTitle("")
	self:SetSize(512, 400)
	self:ShowCloseButton(false)
	self:SetDraggable(true)
	self:Center()
	self:MakePopup()
	self:SetSkin("STALKER")
	
	self.SupportItemsScroll = vgui.Create("DScrollPanel", self)
	self.SupportItemsScroll:SetSize(250, 220)
	self.SupportItemsScroll:SetPos(260, 128)

	self.MaintainItemsScroll = vgui.Create("DScrollPanel", self)
	self.MaintainItemsScroll:SetSize(250, 220)
	self.MaintainItemsScroll:SetPos(2, 128)
	
	self.Repair = vgui.Create("DButton", self)
	self.Repair:SetText("Repair")
	self.Repair:SetSize(128, 24)
	self.Repair:SetPos(self:GetWide() / 2 + 2, 368)
	self.Repair:SetDisabled(true)
	self.Repair.DoClick = function(button)
		netstream.Start("MaintainWeapon", self.selected_maintainer, self.selected_item, self.selected_support)
		
		self:Close()
	end
	
	self.Cancel = vgui.Create("DButton", self)
	self.Cancel:SetText("Cancel")
	self.Cancel:SetSize(128, 24)
	self.Cancel:SetPos(self:GetWide() / 2 - 130, 368)
	function self.Cancel:DoClick()
		self:GetParent():Close()
	end

	self.WeaponDisplay = vgui.Create("DScrollPanel", self)
	self.WeaponDisplay:SetSize(506, 100)
	self.WeaponDisplay:SetPos(2, 20)
end

function PANEL:SetItem(item_class, id)
	local metaitem = GAMEMODE:GetItemByID(item_class)
	if !metaitem then return end
	
	self.selected_item = id
	self.support_buttons = {}
	for k,v in next, GAMEMODE.g_ItemTable do
		if v.CharID != LocalPlayer():CharID() then continue end -- hotfix, and doesnt actually solve the problem
		if v.Base == "weapon_maintainers" then continue end
		if v.SuitOnly and metaitem.Base != "clothes" then continue end
		if v.WeaponOnly and metaitem.Base != "weapon" then continue end
		if !v.RaiseCondition then continue end
		
		local button = vgui.Create("DButton", self.SupportItemsScroll)
		button:SetSize(200, 24)
		button:SetText(v.Name.." +"..v.RaiseCondition.."%")
		button.id = v:GetID()
		button:Dock(TOP)
		button:DockMargin(40,2,40,6)
		button:SetIsToggle(true)
		button.DoClick = function(button)
			for k,v in next, self.support_buttons do
				v:SetToggle(false)
			end
			
			self.selected_support = button.id
			button:SetToggle(true)
			
			local maintainer_item = GAMEMODE.g_ItemTable[self.selected_maintainer]
			local support_item = GAMEMODE.g_ItemTable[self.selected_support]
			local repair_amt = 0
			if support_item then
				repair_amt = repair_amt + support_item.RaiseCondition
			end
			if maintainer_item then
				repair_amt = repair_amt + maintainer_item.RaiseCondition
			end
			
			self:SetNewRepairAmount(repair_amt)
		end
		
		self.support_buttons[#self.support_buttons + 1] = button
	end
	
	self.maintainer_buttons = {}
	for k,v in next, GAMEMODE.g_ItemTable do
		if v.Base != "weapon_maintainers" then continue end
		if v.SuitOnly and metaitem.Base != "clothes" then continue end
		if v.WeaponOnly and metaitem.Base != "weapon" then continue end
		if v.TechOnly and !LocalPlayer():HasCharFlag("T") then continue end

		local button = vgui.Create("DButton", self.MaintainItemsScroll)
		button:SetSize(200, 24)
		button:SetText(v.Name.." +"..v.RaiseCondition.."%")
		button.id = v:GetID()
		button:Dock(TOP)
		button:DockMargin(40,2,40,6)
		button:SetIsToggle(true)
		button.DoClick = function(button)
			for k,v in next, self.maintainer_buttons do
				v:SetToggle(false)
			end
			
			self.Repair:SetDisabled(false)
			self.selected_maintainer = button.id
			button:SetToggle(true)
			
			local maintainer_item = GAMEMODE.g_ItemTable[self.selected_maintainer]
			local support_item = GAMEMODE.g_ItemTable[self.selected_support]
			local repair_amt = 0
			if maintainer_item then
				repair_amt = repair_amt + maintainer_item.RaiseCondition
			end
			if support_item then
				repair_amt = repair_amt + support_item.RaiseCondition
			end
			
			self:SetNewRepairAmount(repair_amt)
		end
		
		self.maintainer_buttons[#self.maintainer_buttons + 1] = button
	end
	
	self:SetupEndProductDisplay(self.WeaponDisplay, id)
end

function PANEL:SetupEndProductDisplay(panel, id)
	local item = GAMEMODE.g_ItemTable[id]
	local icon = vgui.Create("DModelPanel", panel)
	icon:SetSize(100,100)
	icon:SetPos(0,0)
	icon:SetModel(item.Model)
	
	function icon:LayoutEntity() end
	
	local p = icon.Paint;
	
	function icon:Paint( w, h )
		local pnl = self:GetParent():GetParent()
		local x2, y2 = pnl:LocalToScreen(0, 0)
		local w2, h2 = pnl:GetSize()
		render.SetScissorRect(x2, y2, x2 + w2, y2 + h2, true)

		p(self, w, h)
		
		render.SetScissorRect(0, 0, 0, 0, false)
	end

	if item.LookAt then
		icon:SetFOV(item.FOV)
		icon:SetCamPos(item.CamPos)
		icon:SetLookAt(item.LookAt)
	else
		local a, b = icon.Entity:GetModelBounds();
	
		icon:SetFOV(20)
		icon:SetCamPos(Vector(math.abs(a.x), math.abs(a.y), math.abs(a.z)) * 5)
		icon:SetLookAt(( a + b ) / 2)
	end
	
	if item.IconMaterial then icon.Entity:SetMaterial(item.IconMaterial) end
	if item.IconColor then icon.Entity:SetColor(item.IconColor) end
	
	panel.ModelDisplay = icon
	
	local text = vgui.Create("DLabel", panel)
	text:SetSize(200, 96)
	text:SetPos(102, 2)
	text:SetFont("CombineControl.LabelBig")
	text:SetText(item:GetName().."\n"..item:GetDesc())
	text:SetAutoStretchVertical(true)
	
	panel.ItemInfo = text
	
	local repair_info = vgui.Create("DLabel", panel)
	repair_info:SetSize(60, 96)
	repair_info:SetPos(300, 2)
	repair_info:SetFont("CombineControl.LabelBig")
	repair_info:SetText("Total repair amount: ")
	repair_info:SizeToContents()
	
	panel.RepairInfo = repair_info
	
	local repair_amt = vgui.Create("DLabel", panel)
	local x,y = repair_info:GetPos()
	repair_amt:SetSize(40, 96)
	repair_amt:SetPos(x + repair_info:GetWide(), 2)
	repair_amt:SetTextColor(Color(255,0,0,255))
	repair_amt:SetFont("CombineControl.LabelBig")
	repair_amt:SetText("0%")
	repair_amt:SizeToContents()
	
	panel.RepairAmount = repair_amt
end

function PANEL:SetNewRepairAmount(amt)
	self.WeaponDisplay.RepairInfo:SetText("Total repair amount: ")
	self.WeaponDisplay.RepairInfo:SizeToContents()
	
	local x, y = self.WeaponDisplay.RepairInfo:GetPos()
	self.WeaponDisplay.RepairAmount:SetText(amt.."%")
	self.WeaponDisplay.RepairAmount:SetTextColor(Color(0,255,0,255))
	self.WeaponDisplay.RepairAmount:SizeToContents()
	self.WeaponDisplay.RepairAmount:SetPos(x + self.WeaponDisplay.RepairInfo:GetWide(), 2)
end

function PANEL:Paint(w, h)
	kingston.gui.FindFunc(self, "Paint", "CleaningMenu", w, h)
end

vgui.Register("CMaintainMenu", PANEL, "DFrame")