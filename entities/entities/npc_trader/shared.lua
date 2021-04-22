AddCSLuaFile()

ENT.Type = "anim"
ENT.PrintName = "Vendor"
ENT.Author = "rusty"
ENT.Contact = ""
ENT.Information		= ""
ENT.Category		= "Kingston"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.Vendor = true

function ENT:CanSellItem(item)
	local item = self.Items[item]
	if item then
		return item.SellFactor > 0
	end
end

function ENT:CanBuyItem(item)
	local item = self.Items[item]
	if item then
		return item.BuyFactor > 0
	end
end