kingston = kingston or {}
kingston.pda = kingston.pda or {}

/* Networking */

local function PDAGrabChat(data)
	if GAMEMODE.PDAMenu then
		GAMEMODE.PDAMenu:PopulateMessages(data)
	end
end
netstream.Hook("PDAGrabChat", PDAGrabChat)

local function PDAGrabJournal(data)
	if GAMEMODE.PDAMenu then
		GAMEMODE.PDAMenu:PopulateJournal(data)
	end
end
netstream.Hook("PDAGrabJournal", PDAGrabJournal)

local function PDAGrabContacts(data)
	if GAMEMODE.PDAMenu then
		GAMEMODE.PDAMenu:PopulateContacts(data)
	end
end
netstream.Hook("PDAGrabContacts", PDAGrabContacts)