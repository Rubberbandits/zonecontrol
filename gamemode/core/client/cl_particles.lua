local ParticleSystems = {
	"st_elmos_fire",
	"electrical_arc_01_system",
	"pfx_fruit_punch",
	"pfx_fruit_punch_pop",
	"hunter_shield_impact2",
	"warp_shield_impact",
	"striderbuster_shotdown_core_flash",
	"acid",
	"electrical_arc_01",
	"burner",
	"vortex_inactive",
	"vortex_armed",
	"vortex_repulse",
	"vortex_repulse_bloody",
}

local ParticleFiles = {
	"particles/electrical_fx.pcf",
	"particles/stalker_fx.pcf",
	"particles/hunter_shield_impact.pcf",
	"particles/warpshield.pcf",
	"particles/acid.pcf",
	"particles/burner.pcf",
	"particles/vortex.pcf",
}

hook.Add("Initialize", "LoadParticleSystems", function()
	for _,v in next, ParticleFiles do
		game.AddParticles( v );
	end
	
	for _,v in next, ParticleSystems do
		PrecacheParticleSystem( v );
	end
end)