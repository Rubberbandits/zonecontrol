AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( "shared.lua" )

function ENT:Initialize()
	if (SERVER) then
		self:SetModel( self.NPC_INFORMATION.model )
		self:SetUseType(SIMPLE_USE)
		self:SetMoveType(MOVETYPE_NONE)
		self:DrawShadow(true)
		self:SetSolid(SOLID_BBOX)
		self:PhysicsInit(SOLID_BBOX)
		--self:DropToFloorent()
	end
	
	timer.Simple(1, function()
		if (IsValid(self)) then
			self:setAnim()
		end
	end)
	
	local physObj = self:GetPhysicsObject()
	
	if (IsValid(physObj)) then
		physObj:EnableMotion(false)
		physObj:Sleep()
	end
end

function ENT:setAnim()
	for k, v in ipairs(self:GetSequenceList()) do
		if (v:lower():find("idle") and v ~= "idlenoise") then
			return self:ResetSequence(k)
		end
	end

	self:ResetSequence(4)
end

util.AddNetworkString("ui_help_npc")
util.AddNetworkString("zcBogdan_TurnIn")

function ENT:OnTakeDamage()
	return false
end 

function ENT:AcceptInput( Name, Activator, Caller )    
	if Name == "Use" and Caller:IsPlayer() then
		net.Start("ui_help_npc")
			net.WriteEntity(self)
		net.Send(Caller)
	end
end

local function zcBogdan_TurnIn(len, ply)
	local npc = net.ReadEntity()
	if !npc or npc:GetClass() != "xp_npc" or npc:GetPos():Distance(ply:GetPos()) > 250 then return end

	local itemId = net.ReadUInt(32)
	if !itemId then return end

	local item = ply.Inventory[itemId]
	if !item then return end
	if !item.Experience then return end

	local pda = ply:GetPrimaryPDA()
	if !pda then return end

	pda:GiveExperience(item.Experience)
	item:RemoveItem(true)
end
net.Receive("zcBogdan_TurnIn", zcBogdan_TurnIn)