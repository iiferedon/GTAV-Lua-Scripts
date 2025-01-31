function brohug()
    local pid = g_util.get_selected_player()
    local hash = j.conv("a_f_o_ktown_01")
        if pid == j.own() then
            g_gui.add_toast("Do not crash yourself.")
        else
            j.stream(hash)
            while not j.isValid(hash) do
                g_util.yield()
            end
        local coords = j.vec3(j.ped(pid))
        local heading = ENTITY.GET_ENTITY_HEADING(hash)
            crashped = PED.CREATE_PED(26, hash, coords.x, coords.y, coords.z+1, heading, true, false)
            g_util.yield(1)
            ENTITY.ATTACH_ENTITY_TO_ENTITY(crashped, crashped, 0, 0, 0, 0, 0, 0, 0, true, true, true, true, 0, false)
        j.wait(400)
        j.delete_ent(hash)
        j.delete_ent(crashped)
    end
end
