include( "shared.lua" )

ENT.NPC_CONVERSATION = {
    opening = { // this opening is the dialogue shown when you first interact with the NPC
        response = "What can I do for you, stalker?", // this is what the NPC says
        options = { // these are your dialogue choices
            "something_interesting", // from the opening, we can pick either something_interesting or exit
            "exit",
        },
    },
    something_interesting = { // unique identifier to tell the script what specific dialogue info to use
        dialog = "See anything interesting around here?", // this is what we are going to say to the NPC
        response = "It's the same-old-same-old here in the Cordon, a bunch of rookies shitting their pants. What else would it be?" // this is the NPCs response to what we said
        // if there is no options specified, we go back to options
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
	dialog:SetName(npc.NPC_INFORMATION.name)
	dialog:AddDialogOptions(npc.NPC_CONVERSATION)
	dialog.NPCEntity = npc
end)