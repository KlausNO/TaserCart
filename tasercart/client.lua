
local QBCore = exports['qb-core']:GetCoreObject()
    RegisterKeyMapping("taserreload", "Reload", 'keyboard', "R")


local maxTaserCarts = 2
local refillCommand = "taserreload"
local longerTazeTime = false
local longerTazeSecTime = 20
taserModel = GetHashKey("WEAPON_STUNGUN")
local taserCartsLeft = maxTaserCarts
local notified = false


InNotify = false

function ShowNotification(text, time)
    _time = time or 2000
    CreateThread(function()
        if(InNotify == false) then
            QBCore.Functions.Notify(text, 'primary', _time)
            InNotify = true
            Wait(_time - 1)
            InNotify = false

        end
    end)

end

RegisterCommand(refillCommand, function(source, args, rawCommand)
    if(GetSelectedPedWeapon(PlayerPedId()) == taserModel) then
        if QBCore.Functions.HasItem('taser_cardridge') then
            exports['okokNotify']:Alert('Taser', 'Reloading...', 3000, 'info')
            Citizen.Wait(3000)
            taserCartsLeft = maxTaserCarts
            exports['okokNotify']:Alert('Taser', 'Reloaded', 3000, 'success')        
            TriggerServerEvent('DD-taser:server:jhkjkl')
        else
            exports['okokNotify']:Alert('Taser', 'You need a Cardridge', 3000, 'error') 
        end
    end
end)


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local ped = PlayerPedId()

        if GetSelectedPedWeapon(ped) == taserModel then
            if IsPedShooting(ped) then
                taserCartsLeft = taserCartsLeft - 1
                -- print("[Taser Cartridge] Taser Cartridges over = " .. taserCartsLeft)
            end
        end

        if taserCartsLeft <= 0 then
            if GetSelectedPedWeapon(ped) == taserModel then
                SetPlayerCanDoDriveBy(ped, false)
                DisablePlayerFiring(ped, true)
                if IsControlPressed(0, 106) then
                    if not notified then
                        exports['okokNotify']:Alert('Taser', 'Your Taser is Empty', 3000, 'error')
                        notified = true
                    end
                    DisablePlayerFiring(ped, true)
                end
            end
        end

        if longerTazeTime then
            SetPedMinGroundTimeForStungun(ped, longerTazeSecTime * 1000)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
      Citizen.Wait(8000)
      notified = false
    end
end)
