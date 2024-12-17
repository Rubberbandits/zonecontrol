zonecontrol = zonecontrol or {}

local PANEL = {}

sound.Add({
	name = "main_menu_music",
	channel = CHAN_STATIC,
	volume = 0.75,
	level = 66,
	pitch = {100, 100},
	sound = "zonecontrol/menu/menu_music.ogg"
})

function PANEL:Init()
	self.background = self:Add("DHTML")
	self.background:SetSize(self:GetSize())
	self.background:OpenURL("http://45.45.237.200/")
	self.background:SetAllowLua(true)

	local sound_data = sound.GetProperties("main_menu_music")
	self.music = sound.PlayFile("sound/" .. sound_data.sound, "noblock", function(chan)
		if not IsValid(chan) then return end
		chan:EnableLooping(true)

		self.music_chan = chan
	end)

	local div = self:Add("DPanel")
	div:Dock(LEFT)
	div:SetSize(ScrW() * 0.2, ScrH() * 0.8)

	local icon = div:Add("DImage")
	icon:Dock(TOP)
	icon:SetImage("gm_construct/flatsign")
	icon:SetHeight(ScrH() * 0.2)

	local selection = div:Add("MenuSelection")
	selection:Dock(TOP)
	selection:SetSize(ScrW() * 0.2, ScrH() * 0.6)

	selection:AddSelection("NEW", function()
		local creation = vgui.Create("CharacterCreation")
		creation:SetSkin("Menu")
		creation:Dock(FILL)
		creation:DockPadding(ScrW() * 0.33, ScrH() * 0.1, ScrW() * 0.33, ScrH() * 0.1)
		creation:MakePopup()

		self:Remove()
	end)
	selection:AddSelection("LOAD", function()
		local char_select = vgui.Create("CharacterSelection")
		char_select:SetSkin("Menu")
		char_select:Dock(FILL)
		char_select:DockPadding(ScrW() * 0.33, ScrH() * 0.1, ScrW() * 0.33, ScrH() * 0.1)
		char_select:MakePopup()

		self:Remove()
	end)
	selection:AddSelection("SETTINGS", function() self:Remove() end)
	selection:AddSelection("QUIT", function() self:Remove() end)
end

function PANEL:PerformLayout()
	local width, height = self:GetSize()
	self:DockPadding(width * 0.1, height * 0.1, width * 0.1, height * 0.1)

	self.background:SetSize(self:GetSize())
end

function PANEL:Paint()
	surface.SetDrawColor(0,0,0,255)
		surface.DrawRect(0,0, self:GetSize())

		surface.SetTextColor(255, 255, 255, 80)
		surface.SetTextPos(ScrW() / 2, ScrH() / 2)
		surface.SetFont("MainMenuSelection")
		surface.DrawText("Loading...")
end

function PANEL:OnRemove()
	if not IsValid(self.music_chan) then return end
	self.music_chan:Stop()
end

vgui.Register("MainMenu", PANEL, "DPanel")

hook.Add("InitPostEntity", "CreateMainMenu", function()
	zonecontrol.CreateMainMenu()
end)

function zonecontrol.CreateMainMenu()
	local main_menu = vgui.Create("MainMenu", GetHUDPanel())
	main_menu:SetSkin("Menu")
	main_menu:Dock(FILL)
	main_menu:MakePopup()
end