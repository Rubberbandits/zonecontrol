zonecontrol = zonecontrol or {}
zonecontrol.chat = zonecontrol.chat or {}

local PANEL = {}

function PANEL:Init()
	self.chat = self:Add("ChatText")
	self.chat:Dock(FILL)
	self.chat:DockMargin(4, 4, 4, 4)
	self.chat:GetCanvas():DockPadding(8, 4, 4, 2)
	self.chat:SetPaintedManually(true)

	self.entry = self:Add("ChatEntry")
	self.entry:SetFont("NewChatFont")
	self.entry:Dock(BOTTOM)
	self.entry:DockMargin(4, 4, 4, 4)
	self.entry:SetTabbingDisabled(true)
	self.entry.OnEnter = function(entry)
		if #entry:GetValue() == 0 then
			self:SetAlpha(0)
			self:SetMouseInputEnabled(false)
			self:SetKeyboardInputEnabled(false)

			return
		end

		if string.len(entry:GetValue()) > 2000 then
			GAMEMODE:AddChat( {[CB_ALL] = true, [CB_OOC] = true}, "NewChatFont", Color(200, 0, 0, 255), "The maximum chat length is 2000 characters. You typed " .. string.len(self:GetValue()) .. "." );
			GAMEMODE.NextChatText = entry:GetValue();
		end

		netstream.Start("nSay", entry:GetValue())
		entry:SetText("")

		self:SetAlpha(0)
		self:SetMouseInputEnabled(false)
		self:SetKeyboardInputEnabled(false)
	end
end

function PANEL:PerformLayout(w, h)
	self.chat:DockMargin(4, 4, 4, 4)
	self.entry:DockMargin(4, 4, 4, 4)
end

function PANEL:AddLine(text)
	self.chat:AddLine(text)
end

function PANEL:Paint(w, h)
	self.chat:PaintManual()
end

function PANEL:OnKeyCodeReleased(key_code)
	if (input.LookupKeyBinding(key_code) == "messagemode" and not self.entry:HasFocus()) or input.LookupKeyBinding(key_code) == "cancelselect" then
		self:SetAlpha(0)
		self:SetMouseInputEnabled(false)
		self:SetKeyboardInputEnabled(false)
	end
end

vgui.Register("ChatBox", PANEL, "EditablePanel")

function zonecontrol.chat.create()
	local chatbox = vgui.Create("ChatBox")
	chatbox:SetSize(ScrW() * 0.33, ScrH() * 0.4)
	chatbox:SetPos(10, ScrH() * 0.5)
	chatbox:SetAlpha(0)
	chatbox:SetSkin("Chat")

	return chatbox
end

function zonecontrol.chat.open(chatbox)
	chatbox:SetAlpha(255)
	chatbox:MakePopup()
	chatbox:SetMouseInputEnabled(true)
	chatbox:SetKeyboardInputEnabled(true)
	chatbox.entry:RequestFocus()
end