zonecontrol = zonecontrol or {}
zonecontrol.inventory = zonecontrol.inventory or {}

local PANEL = {}

function PANEL:Init()
    self.div = self:Add("EditablePanel")
    self.div:Dock(RIGHT)
    self.div:DockMargin(self:GetWide() * 0.05, self:GetTall() * 0.15, self:GetWide() * 0.05, self:GetTall() * 0.1)
    self.div:SetWide(self:GetWide())

    self.grid = self.div:Add("InventoryGrid")
    self.grid:Dock(FILL)
end

function PANEL:PerformLayout(w, h)
    if not IsValid(self.div) then return end
    self.div:SetWide(w - w * 0.1)
    self.div:DockMargin(w * 0.05, h * 0.15, w * 0.05, h * 0.04)
end

function PANEL:OnKeyCodeReleased(key_code)
    if zonecontrol.binds.get(key_code) == "open_inventory" then
        self:Remove()
    end
end

function PANEL:Paint(w, h)
    kingston.gui.FindFunc(self, "Paint", "InventoryFrame", w, h)
end

vgui.Register("Inventory", PANEL, "EditablePanel")

function zonecontrol.inventory.open()
    local inventory = vgui.Create("Inventory")
    inventory:Dock(RIGHT)
    inventory:SetSize(ScrW() * 0.263, ScrH())
    inventory:MakePopup()
    inventory:SetSkin("Inventory")
end