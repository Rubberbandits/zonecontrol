local PANEL = {}

function PANEL:Init()
	self:SetTitle("Attach")
	self:SetSize(256, 64)
	self:ShowCloseButton(true)
	self:SetDraggable(true)
	self:Center()
	self:MakePopup()
end

function PANEL:SetAttachment(attachment, id)
	local metaitem = GAMEMODE:GetItemByID(attachment)
	if !metaitem then return end
	
	self.buttons = {}
	for k,v in next, GAMEMODE.g_ItemTable do
		if v.Base != "weapon" then continue end
		if v:GetVar("CurrentAttachments",{})[attachment] then continue end
		
		local has_an_att = false
		local stored_wep = weapons.GetStored(v.WeaponClass)
		for k,v in next, stored_wep.Attachments do
			for m,n in next, metaitem.Attachment do
				if table.HasValue(v.atts, m) then
					has_an_att = true
				end
			end
		end
		
		if !has_an_att then continue end
		
		local skip_item = false
		for m,n in next, metaitem.RequiredUpgrades do
			if !v:GetVar("Upgrades", {})[m] then
				skip_item = true
				break
			end
		end
		if skip_item then
			continue
		end
		
		local button = vgui.Create("DButton", self)
		button:SetSize(250, 20)
		button:SetText(v.Name)
		button.id = v:GetID()
		button:Dock(TOP)
		button:DockMargin(6,2,2,6)
		button.DoClick = function(button)
			netstream.Start("AttachToWeapon", id, button.id)
			self:Close()
		end
		
		self.buttons[#self.buttons + 1] = button
	end
	
	self:SetTall(48 + (20 * #self.buttons))
	self:Center()
end

function PANEL:SetWeapon(weapon, id)
	self:SetTitle("Detach")

	local item = GAMEMODE.g_ItemTable[id]
	if !item then return end
	if item.Base != "weapon" then return end
	
	self.buttons = {}
	for k,v in next, item:GetVar("CurrentAttachments", {}) do
		local attachment = GAMEMODE:GetItemByID(k)
		if !attachment then continue end
		
		local button = vgui.Create("DButton", self)
		button:SetSize(250, 20)
		button:SetText(attachment.Name)
		button.id = k
		button:Dock(TOP)
		button:DockMargin(6,2,2,6)
		button.DoClick = function(button)
			netstream.Start("DetachFromWeapon", k, id)
			self:Close()
		end
		
		self.buttons[#self.buttons + 1] = button
	end
	
	self:SetTall(48 + (20 * #self.buttons))
	self:Center()
end

vgui.Register("CAttachmentMenu", PANEL, "DFrame")