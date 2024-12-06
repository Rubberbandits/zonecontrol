local function VJWelcomeCode()

end

local function KillVJ()
	concommand.Add("vj_welcome", VJWelcomeCode)
	concommand.Add("vj_welcome_msg", VJWelcomeCode)
	net.Receive("VJWelcome", VJWelcomeCode)
	net.Receive("vj_welcome_msg", VJWelcomeCode)
	concommand.Add("vj_iamhere", function(ply,cmd,args) end)
end

hook.Add("InitPostEntity", "kill_vj", function()
	KillVJ()
end)

KillVJ()