function GM:HUDShouldDraw(str)
	if str == "CHudWeaponSelection" then return false end
	if str == "CHudAmmo" then return false end
	if str == "CHudAmmoSecondary" then return false end
	if str == "CHudHealth" then return false end
	if str == "CHudBattery" then return false end
	if str == "CHudChat" then return false end
	if str == "CHudDamageIndicator" then return false end
	if str == "CHudCrosshair" then return false end

	return true
end

function GM:HUDPaint()

end