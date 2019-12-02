local PANEL = {}

function PANEL:Init()
	self:SetTitle("Change BDU")
	self:SetSize(256, 64)
	self:ShowCloseButton(true)
	self:SetDraggable(true)
	self:Center()
	self:MakePopup()
end

function PANEL:SetItem(item, id)
	local metaitem = GAMEMODE:GetItemByID(item)
	if !metaitem then return end
	
	self.buttons = {}
	for k,v in next, GAMEMODE.g_ItemTable do
		if v.Base != "clothes" then continue end
		if metaitem.Item != v:GetClass() then continue end
		if v:GetVar("SuitClass","") == metaitem.SuitVariant then continue end
		if v:GetVar("Equipped", false) then continue end
		
		local button = vgui.Create("DButton", self)
		button:SetSize(250, 20)
		button:SetText(v:GetName())
		button.id = v:GetID()
		button:Dock(TOP)
		button:DockMargin(6,2,2,6)
		button.DoClick = function(button)
			netstream.Start("ChangeClothesBDU", id, button.id)
			self:Close()
		end
		
		self.buttons[#self.buttons + 1] = button
	end
	
	self:SetTall(48 + (20 * #self.buttons))
	self:Center()
end

vgui.Register("CBDUMenu", PANEL, "DFrame")