function add_snaplines_to_missionent()
    objData = {}
    local max_obj = PoolMgr.GetMaxObjectCount()
    for i = 0, max_obj do
        local obj = PoolMgr.GetObject(i)
        local localped = PLAYER.PLAYER_PED_ID()
        if not ENTITY.IS_ENTITY_A_MISSION_ENTITY(obj) then
            local x, y, z = ENTITY.GET_ENTITY_COORDS(obj, true)
            local localx, localy, localz = ENTITY.GET_ENTITY_COORDS(localped, true)
            local objectcoords = { x, y, z }
            local localcoords = { localx, localy, localz }
            local distanceoff = VecDistance(objectcoords, localcoords)
            local normalized_x, normalized_y = GTA.WorldToScreen(x, y, z)
			 local objectname = "Unknown"
            	local modelHash = ENTITY.GET_ENTITY_MODEL(obj)
            	objectname = GTA.GetDisplayNameFromHash(modelHash)   
				finalname = GTA.GetModelNameFromHash(objectname)
            if normalized_x > 0.1 then
                local screen_x, screen_y = ImGui.GetDisplaySize()
                local resolved_screen_x, resolved_screen_y = screen_x * normalized_x, screen_y * normalized_y
                table.insert(objData, { index = i, x = resolved_screen_x, y = resolved_screen_y, distance = math.floor(distanceoff), entity = finalname })
            end
        end
    end
    Script.Yield()
end

function add_snaplines_to_veh()
vehData = {}
	local max_veh = PoolMgr.GetMaxVehicleCount()
		for i = 0, max_veh do
			local veh = PoolMgr.GetVehicle(i)
			local ownveh = PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID())
			if ENTITY.IS_ENTITY_A_VEHICLE(veh) then
					if not  is_veh_personal(veh) and veh ~= ownveh   then 
						if ENTITY.DOES_ENTITY_EXIST(veh) and ENTITY.GET_ENTITY_HEALTH(veh) > 0 then
							local x, y, z =  ENTITY.GET_ENTITY_COORDS(veh,true)
							local normalized_x, normalized_y= GTA.WorldToScreen(x, y, z)
									if normalized_x > 0.1 then
										local screen_x, screen_y = ImGui.GetDisplaySize()
										local resolved_screen_x , resolved_screen_y = screen_x * normalized_x,screen_y * normalized_y
										table.insert(vehData, { x = resolved_screen_x, y = resolved_screen_y })
							end
						end
					end
				end
			end
Script.Yield()
end

function add_snaplines_to_ped()
pedData = {}
	local max_peds = PoolMgr.GetMaxPedCount()
	for i = 0, max_peds do
			local ped = PoolMgr.GetPed(i)
				if ped ~= PLAYER.PLAYER_PED_ID() then
					if ENTITY.DOES_ENTITY_EXIST(ped) and ENTITY.GET_ENTITY_HEALTH(ped) > 0 and not ENTITY.IS_ENTITY_A_MISSION_ENTITY(ped) then
						if not PED.IS_PED_A_PLAYER(ped) then
						local x, y, z =  ENTITY.GET_ENTITY_COORDS(ped,true)
						local normalized_x, normalized_y= GTA.WorldToScreen(x, y, z)
							if normalized_x > 0.1 then
								local screen_x, screen_y = ImGui.GetDisplaySize()
								local resolved_screen_x , resolved_screen_y = screen_x * normalized_x,screen_y * normalized_y
								table.insert(pedData, { x = resolved_screen_x, y = resolved_screen_y })
							end
						end
					end
				end
			end
Script.Yield()
end

function draw()
    for _,pedInfo in ipairs(pedData) do
	local screen_x, screen_y = ImGui.GetDisplaySize()
		if FeatureMgr.IsFeatureEnabled(Utils.Joaat("ExplodeLoopPeds")) then
			 ImGui.AddCircleFilled(pedInfo.x, pedInfo.y, 5 , 0, 4, 130, 255, 0)
			ImGui.AddLine(screen_x/2, screen_y, pedInfo.x, pedInfo.y,0, 212, 18, 255,2.0)
		end
      end
			for _,vehInfo in ipairs(vehData) do
			local screen_x, screen_y = ImGui.GetDisplaySize()
			ImGui.AddCircleFilled(vehInfo.x, vehInfo.y, 5 , 66, 0, 181, 255, 0)
			ImGui.AddLine(screen_x/2, screen_y, vehInfo.x, vehInfo.y, 212, 66, 0, 181,2.0)
			end

for _, objInfo in ipairs(objData) do
        local screen_x, screen_y = ImGui.GetDisplaySize()
        ImGui.AddCircleFilled(objInfo.x, objInfo.y, 5, 66, 0, 181, 255, 0)
        ImGui.AddLine(screen_x / 2, screen_y, objInfo.x, objInfo.y, 212, 66, 0, 181, 2.0)

        ImGui.AddText(objInfo.x, objInfo.y, "(" .. tostring(objInfo.distance) .. ") " .. objInfo.entity , 212, 15, 179, 255)
			end
end


draw_screen = EventMgr.RegisterHandler(eLuaEvent.ON_PRESENT, draw)
function draw_thread()
if not FeatureMgr.IsFeatureEnabled(Utils.Joaat("ExplodeLoopPeds")) then
			pedData = {}
	end
	if FeatureMgr.IsFeatureEnabled(Utils.Joaat("ExplodeLoopPeds")) then
			add_snaplines_to_ped()
	end

if not FeatureMgr.IsFeatureEnabled(Utils.Joaat("ExplodeLoopVehs")) then
			vehData = {}
	end
if FeatureMgr.IsFeatureEnabled(Utils.Joaat("ExplodeLoopVehs")) then
			add_snaplines_to_veh()
end

if FeatureMgr.IsFeatureEnabled(Utils.Joaat("Snaplineonmissionents")) then
			add_snaplines_to_missionent()
end

if not FeatureMgr.IsFeatureEnabled(Utils.Joaat("Snaplineonmissionents")) then
			objData = {}
	end

end
