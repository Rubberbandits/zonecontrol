sound.Add({
	name = "wish_granter_amb",
	channel = CHAN_STATIC,
	volume = 0.75,
	level = 66,
	pitch = {100, 100},
	sound = "zonecontrol/wish_granter/wish_granter_amb.ogg"
})
sound.Add({
	name = "wish_granter_1",
	channel = CHAN_VOICE,
	volume = 1.0,
	level = 75,
	pitch = {100, 100},
	sound = "zonecontrol/wish_granter/wish_granter_2-01.ogg"
})
sound.Add({
	name = "wish_granter_2",
	channel = CHAN_VOICE,
	volume = 1.0,
	level = 75,
	pitch = {100, 100},
	sound = "zonecontrol/wish_granter/wish_granter_2-02.ogg"
})
sound.Add({
	name = "wish_granter_3",
	channel = CHAN_VOICE,
	volume = 1.0,
	level = 75,
	pitch = {100, 100},
	sound = "zonecontrol/wish_granter/wish_granter_2-03.ogg"
})
sound.Add({
	name = "wish_granter_4",
	channel = CHAN_VOICE,
	volume = 1.0,
	level = 75,
	pitch = {100, 100},
	sound = "zonecontrol/wish_granter/wish_granter_2-04.ogg"
})
sound.Add({
	name = "wish_granter_5",
	channel = CHAN_VOICE,
	volume = 1.0,
	level = 75,
	pitch = {100, 100},
	sound = "zonecontrol/wish_granter/wish_granter_2-05.ogg"
})
sound.Add({
	name = "wish_granter_6",
	channel = CHAN_VOICE,
	volume = 1.0,
	level = 75,
	pitch = {100, 100},
	sound = "zonecontrol/wish_granter/wish_granter_2-06.ogg"
})

local STAGE_ELEMENTS = {
	function(panel)
		local entry = panel:Add("DTextEntry")
		entry:SetFont("MainMenuSelection")
		entry:SetTall(40)
		entry:Dock(BOTTOM)
		entry:RequestFocus()
		entry.OnEnter = function(self)
			panel.character_name = self:GetValue()
			panel:AdvanceCutscene()
		end
	end,
	function(panel)
		local advance = panel:Add("DButton")
		advance:SetFont("MainMenuSelection")
		advance:SetText("CONTINUE")
		advance:SetTall(40)
		advance:Dock(BOTTOM)
		advance.DoClick = function(self)
			panel:AdvanceCutscene()
			panel:SetAutoAdvance(true)
		end

		local entry = panel:Add("DTextEntry")
		entry:SetMultiline(true)
		entry:SetTall(256)
		entry:SetUpdateOnType(true)
		entry:Dock(BOTTOM)
		entry:RequestFocus()
		entry.OnChange = function(self)
			panel.character_desc = self:GetValue()
		end
	end
}

function zonecontrol.FinishCreation()
	local end_cutscene = vgui.Create("Cutscene")
	end_cutscene:Dock(FILL)
	end_cutscene:SetSkin("Menu")
	end_cutscene:DockPadding(ScrW() * 0.33, ScrH() * 0.2, ScrW() * 0.33, ScrH() * 0.2)
	end_cutscene:SetBackgroundSound("wish_granter_amb")
		end_cutscene:AddDialog("wish_granter_1", "Who are you?")
		end_cutscene:AddDialog("wish_granter_2", "Picture yourself, stalker. What do you see?")
		end_cutscene:AddDialog("wish_granter_3", "The center awaits.")
		end_cutscene:AddDialog("wish_granter_4", "The lost are found here, in the Zone. Perhaps you'll find what you're looking for.")
		end_cutscene:AddDialog("wish_granter_5", "Come to me.")
		end_cutscene:AddDialog("wish_granter_6", "Your eyes are open, yet you see nothing.")
	end_cutscene:SetAutoAdvance(false)
	end_cutscene.OnStageChanged = function(self, stage, last_stage)
		for _,child in pairs(self:GetChildren()) do
			child:Remove()
		end

		if STAGE_ELEMENTS[stage] then
			STAGE_ELEMENTS[stage](self)
		end
	end
	end_cutscene.OnCutsceneFinished = function(self)
		local character_name = self.character_name
		local character_desc = self.character_desc
		local model = zonecontrol.creation.models.player:GetModel()
		local skin = zonecontrol.creation.models.player:GetSkin()

		local items = zonecontrol.creation.items

		net.Start("CharacterCreate")
			net.WriteString(character_name)
			net.WriteString(character_desc)
			net.WriteString(model)
			net.WriteUInt(skin, 8)

			net.WriteUInt(#items, 8)
			for _,ent in pairs(items) do
				net.WriteString(ent.class)
				net.WriteUInt(ent.count, 8)
			end
		net.SendToServer()

		self:Remove()
		zonecontrol.DestroyCreationScene()
	end
	end_cutscene:MakePopup()

	end_cutscene:StartCutscene()
end