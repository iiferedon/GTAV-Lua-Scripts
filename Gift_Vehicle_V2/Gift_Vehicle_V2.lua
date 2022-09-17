--iiferedon#1337

g_lua.register();

for i=0,31 do
    g_gui.add_button("player_options_vehicle_"..i, "Gift Vehicle 2.0", "Gift user a vehicle", function() giftvehicle(g_util.get_selected_player()) end)
end

local PI = 3.14159265359
local PI_180 = PI/180
local DISTANCE = 5
function asin(x) return g_math.sin(x*PI_180) end
function acos(x) return g_math.cos(x*PI_180) end

function spawn_for_player_model(player, model)
    local c = PLAYER.GET_PLAYER_COORDS(player)
    local rot = ENTITY.GET_ENTITY_ROTATION(PLAYER.GET_PLAYER_PED(player), 0)
    local x, y = c.x - (asin(rot.z)* DISTANCE) , c.y + (acos(rot.z)*DISTANCE)
    local veh = VEHICLE.CREATE_VEHICLE(model, x, y, c.z+1, rot.z, true, true, false)
    VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT(veh, "frown")
    VEHICLE.SET_VEHICLE_ON_GROUND_PROPERLY(veh, 0)
    return veh
end

function giftvehicle(pid)
    local pveh = PLAYER.GET_PLAYER_VEHICLE(pid)
    if PLAYER.IS_PLAYER_IN_ANY_VEHICLE(pid) then
        local veh = spawn_for_player_model(pid, ENTITY.GET_ENTITY_MODEL(pveh))
        local phash = NETWORK.NETWORK_HASH_FROM_PLAYER(pid)
        DECORATOR.DECOR_SET_INT(veh, "Player_Vehicle", phash)
        DECORATOR.DECOR_SET_INT(veh, "Veh_Modded_By_Player", phash)
        DECORATOR.DECOR_SET_INT(veh, "PV_Slot", 2)
        DECORATOR.DECOR_SET_INT(veh, "Previous_Owner", phash)

        g_gui.add_toast("Vehicle gifted successfully!")
    else
        g_gui.add_toast("Player is not in a vehicle!")
    end
end

function directx() 
	if true then 
		g_imgui.set_next_window_size(vec2(540, 280)) 
		if  g_imgui.begin_window("Instructions", ImGuiWindowFlags_NoResize) then 
			g_imgui.begin_child("Instructions", vec2(525,240), true) 
            g_imgui.add_text('Must do:')   g_imgui.same_line() g_imgui.add_text("Return current/active vehicles to storage")
            g_imgui.separator()
            g_imgui.add_text('Step 1:')   g_imgui.same_line() g_imgui.add_text("Buy a two car garage on 123 popular street ($25K).")
            g_imgui.add_text('Step 2:')   g_imgui.same_line() g_imgui.add_text("Fill it up with two cars off the street.")
            g_imgui.add_text('Step 3:')   g_imgui.same_line() g_imgui.add_text("Get out of the garage, spawn a vehicle with the menu.")
            g_imgui.add_text('Step 4:')  g_imgui.same_line() g_imgui.add_text("Click gift vehicle on yourself or the other player.")
            g_imgui.add_text('Step 4:')  g_imgui.same_line() g_imgui.add_text("Get in the newly spawned car.")
            g_imgui.add_text('Step 5:')  g_imgui.same_line() g_imgui.add_text("Drive into the garage and replace a street car with your spawned car")
            g_imgui.add_text('Step 6:')  g_imgui.same_line() g_imgui.add_text("Stay in the garage and get back in the car and drive out.")
            g_imgui.add_text('Step 7:')  g_imgui.same_line() g_imgui.add_text("Go to Los Santos Customs and put on loss theft protection")
            g_imgui.add_text('Step 8:')  g_imgui.same_line() g_imgui.add_text("The car is now yours!")
            g_imgui.separator()
            g_imgui.add_text('Info:')  g_imgui.same_line() g_imgui.add_text("You can sell an issi futureshock for 1 million dollars instead of putting") 
            g_imgui.add_text('loss theft prevention on.')
            g_imgui.end_child() 
			g_imgui.end_window() 
		end
	end
end

id = g_hooking.register_D3D_hook(directx);
    while g_isRunning do
        g_util.yield(100)
    end
g_hooking.unregister_hook(id)
g_lua.unregister();
