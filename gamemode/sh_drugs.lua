AddCSLuaFile()

local meta = FindMetaTable("Player")

GM.DrugEffects = GM.DrugEffects or {}

function GM:CreateDrugType(class, data)
	if !class then return end

	self.DrugEffects[class] = data

	if data.Hooks then
		for hook,func in next, data.Hooks do
			hook.Add(hook, "DRUG_"..class, func)
		end
	end
end

function GM:GetDrugData(class)
	return self.DrugEffects[class]
end

function meta:HasDrug(d)
	if SERVER then
		if !self.DrugEffects then
			self:ClearDrug()
		end

		return self.DrugEffects[d]
	else
		return GAMEMODE.DrugType == d
	end
end

function meta:ApplyDrug(class)
	local data = GAMEMODE:GetDrugData(class)
	if !data then return end
	
	if data.Duration then
		timer.Create("DRUG_"..class, data.Duration, 1, function()
			self:RemoveDrug(class)
		end)
	end

	self.DrugEffects[class] = CurTime()
	hook.Run("PlayerDrugApplied", self, class)
end

function meta:RemoveDrug(class)
	self.DrugEffects[class] = nil
	hook.Run("PlayerDrugRemoved", self, class)
end