ITEM.Name =  "PDA";
ITEM.Desc =  "A run of the mill PDA common all through-out the Zone. Its usefulness has every stalker carrying one from here to the CNPP.";
ITEM.Model =  "models/kali/miscstuff/stalker/pda.mdl";
ITEM.Weight =  0.2;
ITEM.FOV 			= 6;
ITEM.CamPos 		= Vector( 0, 0, 90 );
ITEM.LookAt 		= Vector( 0, 0, 0 );
ITEM.BulkPrice =  5000
ITEM.W = 1
ITEM.H = 1
-- explanation of PrivateVars key
-- this is built into the metaobject of items. the key PrivateVars is not transmitted normally
-- this is for data that needs to stay on the server and shouldnt be exposed to the client owner
ITEM.Vars = {
	Primary = false,
	Power = true,
	Encrypted = false,
	HasPassword = false,
	Experience = 0,
	CustomIcon = "",
}
if SERVER then
	ITEM.Vars.PrivateVars = {
		Password = "",
	}
end
ITEM.functions = {}
ITEM.functions.SetName = {
	SelectionName = "Register",
	OnUse = function(item)
		if CLIENT then
			GAMEMODE:PMCreatePDANameEdit( item );
		end
		
		return true
	end,
	CanRun = function(item)
		return !item:GetVar("PDAName")
	end,
}
ITEM.functions.MakePrimary = {
	SelectionName = "Make Primary",
	OnUse = function(item)
		for k,v in next, item:Owner().Inventory do
			if v:GetClass() == "pda" then
				v:SetVar("Primary", false)
			end
		end
	
		item:SetVar("Primary", true)
		
		return true
	end,
	CanRun = function(item)
		return !item:GetVar("Primary", false)
	end,
}
ITEM.functions.PowerOn = {
	SelectionName = "Turn On",
	OnUse = function(item)
		item:SetVar("Power", true)
		
		return true
	end,
	CanRun = function(item)
		return !item:GetVar("Power", false)
	end,
}
ITEM.functions.PowerOff = {
	SelectionName = "Turn Off",
	OnUse = function(item)
		item:SetVar("Power", false)
		
		return true
	end,
	CanRun = function(item)
		return item:GetVar("Power", false)
	end,
}
ITEM.functions.View = {
	SelectionName = "View",
	OnUse = function(item)
		if CLIENT then
			GAMEMODE.PDAMenu = vgui.Create("zc_pda")
			GAMEMODE.PDAMenu.pda_id = item:GetID()
			if item:GetVar("HasPassword", false) and !kingston.pda.has_authenticated[item:GetID()] then
				GAMEMODE.PDAMenu:CreatePasswordEntry()
			else
				GAMEMODE.PDAMenu:CreateTabs()
			end
			if GAMEMODE.Inventory and IsValid(GAMEMODE.Inventory) then
				GAMEMODE.Inventory:Close()
			end
		end
		
		return true
	end,
	CanRun = function(item)
		return item:GetVar("Power", false)
	end,
}
ITEM.functions.SetPassword = {
	SelectionName = "Set Password",
	OnUse = function(item)
		if CLIENT then
			GAMEMODE:PMCreatePDAPassword(item)
		end
		
		return true
	end,
	CanRun = function(item)
		return item:GetVar("Encrypted", false) and !item:GetVar("HasPassword", false)
	end,
}
ITEM.functions.Encrypt = {
	SelectionName = "Encrypt",
	OnUse = function(item)
		if CLIENT then
			GAMEMODE:CreateTimedProgressBar(20, "Encrypting PDA...", LocalPlayer(), function()
				netstream.Start("PDAEncrypt", item:GetID())
			end)
		end
			
		item:Owner().StartPDAEncrypt = CurTime()
		
		return true
	end,
	CanRun = function(item)
		return (
			!item:GetVar("Encrypted", false) and 
			!item:GetVar("HasPassword", false) and 
			item:Owner():IsPDATech() and
			item:Owner():HasItem("pda_encryption")
		)
	end,
}
ITEM.functions.Decrypt = {
	SelectionName = "Decrypt",
	OnUse = function(item)
			if CLIENT then
				GAMEMODE:CreateTimedProgressBar(200, "Decrypting PDA...", LocalPlayer(), function()
					netstream.Start("PDADecrypt", item:GetID())
				end)
			end
			
			item:Owner().StartPDADecrypt = CurTime()
		
		return true
	end,
	CanRun = function(item)
		return (
			item:GetVar("Encrypted", false) and 
			item:GetVar("HasPassword", false) and 
			item:Owner():IsPDATech() and
			item:Owner():HasItem("pda_decryption")
		)
	end,
}
ITEM.functions.RecoverJournal = {
	SelectionName = "Recover",
	OnUse = function(item)
		if CLIENT then
			GAMEMODE:CreateTimedProgressBar(120, "Recovering Journals...", LocalPlayer(), function()
				netstream.Start("PDARecoverJournals", item:GetID())
			end)
		end
		
		item:Owner().StartPDARecover = CurTime()
		
		return true
	end,
	CanRun = function(item)
		return (
			!item:GetVar("Encrypted", false) and 
			!item:GetVar("HasPassword", false) and 
			item:Owner():IsPDATech() and
			item:Owner():HasItem("pda_recover")
		)
	end,
}
function ITEM:GetName()
	local name = self:GetVar("PDAName", "")
	if #name > 0 then
		return name.."'s PDA"
	end
	
	return self.Name
end

function ITEM:OnDeleted()
	local function onSuccess()
	end
	mysqloo.Query( Format( "DELETE FROM cc_pda_journal WHERE Owner = '%d'", self:GetID() ), onSuccess );
end

local PDARanks = {
	{name = "Novice", xp = 2000},
	{name = "Experienced", xp = 10000},
	{name = "Veteran", xp = 20000},
	{name = "Expert", xp = 50000},
	{name = "Master", xp = 130000},
	{name = "Legend", xp = 300000},
}

function ITEM:GetPDARank(forXP)
	local rank = "Rookie"
	for _,rankData in pairs(PDARanks) do
		if (forXP or self:GetVar("Experience", 0)) >= rankData.xp then
			rank = rankData.name
		end
	end

	return rank
end

function ITEM:GiveExperience(amt)
	self:SetVar("Experience", math.Clamp(self:GetVar("Experience", 0) + amt, 0, 300000), nil, true)

	hook.Run("PDAExperienceChanged", self, amt)
end

function ITEM:TakeExperience(amt)
	self:SetVar("Experience", math.Clamp(self:GetVar("Experience", 0) - amt, 0, 300000), nil, true)

	hook.Run("PDAExperienceChanged", self, -amt)
end

/* UI */
function GM:PMCreatePDAPassword(item)
	Derma_StringRequest(
		"Set Password", 
		"Set this PDA's password. (WARNING: THIS IS STORED IN PLAINTEXT. DO NOT USE A REAL PASSWORD!)",
		"",
		function(text)
			netstream.Start("PDASetPassword", item:GetID(), text)
		end
	)
end

function ITEM:QuickUse()
	self:CallFunction("View")
	
	return true
end
function ITEM:CanQuickUse()
	return self:GetVar("Power", false)
end
ITEM.Rarity = 2

if SERVER then
	local function GiveXPForArtifactReveal(ply, ent, itemClass)
		local metaitem = GAMEMODE:GetItemByID(itemClass)
		if !metaitem or !metaitem.Artifact then return end

		local pda = ply:GetPrimaryPDA()
		if !pda then return end

		pda:GiveExperience(metaitem.Tier * 250)
	end
	hook.Add("PlayerArtifactRevealed", "GiveXPForArtifactReveal", GiveXPForArtifactReveal)

	local function NotifyExperience(item, amt)
		local oldAmount = item:GetVar("Experience", 0) - amt
		local ply = item:Owner()

		local curRank = item:GetPDARank()
		local lastRank = item:GetPDARank(oldAmount)

		print(curRank, lastRank)

		if amt > 0 then
			if curRank != lastRank then
				ply:PDANotify("Message", Format("You've advanced to the rank of \"%s\"", curRank), 4, 1)
			end
		else
			if curRank != lastRank then
				ply:PDANotify("Message", Format("You've dropped to the rank of \"%s\"", curRank), 4, 1)
			end
		end
	end
	hook.Add("PDAExperienceChanged", "NotifyExperience", NotifyExperience)
end