include( "shared.lua" )

/*
First greeting:

Big-brother: Well, hello! I don't think we've met. I'm Bogdan, though most everyone just calls me Big-brother.

1. I'm [player name]. What kind of nickname is that?

		Big-brother: I work with Sidorovich and Barkeep on the STALKERNet project. My job is to keep track of stalkers' reputations - specifically their skill levels.
		1. Interesting. Why bother?
		2. That's kind of creepy. What if I don't consent to you sharing my data?
		
		Big-brother: The Zone is teeming with work - and most of it's pretty dangerous. Some jobs take a certain caliber of stalker, and employers wanna know you're worth a damn before they send you off to do their bidding. Our data tracking helps employers screen their candidates, and they pay us quite a bit for that. (if option 2 is selected:) That means if you wanna use STALKERNet, you better just learn to deal with it. If not, well, just toss your PDA in a ditch.
		1. How does it all work?
			
			Big-brother: Word gets around here. When you do good work for somebody, we hear about it. And if you wanna boost your score, you can bring me direct proof of your work... trophies, classified documents, anything that proves you did something.
				1. OK - let's get to business.
				2. I don't have anything right now. See you later.
		
		
2. OK - let's get to business.
3. Don't care. Bye.

OK - let's get to business. -> 
	Big-brother: Sure thing. What have you brought me?
	
		1. I have something to turn in.
			(Open a dialog box where the player can select all applicable items to turn in - rather than a catch-all option that could accidentally give him items the player wants to keep.)
		2. Nothing right now. See you later.
*/

ENT.NPC_CONVERSATION = {
	opening = { // this opening is the dialogue shown when you first interact with the NPC
		response = function(panel, key)
			if cookie.GetNumber(Format("zcBogdan_spokenTo%d", LocalPlayer():CharID()), 0) == 0 then
				cookie.Set(Format("zcBogdan_spokenTo%d", LocalPlayer():CharID()), "1")

				return "Well, hello! I don't think we've met. I'm Bogdan, though most everyone just calls me Big-brother."
			else
				return Format("Welcome back, %s. What have you brought me?", cookie.GetNumber(Format("zcBogdan_introduced%d", LocalPlayer():CharID()), 0) == 1 and LocalPlayer():RPName() or "stalker")
			end
		end,
		options = function(panel, key)
			if cookie.GetNumber(Format("zcBogdan_spokenTo%d", LocalPlayer():CharID()), 0) == 0 then
				return {
					"introduce_yourself",
					"business",
					"dont_care",
				}
			else
				return {
					"turn_in",
					"nothing_now"
				}
			end
		end,
	},
	introduce_yourself = {
		dialog = function(panel, key)
			return Format("I'm %s. What kind of nickname is that?", LocalPlayer():RPName())
		end,
		response = function()
			cookie.Set(Format("zcBogdan_introduced%d", LocalPlayer():CharID()), "1")
			return "I work with Sidorovich and Barkeep on the STALKERNet project. My job is to keep track of stalkers' reputations - specifically their skill levels."
		end,
		options = {
			"why_bother",
			"creepy"
		}
	},
	why_bother = {
		dialog = "Interesting. Why bother?",
		response = "The Zone is teeming with work - and most of it's pretty dangerous. Some jobs take a certain caliber of stalker, and employers wanna know you're worth a damn before they send you off to do their bidding. Our data tracking helps employers screen their candidates, and they pay us quite a bit for that.",
		options = {
			"how_works"
		}
	},
	creepy = {
		dialog = "That's kind of creepy. What if I don't consent to you sharing my data?",
		response = "The Zone is teeming with work - and most of it's pretty dangerous. Some jobs take a certain caliber of stalker, and employers wanna know you're worth a damn before they send you off to do their bidding. Our data tracking helps employers screen their candidates, and they pay us quite a bit for that. That means if you wanna use STALKERNet, you better just learn to deal with it. If not, well, just toss your PDA in a ditch.",
		options = {
			"how_works"
		}
	},
	how_works = {
		dialog = "How does it all work?",
		response = "Word gets around here. When you do good work for somebody, we hear about it. And if you wanna boost your score, you can bring me direct proof of your work... trophies, classified documents, anything that proves you did something.",
		options = {
			"business",
			"cool"
		}
	},
	business = {
		dialog = "OK - let's get to business.",
		response = "Sure thing. What have you brought me?",
		options = {
			"turn_in",
			"nothing_now"
		}
	},
	turn_in = {
		dialog = "I have something to turn in.",
		callback = function(panel, key)
			// open dialog to turn in items
			print("open dialog to turn in items")
		end
	},
	nothing_now = {
		dialog = "Nothing right now. See you later.",
		callback = function(panel, key)
			panel:Close()
		end,
	},
	dont_care = {
		can_see = function(panel, key)
			return cookie.GetNumber(Format("zcBogdan_spokenTo%d", LocalPlayer():CharID()), 0) == 0
		end,
		dialog = "Don't care. Bye.",
		callback = function(panel, key)
			panel:Close()
		end
	},
	cool = {
		dialog = "Cool. I'll come back later.",
		callback = function(panel, key)
			panel:Close()
		end,
	},
}

net.Receive("ui_help_npc", function(len)
	local npc = net.ReadEntity()
	local dialog = vgui.Create("zcNPCDialog")
	dialog:SetName(npc.NPC_INFORMATION.name)
	dialog:AddDialogOptions(npc.NPC_CONVERSATION)
	dialog.NPCEntity = npc
end)