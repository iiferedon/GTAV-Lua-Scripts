--iiferedon#1337
g_lua.register();

g_gui.add_button("recovery_business", "Give 500k", "Gives 500k Instantly", function() give500() end)
g_gui.add_button("recovery_business", "Give 750k", "Gives 750k Instantly", function() give750() end)
g_gui.add_toggle("recovery_business", "500k Loop", "500k every 20 seconds", function(on) loop500 = on end)
g_gui.add_toggle("recovery_business", "1.25M Loop", "1.25M every 30 seconds", function(on) loop125 = on end)

function give500() 
    SCRIPT.SET_GLOBAL_I(1963962, 1)
    SCRIPT.SET_GLOBAL_F(262145, 133337)
        g_util.yield(400)
    SCRIPT.SET_GLOBAL_I(1963962, 0)
end

function give750() 
    SCRIPT.SET_GLOBAL_I(1963962, 2)
    SCRIPT.SET_GLOBAL_F(262145, 133337)
        g_util.yield(400)
    SCRIPT.SET_GLOBAL_I(1963962, 0)
end

while g_isRunning do

    if loop500 == true then --Every 20 seconds
        SCRIPT.SET_GLOBAL_I(1963962, 1)
        SCRIPT.SET_GLOBAL_F(262145, 133337)
            g_util.yield(400)
        SCRIPT.SET_GLOBAL_I(1963962, 0)
            g_util.yield(20000)
    end

    if loop125 == true then --Every 30 seconds
        g_util.yield(400)
        SCRIPT.SET_GLOBAL_I(1963962, 2)
        g_util.yield(15000)
        SCRIPT.SET_GLOBAL_I(1963962, 1)
        g_util.yield(3000)
        SCRIPT.SET_GLOBAL_I(1963962, 0)
        g_util.yield(15000)
    end

    g_util.yield(100)

end
g_lua.unregister();
