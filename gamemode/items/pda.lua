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
	[2000] = "Novice",
	[10000] = "Experienced",
	[20000] = "Veteran",
	[50000] = "Expert",
	[130000] = "Master",
	[300000] = "Legend",
}

function ITEM:GetPDARank()
	local rank = "Rookie"
	for xp,name in pairs(PDARanks) do
		if self:GetVar("Experience", 0) >= xp then
			rank = name
		end
	end

	return rank
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

