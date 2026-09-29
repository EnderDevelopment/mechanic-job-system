local ESX = exports['es_extended']:getSharedObject()

Citizen.CreateThread(function()
    while ESX == nil do
        Citizen.Wait(0)
    end

    if ESX.IsPlayerLoaded() then
        ESX.TriggerServerCallback('mechanicjob:getPlayerJob', function(job)
            if job == 'mechanic' then
                CreateBlip()
                SetupVehicleSpawns()
            end
        end)
    end
end)

function CreateBlip()
    local blip = AddBlipForCoord(-212.5, -1325.0, 30.8)
    SetBlipSprite(blip, Config.MechanicJob.Blip.Sprite)
    SetBlipColour(blip, Config.MechanicJob.Blip.Color)
    SetBlipScale(blip, Config.MechanicJob.Blip.Scale)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString(Config.MechanicJob.Blip.Name)
    EndTextCommandSetBlipName(blip)
end

function SetupVehicleSpawns()
    for _, spawn in ipairs(Config.MechanicJob.VehicleSpawns) do
        local blip = AddBlipForCoord(spawn.x, spawn.y, spawn.z)
        SetBlipSprite(blip, 225)
        SetBlipColour(blip, 5)
        SetBlipScale(blip, 0.8)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentString('Vehicle Spawn')
        EndTextCommandSetBlipName(blip)
    end
end

RegisterNetEvent('mechanicjob:repairVehicle')
AddEventHandler('mechanicjob:repairVehicle', function()
    local playerPed = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(playerPed, false)
    if DoesEntityExist(vehicle) then
        SetVehicleEngineHealth(vehicle, 1000.0)
        SetVehiclePetrolTankHealth(vehicle, 1000.0)
        ESX.ShowNotification('Vehicle repaired!')
    else
        ESX.ShowNotification('You are not in a vehicle!')
    end
end)