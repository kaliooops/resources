Citizen.CreateThread(function()
  local wTime = 400
  while true do
      local t = 0
      local activePly = GetActivePlayers()
      for _, i in pairs(activePly)  do
          if NetworkIsPlayerTalking(i) then
              wTime = 1
              local ped = GetPlayerPed(i)
              if selfPed ~= PlayerPedId() then
                local coords = GetEntityCoords(ped) + vector3(0.0, 0.0, 1.0)
                DrawMarker(0, coords, 0, 0, 0, 0, 0, 0, 0.100, 0.100, 0.050, 255, 255, 255, 150)
              end
          end
      end
      Wait(wTime)
      wTime = 400
  end
end)