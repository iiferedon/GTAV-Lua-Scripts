function invalidpropv1()
    local pid = g_util.get_selected_player()
    if pid == PLAYER.PLAYER_ID() then
		return --Error
	else
		local objectHash = g_util.joaat("h4_prop_bush_mang_low_ab")
		STREAMING.REQUEST_MODEL(objectHash)
		while not STREAMING.HAS_MODEL_LOADED(objectHash) do
			g_util.yield()
		end
        local playerCoords = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid))
		object = OBJECT.CREATE_WORLD_OBJECT(objectHash, playerCoords.x, playerCoords.y, playerCoords.z, true, true)
        g_util.yield(200) 
        STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(objectHash)
    end
end
