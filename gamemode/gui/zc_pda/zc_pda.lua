kingston = kingston or {}
kingston.pda = kingston.pda or {}
kingston.pda.has_authenticated = kingston.pda.has_authenticated or {}
kingston.pda.tabs = {
	Map = {
		order = 4,
		func = function(pnl)

		end
	},
	Journal = {
		order = 3,
		default = true,
		func = function(pnl)
			pnl.select_journal = vgui.Create("DScrollPanel", pnl)
			pnl.select_journal:SetSize(pnl:GetWide() / 4, pnl:GetTall() - ScreenScaleH(24))
			pnl.select_journal:SetPos(ScreenScaleH(8), ScreenScaleH(12))
			pnl.select_journal:DockPadding(20, 4, 4, 4)
			pnl.select_journal.Paint = function(scroll, w, h)
				surface.SetDrawColor(200,200,200,120)
				surface.DrawOutlinedRect(0,0,w,h)
			end
			
			pnl.journal_title = vgui.Create("DTextEntry", pnl)
			pnl.journal_title:SetSize(pnl:GetWide() - (pnl:GetWide() / 4) - ScreenScaleH(20), ScreenScaleH(12))
			pnl.journal_title:SetPos(pnl:GetWide() / 4 + ScreenScaleH(12), ScreenScaleH(12))
			pnl.journal_title:SetFont("CombineControl.ChatNormal")
			pnl.journal_title:SetText("Journal")
			pnl.journal_title:SetTextColor(Color(200,200,200))
			pnl.journal_title:SetEditable(false)
			
			pnl.journal_entry = vgui.Create("DTextEntry", pnl)
			pnl.journal_entry:SetSize(pnl:GetWide() - (pnl:GetWide() / 4) - ScreenScaleH(20), pnl:GetTall() - ScreenScaleH(28) - pnl.journal_title:GetTall())
			pnl.journal_entry:SetPos(pnl:GetWide() / 4 + ScreenScaleH(12), ScreenScaleH(16) + pnl.journal_title:GetTall())
			pnl.journal_entry:SetFont("CombineControl.ChatNormal")
			pnl.journal_entry:SetText("No journal selected.")
			pnl.journal_entry:SetTextColor(Color(200,200,200))
			pnl.journal_entry:SetMultiline(true)
			pnl.journal_entry:SetVerticalScrollbarEnabled(true)
			pnl.journal_entry:SetEditable(false)
			
			local x,y,w,h = pnl.journal_entry:GetBounds()
			
			pnl.save_journal = vgui.Create("DButton", pnl)
			pnl.save_journal:SetSize(ScreenScaleH(32), ScreenScaleH(12))
			pnl.save_journal:SetPos(x, y + h)
			pnl.save_journal:SetTextColor(Color(32,200,32))
			pnl.save_journal:SetFont("CombineControl.ChatNormal")
			pnl.save_journal:SetText("")
			pnl.save_journal:SetContentAlignment(4)
			pnl.save_journal.NoPaint = true
			pnl.save_journal.DoClick = function(btn)
				local title = pnl.journal_title:GetText()
				local entry = pnl.journal_entry:GetText()
				
				if #title > 128 then
					pnl.notify:SetText("Title is too long, limit is 128 characters!")
					pnl.notify:SizeToContents()
					pnl.notify:InvalidateLayout(true)
					
					pnl.notify:SetPos((x + w) - pnl.notify:GetWide() - ScreenScaleH(4), y + h)
					
					return
				elseif #entry > 2048 then
					pnl.notify:SetText("Entry is too long, limit is 2048 characters!")
					pnl.notify:SizeToContents()
					pnl.notify:InvalidateLayout(true)
					
					pnl.notify:SetPos((x + w) - pnl.notify:GetWide() - ScreenScaleH(4), y + h)
					
					return
				end
				
				pnl.journal_title:SetEditable(false)
				pnl.journal_entry:SetEditable(false)
				
				pnl.notify:SetText("")
				
				btn:SetText("")
				btn:SetDisabled(true)
			
				netstream.Start("PDAWriteJournal", pnl:GetParent().pda_id, title, entry, true)
			end
			pnl.save_journal:SetDisabled(true)
			
			pnl.delete_journal = vgui.Create("DButton", pnl)
			pnl.delete_journal:SetSize(ScreenScaleH(32), ScreenScaleH(12))
			pnl.delete_journal:SetPos(x + pnl.save_journal:GetWide(), y + h)
			pnl.delete_journal:SetTextColor(Color(200,32,32))
			pnl.delete_journal:SetFont("CombineControl.ChatNormal")
			pnl.delete_journal:SetText("")
			pnl.delete_journal:SetContentAlignment(4)
			pnl.delete_journal.NoPaint = true
			pnl.delete_journal.DoClick = function(btn)
				netstream.Start("PDADeleteJournal", pnl:GetParent().pda_id, pnl.selected_journal)
				
				pnl.journal_title:SetEditable(false)
				pnl.journal_title:SetText("Journal")
				
				pnl.journal_entry:SetEditable(false)
				pnl.journal_entry:SetText("No journal selected.")
				
				pnl.delete_journal:SetDisabled(true)
				pnl.delete_journal:SetText("")
			end
			pnl.delete_journal:SetDisabled(true)
			
			pnl.notify = vgui.Create("DLabel", pnl)
			pnl.notify:SetText("")
			pnl.notify:SetSize(ScreenScaleH(256), ScreenScaleH(12))
			pnl.notify:SetFont("CombineControl.ChatNormal")
			pnl.notify:SetTextColor(Color(200,0,0))
			pnl.notify:SetPos((x + w) - pnl.notify:GetWide(), y + h)
			
			netstream.Start("PDAGrabJournal", pnl:GetParent().pda_id)
		end
	},
	Contacts = {
		order = 2,
		func = function(pnl)
			pnl.contacts = vgui.Create("DScrollPanel", pnl)
			pnl.contacts:SetSize(pnl:GetWide() - ScreenScaleH(16), pnl:GetTall() - ScreenScaleH(24))
			pnl.contacts:SetPos(ScreenScaleH(8), ScreenScaleH(12))
			pnl.contacts.Paint = function(scroll, w, h)
				surface.SetDrawColor(200,200,200,120)
				surface.DrawOutlinedRect(0,0,w,h)
			end
			
			netstream.Start("PDAGrabContacts")
		end
	},
	Messages = {
		order = 1,
		func = function(pnl)
			pnl.message_container = vgui.Create("DScrollPanel", pnl)
			pnl.message_container:SetSize(pnl:GetWide() - ScreenScaleH(16), pnl:GetTall() - ScreenScaleH(40))
			pnl.message_container:SetPos(ScreenScaleH(8), ScreenScaleH(24))
			pnl.message_container.Paint = function(scroll, w, h)
				surface.SetDrawColor(200,200,200,120)
				surface.DrawOutlinedRect(0,0,w,h)
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
	
	if default and self:HasAuthenticated() then
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
			panel:DockMargin(10,4,0,0)
			panel:Dock(TOP)
			
			scroll:AddItem(panel)
		end
	else
		local text = vgui.Create("DLabel", scroll)
		text:DockMargin(10, 4, 0, 0)
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

function PANEL:PopulateJournal(data)
	self.Body.select_journal:Clear()

	for _,entry in next, data do
		local btn = vgui.Create("DButton", self.Body.select_journal)
		btn:DockMargin(10, 10, 10, 10)
		btn:Dock(TOP)
		btn:SetTextColor(Color(32,200,32))
		btn:SetFont("CombineControl.ChatNormal")
		btn:SetText(entry.Title)
		btn:SetContentAlignment(4)
		btn.DoClick = function()
			self.Body.journal_title:SetText(entry.Title)
			self.Body.journal_entry:SetText(entry.Message)
			self.Body.selected_journal = entry.id
			
			self.Body.delete_journal:SetText("Delete")
			self.Body.delete_journal:SetDisabled(false)
			
			self.Body.save_journal:SetDisabled(true)
			self.Body.save_journal:SetText("")
		end
		function btn:Paint()
			if self:IsHovered() and !self.LastHovered then
				self:SetTextColor(Color(128,255,128))
			elseif !self:IsHovered() and self.LastHovered then
				self:SetTextColor(Color(32,200,32))
			end
			
			self.LastHovered = self:IsHovered()
		end
		btn:SizeToContents()
	end
	
	local btn = vgui.Create("DButton", self.Body.select_journal)
	btn:DockMargin(10, 10, 10, 10)
	btn:Dock(TOP)
	btn:SetTextColor(Color(32,200,32))
	btn:SetFont("CombineControl.ChatNormal")
	btn:SetText("+ New")
	btn:SetContentAlignment(4)
	btn.DoClick = function()
		local pnl = self.Body
		
		pnl.save_journal:SetDisabled(false)
		pnl.save_journal:SetText("Save")
		
		pnl.delete_journal:SetText("")
		pnl.delete_journal:SetDisabled(true)
		
		pnl.journal_title:SetEditable(true)
		pnl.journal_title:SetText("Title")
		
		pnl.journal_entry:SetEditable(true)
		pnl.journal_entry:SetText("Entry")
	end
	function btn:Paint()
		if self:IsHovered() and !self.LastHovered then
			self:SetTextColor(Color(128,255,128))
		elseif !self:IsHovered() and self.LastHovered then
			self:SetTextColor(Color(32,200,32))
		end
		
		self.LastHovered = self:IsHovered()
	end
	btn:SizeToContents()
end

function PANEL:PopulateContacts(data)
	local scroll = self.Body.contacts
	if !scroll or !scroll:IsValid() then return end
	scroll:Clear()
	
	for _,contact in next, data do
		local panel = self:CreateContact(contact)
		panel:DockMargin(10,4,0,0)
		panel:Dock(TOP)
		
		scroll:AddItem(panel)
	end
end

local rand_devices = {
	"HP_iPAQ_H1940",
	"SAMSUNG_SGH-i700",
	"SAMSUNG_F700",
}

function PANEL:CreateContact(data)
	local panel = vgui.Create("DSizeToContents")
	panel:SetSize(ScreenScaleH(256), ScreenScaleH(32))
	panel.Paint = function(pnl, w, h)
	end
	
	local contact_name = vgui.Create("DLabel", panel)
	contact_name:SetFont("CombineControl.ChatNormal")
	contact_name:SetText("USERNAME: "..data.name)
	contact_name:SetTextColor(Color(229, 201, 98))
	contact_name:SizeToContents()
	contact_name:SetPos(ScreenScaleH(2), ScreenScaleH(2))

	local rank = vgui.Create("DLabel", panel)
	rank:SetFont("CombineControl.ChatNormal")
	rank:SetText(data.rank)
	rank:SetTextColor(Color(120,120,120))
	rank:SizeToContents()
	rank:SetPos(ScreenScaleH(4), ScreenScaleH(2) + contact_name:GetTall())

	local placeholder = vgui.Create("DLabel", panel)
	placeholder:SetFont("CombineControl.ChatNormal")
	placeholder:SetText("ACTIVE_DEVICE: "..table.Random(rand_devices))
	placeholder:SetTextColor(Color(120,120,120))
	placeholder:SizeToContents()
	placeholder:SetPos(ScreenScaleH(4), ScreenScaleH(2) + contact_name:GetTall() + rank:GetTall())
	
	function panel:PerformLayout(w,h)
		contact_name:SizeToContentsY()
		self:SizeToChildren(false, true)
	end
	
	panel:InvalidateLayout(true)
	
	return panel
end

function PANEL:CreatePasswordEntry()
	local pnl = self.Body
	
	pnl.PasswordEntry = vgui.Create("DTextEntry", pnl)
	pnl.PasswordEntry:SetSize(ScrW() / 6, ScreenScaleH(12))
	pnl.PasswordEntry:SetPos((pnl:GetWide() / 2) - ((ScrW() / 6) / 2), (pnl:GetTall() / 2) - ScreenScaleH(19))
	pnl.PasswordEntry:SetFont("CombineControl.ChatNormal")
	pnl.PasswordEntry:SetText("Password")
	pnl.PasswordEntry:SetContentAlignment(5)
	pnl.PasswordEntry.OnEnter = function(entry)
		netstream.Start("AuthenticatePDA", self.pda_id, entry:GetText())
	end
	
	pnl.UnlockBtn = vgui.Create("DButton", pnl)
	pnl.UnlockBtn:SetSize(ScrW() / 6, ScreenScaleH(12))
	pnl.UnlockBtn:SetPos((pnl:GetWide() / 2) - ((ScrW() / 6) / 2), (pnl:GetTall() / 2) - ScreenScaleH(5))
	pnl.UnlockBtn:SetFont("CombineControl.ChatNormal")
	pnl.UnlockBtn:SetText("Unlock")
	pnl.UnlockBtn.DoClick = function(btn)
		netstream.Start("AuthenticatePDA", self.pda_id, pnl.PasswordEntry:GetText())
	end
end

function PANEL:AuthenticationComplete()
	self.Body:Clear()
	kingston.pda.has_authenticated[self.pda_id] = true
	
	self:CreateTabs()
end

function PANEL:CreateTabs()
	for title,tab in SortedPairsByMemberValue(kingston.pda.tabs, "order") do
		self:AddTab(title, tab.func, tab.default)
	end
end

function PANEL:HasAuthenticated()
	local item = GAMEMODE.g_ItemTable[self.pda_id]
	if !item then return false end
	if !item:GetVar("HasPassword", false) then return true end
	
	return kingston.pda.has_authenticated[self.pda_id]
end

function PANEL:Paint(w, h)
	kingston.gui.FindFunc(self, "Paint", "Main", w, h)
end

vgui.Register("zc_pda", PANEL, "DFrame")