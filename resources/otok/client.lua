local islandVec = vector3(4840.571, -5174.425, 2.0)
local otok = false
Citizen.CreateThread(function()
    while true do
		local pCoords = GetEntityCoords(GetPlayerPed(-1))		
        local distance1 = #(pCoords - islandVec)
        if distance1 < 2000.0 then
            if not otok then
                otok = true
                SetIslandHopperEnabled("HeistIsland", true)  -- load the map and removes the city
                SetToggleMinimapHeistIsland(true) -- load the minimap/pause map and removes the city minimap/pause map
            end
        elseif otok then
            otok = false
            SetIslandHopperEnabled("HeistIsland", false)
            SetToggleMinimapHeistIsland(false)
        end
		Citizen.Wait(5000)
    end
end)