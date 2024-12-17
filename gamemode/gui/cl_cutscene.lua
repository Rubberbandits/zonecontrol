local PANEL = {}

function PANEL:Init()
	self.Dialog = {}
	self.ActiveSounds = {}
end

function PANEL:AddDialog(sound_name, text)
	table.insert(self.Dialog, {sound = sound_name, subtitle = text})
end

function PANEL:SetBackgroundSound(sound_name)
	self.background_sound = sound_name
end

function PANEL:SetAutoAdvance(auto_advance)
	self.auto_advance = auto_advance
end

function PANEL:StartCutscene()
	if self.background_sound then
		local sound_data = sound.GetProperties(self.background_sound)
		sound.PlayFile("sound/" .. sound_data.sound, "noblock", function(chan, err)
			if not chan then error(err) end
			chan:EnableLooping(true)

			table.insert(self.ActiveSounds, chan)
		end)
	end

	self.last_sound_start = 0
	self.last_sound_len = 0
	self.running = true
	self.stage = 1

	local last_stage = 0
	local total_stages = #self.Dialog
	hook.Add("Think", "RunCutscene", function()
		if self.loading_sound then return end
		if self.last_sound_start + self.last_sound_len > CurTime() then return elseif last_stage == total_stages then
			hook.Remove("Think", "RunCutscene")

			self.running = false
			self.last_sound_start = 0
			self.last_sound_len = 0
			self.stage = 0

			self:OnCutsceneFinished()
			return
		end
		if last_stage == self.stage then return end

		self:OnStageChanged(self.stage, total_stages == self.stage)

		local current_dialog = self.Dialog[self.stage]
		local sound_data = sound.GetProperties(current_dialog.sound)
		sound.PlayFile("sound/" .. sound_data.sound, "", function(chan)
			if not chan then return end

			self.last_sound_start = CurTime()
			self.last_sound_len = chan:GetLength()
			self.loading_sound = false
			self.current_subtitle = current_dialog.subtitle
		end)
		self.loading_sound = true

		last_stage = self.stage

		if not self.auto_advance then return end
		if last_stage == total_stages then return end

		self.stage = self.stage + 1
	end)
end

function PANEL:AdvanceCutscene()
	self.stage = math.Clamp(self.stage + 1, self.stage, #self.Dialog)
end

function PANEL:OnRemove()
	hook.Remove("Think", "RunCutscene")

	for _,chan in pairs(self.ActiveSounds) do
		if not IsValid(chan) then continue end
		chan:Stop()
	end
end

function PANEL:OnStageChanged(stage, last_stage)
	// This is for override
end

function PANEL:OnCutsceneFinished()
	// This is for override
end

function PANEL:Paint(w, h)
	surface.SetDrawColor(0, 0, 0, 255)
	surface.DrawRect(0, 0, w, h)

	if self.running and self.current_subtitle then
		local text = self.current_subtitle
		surface.SetTextColor(255, 255, 255, 255)
		surface.SetFont("Subtitle")

		if not self.last_subtitle or self.last_subtitle != text then
			self.anim_start = CurTime()
		end

		if self.anim_start and self.last_sound_len then
			local progress = (CurTime() - self.anim_start) / (self.last_sound_len * 0.8)
			text = string.sub(self.current_subtitle, 0, math.floor(Lerp(progress, 0, #self.current_subtitle)))
		end

		local text_w, text_h = surface.GetTextSize(self.current_subtitle)
		surface.SetTextPos(w * 0.5 - text_w * 0.5, h * 0.9 - text_h * 0.5)
		surface.DrawText(text)

		self.last_subtitle = self.current_subtitle
	end
end

vgui.Register("Cutscene", PANEL, "EditablePanel")

function zonecontrol.TestCutscene()
	local end_cutscene = vgui.Create("Cutscene")
	end_cutscene:Dock(FILL)
	end_cutscene:DockPadding(ScrW() * 0.33, ScrH() * 0.2, ScrW() * 0.33, ScrH() * 0.2)
	end_cutscene:SetBackgroundSound("wish_granter_amb")
		end_cutscene:AddDialog("wish_granter_1", "Who are you?")
		end_cutscene:AddDialog("wish_granter_2", "I see your soul, describe yourself.")
		end_cutscene:AddDialog("wish_granter_3", "The center awaits.")
		end_cutscene:AddDialog("wish_granter_4", "The lost are found here, in the Zone. Perhaps you'll find what you're looking for.")
		end_cutscene:AddDialog("wish_granter_5", "Come to me.")
		end_cutscene:AddDialog("wish_granter_6", "Your eyes are open, yet you see nothing.")
	end_cutscene:SetAutoAdvance(true)
	end_cutscene.OnStageChanged = function(self, stage, last_stage)
		for _,child in pairs(self:GetChildren()) do
			child:Remove()
		end
	end
	end_cutscene.OnCutsceneFinished = function(self)
		self:Remove()
	end
	end_cutscene:MakePopup()

	end_cutscene:StartCutscene()
end