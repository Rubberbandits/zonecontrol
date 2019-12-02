BASE.Attachment = ""
BASE.CanAttachTo = {}
BASE.RequiredUpgrades = {}
--BASE.AttachmentSlot = "" 
-- use this to prevent two attachments from being able both be attached at the same time
BASE.functions = {};
BASE.functions.Attach = {
	SelectionName = "Attach",
	OnUse = function(item)
		if CLIENT then
			local menu = vgui.Create("CAttachmentMenu")
			menu:SetAttachment(item:GetClass(), item:GetID())
		end
		
		return true
	end,
	CanRun = function(item)
		return true
	end,
}

function BASE:CanAttach(weapon)
	if !weapon then return end
	
	for k,v in next, weapon:GetVar("CurrentAttachments", {}) do
		local attachment = GAMEMODE:GetItemByID(k)
		if !attachment then continue end
		
		if attachment.AttachmentSlot == self.AttachmentSlot then return false end
	end
	
	if weapon:GetVar("CurrentAttachments", {})[self.Class] then return false end
	
	for k,v in next, self.RequiredUpgrades do
		if !weapon:GetVar("Upgrades", {})[k] then return false end
	end
	
	return self.CanAttachTo[weapon:GetClass()]
end

if SERVER then
	netstream.Hook("AttachToWeapon", function(ply, attach_id, weapon_id)
		local attachment = GAMEMODE.g_ItemTable[attach_id]
		local weapon = GAMEMODE.g_ItemTable[weapon_id]
		
		if !attachment or !weapon then return end
		if !attachment:CanAttach(weapon) then return end
		
		local cur_attachments = weapon:GetVar("CurrentAttachments", {}) -- returns a reference
		cur_attachments[attachment.Class] = true
		
		weapon:SetVar("CurrentAttachments", cur_attachments, nil, true)

		local weapon_ent = ply:GetWeapon(weapon.WeaponClass)
		if weapon_ent and weapon_ent:IsValid() then
			weapon_ent:Attach(attachment.Attachment)
		end
		
		attachment:RemoveItem(true)
	end)
	
	netstream.Hook("DetachFromWeapon", function(ply, attach, weapon_id)
		local attachment = GAMEMODE:GetItemByID(attach)
		local weapon = GAMEMODE.g_ItemTable[weapon_id]
		
		if !attachment or !weapon then return end
		
		local cur_attachments = weapon:GetVar("CurrentAttachments", {}) -- returns a reference
		if !cur_attachments[attachment.Class] then return end
		
		cur_attachments[attachment.Class] = nil
		weapon:SetVar("CurrentAttachments", cur_attachments, nil, true)

		local weapon_ent = ply:GetWeapon(weapon.WeaponClass)
		if weapon_ent and weapon_ent:IsValid() then
			weapon_ent:Detach(attachment.Attachment)
		end
		
		ply:GiveItem(attach, attachment.Vars or {})
	end)
end