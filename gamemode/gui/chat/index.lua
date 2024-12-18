zonecontrol = zonecontrol or {}
zonecontrol.chat = zonecontrol.chat or {}

local PANEL = {}

function PANEL:Init()
	self.chat = self:Add("ChatText")
	self.chat:Dock(FILL)
	self.chat:DockMargin(4, 4, 4, 4)
	self.chat:DockPadding(8, 4, 4, 2)
	self.chat:SetPaintedManually(true)

	self.entry = self:Add("ChatEntry")
	self.entry:Dock(BOTTOM)
	self.entry:DockMargin(4, 4, 4, 4)
	self.entry:RequestFocus()
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
		self:Remove()
	end
end

vgui.Register("ChatBox", PANEL, "EditablePanel")

function zonecontrol.chat.open()
	local chatbox = vgui.Create("ChatBox")
	chatbox:Dock(FILL)
	chatbox:DockMargin(10, ScrH() * 0.5, ScrW() * 0.6, ScrH() * 0.1)
	chatbox:MakePopup()
	chatbox:AddLine("<font=NewChatFont>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam gravida nibh in nunc rhoncus, id aliquam magna lacinia. Mauris posuere eu enim et mollis. Proin finibus elit erat, eget tincidunt magna lacinia vel. Fusce mattis mi ut metus elementum, vel pharetra arcu porta.</font>")
	chatbox:AddLine("<font=NewChatFont>Ut in malesuada sem. Phasellus sem arcu, sagittis ultricies gravida pulvinar, dapibus eu ligula. Aenean eleifend ac leo in vulputate. Phasellus nec lacinia tellus. Pellentesque pulvinar tristique risus, a pretium massa sodales ut. Praesent sed odio arcu. Integer sem magna, elementum vitae pulvinar et, mattis ut ipsum. Donec pellentesque ullamcorper libero eu dapibus.</font>")
end