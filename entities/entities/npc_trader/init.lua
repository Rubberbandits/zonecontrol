AddCSLuaFile("cl_init.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/tnb/stalker_2019/trenchcoat_io7mask.mdl")
	self:SetUseType(SIMPLE_USE)
	self:SetMoveType(MOVETYPE_NONE)
	self:DrawShadow(true)
	self:SetSolid(SOLID_BBOX)
	self:PhysicsInit(SOLID_BBOX)

	self.Items = {}

	timer.Simple(1, function()
		if (IsValid(self)) then
			self:SetAnim()
			self:DropToFloor()
		end
	end)

	local physObj = self:GetPhysicsObject()
	
	if (IsValid(physObj)) then
		physObj:EnableMotion(false)
		physObj:Sleep()
	end
end

function ENT:SetAnim(animIndex)
	if isstring(animIndex) then
		animIndex = self:LookupSequence(animIndex)
	end

	if !animIndex then
		for k, v in next, self:GetSequenceList() do
			if (v:lower():find("idle") and v ~= "idlenoise" and v ~= "idle") then
				animIndex = k
				break
			end
		end
	end

	self:SetNW2Int("CurrentAnimation", animIndex)

	return self:ResetSequence(animIndex)
end

local Entity_SetModel = FindMetaTable("Entity").SetModel

function ENT:SetVendorModel(str)
	Entity_SetModel(self, str)

	timer.Simple(1, function()
		if (IsValid(self)) then
			self:SetAnim(self:GetNW2Int("CurrentAnimation"))
			self:DropToFloor()
		end
	end)
end

function ENT:AddItem(item, sellFactor, buyFactor)
	if !GAMEMODE:GetItemByID(item) then return end

	self.Items[item] = {
		SellFactor = sellFactor or 0,
		BuyFactor = buyFactor or 0,
	}
end

function ENT:Use(ply, caller, useType, int)
	net.Start("VendorOpenMenu")
		net.WriteEntity(self)
		
		net.WriteUInt(table.Count(self.Items), 32)
		for class,data in next, self.Items do
			net.WriteString(class)
			net.WriteFloat(data.BuyFactor)
			net.WriteFloat(data.SellFactor)
		end
		net.WriteBool(false)
	net.Send(ply)
end

/*
	Networking
*/

util.AddNetworkString("VendorOpenMenu")
util.AddNetworkString("VendorUpdateUI")

util.AddNetworkString("VendorBuyItem")
local function VendorBuyItem(len, ply)
	local vendor = net.ReadEntity()

	if !vendor.Vendor then return end
	if vendor:GetPos():DistToSqr(ply:GetPos()) > 500*500 then return end

	local itemClass = net.ReadString()
	local metaitem = GAMEMODE:GetItemByID(itemClass)
	if !metaitem then return end

	local vendorData = vendor.Items[itemClass]
	if !vendor:CanSellItem(itemClass) then return end

	local sellFactor = vendorData.SellFactor

	local quantity = net.ReadUInt(32)
	local totalCost = (hook.Run("GetBuyPrice", ply, itemClass, true) * sellFactor) * quantity

	if ply:Money() < totalCost then
		ply:Notify(nil, COLOR_ERROR, "You can't afford to buy this.")
		return 
	end

	ply:AddMoney(-totalCost)
	ply:UpdateCharacterField("Money", ply:Money())

	for i = 1, quantity do
		ply:GiveItem(itemClass)
	end

	ply:Notify(nil, COLOR_NOTIF, "You've purchased %d %s for %d RU.", quantity, metaitem.Name, totalCost)

	net.Start("VendorUpdateUI")
	net.Send(ply)
end
net.Receive("VendorBuyItem", VendorBuyItem)

util.AddNetworkString("VendorSellItem")
local function VendorSellItem(len, ply)
	local vendor = net.ReadEntity()

	if !vendor.Vendor then return end
	if vendor:GetPos():DistToSqr(ply:GetPos()) > 500*500 then return end

	local itemID = net.ReadUInt(32)
	if !ply.Inventory then return end

	local item = ply.Inventory[itemID]
	if !item then return end

	local vendorData = vendor.Items[item:GetClass()]
	if !vendor:CanBuyItem(item:GetClass()) then return end

	local buyFactor = vendorData.BuyFactor

	local totalValue = hook.Run("CalculatePrice", item) * buyFactor
	if totalValue == 0 then return end

	ply:AddMoney(totalValue)
	ply:UpdateCharacterField("Money", ply:Money())
	ply:Notify(nil, COLOR_NOTIF, "You've sold your %s for %d RU.", item:GetName(), totalValue)

	item:RemoveItem(true)

	net.Start("VendorUpdateUI")
	net.Send(ply)
end
net.Receive("VendorSellItem", VendorSellItem)

util.AddNetworkString("VendorModifyItems")
local function VendorModifyItems(len, ply)
	if !ply:IsAdmin() then return end

	local vendor = net.ReadEntity()

	if !vendor.Vendor then return end

	local data = {}
	local dataCount = net.ReadUInt(32)
	for i = 1, dataCount do
		local className = net.ReadString()
		local shouldRemove = net.ReadBool()
		if shouldRemove then
			vendor.Items[className] = nil
			continue
		end

		local buyFactor = net.ReadFloat()
		local sellFactor = net.ReadFloat()

		data[className] = {
			SellFactor = sellFactor,
			BuyFactor = buyFactor,
		}
	end

	table.Merge(vendor.Items, data)
end
net.Receive("VendorModifyItems", VendorModifyItems)

util.AddNetworkString("VendorChangeModel")
local function VendorChangeModel(len, ply)
	if !ply:IsAdmin() then return end

	local vendor = net.ReadEntity()

	if !vendor.Vendor then return end

	vendor:SetVendorModel(net.ReadString())
end
net.Receive("VendorChangeModel", VendorChangeModel)

util.AddNetworkString("VendorChangeAnimation")
local function VendorChangeAnimation(len, ply)
	if !ply:IsAdmin() then return end

	local vendor = net.ReadEntity()

	if !vendor.Vendor then return end

	local seqIndex = vendor:LookupSequence(net.ReadString())
	if !seqIndex then return end

	vendor:SetAnim(seqIndex)
end
net.Receive("VendorChangeAnimation", VendorChangeAnimation)

function GAMEMODE:LoadVendors()
	local data = file.Read("zonecontrol/"..game.GetMap().."/vendors.txt", "DATA")

	if !data or #data == 0 then return end

	local vendors = util.JSONToTable(data)
	if vendors then
		for _,data in ipairs(vendors) do
			local vendor = ents.Create("npc_trader")
			vendor:SetPos(data.Pos)
			vendor:SetAngles(data.Angles)
			vendor:Spawn()

			vendor:SetNW2Int("CurrentAnimation", data.SequenceIndex)
			vendor:SetVendorModel(data.Model)
			vendor.Items = data.Items
		end
	end
end

function GAMEMODE:SaveVendors()
	if !file.IsDir("zonecontrol", "DATA") then
		file.CreateDir("zonecontrol")
	end

	if !file.IsDir("zonecontrol/"..game.GetMap(), "DATA") then
		file.CreateDir("zonecontrol/"..game.GetMap())
	end

	local data = {}
	for _,vendor in ipairs(ents.FindByClass("npc_trader")) do
		table.insert(
			data,
			{
				Pos = vendor:GetPos(),
				Angles = vendor:GetAngles(),
				Model = vendor:GetModel(),
				SequenceIndex = vendor:GetSequence(),
				Items = vendor.Items,
			}
		)
	end

	file.Write("zonecontrol/"..game.GetMap().."/vendors.txt", util.TableToJSON(data))
end

hook.Add("InitPostEntity", "STALKER.LoadVendors", function()
	hook.Run("LoadVendors")
end)

hook.Add("ShutDown", "STALKER.SaveVendors", function()
	hook.Run("SaveVendors")
end)