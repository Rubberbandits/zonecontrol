local PANEL = {}

local RANK_FUNCTIONS = {
	["Set priority"] = function(pnl, line)
		Derma_StringRequest("Set priority", "Set rank priority", line.data.priority, function(text) 
			net.Start("zcRunCommand")
				net.WriteString("ranksetpriority")
				net.WriteTable({
					line.data.uniqueID,
					text
				})
			net.SendToServer()
		end)
	end,
	["Set is admin"] = function(pnl, line)
		Derma_Query(
			"Is this rank considered an admin?", 
			"Set is admin", 
			'Yes', 
			function() 
				net.Start("zcRunCommand")
					net.WriteString("ranksetadmin")
					net.WriteTable({
						line.data.uniqueID,
						"true"
					})
				net.SendToServer()
			end, 
			"No", 
			function() 
				net.Start("zcRunCommand")
					net.WriteString("ranksetadmin")
					net.WriteTable({
						line.data.uniqueID,
						"false"
					})
				net.SendToServer()
			end
		)
	end,
	["Set is superadmin"] = function(pnl, line)
		Derma_Query(
			"Is this rank considered a superadmin?", 
			"Set is superadmin", 
			'Yes', 
			function() 
				net.Start("zcRunCommand")
					net.WriteString("ranksetsuperadmin")
					net.WriteTable({
						line.data.uniqueID,
						"true"
					})
				net.SendToServer()
			end, 
			"No", 
			function() 
				net.Start("zcRunCommand")
					net.WriteString("ranksetsuperadmin")
					net.WriteTable({
						line.data.uniqueID,
						"false"
					})
				net.SendToServer()
			end
		)
	end
}

function PANEL:Init()
	self:SetTitle("Rank Management")
	self:SetSize(ScrW() * 0.6, ScrH() * 0.8)
	self:Center()
	self:MakePopup()

	self.ranks = self:Add("DListView")
	self.ranks:Dock(LEFT)
	self.ranks:SetWide(self:GetWide() * 0.3)
	self.ranks:AddColumn("Rank")
	self.ranks:SetMultiSelect(false)
	self.ranks.OnRowRightClick = function(pnl, lineID, line)
		local menu = DermaMenu(false, self.ranks)

		for name,callback in pairs(RANK_FUNCTIONS) do
			menu:AddOption(name, function()
				callback(self, line)
			end)
		end

		menu:Open()
	end
	self.ranks.OnRowSelected = function(pnl, lineID, line)
		pnl.selected = lineID

		self.permissions:Clear()

		for cmd,_ in SortedPairs(line.data.permissions) do
			self.permissions:AddLine(cmd)
		end

		self.commands:Clear()

		for cmd,_ in SortedPairs(kingston.admin.commands) do
			if line.data.permissions[cmd] then continue end

			self.commands:AddLine(cmd)
		end
	end

	self.permissions = self:Add("DListView")
	self.permissions:DockMargin(6, 0, 0, 0)
	self.permissions:Dock(LEFT)
	self.permissions:SetWide(self:GetWide() * 0.3)
	self.permissions:AddColumn("Permission")
	self.permissions.OnRowSelected = function(pnl, lineID, line)
		self.buttons.remove:SetDisabled(false)
	end
	self.permissions.DoDoubleClick = function(pnl, lineID, line)
		self.buttons.remove:DoClick()
	end

	self.buttons = self:Add("DPanel")
	self.buttons:DockMargin(6, 0, 6, 0)
	self.buttons:Dock(LEFT)
	self.buttons:SetWide(ScreenScaleH(32))
	self.buttons.Paint = function() end

	self.buttons.container = self.buttons:Add("DPanel")
	self.buttons.container:SetSize(self.buttons:GetWide(), ScreenScaleH(32))
	self.buttons.container:SetPos(0, self:GetTall() * 0.475 - (ScreenScaleH(32) * 0.5))
	self.buttons.container.Paint = function() end

	self.buttons.add = self.buttons.container:Add("DButton")
	self.buttons.add:SetText("<-")
	self.buttons.add:Dock(TOP)
	self.buttons.add:SetDisabled(true)
	self.buttons.add.DoClick = function(pnl)
		local lines = self.commands:GetSelected()
		if #lines > 0 then
			local selectedRank = self.ranks:GetLine(self.ranks.selected).data.uniqueID
			local perms = {}

			for lineID,line in pairs(lines) do
				local text = line:GetColumnText(1)
				table.insert(perms, text)

				self.commands:RemoveLine(lineID)
				self.permissions:AddLine(text)
			end

			net.Start("zcRunCommand")
				net.WriteString("rankgiveperm")
				net.WriteTable({
					selectedRank,
					table.concat(perms, ",")
				})
			net.SendToServer()

			pnl:SetDisabled(true)
		end
	end

	self.buttons.remove = self.buttons.container:Add("DButton")
	self.buttons.remove:SetText("->")
	self.buttons.remove:DockMargin(0, 4, 0, 0)
	self.buttons.remove:Dock(TOP)
	self.buttons.remove:SetDisabled(true)
	self.buttons.remove.DoClick = function(pnl)
		local lines = self.permissions:GetSelected()
		if #lines > 0 then
			local selectedRank = self.ranks:GetLine(self.ranks.selected).data.uniqueID
			local perms = {}

			for lineID,line in pairs(lines) do
				local text = line:GetColumnText(1)
				table.insert(perms, text)

				self.permissions:RemoveLine(lineID)
				self.commands:AddLine(text)
			end

			net.Start("zcRunCommand")
				net.WriteString("ranktakeperm")
				net.WriteTable({
					selectedRank,
					table.concat(perms, ",")
				})
			net.SendToServer()

			pnl:SetDisabled(true)
		end
	end

	self.commands = self:Add("DListView")
	self.commands:Dock(LEFT)
	self.commands:SetWide(self:GetWide() * 0.3)
	self.commands:AddColumn("Command")
	self.commands.OnRowSelected = function(pnl, lineID, line)
		self.buttons.add:SetDisabled(false)
	end
	self.commands.DoDoubleClick = function(pnl, lineID, line)
		self.buttons.add:DoClick()
	end

	self:PopulateRanks()
end

function PANEL:PopulateRanks()
	self.ranks:Clear()

	for rank,data in SortedPairsByMemberValue(kingston.admin.groups, "priority") do
		local line = self.ranks:AddLine(rank)
		line.data = data
		line:SetTooltip(Format("Priority: %d\nIs admin: %s\nIs superadmin: %s", data.priority, data.isAdmin, data.isSuperAdmin))
	end
end

vgui.Register("zc_rank_manage", PANEL, "DFrame")