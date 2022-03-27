include( "shared.lua" )

ENT.NPC_INFORMATION = {
	name = "Redrick",
	profession = "Stubborn Bastard",
	model = "models/tnb/stalker_2019/psz.mdl",
}

ENT.NPC_CONVERSATION = {
	opening = {
		response = "What can I do for you, stalker?",
		options = {
			"exit",
		},
	},
	exit = {
		dialog = "See you around.",
		callback = function(panel, key)
			panel:Close()
		end,
	},
}

net.Receive("ui_help_npc", function(len)
	local npc = net.ReadEntity()
	local dialog = vgui.Create("zcNPCDialog")
	dialog:AddDialogOptions(npc.NPC_CONVERSATION)
	dialog.NPCEntity = npc
end)