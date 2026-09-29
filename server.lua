local ESX = exports['es_extended']:getSharedObject()

ESX.RegisterServerCallback('mechanicjob:getPlayerJob', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        cb(xPlayer.job.name)
    else
        cb(nil)
    end
end)

RegisterNetEvent('mechanicjob:repairVehicle')
AddEventHandler('mechanicjob:repairVehicle', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        local account = xPlayer.getAccount('bank')
        if account.money >= Config.MechanicJob.RepairCost then
            xPlayer.removeAccountMoney('bank', Config.MechanicJob.RepairCost)
            TriggerClientEvent('mechanicjob:repairVehicle', source)
            MySQL.Async.execute('UPDATE mechanic_job_vehicles SET last_repair = CURRENT_TIMESTAMP WHERE owner = @owner', {
                ['@owner'] = xPlayer.identifier
            }, function(rowsChanged)
                if rowsChanged == 0 then
                    MySQL.Async.execute('INSERT INTO mechanic_job_vehicles (owner, vehicle_model, vehicle_plate) VALUES (@owner, @model, @plate)', {
                        ['@owner'] = xPlayer.identifier,
                        ['@model'] = 'unknown',
                        ['@plate'] = 'unknown'
                    })
                end
            end)
        else
            TriggerClientEvent('esx:showNotification', source, 'Not enough money!')
        end
    end
end)