ITEM.Name =  "PDA";
ITEM.Desc =  "A run of the mill PDA common all through-out the Zone. Its usefulness has every stalker carrying one from here to the CNPP.";
ITEM.Model =  "models/kali/miscstuff/stalker/pda.mdl";
ITEM.Weight =  1;
ITEM.FOV =  12;
ITEM.CamPos =  Vector( 50, 50, 50 );
ITEM.LookAt =  Vector( 0, 0, 0 );
ITEM.BulkPrice =  20000;
-- explanation of PrivateVars key
-- this is built into the metaobject of items. the key PrivateVars is not transmitted normally
-- this is for data that needs to stay on the server and shouldnt be exposed to the client owner
ITEM.Vars = {
	Primary = false,
	Power = true,
	Encrypted = false,
	HasPassword = false,
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
		return !item:GetVar("Name")
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
			GAMEMODE.PDAMenu:CreateTabs()
			CCP.PlayerMenu:Close()
		end
		
		return true
	end,
	CanRun = function(item)
		return item:GetVar("Power", false)
	end,
}
/*
ITEM.functions.SetPassword = {
	SelectionName = "Set Password",
	OnUse = function(item)
		if CLIENT then
		
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
		
		end
		
		return true
	end,
	CanRun = function(item)
		return (
			!item:GetVar("Encrypted", false) and 
			!item:GetVar("HasPassword", false) and 
			item:Owner():HasCharFlag("T") and
			item:Owner():HasItem("pda_encryption")
		)
	end,
}
ITEM.functions.Decrypt = {
	SelectionName = "Decrypt",
	OnUse = function(item)
		if CLIENT then
		
		end
		
		return true
	end,
	CanRun = function(item)
		return (
			item:GetVar("Encrypted", false) and 
			item:GetVar("HasPassword", false) and 
			item:Owner():HasCharFlag("T") and
			item:Owner():HasItem("pda_decryption")
		)
	end,
}
*/
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
			item:Owner():HasCharFlag("T") and
			item:Owner():HasItem("pda_recover")
		)
	end,
}
function ITEM:GetName()
	local name = self:GetVar("Name", "")
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