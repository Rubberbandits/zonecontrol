hook.Add("InitPostEntity", "join_con_commands", function()
    RunConsoleCommand("gmod_mcore_test", "1")
    RunConsoleCommand("mat_queue_mode", "-1")
    RunConsoleCommand("cl_threaded_bone_setup", "1")
    RunConsoleCommand("cl_threaded_client_leaf_system", "1")
    RunConsoleCommand("r_threaded_client_shadow_manager", "1")
    RunConsoleCommand("r_threaded_particles", "1")
    RunConsoleCommand("r_threaded_renderables", "1")
    RunConsoleCommand("r_queued_ropes", "1")
    RunConsoleCommand("studio_queue_mode", "1")
    RunConsoleCommand("cl_showhints", "0")

    RunConsoleCommand("mat_specular", "0")
    RunConsoleCommand("r_3dsky", "1")

    hook.Remove("PreventScreenClicks", "SuperDOFPreventClicks")
    hook.Remove("PostRender", "RenderFrameBlend")
    hook.Remove("PreRender", "PreRenderFrameBlend")
    hook.Remove("Think", "DOFThink")
    hook.Remove("RenderScreenspaceEffects", "RenderBokeh")
    hook.Remove("NeedsDepthPass", "NeedsDepthPass_Bokeh")
    hook.Remove("PostDrawEffects", "RenderWidgets")
    hook.Remove("Think", "RenderHalos")
end)

local function antiWidget(ent)
    if ent:IsWidget() then
        hook.Add("PlayerTick", "TickWidgets", function(pl, mv)
            widgets.PlayerTick(pl, mv)
        end)
        hook.Remove("OnEntityCreated", "WidgetInit") -- calls it only once
    end
end

hook.Add("OnEntityCreated", "WidgetInit", antiWidget)