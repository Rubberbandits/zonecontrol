
-- Clear weather. This is the default weather

local clear = StormFox2.Weather.Add( "Clear" )

local windy = 8

-- Description
if CLIENT then
	function clear:GetName(nTime, nTemp, nWind, bThunder, nFraction )
		local b_windy = StormFox2.Wind.GetBeaufort(nWind) >= windy
		if b_windy then
			return language.GetPhrase("#sf_weather.clear.windy")
		end
		return language.GetPhrase("#sf_weather.clear")
	end
else
	function clear:GetName(nTime, nTemp, nWind, bThunder, nFraction )
		local b_windy = StormFox2.Wind.GetBeaufort(nWind) >= windy
		if b_windy then
			return "Windy"
		end
		return "Clear"
	end
end
-- Icon
local m1,m2,m3,m4 = (Material("stormfox2/hud/w_clear.png")),(Material("stormfox2/hud/w_clear_night.png")),(Material("stormfox2/hud/w_clear_windy.png")),(Material("stormfox2/hud/w_clear_cold.png"))
function clear.GetSymbol( nTime ) -- What the menu should show
	return m1
end

function clear.GetIcon( nTime, nTemp, nWind, bThunder, nFraction) -- What symbol the weather should show
	local b_day = StormFox2.Time.IsDay(nTime)
	local b_cold = nTemp < -2
	local b_windy = StormFox2.Wind.GetBeaufort(nWind) >= windy
	if b_windy then
		return m3
	elseif b_cold then
		return m4
	elseif b_day then
		return m1
	else
		return m2
	end
end

-- Day
	clear:SetSunStamp("topColor",Color(91, 127.5, 255),		SF_SKY_DAY)
	clear:SetSunStamp("bottomColor",Color(204, 255, 255),	SF_SKY_DAY)
	clear:SetSunStamp("fadeBias",0.2,						SF_SKY_DAY)
	clear:SetSunStamp("duskColor",Color(255, 255, 255),		SF_SKY_DAY)
	clear:SetSunStamp("duskIntensity",1.94,					SF_SKY_DAY)
	clear:SetSunStamp("duskScale",0.29,						SF_SKY_DAY)
	clear:SetSunStamp("sunSize",20,							SF_SKY_DAY)
	clear:SetSunStamp("sunColor",Color(255, 255, 255),		SF_SKY_DAY)
	clear:SetSunStamp("starFade",0,							SF_SKY_DAY)
	--clear:SetSunStamp("fogDensity",0.8,						SF_SKY_DAY)
-- Night
	clear:SetSunStamp("topColor",Color(0,0,0),				SF_SKY_NIGHT)
	clear:SetSunStamp("bottomColor",Color(0, 1.5, 5.25),	SF_SKY_NIGHT)
	clear:SetSunStamp("fadeBias",0.12,						SF_SKY_NIGHT)
	clear:SetSunStamp("duskColor",Color(9, 9, 0),			SF_SKY_NIGHT)
	clear:SetSunStamp("duskIntensity",0,					SF_SKY_NIGHT)
	clear:SetSunStamp("duskScale",0,						SF_SKY_NIGHT)
	clear:SetSunStamp("sunSize",0,							SF_SKY_NIGHT)
	clear:SetSunStamp("starFade",100,						SF_SKY_NIGHT)
	--clear:SetSunStamp("fogDensity",1,						SF_SKY_NIGHT)
-- Sunset
	-- Old Color(170, 85, 43)
	clear:SetSunStamp("topColor",Color(130.5, 106.25, 149),	SF_SKY_SUNSET)
	clear:SetSunStamp("bottomColor",Color(204, 98, 5),	SF_SKY_SUNSET)
	clear:SetSunStamp("fadeBias",1,						SF_SKY_SUNSET)
	clear:SetSunStamp("duskColor",Color(248, 103, 30),	SF_SKY_SUNSET)
	clear:SetSunStamp("duskIntensity",3,				SF_SKY_SUNSET)
	clear:SetSunStamp("duskScale",0.6,					SF_SKY_SUNSET)
	clear:SetSunStamp("sunSize",15,						SF_SKY_SUNSET)
	clear:SetSunStamp("sunColor",Color(198, 170, 59),	SF_SKY_SUNSET)
	clear:SetSunStamp("starFade",30,					SF_SKY_SUNSET)
	--clear:SetSunStamp("fogDensity",0.8,					SF_SKY_SUNSET)
-- Sunrise
	clear:SetSunStamp("topColor",Color(130.5, 106.25, 149),	SF_SKY_SUNRISE)
	clear:SetSunStamp("bottomColor",Color(204, 98, 5),	SF_SKY_SUNRISE)
	clear:SetSunStamp("fadeBias",1,						SF_SKY_SUNRISE)
	clear:SetSunStamp("duskColor",Color(248, 103, 30),	SF_SKY_SUNRISE)
	clear:SetSunStamp("duskIntensity",3,				SF_SKY_SUNRISE)
	clear:SetSunStamp("duskScale",0.6,					SF_SKY_SUNRISE)
	clear:SetSunStamp("sunSize",15,						SF_SKY_SUNRISE)
	clear:SetSunStamp("sunColor",Color(198, 170, 59),	SF_SKY_SUNRISE)
	clear:SetSunStamp("starFade",30,					SF_SKY_SUNRISE)
	clear:SetSunStamp("fogDensity",0.8,					SF_SKY_SUNRISE)
-- Cevil
	clear:CopySunStamp( SF_SKY_NIGHT, SF_SKY_CEVIL ) -- Copy the night sky
	clear:SetSunStamp("fadeBias",1,	SF_SKY_CEVIL)
	clear:SetSunStamp("sunSize",0,	SF_SKY_CEVIL)

-- Default variables. These don't change.
	clear:Set("moonColor", Color( 205, 205, 205 ))
	clear:Set("moonSize",30)
	clear:Set("moonTexture", ( Material( "stormfox2/effects/moon/moon.png" ) ))
	clear:Set("skyVisibility",100) -- Blocks out the sun/moon
	clear:Set("mapDayLight",100)
	clear:Set("mapNightLight",0)
	clear:Set("clouds",0)
	clear:Set("HDRScale",0.7)
	
	clear:Set("fogDistance", 400000)
	clear:Set("fogIndoorDistance", 3000)
	--clear:Set("fogEnd",90000)
	--clear:Set("fogStart",0)

-- Static values
	clear:Set("starSpeed", 0.001)
	clear:Set("starScale", 2.2)
	clear:Set("starTexture", "skybox/starfield")
	clear:Set("enableThunder") 	-- Tells the generator that this weather_type can't have thunder.

-- 2D skyboxes
if SERVER then
	local t_day, t_night, t_sunrise, t_sunset
	t_day = {"sky_day01_05", "hav"}
	t_sunrise = {"sky_day01_06_hdr", "sky_day03_06"}
	t_sunset = {"sky_day01_08_hdr"}
	t_night = {"sky_day01_09_hdr"}

	clear:SetSunStamp("skyBox",t_day,		SF_SKY_DAY)
	clear:SetSunStamp("skyBox",t_sunrise,	SF_SKY_SUNRISE)
	clear:SetSunStamp("skyBox",t_sunset,	SF_SKY_SUNSET)
	clear:SetSunStamp("skyBox",t_night,		SF_SKY_NIGHT)

	local function BroadcastSkyboxChange(convar, old, new)
		print(old, new)
	end
	cvars.AddChangeCallback("sv_skyname", BroadcastSkyboxChange, "updateskybox")
else
	local function ListSkynameChange(convar, old, new)
		print(old, new)
		if(old != new) then
			local skybox = "skybox/"..new

			GAMEMODE.CubemapMats = {
				Material(skybox .. "ft"),
				Material(skybox .. "rt"),
				Material(skybox .. "bk"),
				Material(skybox .. "lf"),
				Material(skybox .. "up"),
				Material(skybox .. "dn"),
			}

			local rt = GetRenderTarget("skybox_foggation_renderation", ScrW(), ScrH())

			render.PushRenderTarget(rt)
			render.Clear(0, 0, 0, 0)

			cam.Start2D()
				surface.SetDrawColor(255,255,255,255)
				surface.SetMaterial(GAMEMODE.CubemapMats[1])
				surface.DrawTexturedRect(0,0, ScrW() * 0.25, ScrH())

				surface.SetMaterial(GAMEMODE.CubemapMats[2])
				surface.DrawTexturedRect(ScrW() * 0.25,0, ScrW() * 0.25, ScrH())

				surface.SetMaterial(GAMEMODE.CubemapMats[3])
				surface.DrawTexturedRect(ScrW() * 0.5,0, ScrW() * 0.25, ScrH())

				surface.SetMaterial(GAMEMODE.CubemapMats[4])
				surface.DrawTexturedRect(ScrW() * 0.75,0, ScrW() * 0.25, ScrH())
			cam.End2D()

			render.CapturePixels()

			local w = math.min(ScrW(), 16843009)
			local avgcol = {
				r = 0, g = 0, b = 0
			}

			for i = 1, w do
				local r, g, b = render.ReadPixel(i, math.random(ScrH() * 0.5 - ScrH() * 0.2), ScrH() * 0.5)
				avgcol.r = avgcol.r + r
				avgcol.b = avgcol.b + b
				avgcol.g = avgcol.g + g
			end

			avgcol.r = avgcol.r / w
			avgcol.g = avgcol.g / w
			avgcol.b = avgcol.b / w

			StormFox2.Weather.GetCurrent():Set("fogColor", Color(avgcol.r, avgcol.g, avgcol.b, 255))

			render.PopRenderTarget()
		end
	end
	cvars.AddChangeCallback("sv_skyname", ListSkynameChange, "updateskybox")

	local function PostDraw2DSkyBox()
		local color2 = Color(255, 255, 255, 255)
		local size = 16

		GAMEMODE.Rotation = (GAMEMODE.Rotation or 0) + 0.3 * (CurTime() - (GAMEMODE.LastTime or 0))
		GAMEMODE.LastTime = CurTime()
		local mat = Matrix()
		mat:SetAngles(Angle(0, GAMEMODE.Rotation, 0))
		mat:SetTranslation(EyePos())

		if !GAMEMODE.CubemapMats then
			ListSkynameChange("sv_skyname", "", GetConVarString("sv_skyname"))
		end

		local materials = GAMEMODE.CubemapMats

		cam.Start3D(EyePos(), RenderAngles())
			cam.PushModelMatrix(mat)

			render.OverrideDepthEnable(false, true)
			render.SetMaterial(materials[1])
			render.DrawQuadEasy(Vector(1, 0, 0) * size, Vector(-1, 0, 0), size * 2, size * 2, color2, 180)

			render.SetMaterial(materials[4])
			render.DrawQuadEasy(Vector(0, -1, 0) * size, Vector(0, 1, 0), size * 2, size * 2, color2, 180)

			render.SetMaterial(materials[3])
			render.DrawQuadEasy(Vector(-1, 0, 0) * size, Vector(1, 0, 0), size * 2, size * 2, color2, 180)

			render.SetMaterial(materials[2])
			render.DrawQuadEasy(Vector(0, 1, 0) * size, Vector(0, -1, 0), size * 2, size * 2, color2, 180)

			render.SetMaterial(materials[5])
			render.DrawQuadEasy(Vector(0, 0, 1) * size, Vector(0, 0, -1), size * 2, size * 2, color2, 270)

			render.SetMaterial(materials[6])
			render.DrawQuadEasy(Vector(0, 0, -1) * size, Vector(0, 0, 1), size * 2, size * 2, color2, 90)

			render.OverrideDepthEnable(false, false)

			cam.PopModelMatrix()
		cam.End3D()
	end
	hook.Add("PostDraw2DSkyBox", "STALKER.StormFox2SkyboxFix", PostDraw2DSkyBox)
end