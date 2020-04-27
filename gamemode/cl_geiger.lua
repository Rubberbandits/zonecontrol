kingston = kingston or {}
kingston.geiger = kingston.geiger or {}

local meta = FindMetaTable("Player")
function meta:GetExposureRate()
	local calc_amt = 0
	for k,v in next, ents.FindByClass("kingston_radiation") do
		local dist = self:GetPos():DistToSqr(v:GetPos())
		if dist < (v:GetZoneSize()*v:GetZoneSize()) then
			calc_amt = calc_amt + math.Clamp(math.Round((v:GetSourceIntensity() * v:GetSourceSize()^2) / dist, 2), 0, v:GetSourceIntensity())
		end
	end
	
	return calc_amt
end

function kingston.geiger.calculate_angle(rate)
	local base_degree = 40
	local max_degree = 70
	local multiplier = ScrW() / 72
	local current_angle = base_degree - (rate / max_degree) * multiplier

	if current_angle > base_degree then
		current_angle = base_degree
	elseif current_angle < 330 and current_angle > base_degree then
		current_angle = 330
	elseif current_angle < 0 then
		current_angle = 360 + math.Clamp(current_angle, -base_degree, 0)
	end
	
	return current_angle
end

local needle_mat = Material("kingston/geiger/needle.png", "noclamp smooth")
local background_mat = Material("kingston/geiger/background.png", "noclamp smooth")
local shield_mat = Material("kingston/geiger/shield.png", "noclamp smooth")
local dosi_mat = Material("kingston/geiger/dosimeter.png", "noclamp smooth")

function kingston.geiger.render()
	if !GAMEMODE.LastRandomMovement then
		GAMEMODE.LastRandomMovement = CurTime()
	end
	
	if !GAMEMODE.LastGeigerAngle then
		GAMEMODE.LastGeigerAngle = 40
	end

	local pos_x = (ScrW() - (ScrW() / 12)) - ((ScrW() / 6.25) / 2)
	local pos_y = ((ScrH() / 1.45)) - ((ScrH() / 3.5156) / 2)
	
	if GAMEMODE.Detector then
		pos_y = ((ScrH() / 6.5)) - ((ScrH() / 3.5156) / 2)
	end
	
	local rate = LocalPlayer():GetExposureRate()
	local last_angle = GAMEMODE.LastGeigerAngle
	local next_angle = kingston.geiger.calculate_angle(rate)
	
	if rate > 0 and CurTime() - GAMEMODE.LastRandomMovement > (18 / rate) then
		local rand = math.random(-4, 4)
		
		next_angle = next_angle + rand
		
		if rand >= -2 then
			surface.PlaySound( "kingston/detectors/geiger_"..math.random(1,8)..".ogg" )
		end
		
		GAMEMODE.LastRandomMovement = CurTime()
	end
	
	current_angle = Lerp(CurTime() * 2, current_angle, next_angle)

	surface.SetDrawColor(Color(255,255,255,255))
	
	surface.SetMaterial(background_mat)
	surface.DrawTexturedRect(pos_x, pos_y, ScrW() / 6.25, ScrH() / 3.5156)
	
	surface.SetMaterial(needle_mat)
	surface.DrawTexturedRectRotatedPoint(pos_x + ((ScrW() / 6.25) / 2), pos_y + ((ScrH() / 3.5156) / 1.4), ScrW() / 6.25, ScrH() / 3.5156, current_angle, 0, 0)
	
	surface.SetMaterial(shield_mat)
	surface.DrawTexturedRect(pos_x, pos_y, ScrW() / 6.25, ScrH() / 3.5156)
	
	GAMEMODE.LastGeigerAngle = next_angle
end

local function RenderGeigerCounter()
	if GAMEMODE.GeigerCounterEquipped then
		kingston.geiger.render()
	end
end
hook.Add("HUDPaint", "STALKER.RenderGeigerCounter", RenderGeigerCounter)

function kingston.geiger.render_dosimeter()
	surface.SetDrawColor(Color(0,0,0))
	surface.DrawRect(0,0, ScrW(), ScrH())

	surface.SetDrawColor(Color(255,255,255))
	surface.SetMaterial(dosi_mat)
	surface.DrawTexturedRect((ScrW() / 2) - ((ScrW() / 1.7) / 2),0, ScrW() / 1.7, ScrH())
	
	local dose = GAMEMODE.ReadingDosimeter:GetVar("Radiation", 0)
	local start_pos = ScrW() / 3.38
	local end_pos = ScrW() / 1.423
	local cur_pos = math.Clamp(start_pos + (dose * (ScrW() / 480)), start_pos, end_pos)
	
	surface.SetDrawColor(Color(0,0,0))
	surface.DrawRect(cur_pos, 0, 2, ScrH())
	
	surface.SetFont("CombineControl.ChatNormal")
	local text = "Press any button to close."
	local tW, tH = surface.GetTextSize(text)
	local pos_x = (ScrW() / 2) - (tW / 2)
	local pos_y = (ScrH() / 1.04)
	
	surface.SetDrawColor(255,255,255)
	surface.SetTextColor(255,255,255)
	surface.SetTextPos(pos_x, pos_y)
	surface.DrawText(text)
end

local function RenderDosimeter()
	if GAMEMODE.ReadingDosimeter then
		if !input.IsKeyTrapping() then
			input.StartKeyTrapping()
		end
		
		kingston.geiger.render_dosimeter()
		
		if input.CheckKeyTrapping() then
			GAMEMODE.ReadingDosimeter = nil
		end
	end
end
hook.Add("HUDPaint", "STALKER.RenderDosimeter", RenderDosimeter)