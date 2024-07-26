local natives = FileMgr.GetMenuRootPath() .. "\\Lua\\natives.lua"
if not FileMgr.DoesFileExist(natives) then
	Logger.LogError("Natives do not exists at " .. natives)
	SetShouldUnload()
	return
end
dofile(natives)

local Playerped = PLAYER.GET_PLAYER_PED(PLAYER.PLAYER_ID())
local vehicle = PED.GET_VEHICLE_PED_IS_IN(Playerped, false)

function is_player_in_veh()
	if PLAYER.IS_PLAYER_PLAYING(PLAYER.PLAYER_ID()) then
		if PED.IS_PED_IN_ANY_VEHICLE(PLAYER.PLAYER_PED_ID(), 0) then
			return true
		else
			return false
		end
		return false
	end
end

function drift()
    Script.Yield(3)
    if is_player_in_veh() then
        if PAD.IS_CONTROL_PRESSED(1, 61) or PAD.IS_CONTROL_PRESSED(1, 21) then
        VEHICLE.SET_VEHICLE_REDUCE_GRIP(vehicle, true)
        else 
        VEHICLE.SET_VEHICLE_REDUCE_GRIP(vehicle, false)
        end
    end
 end

Script.RegisterLooped(drift, false)
