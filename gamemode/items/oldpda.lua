ITEM.Name =  "Broken PDA"
ITEM.Desc =  "An abused Multimedia PDA with a cracked screen. If the SIM card inside is in-tact, the thing very well may contain some lucrative information. Someone out there's probably got the tools to crack into it if that's the case."
ITEM.Model =  "models/kali/miscstuff/stalker/pda.mdl"
ITEM.Weight =  1
ITEM.FOV =  10
ITEM.CamPos =  Vector( 50, 50, 50 )
ITEM.LookAt =  Vector( 0, 0, 0 )
ITEM.BulkPrice =  1000
ITEM.W = 1
ITEM.H = 1
ITEM.Rarity = 1
ITEM.AllowRandomSpawn = true
ITEM.IsSellable = true
ITEM.functions = {}
ITEM.functions.unpack = {
		SelectionName = "dismantle",
		RemoveOnUse = true,
		CanRun = function(item)
			return true
		end,
		OnUse = function(item)
			if CLIENT then
				LocalPlayer():Notify(nil, COLOR_NOTIF, "It costs more to fix these things than they're worth, so rather than putting all that effort in, you smash the PDA on the ground with great force and cause the casing to crack open. It reveals all its delicious insides. These can be put to better use.")
			else
				item:Owner():GiveItem("scrapelectronics")
				item:Owner():GiveItem("scrapelectronics")
				item:Owner():GiveItem("scrapmetal")
			end
	
			return true
		end,
	}