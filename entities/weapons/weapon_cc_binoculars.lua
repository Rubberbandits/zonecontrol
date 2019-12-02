AddCSLuaFile()

SWEP.Base			= "weapon_cc_base"

SWEP.PrintName 		= "Binoculars"
SWEP.Slot 			= 1
SWEP.SlotPos 		= 7

SWEP.UseHands		= false
SWEP.ViewModel 		= "models/weapons/c_arms_citizen.mdl"
SWEP.WorldModel 	= "models/gibs/shield_scanner_gib1.mdl"

SWEP.HoldType = "camera"
SWEP.HoldTypeHolster = "normal"

SWEP.Holsterable = false
SWEP.NoDrawHolstered = true

SWEP.Itemize = true
SWEP.ItemDescription = "A pair of rugged binoculars with variable zoom."
SWEP.ItemWeight = 0.5
SWEP.ItemFOV = 5
SWEP.ItemCamPos = Vector(50, 50, 50)
SWEP.ItemLookAt = Vector(0, 0, 0)

SWEP.ItemBulkAmount 	= 5
SWEP.ItemBulkPrice		= 40000
SWEP.ItemLicense		= LICENSE_BLACK

function SWEP:PreDrawViewModel(vm, wep, ply)
	vm:SetMaterial("engine/occlusionproxy") -- Hide that view model with hacky material
end

function SWEP:OnRemove()
	if self.Owner and self.Owner:IsValid() then

		local vm = self.Owner:GetViewModel()

		if vm and vm:IsValid() then

			vm:SetMaterial("")

		end

	end
end

function SWEP:TranslateFOV()
	self.BinocularZoom = self.BinocularZoom or 0
	local state = self.BinocularZoom
	if state == 0 then
		return 60
	elseif state == 1 then
		return 30
	elseif state == 2 then
		return 5 end
	return
end

function SWEP:AdjustMouseSensitivity()
	if self.BinocularZoom == 0 then
		return 0.4
	elseif self.BinocularZoom == 1 then
		return 0.2
	else
		return 0.1
	end
end

function SWEP:PrimaryAttack()
	if CLIENT then
		if not IsFirstTimePredicted() then return end

		if self.BinocularZoom == 0 then
			self.BinocularZoom = 1
		elseif self.BinocularZoom == 1 then
			self.BinocularZoom = 2
		else
			self.BinocularZoom = 0
		end
	end
end

function SWEP:DrawWorldModel()

end