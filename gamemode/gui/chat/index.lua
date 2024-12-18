zonecontrol = zonecontrol or {}
zonecontrol.chat = zonecontrol.chat or {}

local PANEL = {}

function PANEL:Init()
    self.chat = self:Add("ChatText")
    self.chat:Dock(FILL)
    self.chat:DockMargin(4, 4, 4, 4)
    self.chat:SetPaintedManually(true)

    self.entry = self:Add("ChatEntry")
    self.entry:Dock(BOTTOM)
    self.entry:DockMargin(4, 4, 4, 4)
end

function PANEL:PerformLayout(w, h)

end

function PANEL:Paint(w, h)
    self.chat:PaintManual()
end

function PANEL:OnKeyCodeReleased(key_code)
    if input.LookupKeyBinding(key_code) == "messagemode" and not self.entry:HasFocus() then
        self:Remove()
    end
end

vgui.Register("ChatBox", PANEL, "EditablePanel")

function zonecontrol.chat.open()
    local chatbox = vgui.Create("ChatBox")
    chatbox:Dock(FILL)
    chatbox:DockMargin(10, ScrH() * 0.5, ScrW() * 0.6, ScrH() * 0.1)
    //chatbox:SetWide(ScrW() * 0.333)
    chatbox:MakePopup()
end