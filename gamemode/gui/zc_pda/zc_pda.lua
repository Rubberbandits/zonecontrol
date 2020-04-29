kingston = kingston or {}
kingston.pda = kingston.pda or {}
kingston.pda.tabs = {
	Journal = {
		order = 3,
		func = function(pnl)
		
		end
	},
	Contacts = {
		order = 2,
		func = function(pnl)
		
		end
	},
	Messages = {
		order = 1,
		default = true,
		func = function(pnl)
			pnl.message_container = vgui.Create("DScrollPanel", pnl)
			pnl.message_container:SetSize(pnl:GetWide() - ScreenScaleH(16), pnl:GetTall() - ScreenScaleH(32))
			pnl.message_container:SetPos(ScreenScale(8), ScreenScale(16))
			pnl.message_container.Paint = function(scroll, w, h)
			end
			
			local date_select = vgui.Create("DLabel", pnl)
			date_select:SetSize(ScreenScaleH(64), ScreenScaleH(16))
			date_select:SetPos(pnl:GetWide() - ScreenScaleH(72) - ScreenScaleH(16), ScreenScaleH(4))
			date_select:SetFont("CombineControl.ChatBig")
			date_select:SetText(os.date("!%Y-%m-%d"))
			date_select.cur_ostime = os.time()
			
			date_select_left = vgui.Create("DButton", pnl)
			date_select_left:SetSize(ScreenScaleH(16), ScreenScaleH(16))
			date_select_left:SetPos(pnl:GetWide() - ScreenScaleH(72) - ScreenScaleH(16) - ScreenScaleH(24), ScreenScaleH(4))
			date_select_left:SetText("")
			date_select_left.LeftDateButton = true
			date_select_left.DoClick = function(btn)
				date_select:SetText(os.date("!%Y-%m-%d", (date_select.cur_ostime or os.time()) - 86000))
				date_select.cur_ostime = date_select.cur_ostime - 86000
				
				netstream.Start("PDAGrabChat", pnl:GetParent().pda_id, date_select:GetText())
			end
			
			date_select_right = vgui.Create("DButton", pnl)
			date_select_right:SetSize(ScreenScaleH(16), ScreenScaleH(16))
			date_select_right:SetPos(pnl:GetWide() - ScreenScaleH(32), ScreenScaleH(4))
			date_select_right:SetText("")
			date_select_right.RightDateButton = true
			date_select_right.DoClick = function(btn)
				date_select:SetText(os.date("!%Y-%m-%d", (date_select.cur_ostime or os.time()) + 86000))
				date_select.cur_ostime = date_select.cur_ostime + 86000
				
				netstream.Start("PDAGrabChat", pnl:GetParent().pda_id, date_select:GetText())
			end
			
			netstream.Start("PDAGrabChat", pnl:GetParent().pda_id, date_select:GetText())
		end
	}
}

local PANEL = {}

function PANEL:Init()
	self:SetSize(ScrW() / 1.3, ScrH())
	self:Center()
	self:SetTitle("")
	self:MakePopup()
	self:SetSkin("zc_pda")
	self:SetDraggable(false)
	self:ShowCloseButton(false)
	self.TabButtons = {}
	
	self.Header = vgui.Create("zc_pda_header", self)
	self.Header:SetPos(ScreenScaleH(16), ScreenScaleH(21))
	self.Header:SetSize(self:GetWide() - ScreenScaleH(32), ScreenScaleH(56))
	
	self.Body = vgui.Create("zc_pda_body", self)
	self.Body:SetPos(ScreenScaleH(16), ScreenScaleH(86))
	self.Body:SetSize(self:GetWide() - ScreenScaleH(32), self:GetTall() - (ScreenScaleH(64) * 2))
	
	self.CloseBtn = vgui.Create("DButton", self)
	self.CloseBtn:SetSize(ScreenScaleH(16),ScreenScaleH(16))
	self.CloseBtn:SetPos(self:GetWide() - ScreenScaleH(27), ScreenScaleH(16))
	self.CloseBtn:SetText("")
	self.CloseBtn.CloseButton = true
	self.CloseBtn.DoClick = function(btn)
		self:Close()
	end
end

function PANEL:AddTab(title, func, default)
	local button = vgui.Create("DButton", self.Header)
	button.IsTabButton = true
	button:SetSize(ScreenScale(72), ScreenScale(12))
	button:SetFont("CombineControl.ChatNormal")
	button:SetText(title)
	
	local count = #self.TabButtons
	local side_w = ScreenScaleH(16)
	local left_x = ScreenScaleH(8)
	local right_w = ScreenScaleH(64)
	
	local left_w = self.Header:GetWide() - right_w - left_x - side_w * 2
	local left_w = left_w - (count*ScreenScaleH(76)) - ScreenScale(56) - (count*ScreenScale(8))
	
	button:SetPos(left_w, ScreenScaleH(12))
	button.DoClick = function(button)
		self.Body:Clear()
		
		for k,v in next, self.TabButtons do
			v.ActivePage = nil
		end
		
		func(self.Body)

		self.CurrentTab = button
		button.ActivePage = true
	end
	button:SetSkin("zc_pda")
	
	if default then
		button:DoClick()
	end
	
	self.TabButtons[#self.TabButtons + 1] = button
end

function PANEL:PopulateMessages(data)
	local scroll = self.Body.message_container
	scroll:Clear()
	
	if #data > 0 then
		for _,entry in next, data do
			local panel = self:CreateMessageEntry(entry.Date, entry.SenderName, entry.ReceiverName, entry.Message)
			panel:DockMargin(0,4,0,0)
			panel:Dock(TOP)
			
			scroll:AddItem(panel)
		end
	else
		local text = vgui.Create("DLabel", scroll)
		text:Dock(TOP)
		text:SetFont("CombineControl.ChatHuge")
		text:SetText("No logs found for this date.")
		text:SizeToContents()
	end
end

function PANEL:CreateMessageEntry(date, sender, receiver, message)
	local panel = vgui.Create("DSizeToContents")
	panel:SetSize(ScreenScaleH(256), ScreenScaleH(32))
	panel.Paint = function(pnl, w, h)
	end
	
	local date_text = vgui.Create("DLabel", panel)
	date_text:SetFont("CombineControl.ChatNormal")
	date_text:SetText(os.date("!%Y-%m-%d %X", date))
	date_text:SetTextColor(Color(120,120,120))
	date_text:SizeToContents()
	date_text:SetPos(ScreenScaleH(2), ScreenScaleH(2))
	
	local participants_text = vgui.Create("DLabel", panel)
	participants_text:SetFont("CombineControl.ChatNormal")
	participants_text:SetText(Format("%s -> %s", sender, receiver))
	participants_text:SetTextColor(Color(220,220,220))
	participants_text:SizeToContents()
	participants_text:SetPos(ScreenScaleH(10) + date_text:GetWide(), ScreenScaleH(2))
	
	-- 229, 201, 98
	local lbl_y = ScreenScaleH(4) + date_text:GetTall()
	local text = vgui.Create("DLabel", panel)
	text:SetWide(ScreenScaleH(248))
	text:SetPos(ScreenScaleH(8), lbl_y)
	text:SetFont("CombineControl.ChatNormal")
	text:SetTextColor(Color(229, 201, 98))
	text:SetWrap(true)
	text:SetText(message)
	text:SetAutoStretchVertical(true)
	
	function panel:PerformLayout(w,h)
		text:SizeToContentsY()
		self:SizeToChildren(false, true)
	end
	
	panel:InvalidateLayout(true)
	
	return panel
end

function PANEL:CreateTabs()
	for title,tab in SortedPairsByMemberValue(kingston.pda.tabs, "order") do
		self:AddTab(title, tab.func, tab.default)
	end
end

function PANEL:Paint(w, h)
	kingston.gui.FindFunc(self, "Paint", "Main", w, h)
end

vgui.Register("zc_pda", PANEL, "DFrame")