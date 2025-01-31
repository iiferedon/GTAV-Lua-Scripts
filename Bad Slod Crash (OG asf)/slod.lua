local j = { 
    conv = g_util.joaat,
    ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX,
    vec3 = ENTITY.GET_ENTITY_COORDS,
    own = PLAYER.PLAYER_ID,
    stream = STREAMING.REQUEST_MODEL,
    isValid = STREAMING.HAS_MODEL_LOADED,
    spawnped = PED.CREATE_PED,
    wait = g_util.yield,
    delete_ent = STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED,
    playervalid = PLAYER.IS_PLAYER_VALID
}

function builds()
    local det = math.random(1,3)
    if det == 1 then
        slod1()
    elseif det == 2 then
        slod2()
    elseif det == 3 then
         slod3()
    end
end

function slod_1()
    local pid = g_util.get_selected_player()
    local hash = j.conv("slod_large_quadped")
    if pid == j.own() then
        g_gui.add_toast("Do not crash yourself.")
    else
        j.stream(hash)
            while not j.isValid(hash) do
                g_util.yield()
            end 
        local coords = j.vec3(j.ped(pid))
        local heading = ENTITY.GET_ENTITY_HEADING(hash)
        for i=0,4 do
            PED.CREATE_PED(26, hash, coords.x, coords.y, coords.z+i, heading, true, false)
            g_util.yield(1)
        end
        j.wait(10)
        j.delete_ent(hash)
    end
end

function slod_2()
    local pid = g_util.get_selected_player()
    local hash = j.conv("slod_small_quadped")
        if pid == j.own() then
            g_gui.add_toast("Do not crash yourself.")
        else
            j.stream(hash)
            while not j.isValid(hash) do
                g_util.yield()
            end
        local coords = j.vec3(j.ped(pid))
        local heading = ENTITY.GET_ENTITY_HEADING(hash)
        for i=0,4 do
            PED.CREATE_PED(26, hash, coords.x, coords.y, coords.z+i, heading, true, false)
            g_util.yield(1)
        end
        j.wait(10)
        j.delete_ent(hash)
    end
end

function slod_3()
    local pid = g_util.get_selected_player()
    local hash = j.conv("slod_human")
        if pid == j.own() then
            g_logger.log_info("Do not crash yourself.")
        else
            j.stream(hash)
            while not j.isValid(hash) do
                g_util.yield()
            end
        local coords = j.vec3(j.ped(pid))
        local heading = ENTITY.GET_ENTITY_HEADING(hash)
        for i=0,4 do
            PED.CREATE_PED(26, hash, coords.x, coords.y, coords.z+i, heading, true, false)
            g_util.yield(1)
        end
        j.wait(10)
        j.delete_ent(hash)
    end
end
