--iiferedon#1337
function directx()
	if g_gui.is_open() then
		g_imgui.set_next_window_size(vec2(384, 165))
		if  g_imgui.begin_window("Sound Crash", ImGuiWindowFlags_NoResize) then
			g_imgui.begin_child(" ", vec2(372,120), true)
			g_imgui.add_button("HostKick", vec2(358,25), function() sessionhostkick(g_util.get_selected_player()) end ,sessionhostkick)
			g_imgui.add_button("Suicide Crash v1", vec2(358,25), function() soundcrash(g_util.get_selected_player()) end ,soundcrash)
            g_imgui.end_child()
			g_imgui.end_window()
		end
	end
end

g_lua.register();

function sessionhostkick(pid)
	if NETWORK.NETWORK_IS_HOST() then
		NETWORK.NETWORK_SESSION_KICK_PLAYER(pid)
		g_gui.add_toast("Host kicked "..PLAYER.GET_PLAYER_NAME(pid))
	else 
		g_gui.add_toast("You need to be Session Host. Force Host and rejoin session.")
	end
end

function soundcrash()
    for i=0,99 do
        AUDIO.PLAY_SOUND_FROM_ENTITY(-1, "Boss_Message_Orange", PLAYER.PLAYER_PED_ID(), "GTAO_Boss_Goons_FM_Soundset", true, 0)
        if i%10 == 0 then
            g_util.yield()
        end
    end
end

id = g_hooking.register_D3D_hook(directx);
while g_isRunning do
	g_util.yield(100)
end
g_hooking.unregister_hook(id);
g_lua.unregister();
