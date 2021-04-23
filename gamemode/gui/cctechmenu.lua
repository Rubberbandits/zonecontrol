local PANEL = {};

local function PresentRepairDialog(panel, item)
	local dialog = vgui.Create("DFrame")
	dialog:SetTitle("Repair")
	dialog:SetSize(ScrW() * 0.2, ScrH() * 0.2)
	dialog:Center()
	dialog:MakePopup()
	dialog:DockPadding(10, 30, 10, 10)

	local itemCondition = item:GetVar("Durability", 0)
	local maxRepairAmount = item.StartDurability - itemCondition
	local maxPartsRequired = math.ceil(item.RepairCost / (item.StartDurability / (maxRepairAmount)))
	local partsRequired = maxPartsRequired

	local currentCondition = dialog:Add("DLabel")
	currentCondition:SetFont("CombineControl.LabelMedium")
	currentCondition:SetZPos(1)
	currentCondition:Dock(TOP)
	currentCondition:SetContentAlignment(5)
	currentCondition:SetText(Format("Current condition: %d%%", itemCondition))

	local repairCost = dialog:Add("DLabel")
	repairCost:SetFont("CombineControl.LabelMedium")
	repairCost:SetTextColor(Color(255,0,0))
	repairCost:SetZPos(2)
	repairCost:Dock(TOP)
	repairCost:DockMargin(0, 0, 0, 0)
	repairCost:SetContentAlignment(5)
	repairCost:SetText(Format("Required parts to repair: %d", maxPartsRequired))

	local repairCondition = dialog:Add("DLabel")
	repairCondition:SetFont("CombineControl.LabelMedium")
	repairCondition:SetTextColor(Color(0,255,0))
	repairCondition:SetZPos(3)
	repairCondition:Dock(TOP)
	repairCondition:DockMargin(0, 0, 0, 5)
	repairCondition:SetContentAlignment(5)
	repairCondition:SetText(Format("Condition will be repaired to: %d%%", itemCondition + maxRepairAmount))

	local repairAmountLabel = dialog:Add("DLabel")
	repairAmountLabel:SetFont("CombineControl.LabelMedium")
	repairAmountLabel:SetZPos(4)
	repairAmountLabel:Dock(TOP)
	repairAmountLabel:DockMargin(0, 0, 0, 5)
	repairAmountLabel:SetContentAlignment(4)
	repairAmountLabel:SetText("Desired Repair Amount")

	local repairAmount = dialog:Add("DTextEntry")
	repairAmount:SetFont("CombineControl.LabelMedium")
	repairAmount:SetZPos(5)
	repairAmount:Dock(TOP)
	repairAmount:DockMargin(0, 0, 0, 10)
	repairAmount:SetText(maxRepairAmount)
	function repairAmount:OnValueChange(newValue)
		local repairAmt = tonumber(newValue)
		if repairAmt > maxRepairAmount or repairAmt <= 0 then
			self:SetText(maxRepairAmount)
			return
		end

		partsRequired = math.ceil(item.RepairCost / (item.StartDurability / repairAmt))

		repairCost:SetText(Format("Required parts to repair: %d", partsRequired))
		repairCondition:SetText(Format("Condition will be repaired to: %d%%", itemCondition + repairAmt))
	end

	local doRepair = dialog:Add("DButton")
	doRepair:SetFont("CombineControl.LabelMedium")
	doRepair:SetText("Repair")
	doRepair:SetZPos(6)
	doRepair:Dock(TOP)
	function doRepair:DoClick()
		local items = LocalPlayer():HasItem(item.RepairPart)
		if !items or (items.IsItem and partsRequired > 1) or (#items < partsRequired) then
			LocalPlayer():Notify(nil, COLOR_ERROR, "You don't have enough parts to repair the item to this amount!")
			return
		end

		net.Start("zcRepairItem")
			net.WriteUInt(item:GetID(), 32)
			net.WriteUInt(tonumber(repairAmount:GetText()), 8) -- since max is 100, technically only need 7 bits
		net.SendToServer()
	
		dialog:Close()
	end
end

function PANEL:Init()
	local panel = self
	self:SetSize( ScrW() / 3.7, ScrH() );
	self:Center()
	self:SetSkin( "STALKER" );
	self:SetAlpha( 0 );
	self:AlphaTo( 255, 0.2, 0 );
	self:SetTitle("")
	self:ShowCloseButton(false)
	self:MakePopup()
	
	self.ItemDisplay = vgui.Create( "CWeaponDisplay", self );
	self.ItemDisplay:SetPos( ScrW() / 100, ScrH() / 5 );
	self.ItemDisplay:SetSize( ( ScrW() / 3.7 ) - ( ( ScrW() / 100 ) * 2 ), ScrH() / 4 );
	
	self.Container = vgui.Create( "DScrollPanel", self );
	self.Container:SetPos( ScrW() / 100, ScrH() / 2.2 );
	self.Container:SetSize( ( ScrW() / 3.7 ) - ( ( ScrW() / 100 ) * 2 ), ScrH() / 2.04 );
	
	self.CloseButton = vgui.Create("DButton", self)
	self.CloseButton:SetPos(16, self:GetTall() - 48)
	self.CloseButton:SetSize(self:GetWide() - 32, 32)
	self.CloseButton:SetFont("CombineControl.ChatBig")
	self.CloseButton:SetText("Close")
	self.CloseButton.DoClick = function(button)
		self:Close()
	end
	self.CloseButton.Paint = function(panel, w, h)
		kingston.gui.FindFunc(panel, "Paint", "TechCloseButton", w, h)
	end
	
	self.Repair = vgui.Create("DButton", self)
	self.Repair:SetSize(self:GetWide() / 5.7, self:GetTall() / 25)
	self.Repair:SetPos(self:GetWide() - self:GetWide() / 4.49, self:GetTall() / 6.95)
	self.Repair:SetText("")
	self.Repair:SetFont("CombineControl.LabelBig")
	self.Repair.Paint = function(panel, w, h)
		kingston.gui.FindFunc(panel, "Paint", "RepairButton", w, h)
	end
	self.Repair:SetEnabled(false)
	function self.Repair:DoClick()
		if panel.ItemObject then
			PresentRepairDialog(panel, panel.ItemObject)
		end
	end
end

function PANEL:SendToMenu( ItemObj )
	local metaitem = GAMEMODE:GetItemByID(ItemObj:GetClass())
	if !metaitem.CanUpgrade or !ItemObj:CanUpgrade() then return false end
	
	self.ItemDisplay:SetModel(metaitem.Model)
	
	if metaitem.LookAt then
		self.ItemDisplay:SetFOV(metaitem.FOV)
		self.ItemDisplay:SetCamPos(metaitem.CamPos)
		self.ItemDisplay:SetLookAt(metaitem.LookAt)
		
	else
		local a, b = self.ItemDisplay.Entity:GetModelBounds();
		
		self.ItemDisplay:SetFOV( 20 );
		self.ItemDisplay:SetCamPos( Vector( math.abs( a.x ), math.abs( a.y ), math.abs( a.z ) ) * 5 );
		self.ItemDisplay:SetLookAt( ( a + b ) / 2 );
	end
	
	self.UpgradeButtons = {}

	local weapon_upgrades = {}
	for k,v in next, GAMEMODE.Upgrades do
		if( !v.Item[ItemObj:GetClass()] ) then continue end
		
		weapon_upgrades[#weapon_upgrades + 1] = k;
	end
	
	self:CreateUpgradeLayout(weapon_upgrades, ItemObj)
	
	if ItemObj:GetVar("Durability", 100) < 100 then
		self.Repair:SetEnabled(true)
	end

	self.ItemObject = ItemObj
end

function PANEL:CreateUpgradeLayout(upgrades, item_obj)
	local layout = {}
	local children = {}
	for _,class in next, upgrades do
		local upgrade = GAMEMODE.Upgrades[class]
		if upgrade.RequiredUpgrade then
			children[class] = true
			continue
		end
		
		layout[class] = {}
	end
	
	layout.grandchildren = {}
	
	for class,_ in next, children do
		local upgrade = GAMEMODE.Upgrades[class]
		local required_class = upgrade.RequiredUpgrade
		local required_upgrade = GAMEMODE.Upgrades[required_class]
		local upgrade_layout = layout[required_class]
		
		if !required_upgrade.RequiredUpgrade then
			upgrade_layout[class] = {}
		else
			-- turns out you cant do multidimensional tables that are deeper than three layers
			local grandparent = GAMEMODE.Upgrades[required_upgrade.RequiredUpgrade]
			local grandparent_layout = layout[grandparent.ClassName]
			if !layout.grandchildren[required_upgrade.ClassName] then
				layout.grandchildren[required_upgrade.ClassName] = {}
			end

			layout.grandchildren[required_upgrade.ClassName][class] = true
		end
	end

	self:SpawnUpgradeLayout(layout, item_obj)
end

-- this is horrible
function PANEL:SpawnUpgradeLayout(layout, item_obj)
	self.Container:Clear()

	for class,info in next, layout do
		if !GAMEMODE.Upgrades[class] then continue end
		local total_height = 60
		
		local block_container = vgui.Create("DPanel", self.Container)
		block_container:SetSize(self.Container:GetWide(), self.Container:GetTall() / table.Count(layout))
		block_container:DockMargin(0,0,0,10)
		block_container:Dock(TOP)
		block_container.lines = {}
		function block_container:Paint(w,h)
			if !self.calc_lines then
				local parent = self:GetChildren()[1]
				if #parent.ChildButtons > 0 then
					local start_pnl = parent.ChildButtons[1]
					local end_pnl = parent.ChildButtons[#parent.ChildButtons]
					local start_pos_x, start_pos_y = start_pnl:GetPos()
					local end_pos_x, end_pos_y = end_pnl:GetPos()
					local parent_x, parent_y, parent_w, parent_h = parent:GetBounds()
					local dist_between = start_pos_x - (parent_x + parent_w);
					
					self.lines[#self.lines + 1] = {
						start_x = start_pos_x - dist_between / 2,
						start_y = start_pos_y + start_pnl:GetTall() / 2,
						end_x = end_pos_x - dist_between / 2,
						end_y = end_pos_y + end_pnl:GetTall() / 2,
					}

					self.lines[#self.lines + 1] = {
						start_x = parent_x + parent_w,
						start_y = parent_y + parent_h / 2,
						end_x = parent_x + parent_w + dist_between / 2,
						end_y = parent_y + parent_h / 2,
					}
					
					for k,v in next, parent.ChildButtons do
						local pnl_pos_x, pnl_pos_y = v:GetPos()
						self.lines[#self.lines + 1] = {
							start_x = pnl_pos_x - dist_between / 2,
							start_y = pnl_pos_y + v:GetTall() / 2,
							end_x = pnl_pos_x,
							end_y = pnl_pos_y + v:GetTall() / 2,
						}
						
						if #v.ChildButtons > 0 then
							local start_pnl = v.ChildButtons[1]
							local end_pnl = v.ChildButtons[#v.ChildButtons]
							local start_pos_x, start_pos_y = start_pnl:GetPos()
							local end_pos_x, end_pos_y = end_pnl:GetPos()
							local parent_x, parent_y, parent_w, parent_h = v:GetBounds()
							local dist_between = start_pos_x - (parent_x + parent_w);
							
							self.lines[#self.lines + 1] = {
								start_x = start_pos_x - dist_between / 2,
								start_y = start_pos_y + start_pnl:GetTall() / 2,
								end_x = end_pos_x - dist_between / 2,
								end_y = end_pos_y + end_pnl:GetTall() / 2,
							}

							self.lines[#self.lines + 1] = {
								start_x = parent_x + parent_w,
								start_y = parent_y + parent_h / 2,
								end_x = parent_x + parent_w + dist_between / 2,
								end_y = parent_y + parent_h / 2,
							}
						
							for _,button in next, v.ChildButtons do
								local pnl_pos_x, pnl_pos_y = button:GetPos()
								local btn_h = button:GetTall()
								self.lines[#self.lines + 1] = {
									start_x = pnl_pos_x - dist_between / 2,
									start_y = pnl_pos_y + btn_h / 2,
									end_x = pnl_pos_x,
									end_y = pnl_pos_y + btn_h / 2,
								}
							end
						end
					end
				end

				self.calc_lines = true
			else
				for k,v in next, self.lines do
					surface.SetDrawColor(96,96,96)
					surface.DrawLine(v.start_x, v.start_y, v.end_x, v.end_y)
				end
			end
		end
		
		local meta_upgrade = GAMEMODE.Upgrades[class]
		local upgrade = vgui.Create( "CUpgradeButton", block_container );
		upgrade:SetPos( 12, 5 );
		upgrade:SetSize( 110, 50 );
		upgrade.UpgradeID = class;
		upgrade:SetUpgradeImage( meta_upgrade.IconPage, meta_upgrade.IconX, meta_upgrade.IconY );
		upgrade.CurrentItem = item_obj;
		upgrade.ChildButtons = {};

		for upgrade_class,_ in next, item_obj:GetVar( "Upgrades", {} ) do
			if( upgrade_class == class ) then
				upgrade.ItemHasUpgrade = true;
				break;
			end
		end

		if( !meta_upgrade.CanUpgrade( meta_upgrade, item_obj ) ) then
			upgrade:SetDisabled( true );
		end

		self.UpgradeButtons[#self.UpgradeButtons + 1] = upgrade
		
		if table.Count(info) > 0 then
			local parent_x,parent_y = upgrade:GetPos()
			local next_child_y = parent_y;
			for child_class,child_info in next, info do
				local meta_upgrade = GAMEMODE.Upgrades[child_class]
				local child_upgrade = vgui.Create( "CUpgradeButton", block_container );
				child_upgrade:SetPos( block_container:GetWide() / 2 - 55, next_child_y );
				child_upgrade:SetSize( 110, 50 );
				child_upgrade.UpgradeID = child_class;
				child_upgrade:SetUpgradeImage( meta_upgrade.IconPage, meta_upgrade.IconX, meta_upgrade.IconY );
				child_upgrade.CurrentItem = item_obj;
				child_upgrade.ChildButtons = {};

				for upgrade_class,_ in next, item_obj:GetVar( "Upgrades", {} ) do
					if( upgrade_class == child_class ) then
						child_upgrade.ItemHasUpgrade = true;
						break;
					end
				end
				
				if( !meta_upgrade.CanUpgrade( meta_upgrade, item_obj ) ) then
					child_upgrade:SetDisabled( true );
				end
				
				self.UpgradeButtons[#self.UpgradeButtons + 1] = child_upgrade
				upgrade.ChildButtons[#upgrade.ChildButtons + 1] = child_upgrade
				total_height = total_height + 25
				next_child_y = next_child_y + 54

				if layout.grandchildren[child_class] then
					if table.Count(layout.grandchildren[child_class]) > 0 then
						local parent_x,parent_y = child_upgrade:GetPos()
						local next_grandchild_y = parent_y;
						for child_class,_ in next, layout.grandchildren[child_class] do
							local meta_upgrade = GAMEMODE.Upgrades[child_class]
							local gchild_upgrade = vgui.Create( "CUpgradeButton", block_container );
							gchild_upgrade:SetPos( block_container:GetWide() - 118, next_grandchild_y );
							gchild_upgrade:SetSize( 110, 50 );
							gchild_upgrade.UpgradeID = child_class;
							gchild_upgrade:SetUpgradeImage( meta_upgrade.IconPage, meta_upgrade.IconX, meta_upgrade.IconY );
							gchild_upgrade.CurrentItem = item_obj;

							for upgrade_class,_ in next, item_obj:GetVar( "Upgrades", {} ) do
								if( upgrade_class == child_class ) then
									gchild_upgrade.ItemHasUpgrade = true;
									break;
								end
							end
							
							if( !meta_upgrade.CanUpgrade( meta_upgrade, item_obj ) ) then
								gchild_upgrade:SetDisabled( true );
							end
							
							self.UpgradeButtons[#self.UpgradeButtons + 1] = gchild_upgrade
							child_upgrade.ChildButtons[#child_upgrade.ChildButtons + 1] = gchild_upgrade
							total_height = total_height + 25
							next_grandchild_y = next_grandchild_y + 54
						end
						
						next_child_y = next_child_y + (table.Count(layout.grandchildren[child_class]) * 54) / 2
					end
				end
			end
		end

		block_container:SetSize(self.Container:GetWide() - self.Container.VBar:GetWide(), total_height)
		if total_height > 60 then
			upgrade:SetPos(12, block_container:GetTall() / 2 - 25)
			local new_x, new_y = upgrade:GetPos()
			local child_height = #upgrade.ChildButtons * 25
			local next_child_y = new_y - child_height / #upgrade.ChildButtons

			if #upgrade.ChildButtons > 1 then
				for k,v in next, upgrade.ChildButtons do
					if #v.ChildButtons > 0  then
						local gchild_height = #v.ChildButtons * 50
						v:SetPos(block_container:GetWide() / 2 - 50, next_child_y + (gchild_height / 2) - 25)
						next_child_y = next_child_y + gchild_height + 25
						
						local new_x, new_y = v:GetPos()
						local next_gchild_y = new_y - gchild_height / 2 + 25
						for m,n in next, v.ChildButtons do
							n:SetPos(block_container:GetWide() - 110, next_gchild_y)
							next_gchild_y = next_gchild_y + 54
							
							
							if next_gchild_y > block_container:GetTall() then
								block_container:SetSize(self.Container:GetWide() - self.Container.VBar:GetWide(), next_gchild_y + next_gchild_y - block_container:GetTall())
								upgrade:SetPos(12, block_container:GetTall() / 2 - 25)
							end
						end
					else
						v:SetPos(block_container:GetWide() / 2 - 50, next_child_y)
						next_child_y = next_child_y + 54
					end
				end
			else
				for k,v in next, upgrade.ChildButtons do
					v:SetPos(block_container:GetWide() / 2 - 50, block_container:GetTall() / 2 - 25)
					for m,n in next, v.ChildButtons do
						n:SetPos(block_container:GetWide() - 110, block_container:GetTall() / 2 - 25)
					end
				end
			end
		end
	end
end

function PANEL:Paint( w, h )
	
	kingston.gui.FindFunc( self, "Paint", "TechMenuFrame", w, h );

end

vgui.Register( "CTechMenu", PANEL, "DFrame" );