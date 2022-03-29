surface.CreateFont("Dialog_Name", {
	font = "Arial", 
	extended = false,
	size = ScreenScale(10),
	weight = 800,
	antialias = true,
})

surface.CreateFont("Dialog_Font", {
	font = "Arial", 
	extended = false,
	size = ScreenScale(8),
	weight = 500,
	antialias = true,
})

local DEV_CONVERSATION = {
	opening = {
		response = "Hey there, how can I help you?",
		options = {
			"ask_help",
			"seen_anything",
			"got_money",
			"exit",
		}
	},
	ask_help = {
		dialog = "Hey man, do you know where I can find some help?",
		response = "Sounds like you mean the mental kind of help.",
	},
	seen_anything = {
		dialog = "Heard anything recently?",
		response = "I heard that sometimes the payphones around here will ring, and when you pick it up, a voice tells you how many days you have left to live. Spooky, right?",
		options = {
			"skeptical_response",
		}
	},
	skeptical_response = {
		dialog = "Yeah, sure, whatever you say.",
		response = "Hey man, I swear it's true! My friend said his friend heard it himself.",
	},
	got_money = {
		dialog = function(panel, key)
			return Format("I have %s%d.", "$", LocalPlayer():Money())
		end,
		response = function(panel, key)
			return Format("Good for you, %s", LocalPlayer():RPName())
		end,
		can_see = function(panel, key)
			return LocalPlayer():Money() > 0
		end,
	},
	exit = {
		dialog = "Bye.",
		callback = function(panel, key)
			panel:Close()
		end,
	},
}

local PANEL = {}

function PANEL:Init()
	self:SetSize(ScrW() * .4, ScrH())
	self:Center()
	self:MakePopup()
	self:SetSkin("STALKER")
	self.NPCName = "None"

	self.dialog = self:Add("DScrollPanel")
	self.dialog:DockMargin(ScreenScaleH(8), ScreenScaleH(24), ScreenScaleH(8), 0)
	self.dialog:Dock(TOP)
	self.dialog:SetTall(self:GetTall() * .62)
	function self.dialog:Paint(w, h) end

	self.dialogOptions = self:Add("DScrollPanel")
	self.dialogOptions:Dock(TOP)
	self.dialogOptions:DockMargin(ScreenScaleH(20), ScreenScaleH(24), ScreenScaleH(20), 0)
	self.dialogOptions:SetTall(self:GetTall() * .24)
	function self.dialogOptions:Paint(w, h) end

	//self:InitiateDevDialog()
end

function PANEL:SetName(name)
	self.NPCName = name;
end

function PANEL:Close()
	self:Remove()
end

function PANEL:Paint(w, h)
	kingston.gui.FindFunc(self, "Paint", "DialogMenu", w, h)
end

function PANEL:InitiateDevDialog()
	self:AddDialogOptions(DEV_CONVERSATION)
end

local function defaultDialogCallback(panel, key, noResponse)
	panel:ClearDialogOptions()

	local dialogData = panel.conversations[key]
	local options = dialogData.options or panel.conversations.opening.options
	
	if isfunction(options) then
		options = options(panel, key)
	end

	for i,dialogKey in ipairs(options) do
		local dialogData = panel.conversations[dialogKey]

		if dialogData.can_see and !dialogData.can_see(panel, dialogKey) then
			continue 
		end

		panel:AddDialogOption(Format("%d. %s", i, (isfunction(dialogData.dialog) and dialogData.dialog(self, dialog)) or dialogData.dialog), dialogKey, dialogData.callback)
	end

	panel:AddDialog(LocalPlayer():RPName(), (isfunction(dialogData.dialog) and dialogData.dialog(panel, dialogKey)) or dialogData.dialog, true)

	if !noResponse then
		panel:AddDialog(panel.NPCName, (isfunction(dialogData.response) and dialogData.response(panel, key)) or dialogData.response or "")
	end
end

function PANEL:BackToOpening()
	if !self.conversations then return end

	defaultDialogCallback(self, "opening", true)
end

function PANEL:AddDialogOptions(data)
	self.conversations = data
	local openingDialog = data.opening
	if !openingDialog then
		error("Invalid data passed to function, conversation must have an opening!\n")
	end
	
	local options = openingDialog.options

	if options then
		if isfunction(options) then
			options = options(self, "opening")
		end

		for i,dialog in ipairs(options) do
			local dialogData = data[dialog]
			if !dialogData then
				error("Specified dialog doesn't exist!\n")
			end

			if dialogData.can_see and !dialogData.can_see(self, dialog) then
				continue 
			end

			self:AddDialogOption(Format("%d. %s", i, (isfunction(dialogData.dialog) and dialogData.dialog(self, dialog)) or dialogData.dialog), dialog, dialogData.callback)
		end
	end

	self:AddDialog(self.NPCName, (isfunction(openingDialog.response) and openingDialog.response(self, "opening")) or openingDialog.response or "")
end

local NPC_NAME_COLOR = Color(229, 159, 26)
local NPC_TEXT_COLOR = Color(209, 188, 161)
local PLAYER_NAME_COLOR = Color(139, 177, 122)
local PLAYER_TEXT_COLOR = Color(230, 230, 230)

function PANEL:AddDialog(name, text, isPlayer)
	local dialogLine = self.dialog:Add("DSizeToContents")
	dialogLine:Dock(TOP)
	dialogLine:DockPadding(20, 20, 20, 0)
	dialogLine:DockMargin(0, 2, 0, 0)
	function dialogLine:Paint(w, h) end

	local nameText = dialogLine:Add("DLabel")
	nameText:Dock(TOP)
	nameText:DockMargin(4, 0, 0, 0)
	nameText:SetContentAlignment(4)
	nameText:SetColor(isPlayer and PLAYER_NAME_COLOR or NPC_NAME_COLOR)
	nameText:SetFont("Dialog_Name")
	nameText:SetText(name)

	local content = dialogLine:Add("DLabel")
	content:Dock(TOP)
	content:DockMargin(32, 0, 0, 0)
	content:SetContentAlignment(4)
	content:SetColor(isPlayer and PLAYER_TEXT_COLOR or NPC_TEXT_COLOR)
	content:SetFont("Dialog_Font")
	content:SetText(text)
	content:SetWrap(true)

	function dialogLine:PerformLayout(w,h)
		content:SizeToContentsY()
		self:SizeToChildren(false, true)
	end
	
	dialogLine:InvalidateLayout(true)
end

-- if ur not gonna have a custom callback u really need a key
function PANEL:AddDialogOption(text, key, callback)
	callback = callback or defaultDialogCallback

	local choice = self.dialogOptions:Add("DButton")
	choice:DockMargin(8, 1, 1, 0)
	choice:Dock(TOP)
	choice:SetText(text)
	choice:SetFont("Dialog_Font")
	choice:SetContentAlignment(4)
	choice.DoClick = function(btn)
		callback(self, key)
	end
	choice.Paint = function(pnl, w, h)

	end

	self:InvalidateLayout(true)
end

function PANEL:ClearDialogOptions()
	self.dialogOptions:Clear()
end

vgui.Register("zcNPCDialog", PANEL, "DPanel")