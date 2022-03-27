AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( "shared.lua" )

function ENT:Initialize()
	if (SERVER) then
		self:SetModel( "models/tnb/stalker_2019/psz.mdl" )
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

if (SERVER) then

	util.AddNetworkString("ui_help_npc")

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
end